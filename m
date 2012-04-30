From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/4] git p4: bring back files in deleted client directory
Date: Sun, 29 Apr 2012 20:57:14 -0400
Message-ID: <1335747437-24034-2-git-send-email-pw@padd.com>
References: <1335747437-24034-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 02:57:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOevz-0003Mf-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab2D3A5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:57:45 -0400
Received: from honk.padd.com ([74.3.171.149]:36586 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2D3A5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:57:40 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id BC65D620A;
	Sun, 29 Apr 2012 17:57:39 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9956D313F8; Sun, 29 Apr 2012 20:57:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.572.ged86f
In-Reply-To: <1335747437-24034-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196527>

The code to auto-create the client directory, added in 0591cfa
(git-p4: ensure submit clientPath exists before chdir,
2011-12-09), works when the client directory never existed.

But if the directory is summarily removed without telling p4,
the sync operation will not bring back all the files.  Always
do "sync -f" if the client directory is newly created.

Reported-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                |   12 +++++++++---
 t/t9807-git-p4-submit.sh |    7 +++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f910d5a..a2eba5d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -133,8 +133,8 @@ def p4_system(cmd):
 def p4_integrate(src, dest):
     p4_system(["integrate", "-Dt", src, dest])
 
-def p4_sync(path):
-    p4_system(["sync", path])
+def p4_sync(f, *options):
+    p4_system(["sync"] + list(options) + [f])
 
 def p4_add(f):
     p4_system(["add", f])
@@ -1279,12 +1279,18 @@ class P4Submit(Command, P4UserMap):
         self.oldWorkingDirectory = os.getcwd()
 
         # ensure the clientPath exists
+        new_client_dir = False
         if not os.path.exists(self.clientPath):
+            new_client_dir = True
             os.makedirs(self.clientPath)
 
         chdir(self.clientPath)
         print "Synchronizing p4 checkout..."
-        p4_sync("...")
+        if new_client_dir:
+            # old one was destroyed, and maybe nobody told p4
+            p4_sync("...", "-f")
+        else:
+            p4_sync("...")
         self.check()
 
         commits = []
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 1541716..2d7dc27 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -28,6 +28,11 @@ test_expect_success 'submit with no client dir' '
 		rm -rf "$cli" &&
 		git config git-p4.skipSubmitEdit true &&
 		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file file1 &&
+		test_path_is_file file2
 	)
 '
 
@@ -44,7 +49,6 @@ test_expect_success 'submit --origin' '
 	) &&
 	(
 		cd "$cli" &&
-		p4 sync &&
 		test_path_is_missing "file3.t" &&
 		test_path_is_file "file4.t"
 	)
@@ -79,7 +83,6 @@ test_expect_success 'submit with master branch name from argv' '
 	) &&
 	(
 		cd "$cli" &&
-		p4 sync &&
 		test_path_is_file "file6.t" &&
 		test_path_is_missing "file7.t"
 	)
-- 
1.7.10.366.g90ade
