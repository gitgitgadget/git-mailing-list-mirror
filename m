From: larsxschneider@gmail.com
Subject: [PATCH v1] git-p4: ignore P4 changelists that only touch files
Date: Sun, 20 Dec 2015 15:59:39 +0100
Message-ID: <1450623579-17013-2-git-send-email-larsxschneider@gmail.com>
References: <1450623579-17013-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 16:00:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAfSs-0007jt-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 16:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbbLTO7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 09:59:51 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36465 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbbLTO7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 09:59:44 -0500
Received: by mail-wm0-f48.google.com with SMTP id p187so40249493wmp.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OObh2vkhsr5Fyqpebm+dStM4kyfz5H9a1NAefZBlVYw=;
        b=Th8sA94CIzxYTYgIfQ2lSUNhsAHjFuF6Fg2NPJq0A1i1l3UlcmmiyFheRAcQoMZ0xJ
         nlQoS5zcipHfgyVZewYnrMFuhapZC1sTNRxJahkPBTRDIcUmsbtoFT5nUWIdS7n7f17l
         RaXvJjUOoUuGjaPE8SZra0m/zeBix09/JsfSaYbaMD93orKqiHgbLtmeXBA3C/Yk7fKo
         Q39RpEtQpOffKAfcOvBBVv8Z2TVPeJn6SveeYo8qNN74SrtW2j5RjWQFfN8EnaBRadPe
         xscWC5icnTtpP4azJOGrgcE5Zn0uXN3r29Pdm6u36XMmrgU2Q8/kz2GEH63k/fErbwdG
         PNeA==
X-Received: by 10.194.173.102 with SMTP id bj6mr15013393wjc.180.1450623583363;
        Sun, 20 Dec 2015 06:59:43 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id xs9sm23830722wjc.43.2015.12.20.06.59.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 06:59:42 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1450623579-17013-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282770>

From: Lars Schneider <larsxschneider@gmail.com>

Detect if a P4 changelists only changes the creation or modification
date of its files. Ignore these kind of changed files on import to avoid
empty Git commits. This would happen because Git does not track these
properties.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py                            | 54 ++++++++++++++++++++++++++++++++++--
 t/t9826-git-p4-keep-empty-commits.sh | 48 ++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7a9dd6a..c38a8f7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -328,6 +328,15 @@ def split_p4_type(p4type):
     return (base, mods)
 
 #
+# converts P4 mods to Git file modes
+#
+def convert_to_git_mode(p4_mods):
+    if 'x' in p4_mods:
+        return '100755'
+    else:
+        return '100644'
+
+#
 # return the raw p4 type of a file (text, text+ko, etc)
 #
 def p4_type(f):
@@ -335,6 +344,35 @@ def p4_type(f):
     return results[0]['headType']
 
 #
+# Returns true if Git would mark the diff of a file `f` in `changelist1`
+# and `changelist2` as modified. The change detection is very conservative
+# as a P4 file type change would usually not change the Git content.
+# However, in case of symlinks or UTF-16 files that might happen.
+#
+def p4_file_changed(f, changelist1, changelist2):
+    if not changelist1 or not changelist2:
+        return True
+    results = p4CmdList([
+        'diff2',
+        '{}@{}'.format(wildcard_encode(f), changelist1),
+        '{}@{}'.format(wildcard_encode(f), changelist2)
+    ])
+    if len(results) != 1:
+        return True
+    elif ('status' not in results[0] or
+          'type' not in results[0] or
+          'type2' not in results[0]):
+        return True
+    else:
+        (type1, mods1) = split_p4_type(results[0]['type'])
+        (type2, mods2) = split_p4_type(results[0]['type2'])
+        return (
+            results[0]['status'] != 'identical' or
+            convert_to_git_mode(mods1) != convert_to_git_mode(mods2) or
+            type1 != type2
+        )
+
+#
 # Given a type base and modifier, return a regexp matching
 # the keywords that can be expanded in the file
 #
@@ -2394,10 +2432,8 @@ class P4Sync(Command, P4UserMap):
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
+        git_mode = convert_to_git_mode(type_mods)
 
-        git_mode = "100644"
-        if "x" in type_mods:
-            git_mode = "100755"
         if type_base == "symlink":
             git_mode = "120000"
             # p4 print on a symlink sometimes contains "target\n";
