From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 10/12] git p4: add submit --dry-run option
Date: Sun,  9 Sep 2012 16:16:11 -0400
Message-ID: <1347221773-12773-11-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:19:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnyr-0005d5-8K
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab2IIUTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:19:38 -0400
Received: from honk.padd.com ([74.3.171.149]:53023 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2IIUTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:19:37 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id DBBB85AF2;
	Sun,  9 Sep 2012 13:19:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 84FC332112; Sun,  9 Sep 2012 16:19:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205100>

A new option, "git p4 submit --dry-run" can be used to verify
what commits and labels would be moved into p4.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt |  4 ++++
 git-p4.py                | 43 ++++++++++++++++++++++++++++++-------------
 t/t9807-git-p4-submit.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 4b03356..1f32b8e 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -269,6 +269,10 @@ These options can be used to modify 'git p4 submit' behavior.
 	Export tags from git as p4 labels. Tags found in git are applied
 	to the perforce working directory.
 
+--dry-run, -n::
+	Show just what commits would be submitted to p4; do not change
+	state in git or p4.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/git-p4.py b/git-p4.py
index 464f64d..04e9a80 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -853,12 +853,14 @@ class P4Submit(Command, P4UserMap):
                 # preserve the user, requires relevant p4 permissions
                 optparse.make_option("--preserve-user", dest="preserveUser", action="store_true"),
                 optparse.make_option("--export-labels", dest="exportLabels", action="store_true"),
+                optparse.make_option("--dry-run", "-n", dest="dry_run", action="store_true"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
         self.detectRenames = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
+        self.dry_run = False
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
         self.p4HasMoveCommand = p4_has_command("move")
@@ -1366,14 +1368,17 @@ class P4Submit(Command, P4UserMap):
             for mapping in clientSpec.mappings:
                 labelTemplate += "\t%s\n" % mapping.depot_side.path
 
-            p4_write_pipe(["label", "-i"], labelTemplate)
+            if self.dry_run:
+                print "Would create p4 label %s for tag" % name
+            else:
+                p4_write_pipe(["label", "-i"], labelTemplate)
 
-            # Use the label
-            p4_system(["tag", "-l", name] +
-                      ["%s@%s" % (mapping.depot_side.path, changelist) for mapping in clientSpec.mappings])
+                # Use the label
+                p4_system(["tag", "-l", name] +
+                          ["%s@%s" % (mapping.depot_side.path, changelist) for mapping in clientSpec.mappings])
 
-            if verbose:
-                print "created p4 label for tag %s" % name
+                if verbose:
+                    print "created p4 label for tag %s" % name
 
     def run(self, args):
         if len(args) == 0:
@@ -1432,12 +1437,15 @@ class P4Submit(Command, P4UserMap):
             os.makedirs(self.clientPath)
 
         chdir(self.clientPath)
-        print "Synchronizing p4 checkout..."
-        if new_client_dir:
-            # old one was destroyed, and maybe nobody told p4
-            p4_sync("...", "-f")
+        if self.dry_run:
+            print "Would synchronize p4 checkout in %s" % self.clientPath
         else:
-            p4_sync("...")
+            print "Synchronizing p4 checkout..."
+            if new_client_dir:
+                # old one was destroyed, and maybe nobody told p4
+                p4_sync("...", "-f")
+            else:
+                p4_sync("...")
         self.check()
 
         commits = []
@@ -1488,10 +1496,17 @@ class P4Submit(Command, P4UserMap):
         # Apply the commits, one at a time.  On failure, ask if should
         # continue to try the rest of the patches, or quit.
         #
+        if self.dry_run:
+            print "Would apply"
         applied = []
         last = len(commits) - 1
         for i, commit in enumerate(commits):
-            ok = self.applyCommit(commit)
+            if self.dry_run:
+                print " ", read_pipe(["git", "show", "-s",
+                                      "--format=format:%h %s", commit])
+                ok = True
+            else:
+                ok = self.applyCommit(commit)
             if ok:
                 applied.append(commit)
             else:
@@ -1515,7 +1530,9 @@ class P4Submit(Command, P4UserMap):
 
         chdir(self.oldWorkingDirectory)
 
-        if len(commits) == len(applied):
+        if self.dry_run:
+            pass
+        elif len(commits) == len(applied):
             print "All commits applied!"
 
             sync = P4Sync()
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 9394fd4..9cb6aa7 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -54,6 +54,47 @@ test_expect_success 'submit --origin' '
 	)
 '
 
+test_expect_success 'submit --dry-run' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "dry-run1" &&
+		test_commit "dry-run2" &&
+		git p4 submit --dry-run >out &&
+		test_i18ngrep "Would apply" out
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing "dry-run1.t" &&
+		test_path_is_missing "dry-run2.t"
+	)
+'
+
+test_expect_success 'submit --dry-run --export-labels' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo dry-run1 >dry-run1 &&
+		git add dry-run1 &&
+		git commit -m "dry-run1" dry-run1 &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit &&
+		echo dry-run2 >dry-run2 &&
+		git add dry-run2 &&
+		git commit -m "dry-run2" dry-run2 &&
+		git tag -m "dry-run-tag1" dry-run-tag1 HEAD^ &&
+		git p4 submit --dry-run --export-labels >out &&
+		test_i18ngrep "Would create p4 label" out
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file "dry-run1" &&
+		test_path_is_missing "dry-run2"
+	)
+'
+
 test_expect_success 'submit with allowSubmit' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
-- 
1.7.12.rc2.111.g96f7c73
