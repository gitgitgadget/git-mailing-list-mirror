From: larsxschneider@gmail.com
Subject: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Mon, 19 Oct 2015 20:43:59 +0200
Message-ID: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 20:44:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoFPk-00053o-UU
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 20:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbbJSSoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 14:44:04 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36725 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbJSSoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 14:44:03 -0400
Received: by lffz202 with SMTP id z202so36234822lff.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sPGjzXmHI2lPmCmGgdm6LJWOCLUO1QdtRtpcyL9NhVc=;
        b=EXEFwMWTpgTT+PR49wbUSpTR4k2ku2K4ocsMPfsWd1AT4bANFXa0mh5l13BWTzYqkh
         CLlGosqxj+JiJX/0Yr9/gBLVOSOeno66V/TjMge0VPqng6JGPwHpmg7Lohgf4+wxEfZQ
         9zVC3yXyVKU7TgmvMHnrcPBrhyCIDH+o0ZAkdKpoqpJ6tq3+OE36PyuibpJnT+pUylrs
         l76HKpoSwY3RgwzgmeLCHgZH/gOoVI/iLjADNCEmbmARriab4X9lbrGbGuG//8gwBKSY
         uUafMj0SwQxaqBKwD+0CYzet6L4wXTEEo5zEOPIXg3Utm/uk3RRpuYS4Ma13iRaVZIU+
         kfOw==
X-Received: by 10.181.29.102 with SMTP id jv6mr21913574wid.59.1445280241243;
        Mon, 19 Oct 2015 11:44:01 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB5D2E.dip0.t-ipconnect.de. [93.219.93.46])
        by smtp.gmail.com with ESMTPSA id q1sm41756667wjy.31.2015.10.19.11.44.00
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Oct 2015 11:44:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279885>

From: Lars Schneider <larsxschneider@gmail.com>

A changelist that contains only excluded files (e.g. via client spec or
branch prefix) will be imported as empty commit. Add option
"git-p4.ignoreEmptyCommits" to ignore these commits.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt               |   5 ++
 git-p4.py                              |  41 ++++++++-----
 t/t9826-git-p4-ignore-empty-commits.sh | 103 +++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 16 deletions(-)
 create mode 100755 t/t9826-git-p4-ignore-empty-commits.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..f096a6a 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -510,6 +510,11 @@ git-p4.useClientSpec::
 	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
 
+git-p4.ignoreEmptyCommits::
+	A changelist that contains only excluded files will be imported
+	as empty commit. To ignore these commits set this boolean option
+	to 'true'.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index 0093fa3..6c50c74 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2288,12 +2288,6 @@ class P4Sync(Command, P4UserMap):
         filesToDelete = []
 
         for f in files:
-            # if using a client spec, only add the files that have
-            # a path in the client
-            if self.clientSpecDirs:
-                if self.clientSpecDirs.map_in_client(f['path']) == "":
-                    continue
-
             filesForCommit.append(f)
             if f['action'] in self.delete_actions:
                 filesToDelete.append(f)
@@ -2368,18 +2362,33 @@ class P4Sync(Command, P4UserMap):
         if self.verbose:
             print "commit into %s" % branch
 
-        # start with reading files; if that fails, we should not
-        # create a commit.
-        new_files = []
-        for f in files:
-            if [p for p in self.branchPrefixes if p4PathStartsWith(f['path'], p)]:
-                new_files.append (f)
-            else:
-                sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
-
         if self.clientSpecDirs:
             self.clientSpecDirs.update_client_spec_path_cache(files)
 
+        def inClientSpec(path):
+            if not self.clientSpecDirs:
+                return True
+            inClientSpec = self.clientSpecDirs.map_in_client(path)
+            if not inClientSpec and self.verbose:
+                print '\n  Ignoring file outside of client spec' % path
+            return inClientSpec
+
+        def hasBranchPrefix(path):
+            if not self.branchPrefixes:
+                return True
+            hasPrefix = [p for p in self.branchPrefixes
+                            if p4PathStartsWith(path, p)]
+            if hasPrefix and self.verbose:
+                print '\n  Ignoring file outside of prefix: %s' % path
+            return hasPrefix
+
+        files = [f for f in files
+            if inClientSpec(f['path']) and hasBranchPrefix(f['path'])]
+
+        if not files and gitConfigBool('git-p4.ignoreEmptyCommits'):
+            print '\n  Ignoring change %s as it would produce an empty commit.'
+            return
+
         self.gitStream.write("commit %s\n" % branch)
 #        gitStream.write("mark :%s\n" % details["change"])
         self.committedChanges.add(int(details["change"]))
@@ -2403,7 +2412,7 @@ class P4Sync(Command, P4UserMap):
                 print "parent %s" % parent
             self.gitStream.write("from %s\n" % parent)
 
-        self.streamP4Files(new_files)
+        self.streamP4Files(files)
         self.gitStream.write("\n")
 
         change = int(details["change"])
diff --git a/t/t9826-git-p4-ignore-empty-commits.sh b/t/t9826-git-p4-ignore-empty-commits.sh
new file mode 100755
index 0000000..5ddccde
--- /dev/null
+++ b/t/t9826-git-p4-ignore-empty-commits.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='Clone repositories and ignore empty commits'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create a repo' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+
+		mkdir -p subdir &&
+
+		>subdir/file1.txt &&
+		p4 add subdir/file1.txt &&
+		p4 submit -d "Add file 1" &&
+
+		>file2.txt &&
+		p4 add file2.txt &&
+		p4 submit -d "Add file 2" &&
+
+		>subdir/file3.txt &&
+		p4 add subdir/file3.txt &&
+		p4 submit -d "Add file 3"
+	)
+'
+
+test_expect_success 'Clone repo root path with all history' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+Add file 3
+[git-p4: depot-paths = "//depot/": change = 3]
+
+Add file 2
+[git-p4: depot-paths = "//depot/": change = 2]
+
+Add file 1
+[git-p4: depot-paths = "//depot/": change = 1]
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone repo subdir with all history' '
+	client_view "//depot/subdir/... //client/subdir/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+Add file 3
+[git-p4: depot-paths = "//depot/": change = 3]
+
+Add file 2
+[git-p4: depot-paths = "//depot/": change = 2]
+
+Add file 1
+[git-p4: depot-paths = "//depot/": change = 1]
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone repo subdir with all history but ignore empty commits' '
+	client_view "//depot/subdir/... //client/subdir/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.ignoreEmptyCommits true &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+Add file 3
+[git-p4: depot-paths = "//depot/": change = 3]
+
+Add file 1
+[git-p4: depot-paths = "//depot/": change = 1]
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.5.1
