From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 12/12] git p4: add submit --prepare-p4-only option
Date: Thu, 16 Aug 2012 19:35:14 -0400
Message-ID: <1345160114-27654-13-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29eu-0006Ws-QL
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab2HPXjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:39:19 -0400
Received: from honk.padd.com ([74.3.171.149]:47787 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab2HPXjS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:39:18 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id D9969D27;
	Thu, 16 Aug 2012 16:39:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A1D3B313FD; Thu, 16 Aug 2012 19:39:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option can be used to prepare the client workspace for
submission, only.  It does not invoke the final "p4 submit".
A message describes how to proceed, either submitting the
changes or reverting.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt |  7 +++++++
 git-p4.py                | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t9807-git-p4-submit.sh | 24 ++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 1f32b8e..4be4290 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -273,6 +273,13 @@ These options can be used to modify 'git p4 submit' behavior.
 	Show just what commits would be submitted to p4; do not change
 	state in git or p4.
 
+--prepare-p4-only::
+	Apply a commit to the p4 workspace, opening, adding and deleting
+	files in p4 as for a normal submit operation.  Do not issue the
+	final "p4 submit", but instead print a message about how to
+	submit manually or revert.  This option always stops after the
+	first (oldest) commit.  Git tags are not exported to p4.
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/git-p4.py b/git-p4.py
index 161d106..6d2f47e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -854,6 +854,7 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--preserve-user", dest="preserveUser", action="store_true"),
                 optparse.make_option("--export-labels", dest="exportLabels", action="store_true"),
                 optparse.make_option("--dry-run", "-n", dest="dry_run", action="store_true"),
+                optparse.make_option("--prepare-p4-only", dest="prepare_p4_only", action="store_true"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -861,6 +862,7 @@ class P4Submit(Command, P4UserMap):
         self.detectRenames = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.dry_run = False
+        self.prepare_p4_only = False
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
         self.p4HasMoveCommand = p4_has_command("move")
@@ -1270,6 +1272,41 @@ class P4Submit(Command, P4UserMap):
         tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
         tmpFile.close()
 
+        if self.prepare_p4_only:
+            #
+            # Leave the p4 tree prepared, and the submit template around
+            # and let the user decide what to do next
+            #
+            print
+            print "P4 workspace prepared for submission."
+            print "To submit or revert, go to client workspace"
+            print "  " + self.clientPath
+            print
+            print "To submit, use \"p4 submit\" to write a new description,"
+            print "or \"p4 submit -i %s\" to use the one prepared by" \
+                  " \"git p4\"." % fileName
+            print "You can delete the file \"%s\" when finished." % fileName
+
+            if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
+                print "To preserve change ownership by user %s, you must\n" \
+                      "do \"p4 change -f <change>\" after submitting and\n" \
+                      "edit the User field."
+            if pureRenameCopy:
+                print "After submitting, renamed files must be re-synced."
+                print "Invoke \"p4 sync -f\" on each of these files:"
+                for f in pureRenameCopy:
+                    print "  " + f
+
+            print
+            print "To revert the changes, use \"p4 revert ...\", and delete"
+            print "the submit template file \"%s\"" % fileName
+            if filesToAdd:
+                print "Since the commit adds new files, they must be deleted:"
+                for f in filesToAdd:
+                    print "  " + f
+            print
+            return True
+
         #
         # Let the user edit the change description, then submit it.
         #
@@ -1370,6 +1407,9 @@ class P4Submit(Command, P4UserMap):
 
             if self.dry_run:
                 print "Would create p4 label %s for tag" % name
+            elif self.prepare_p4_only:
+                print "Not creating p4 label %s for tag due to option" \
+                      " --prepare-p4-only" % name
             else:
                 p4_write_pipe(["label", "-i"], labelTemplate)
 
@@ -1510,6 +1550,10 @@ class P4Submit(Command, P4UserMap):
             if ok:
                 applied.append(commit)
             else:
+                if self.prepare_p4_only and i < last:
+                    print "Processing only the first commit due to option" \
+                          " --prepare-p4-only"
+                    break
                 if i < last:
                     quit = False
                     while True:
@@ -1532,6 +1576,8 @@ class P4Submit(Command, P4UserMap):
 
         if self.dry_run:
             pass
+        elif self.prepare_p4_only:
+            pass
         elif len(commits) == len(applied):
             print "All commits applied!"
 
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 9cb6aa7..0ae048f 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -375,6 +375,30 @@ test_expect_success 'description with Jobs section and bogus following text' '
 		make_job $(cat jobname) &&
 		test_must_fail git p4 submit 2>err &&
 		test_i18ngrep "Unknown field name" err
+	) &&
+	(
+		cd "$cli" &&
+		p4 revert desc6 &&
+		rm desc6
+	)
+'
+
+test_expect_success 'submit --prepare-p4-only' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo prep-only-add >prep-only-add &&
+		git add prep-only-add &&
+		git commit -m "prep only add" &&
+		git p4 submit --prepare-p4-only >out &&
+		test_i18ngrep "prepared for submission" out &&
+		test_i18ngrep "must be deleted" out
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file prep-only-add &&
+		p4 fstat -T action prep-only-add | grep -w add
 	)
 '
 
-- 
1.7.11.4
