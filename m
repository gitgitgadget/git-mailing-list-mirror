From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 12/12] git-p4: add submit --conflict option and config varaiable
Date: Sun,  9 Sep 2012 16:16:13 -0400
Message-ID: <1347221773-12773-13-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:20:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnzb-00069N-DJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab2IIUUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:20:19 -0400
Received: from honk.padd.com ([74.3.171.149]:53033 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024Ab2IIUUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:20:17 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 06FA85AF2;
	Sun,  9 Sep 2012 13:20:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A272132112; Sun,  9 Sep 2012 16:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205102>

This allows specifying what to do when a conflict
happens when applying a commit to p4, automating the
interactive prompt.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt      | 11 ++++++++
 git-p4.py                     | 36 +++++++++++++++++++++----
 t/t9815-git-p4-submit-fail.sh | 63 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 4be4290..beff622 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -280,6 +280,13 @@ These options can be used to modify 'git p4 submit' behavior.
 	submit manually or revert.  This option always stops after the
 	first (oldest) commit.  Git tags are not exported to p4.
 
+--conflict=(ask|skip|quit)::
+	Conflicts can occur when applying a commit to p4.  When this
+	happens, the default behavior ("ask") is to prompt whether to
+	skip this commit and continue, or quit.  This option can be used
+	to bypass the prompt, causing conflicting commits to be automatically
+	skipped, or to quit trying to apply commits, without prompting.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
@@ -530,6 +537,10 @@ git-p4.labelExportRegexp::
 	Only p4 labels matching this regular expression will be exported. The
 	default value is '[a-zA-Z0-9_\-.]+$'.
 
+git-p4.conflict::
+	Specify submit behavior when a conflict with p4 is found, as per
+	--conflict.  The default behavior is 'ask'.
+
 IMPLEMENTATION DETAILS
 ----------------------
 * Changesets from p4 are imported using git fast-import.
diff --git a/git-p4.py b/git-p4.py
index 2dd2b76..96f6bc0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -844,6 +844,9 @@ class P4RollBack(Command):
         return True
 
 class P4Submit(Command, P4UserMap):
+
+    conflict_behavior_choices = ("ask", "skip", "quit")
+
     def __init__(self):
         Command.__init__(self)
         P4UserMap.__init__(self)
@@ -855,6 +858,8 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--export-labels", dest="exportLabels", action="store_true"),
                 optparse.make_option("--dry-run", "-n", dest="dry_run", action="store_true"),
                 optparse.make_option("--prepare-p4-only", dest="prepare_p4_only", action="store_true"),
+                optparse.make_option("--conflict", dest="conflict_behavior",
+                                     choices=self.conflict_behavior_choices)
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -863,6 +868,7 @@ class P4Submit(Command, P4UserMap):
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.dry_run = False
         self.prepare_p4_only = False
+        self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
         self.p4HasMoveCommand = p4_has_command("move")
@@ -1445,6 +1451,16 @@ class P4Submit(Command, P4UserMap):
             if not self.canChangeChangelists():
                 die("Cannot preserve user names without p4 super-user or admin permissions")
 
+        # if not set from the command line, try the config file
+        if self.conflict_behavior is None:
+            val = gitConfig("git-p4.conflict")
+            if val:
+                if val not in self.conflict_behavior_choices:
+                    die("Invalid value '%s' for config git-p4.conflict" % val)
+            else:
+                val = "ask"
+            self.conflict_behavior = val
+
         if self.verbose:
             print "Origin branch is " + self.origin
 
@@ -1557,11 +1573,21 @@ class P4Submit(Command, P4UserMap):
                 if i < last:
                     quit = False
                     while True:
-                        print "What do you want to do?"
-                        response = raw_input("[s]kip this commit but apply"
-                                             " the rest, or [q]uit? ")
-                        if not response:
-                            continue
+                        # prompt for what to do, or use the option/variable
+                        if self.conflict_behavior == "ask":
+                            print "What do you want to do?"
+                            response = raw_input("[s]kip this commit but apply"
+                                                 " the rest, or [q]uit? ")
+                            if not response:
+                                continue
+                        elif self.conflict_behavior == "skip":
+                            response = "s"
+                        elif self.conflict_behavior == "quit":
+                            response = "q"
+                        else:
+                            die("Unknown conflict_behavior '%s'" %
+                                self.conflict_behavior)
+
                         if response[0] == "s":
                             print "Skipping this commit, but applying the rest"
                             break
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 1823cff..d2b7b3d 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -108,6 +108,69 @@ test_expect_success 'conflict on first of two commits, quit' '
 	)
 '
 
+test_expect_success 'conflict cli and config options' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git p4 submit --conflict=ask &&
+		git p4 submit --conflict=skip &&
+		git p4 submit --conflict=quit &&
+		test_expect_code 2 git p4 submit --conflict=foo &&
+		test_expect_code 2 git p4 submit --conflict &&
+		git config git-p4.conflict foo &&
+		test_expect_code 1 git p4 submit &&
+		git config --unset git-p4.conflict &&
+		git p4 submit
+	)
+'
+
+test_expect_success 'conflict on first of two commits, --conflict=skip' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 open file1 &&
+		echo line9 >>file1 &&
+		p4 submit -d "line9 in file1"
+	) &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		# this submit should cause a conflict
+		echo line10 >>file1 &&
+		git add file1 &&
+		git commit -m "line10 in file1 will conflict" &&
+		# but this commit is okay
+		test_commit "okay_commit_after_auto_skip" &&
+		test_expect_code 1 git p4 submit --conflict=skip >out &&
+		test_i18ngrep "Applied only the commits" out
+	)
+'
+
+test_expect_success 'conflict on first of two commits, --conflict=quit' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 open file1 &&
+		echo line11 >>file1 &&
+		p4 submit -d "line11 in file1"
+	) &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		# this submit should cause a conflict
+		echo line12 >>file1 &&
+		git add file1 &&
+		git commit -m "line12 in file1 will conflict" &&
+		# but this commit is okay
+		test_commit "okay_commit_after_auto_quit" &&
+		test_expect_code 1 git p4 submit --conflict=quit >out &&
+		test_i18ngrep "No commits applied" out
+	)
+'
+
 #
 # Cleanup after submit fail, all cases.  Some modifications happen
 # before trying to apply the patch.  Make sure these are unwound
-- 
1.7.12.rc2.111.g96f7c73
