From: Romain Picard <romain.picard@oakbits.com>
Subject: [PATCH] git-p4.py: add support for filetype change
Date: Mon, 21 Dec 2015 14:09:25 +0100
Message-ID: <1450703365-10427-1-git-send-email-romain.picard@oakbits.com>
Cc: Romain Picard <romain.picard@oakbits.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 15:23:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB1Mu-0001cc-PB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 15:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbbLUOXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 09:23:16 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:43823 "EHLO
	4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbLUOXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 09:23:15 -0500
X-Greylist: delayed 2409 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2015 09:23:15 EST
Received: from mail184.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 0855FFFC412
	for <git@vger.kernel.org>; Mon, 21 Dec 2015 14:06:12 +0100 (CET)
Received: from localhost (HELO queueout) (127.0.0.1)
	by localhost with SMTP; 21 Dec 2015 15:06:12 +0200
Received: from unknown (HELO sahnlpt0238.softathome.com) (romain.picard@oakbits.com@149.6.166.170)
  by ns0.ovh.net with SMTP; 21 Dec 2015 15:06:06 +0200
X-Mailer: git-send-email 2.6.4
X-Ovh-Tracer-Id: 17959792365144203742
X-Ovh-Remote: 149.6.166.170 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekiedrgeduucetufdoteggodftvfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekiedrgedugdegiecutefuodetggdotffvucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282793>

After changing the type of a file in the git repository, it is not possible to
"git p4 publish" the commit to perforce. This is due to the fact that the git
"T" status is not handled in git-p4.py. This can typically occur when replacing
an existing file with a symbolic link.

The "T" modifier is now supported in git-p4.py. When a file type has changed,
inform perforce with the "p4 edit -f auto" command.

Signed-off-by: Romain Picard <romain.picard@oakbits.com>
---
 git-p4.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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
-- 
2.6.4
