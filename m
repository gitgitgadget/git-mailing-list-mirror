From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 11/11] git-p4: document and test submit options
Date: Sat, 24 Dec 2011 21:07:40 -0500
Message-ID: <1324778860-4821-12-git-send-email-pw@padd.com>
References: <1324778860-4821-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 03:11:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RedYe-0001Tu-Pm
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 03:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058Ab1LYCLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 21:11:25 -0500
Received: from honk.padd.com ([74.3.171.149]:51324 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758056Ab1LYCLY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 21:11:24 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id A4A3231BF;
	Sat, 24 Dec 2011 18:11:23 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 38661315E1; Sat, 24 Dec 2011 21:11:21 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.398.gf9d11
In-Reply-To: <1324778860-4821-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187674>

Clarify there is a -M option, but no -C.  These are both
configurable through variables.

Explain that the allowSubmit variable takes a comma-separated
list of branch names.

Catch earlier an invalid branch name given as an argument to
"git p4 clone".

Test option --origin, variable allowSubmit, and explicit master
branch name.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt   |    8 +++++-
 contrib/fast-import/git-p4 |    7 +++++
 t/t9807-git-p4-submit.sh   |   54 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3092571..f97b1c5 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -267,7 +267,9 @@ These options can be used to modify 'git p4 submit' behavior.
 
 -M[<n>]::
 	Detect renames.  See linkgit:git-diff[1].  Renames will be
-	represented in p4 using explicit 'move' operations.
+	represented in p4 using explicit 'move' operations.  There
+	is no corresponding option to detect copies, but there are
+	variables for both moves and copies.
 
 --preserve-user::
 	Re-author p4 changes before submitting to p4.  This option
@@ -453,7 +455,9 @@ git-p4.skipSubmitEditCheck::
 git-p4.allowSubmit::
 	By default, any branch can be used as the source for a 'git p4
 	submit' operation.  This configuration variable, if set, permits only
-	the named branches to be used as submit sources.
+	the named branches to be used as submit sources.  Branch names
+	must be the short names (no "refs/heads/"), and should be
+	separated by commas (","), with no spaces.
 
 git-p4.skipUserNameCheck::
 	If the user running 'git p4 submit' does not exist in the p4
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 5420bf1..d3c3ad8 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -362,6 +362,11 @@ def isValidGitDir(path):
 def parseRevision(ref):
     return read_pipe("git rev-parse %s" % ref).strip()
 
+def branchExists(ref):
+    rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
+                     ignore_error=True)
+    return len(rev) > 0
+
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
@@ -1089,6 +1094,8 @@ class P4Submit(Command, P4UserMap):
                 die("Detecting current git branch failed!")
         elif len(args) == 1:
             self.master = args[0]
+            if not branchExists(self.master):
+                die("Branch %s does not exist" % self.master)
         else:
             return False
 
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 2cb724e..b1f61e3 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -31,6 +31,60 @@ test_expect_success 'submit with no client dir' '
 	)
 '
 
+# make two commits, but tell it to apply only from HEAD^
+test_expect_success 'submit --origin' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "file3" &&
+		test_commit "file4" &&
+		git config git-p4.skipSubmitEdit true &&
+		"$GITP4" submit --origin=HEAD^
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		test_path_is_missing "file3.t" &&
+		test_path_is_file "file4.t"
+	)
+'
+
+test_expect_success 'submit with allowSubmit' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "file5" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.allowSubmit "nobranch" &&
+		test_must_fail "$GITP4" submit &&
+		git config git-p4.allowSubmit "nobranch,master" &&
+		"$GITP4" submit
+	)
+'
+
+test_expect_success 'submit with master branch name from argv' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "file6" &&
+		git config git-p4.skipSubmitEdit true &&
+		test_must_fail "$GITP4" submit nobranch &&
+		git branch otherbranch &&
+		git reset --hard HEAD^ &&
+		test_commit "file7" &&
+		"$GITP4" submit otherbranch
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		test_path_is_file "file6.t" &&
+		test_path_is_missing "file7.t"
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.534.g03ab.dirty
