From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: support excluding paths on sync
Date: Sat, 17 Jan 2015 20:56:38 +0000
Message-ID: <1421528198-16749-2-git-send-email-luke@diamand.org>
References: <1421528198-16749-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 21:57:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCaQs-0001iN-EF
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 21:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbAQU5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 15:57:11 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39712 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbAQU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 15:57:07 -0500
Received: by mail-pa0-f43.google.com with SMTP id lj1so5178407pab.2
        for <git@vger.kernel.org>; Sat, 17 Jan 2015 12:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7P16CtOM03kX7fntba4JjdilssmO57y3RgDbboUa53Q=;
        b=FmLVupQsoz+4/ySl3Ux2p/Ka1OqIPZjafZQUX1AF5+92dj1Hma8CdrJ0Ipm49dWq+A
         1tYKfGtgM4XEPlGgLWw/j5pDqG1RyiwwetVbB8zEgfjFP5/9ssiAr7qnkUdnYJqdjZwS
         aSc7tIJwCKvbIwOhwqJ3Gid5C6ObQVcARgUYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7P16CtOM03kX7fntba4JjdilssmO57y3RgDbboUa53Q=;
        b=F/KU8XSJa4LpSZvrmrbeNUPwUDIJ6kuK3Q8Hc2SBfsj21DRpNBShHHN/uhFJ5ZhSFe
         IoBxj7Z6+KEr2c57Ry9gAa0tD5Rop51OxwTKdWvHcRrkNahsfcCGQJTp3wEFfCr6J4mt
         RgBM9OnyfdYt7jYPvIBavFClF1PqMpV8Iv6RDukmmlpPC38bCpV+bAZD9j2hj3EPHyY6
         kh+j3Gn/rDVozoJWXBw7HdBWMrqnPpLhKGMA9rE6XLQPqoqZbhN1ksmPSxVa1l2wFeRO
         xz0IDdW+c4EjWixdcvwDcTPAHBKJrSzzHv/3ekh8llzXP165H7gR7YKtWsUQ5Z/hV+ar
         bRyg==
X-Gm-Message-State: ALoCoQlFQFm8xTDX2n6uqSoX5mxgZS8t+4zzZHUioyBoDQPqZQKyMXtKHwzDXwkD/HgbW+xVl8uJ
X-Received: by 10.70.118.202 with SMTP id ko10mr33156209pdb.48.1421528226802;
        Sat, 17 Jan 2015 12:57:06 -0800 (PST)
Received: from lgd-kipper.roku.com (cpc14-cmbg17-2-0-cust690.5-4.cable.virginm.net. [86.14.230.179])
        by mx.google.com with ESMTPSA id rx1sm7413803pbc.86.2015.01.17.12.57.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2015 12:57:06 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.45.g2e81bcb
In-Reply-To: <1421528198-16749-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262591>

The clone subcommand has long had support for excluding
subdirectories, but sync has not. This is a nuisance,
since as soon as you do a sync, any changed files that
were initially excluded start showing up.

Move the "exclude" command-line option into the parent
class; the actual behavior was already present there so
it simply had to be exposed.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt  |    6 ++--
 git-p4.py                 |   18 ++++++------
 t/t9817-git-p4-exclude.sh |   71 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 12 deletions(-)
 create mode 100755 t/t9817-git-p4-exclude.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 6ab5f94..a1664b9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -241,6 +241,9 @@ Git repository:
 	Use a client spec to find the list of interesting files in p4.
 	See the "CLIENT SPEC" section below.
 
+-/ <path>::
+	Exclude selected depot paths when cloning or syncing.
+
 Clone options
 ~~~~~~~~~~~~~
 These options can be used in an initial 'clone', along with the 'sync'
@@ -254,9 +257,6 @@ options described above.
 --bare::
 	Perform a bare clone.  See linkgit:git-clone[1].
 
--/ <path>::
-	Exclude selected depot paths when cloning.
-
 Submit options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 submit' behavior.
diff --git a/git-p4.py b/git-p4.py
index ff132b2..38029a4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1916,6 +1916,9 @@ class P4Sync(Command, P4UserMap):
                                      help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
                 optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
                                      help="Only sync files that are included in the Perforce Client Spec")
+                optparse.make_option("-/", dest="cloneExclude",
+                                     action="append", type="string",
+                                     help="exclude depot path"),
         ]
         self.description = """Imports from Perforce into a git repository.\n
     example:
@@ -1950,6 +1953,12 @@ class P4Sync(Command, P4UserMap):
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
+    # This is required for the "append" cloneExclude action
+    def ensure_value(self, attr, value):
+        if not hasattr(self, attr) or getattr(self, attr) is None:
+            setattr(self, attr, value)
+        return getattr(self, attr)
+
     # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
@@ -3101,9 +3110,6 @@ class P4Clone(P4Sync):
             optparse.make_option("--destination", dest="cloneDestination",
                                  action='store', default=None,
                                  help="where to leave result of the clone"),
-            optparse.make_option("-/", dest="cloneExclude",
-                                 action="append", type="string",
-                                 help="exclude depot path"),
             optparse.make_option("--bare", dest="cloneBare",
                                  action="store_true", default=False),
         ]
@@ -3111,12 +3117,6 @@ class P4Clone(P4Sync):
         self.needsGit = False
         self.cloneBare = False
 
-    # This is required for the "append" cloneExclude action
-    def ensure_value(self, attr, value):
-        if not hasattr(self, attr) or getattr(self, attr) is None:
-            setattr(self, attr, value)
-        return getattr(self, attr)
-
     def defaultDestination(self, args):
         ## TODO: use common prefix of args?
         depotPath = args[0]
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
new file mode 100755
index 0000000..aac568e
--- /dev/null
+++ b/t/t9817-git-p4-exclude.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='git p4 tests for excluded paths during clone and sync'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+# Create a repo with the structure:
+#
+#    //depot/wanted/foo
+#    //depot/discard/foo
+#
+# Check that we can exclude a subdirectory with both
+# clone and sync operations.
+
+test_expect_success 'create exclude repo' '
+	(
+		cd "$cli" &&
+		mkdir -p wanted discard &&
+		echo wanted >wanted/foo &&
+		echo discard >discard/foo &&
+		p4 add wanted/foo discard/foo &&
+		p4 submit -d "initial revision"
+	)
+'
+
+test_expect_success 'check the repo was created correctly' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot/...@all &&
+	(
+		cd "$git" &&
+		test_path_is_file wanted/foo &&
+		test_path_is_file discard/foo
+	)
+'
+
+test_expect_success 'clone, excluding part of repo' '
+	test_when_finished cleanup_git &&
+	git p4 clone -//depot/discard/... --dest="$git" //depot/...@all &&
+	(
+		cd "$git" &&
+		test_path_is_file wanted/foo &&
+		test_path_is_missing discard/foo
+	)
+'
+
+test_expect_success 'clone, then sync with exclude' '
+	test_when_finished cleanup_git &&
+	git p4 clone -//depot/discard/... --dest="$git" //depot/...@all &&
+	(
+		cd "$cli" &&
+		p4 edit wanted/foo discard/foo &&
+		date >>wanted/foo &&
+		date >>discard/foo &&
+		p4 submit -d "updating" &&
+
+		cd "$git" &&
+		git p4 sync -//depot/discard/... &&
+		test_path_is_file wanted/foo &&
+		test_path_is_missing discard/foo
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.10.4
