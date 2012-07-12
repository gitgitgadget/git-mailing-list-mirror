From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 2/2] git p4: add support for 'p4 move' in P4Submit
Date: Thu, 12 Jul 2012 19:29:00 -0400
Message-ID: <1342135740-30290-3-git-send-email-pw@padd.com>
References: <1342135740-30290-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 01:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpSpb-0005Kq-2x
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 01:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161940Ab2GLX3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 19:29:47 -0400
Received: from honk.padd.com ([74.3.171.149]:43168 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161892Ab2GLX3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 19:29:44 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id BEDFB2C1D;
	Thu, 12 Jul 2012 16:29:42 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 88E1431563; Thu, 12 Jul 2012 19:29:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.131.g9e48292
In-Reply-To: <1342135740-30290-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201391>

From: Gary Gibbons <ggibbons@perforce.com>

For -M option (detectRenames) in P4Submit, use 'p4 move' rather
than 'p4 integrate'.  Check Perforce server for exisitence of
'p4 move' and use it if present, otherwise revert to 'p4 integrate'.

[pw: wildcard-encode src/dest, add/update tests, tweak code]

Signed-off-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                | 34 ++++++++++++++++++++++++++--------
 t/t9814-git-p4-rename.sh | 16 ++++++++--------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5fe509f..b79e6f0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -120,6 +120,15 @@ def p4_read_pipe_lines(c):
     real_cmd = p4_build_cmd(c)
     return read_pipe_lines(real_cmd)
 
+def p4_has_command(cmd):
+    """Ask p4 for help on this command.  If it returns an error, the
+       command does not exist in this version of p4."""
+    real_cmd = p4_build_cmd(["help", cmd])
+    p = subprocess.Popen(real_cmd, stdout=subprocess.PIPE,
+                                   stderr=subprocess.PIPE)
+    p.communicate()
+    return p.returncode == 0
+
 def system(cmd):
     expand = isinstance(cmd,basestring)
     if verbose:
@@ -157,6 +166,9 @@ def p4_revert(f):
 def p4_reopen(type, f):
     p4_system(["reopen", "-t", type, wildcard_encode(f)])
 
+def p4_move(src, dest):
+    p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
+
 #
 # Canonicalize the p4 type and return a tuple of the
 # base type, plus any modifiers.  See "p4 help filetypes"
@@ -850,6 +862,7 @@ class P4Submit(Command, P4UserMap):
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
+        self.p4HasMoveCommand = p4_has_command("move") 
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
@@ -1046,7 +1059,6 @@ class P4Submit(Command, P4UserMap):
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
-
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -1087,17 +1099,23 @@ class P4Submit(Command, P4UserMap):
                 editedFiles.add(dest)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
-                p4_integrate(src, dest)
-                if diff['src_sha1'] != diff['dst_sha1']:
-                    p4_edit(dest)
+                if self.p4HasMoveCommand:
+                    p4_edit(src)        # src must be open before move
+                    p4_move(src, dest)  # opens for (move/delete, move/add)
                 else:
-                    pureRenameCopy.add(dest)
+                    p4_integrate(src, dest)
+                    if diff['src_sha1'] != diff['dst_sha1']:
+                        p4_edit(dest)
+                    else:
+                        pureRenameCopy.add(dest)
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
-                    p4_edit(dest)
+                    if not self.p4HasMoveCommand:
+                        p4_edit(dest)   # with move: already open, writable
                     filesToChangeExecBit[dest] = diff['dst_mode']
-                os.unlink(dest)
+                if not self.p4HasMoveCommand:
+                    os.unlink(dest)
+                    filesToDelete.add(src)
                 editedFiles.add(dest)
-                filesToDelete.add(src)
             else:
                 die("unknown modifier %s for %s" % (modifier, path))
 
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 84fffb3..3bf1224 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -77,16 +77,16 @@ test_expect_success 'detect renames' '
 		git commit -a -m "Rename file1 to file4" &&
 		git diff-tree -r -M HEAD &&
 		git p4 submit &&
-		p4 filelog //depot/file4 &&
-		p4 filelog //depot/file4 | test_must_fail grep -q "branch from" &&
+		p4 filelog //depot/file4 >filelog &&
+		! grep " from //depot" filelog &&
 
 		git mv file4 file5 &&
 		git commit -a -m "Rename file4 to file5" &&
 		git diff-tree -r -M HEAD &&
 		git config git-p4.detectRenames true &&
 		git p4 submit &&
-		p4 filelog //depot/file5 &&
-		p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
+		p4 filelog //depot/file5 >filelog &&
+		grep " from //depot/file4" filelog &&
 
 		git mv file5 file6 &&
 		echo update >>file6 &&
@@ -97,8 +97,8 @@ test_expect_success 'detect renames' '
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		git config git-p4.detectRenames $(($level + 2)) &&
 		git p4 submit &&
-		p4 filelog //depot/file6 &&
-		p4 filelog //depot/file6 | test_must_fail grep -q "branch from" &&
+		p4 filelog //depot/file6 >filelog &&
+		! grep " from //depot" filelog &&
 
 		git mv file6 file7 &&
 		echo update >>file7 &&
@@ -109,8 +109,8 @@ test_expect_success 'detect renames' '
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		git config git-p4.detectRenames $(($level - 2)) &&
 		git p4 submit &&
-		p4 filelog //depot/file7 &&
-		p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
+		p4 filelog //depot/file7 >filelog &&
+		grep " from //depot/file6" filelog
 	)
 '
 
-- 
1.7.11.1.72.g3344471