@@ -2656,6 +2692,14 @@ class P4Sync(Command, P4UserMap):
         files = [f for f in files
             if self.inClientSpec(f['path']) and self.hasBranchPrefix(f['path'])]
 
+        files = [f for f in files
+            if not f['action'] == 'edit' or p4_file_changed(
+                f['path'],
+                details.get('previous_change', None),
+                details['change']
+            )
+        ]
+
         if not files and not gitConfigBool('git-p4.keepEmptyCommits'):
             print('Ignoring revision {0} as it would produce an empty commit.'
                 .format(details['change']))
@@ -2993,8 +3037,10 @@ class P4Sync(Command, P4UserMap):
 
     def importChanges(self, changes):
         cnt = 1
+        previous_change = None
         for change in changes:
             description = p4_describe(change)
+            description['previous_change'] = previous_change
             self.updateOptionDict(description)
 
             if not self.silent:
@@ -3069,6 +3115,8 @@ class P4Sync(Command, P4UserMap):
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
                     self.initialParent = ""
+
+                previous_change = change
             except IOError:
                 print self.gitError.read()
                 sys.exit(1)
diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-empty-commits.sh
index be12960..23a300a 100755
--- a/t/t9826-git-p4-keep-empty-commits.sh
+++ b/t/t9826-git-p4-keep-empty-commits.sh
@@ -15,7 +15,7 @@ test_expect_success 'Create a repo' '
 
 		mkdir -p subdir &&
 
-		>subdir/file1.txt &&
+		echo "content1" >subdir/file1.txt &&
 		p4 add subdir/file1.txt &&
 		p4 submit -d "Add file 1" &&
 
@@ -35,7 +35,21 @@ test_expect_success 'Create a repo' '
 		p4 submit -d "Remove file 3" &&
 
 		p4 delete file4.txt &&
-		p4 submit -d "Remove file 4"
+		p4 submit -d "Remove file 4" &&
+
+		p4 edit subdir/file1.txt &&
+		touch subdir/file1.txt &&
+		p4 submit -d "Touch file1 - no changes" subdir/file1.txt
+
+		p4 edit -t text+x subdir/file1.txt &&
+		p4 submit -d "Change execution bit" subdir/file1.txt
+
+		p4 edit -t binary+x subdir/file1.txt &&
+		p4 submit -d "Change filetype" subdir/file1.txt
+
+		p4 edit subdir/file1.txt &&
+		echo "content1 changed" >subdir/file1.txt &&
+		p4 submit -d "Change content" subdir/file1.txt
 	)
 '
 
@@ -47,6 +61,15 @@ test_expect_success 'Clone repo root path with all history' '
 		git init . &&
 		git p4 clone --use-client-spec --destination="$git" //depot@all &&
 		cat >expect <<-\EOF &&
+Change content
+[git-p4: depot-paths = "//depot/": change = 10]
+
+Change filetype
+[git-p4: depot-paths = "//depot/": change = 9]
+
+Change execution bit
+[git-p4: depot-paths = "//depot/": change = 8]
+
 Remove file 4
 [git-p4: depot-paths = "//depot/": change = 6]
 
@@ -80,6 +103,18 @@ test_expect_success 'Clone repo subdir with all history but keep empty commits'
 		git config git-p4.keepEmptyCommits true &&
 		git p4 clone --use-client-spec --destination="$git" //depot@all &&
 		cat >expect <<-\EOF &&
+Change content
+[git-p4: depot-paths = "//depot/": change = 10]
+
+Change filetype
+[git-p4: depot-paths = "//depot/": change = 9]
+
+Change execution bit
+[git-p4: depot-paths = "//depot/": change = 8]
+
+Touch file1 - no changes
+[git-p4: depot-paths = "//depot/": change = 7]
+
 Remove file 4
 [git-p4: depot-paths = "//depot/": change = 6]
 
@@ -112,6 +147,15 @@ test_expect_success 'Clone repo subdir with all history' '
 		git init . &&
 		git p4 clone --use-client-spec --destination="$git" --verbose //depot@all &&
 		cat >expect <<-\EOF &&
+Change content
+[git-p4: depot-paths = "//depot/": change = 10]
+
+Change filetype
+[git-p4: depot-paths = "//depot/": change = 9]
+
+Change execution bit
+[git-p4: depot-paths = "//depot/": change = 8]
+
 Remove file 3
 [git-p4: depot-paths = "//depot/": change = 5]
 
-- 
2.5.1
