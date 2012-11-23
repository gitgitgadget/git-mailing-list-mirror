From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/6] git p4: handle servers without move support
Date: Fri, 23 Nov 2012 17:35:35 -0500
Message-ID: <1353710139-16207-3-git-send-email-pw@padd.com>
References: <1353710139-16207-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 23:36:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc1rV-0005SD-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 23:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab2KWWg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 17:36:27 -0500
Received: from honk.padd.com ([74.3.171.149]:35228 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322Ab2KWWg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 17:36:26 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 986CCE9A;
	Fri, 23 Nov 2012 14:36:25 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E03BE27578; Fri, 23 Nov 2012 17:36:19 -0500 (EST)
X-Mailer: git-send-email 1.8.0.360.gc68af86
In-Reply-To: <1353710139-16207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210276>

Support for the "p4 move" command was added in 8e9497c (git p4:
add support for 'p4 move' in P4Submit, 2012-07-12), which checks
to make sure that the client and server support the command.

But older versions of p4d may not handle the "-k" argument, and
newer p4d allow disabling "p4 move" with a configuration setting.
Check for both these cases by testing a p4 move command on bogus
filenames and looking for strings in the error messages.

Reported-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                | 21 ++++++++++++++++++++-
 t/t9814-git-p4-rename.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index cd68e04..9644c9f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -129,6 +129,25 @@ def p4_has_command(cmd):
     p.communicate()
     return p.returncode == 0
 
+def p4_has_move_command():
+    """See if the move command exists, that it supports -k, and that
+       it has not been administratively disabled.  The arguments
+       must be correct, but the filenames do not have to exist.  Use
+       ones with wildcards so even if they exist, it will fail."""
+
+    if not p4_has_command("move"):
+        return False
+    cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
+    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    (out, err) = p.communicate()
+    # return code will be 1 in either case
+    if err.find("Invalid option") >= 0:
+        return False
+    if err.find("disabled") >= 0:
+        return False
+    # assume it failed because @... was invalid changelist
+    return True
+
 def system(cmd):
     expand = isinstance(cmd,basestring)
     if verbose:
@@ -894,7 +913,7 @@ class P4Submit(Command, P4UserMap):
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
-        self.p4HasMoveCommand = p4_has_command("move")
+        self.p4HasMoveCommand = p4_has_move_command()
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 3bf1224..be802e0 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -199,6 +199,41 @@ test_expect_success 'detect copies' '
 	)
 '
 
+# See if configurables can be set, and in particular if the run.move.allow
+# variable exists, which allows admins to disable the "p4 move" command.
+test_expect_success 'p4 configure command and run.move.allow are available' '
+	p4 configure show run.move.allow >out ; retval=$? &&
+	test $retval = 0 &&
+	{
+		egrep ^run.move.allow: out &&
+		test_set_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW ||
+		true
+	} || true
+'
+
+# If move can be disabled, turn it off and test p4 move handling
+test_expect_success P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW \
+		    'do not use p4 move when administratively disabled' '
+	test_when_finished "p4 configure set run.move.allow=1" &&
+	p4 configure set run.move.allow=0 &&
+	(
+		cd "$cli" &&
+		echo move-disallow-file >move-disallow-file &&
+		p4 add move-disallow-file &&
+		p4 submit -d "add move-disallow-file"
+	) &&
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectRenames true &&
+		git mv move-disallow-file move-disallow-file-moved &&
+		git commit -m "move move-disallow-file" &&
+		git p4 submit
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.0.276.gd9397fc
