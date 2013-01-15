From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 14/14] git p4: fix submit when no master branch
Date: Mon, 14 Jan 2013 19:47:08 -0500
Message-ID: <1358210828-2369-15-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:52:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuulA-0003ze-SH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab3AOAvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:51:53 -0500
Received: from honk.padd.com ([74.3.171.149]:40016 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756803Ab3AOAvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:51:52 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id E0D3F2F3F;
	Mon, 14 Jan 2013 16:51:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8B09D28EC2; Mon, 14 Jan 2013 19:51:49 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213565>

It finds its upstream and applies the commit properly, but
the sync step will fail unless it is told which branch to
work on.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt  |  5 +++++
 git-p4.py                 |  6 +++++-
 t/t9806-git-p4-options.sh | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index e79d046..f70ef9d 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -294,6 +294,11 @@ These options can be used to modify 'git p4 submit' behavior.
 	to bypass the prompt, causing conflicting commits to be automatically
 	skipped, or to quit trying to apply commits, without prompting.
 
+--branch <branch>::
+	After submitting, sync this named branch instead of the default
+	p4/master.  See the "Sync options" section above for more
+	information.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/git-p4.py b/git-p4.py
index 77bde59..2da5649 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -927,7 +927,8 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--dry-run", "-n", dest="dry_run", action="store_true"),
                 optparse.make_option("--prepare-p4-only", dest="prepare_p4_only", action="store_true"),
                 optparse.make_option("--conflict", dest="conflict_behavior",
-                                     choices=self.conflict_behavior_choices)
+                                     choices=self.conflict_behavior_choices),
+                optparse.make_option("--branch", dest="branch"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -940,6 +941,7 @@ class P4Submit(Command, P4UserMap):
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
         self.p4HasMoveCommand = p4_has_move_command()
+        self.branch = None
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
@@ -1676,6 +1678,8 @@ class P4Submit(Command, P4UserMap):
             print "All commits applied!"
 
             sync = P4Sync()
+            if self.branch:
+                sync.branch = self.branch
             sync.run([])
 
             rebase = P4Rebase()
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 8d914a5..4f077ee 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -251,6 +251,31 @@ test_expect_success 'clone --use-client-spec' '
 	)
 '
 
+test_expect_success 'submit works with no p4/master' '
+	test_when_finished cleanup_git &&
+	git p4 clone --branch=b1 //depot@1,2 --destination="$git" &&
+	(
+		cd "$git" &&
+		test_commit submit-1-branch &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --branch=b1
+	)
+'
+
+# The sync/rebase part post-submit will engage detect-branches
+# machinery which will not do anything in this particular test.
+test_expect_success 'submit works with two branches' '
+	test_when_finished cleanup_git &&
+	git p4 clone --branch=b1 //depot@1,2 --destination="$git" &&
+	(
+		cd "$git" &&
+		git p4 sync --branch=b2 //depot@1,3 &&
+		test_commit submit-2-branches &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.1.350.gdbf6fd0
