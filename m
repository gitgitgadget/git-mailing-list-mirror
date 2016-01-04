From: Romain Picard <romain.picard@oakbits.com>
Subject: [PATCH v2] git-p4.py: add support for filetype change
Date: Mon,  4 Jan 2016 11:52:44 +0100
Message-ID: <1451904764-338-1-git-send-email-romain.picard@oakbits.com>
Cc: larsxschneider@gmail.com, sunshine@sunshineco.com,
	git-owner@vger.kernel.org,
	Romain Picard <romain.picard@oakbits.com>
To: git@vger.kernel.org, luke@diamand.org
X-From: git-owner@vger.kernel.org Mon Jan 04 13:00:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG3nq-00032t-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 12:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbcADL7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 06:59:50 -0500
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:55284 "EHLO
	11.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbcADL7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 06:59:46 -0500
X-Greylist: delayed 2111 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2016 06:59:46 EST
Received: from mail436.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 8D4B1FFB3D7
	for <git@vger.kernel.org>; Mon,  4 Jan 2016 11:49:34 +0100 (CET)
Received: from localhost (HELO queueout) (127.0.0.1)
	by localhost with SMTP; 4 Jan 2016 12:49:33 +0200
Received: from unknown (HELO sahnlpt0238.softathome.com) (romain.picard@oakbits.com@149.6.166.170)
  by ns0.ovh.net with SMTP; 4 Jan 2016 12:49:32 +0200
X-Mailer: git-send-email 2.6.4
X-Ovh-Tracer-Id: 5637380834701042142
X-Ovh-Remote: 149.6.166.170 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekiedrieejucetufdoteggodftvfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekiedrieejgddulecutefuodetggdotffvucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283297>

After changing the type of a file in the git repository, it is not possible to
"git p4 publish" the commit to perforce. This is due to the fact that the git
"T" status is not handled in git-p4.py. This can typically occur when replacing
an existing file with a symbolic link.

The "T" modifier is now supported in git-p4.py. When a file type has changed,
inform perforce with the "p4 edit -f auto" command.

Signed-off-by: Romain Picard <romain.picard@oakbits.com>
---
 git-p4.py                         |  9 +++--
 t/t9827-git-p4-change-filetype.sh | 69 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100755 t/t9827-git-p4-change-filetype.sh

diff --git a/git-p4.py b/git-p4.py
index a7ec118..b7a3494 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -240,8 +240,8 @@ def p4_add(f):
 def p4_delete(f):
     p4_system(["delete", wildcard_encode(f)])
 
-def p4_edit(f):
-    p4_system(["edit", wildcard_encode(f)])
+def p4_edit(f, *options):
+    p4_system(["edit"] + list(options) + [wildcard_encode(f)])
 
 def p4_revert(f):
     p4_system(["revert", wildcard_encode(f)])
@@ -1344,6 +1344,7 @@ class P4Submit(Command, P4UserMap):
 
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
         filesToAdd = set()
+        filesToChangeType = set()
         filesToDelete = set()
         editedFiles = set()
         pureRenameCopy = set()
@@ -1404,6 +1405,8 @@ class P4Submit(Command, P4UserMap):
                     os.unlink(dest)
                     filesToDelete.add(src)
                 editedFiles.add(dest)
+            elif modifier == "T":
+                filesToChangeType.add(path)
             else:
                 die("unknown modifier %s for %s" % (modifier, path))
 
@@ -1463,6 +1466,8 @@ class P4Submit(Command, P4UserMap):
         #
         system(applyPatchCmd)
 
+        for f in filesToChangeType:
+            p4_edit(f, "-t", "auto")
         for f in filesToAdd:
             p4_add(f)
         for f in filesToDelete:
diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
new file mode 100755
index 0000000..b0a9f62
--- /dev/null
+++ b/t/t9827-git-p4-change-filetype.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Romain Picard
+#
+
+test_description='git p4 support for file type change'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'create files' '
+	(
+		cd "$cli" &&
+		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
+		cat >file1 <<-EOF &&
+		This is a first file.
+		EOF
+		cat >file2 <<-EOF &&
+		This is a second file whose type will change.
+		EOF
+		p4 add file1 file2 &&
+		p4 submit -d "add files"
+	)
+'
+
+test_expect_success 'change file to symbolic link' '
+	git p4 clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+
+		rm file2 &&
+		ln -s file1 file2 &&
+		git add file2 &&
+		git commit -m "symlink file1 to file2" &&
+		git p4 submit &&
+		p4 filelog -m 1 //depot/file2 >filelog &&
+		grep "(symlink)" filelog
+	)
+'
+
+test_expect_success 'change symbolic link to file' '
+	git p4 clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+
+		rm file2 &&
+		cat >file2 <<-EOF &&
+		This is another content for the second file.
+		EOF
+		git add file2 &&
+		git commit -m "re-write file2" &&
+		git p4 submit &&
+		p4 filelog -m 1 //depot/file2 >filelog &&
+		grep "(text)" filelog
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.6.4
