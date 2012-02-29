From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] Make git-{pull,rebase} message without tracking information friendlier
Date: Wed, 29 Feb 2012 19:41:54 +0100
Message-ID: <1330540914-14515-1-git-send-email-cmn@elego.de>
References: <vpqbooit61u.fsf@bauges.imag.fr>
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 29 19:42:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2oTZ-0006LP-FL
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 19:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187Ab2B2Sl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 13:41:56 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:60199 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966008Ab2B2Sl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 13:41:56 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 1AB9546085;
	Wed, 29 Feb 2012 19:41:49 +0100 (CET)
Received: (nullmailer pid 14549 invoked by uid 1000);
	Wed, 29 Feb 2012 18:41:54 -0000
X-Mailer: git-send-email 1.7.8.352.g876a6f
In-Reply-To: <vpqbooit61u.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191841>

The current message is too long and at too low a level for anybody to
understand it if they don't know about the configuration format
already.

The text about setting up a remote is superfluous and doesn't help
understand the error that has happened. Explain how to set up the
tracking information, as it's the most likely way to get to the state
the user was expecting.

Also simplify the message we print on detached HEAD to remove clutter
and a reference to branch.<branchname>.merge which is better left for
the documentation.
---

This still needs some shell scripting to figure out whether we'd want
to replace <remote> with a real value. The text gets to the matter of
things and even tells you how to fix it. More text doesn't really add
more useful information, and this isn't a manpage.

I've left the branch --set-upstream in this version as it's probably
the most usual fix for a failing git push.

 git-parse-remote.sh |   32 ++++++++++----------------------
 git-pull.sh         |    2 +-
 git-rebase.sh       |    2 +-
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index b24119d..08adc90 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -60,31 +60,19 @@ error_on_missing_default_upstream () {
 	if test -z "$branch_name"
 	then
 		echo "You are not currently on a branch, so I cannot use any
-'branch.<branchname>.merge' in your configuration file.
-Please specify which branch you want to $op_type $op_prep on the command
-line and try again (e.g. '$example').
-See git-${cmd}(1) for details."
-	else
-		echo "You asked me to $cmd without telling me which branch you
-want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merge' in
-your configuration file does not tell me, either. Please
-specify which branch you want to use on the command line and
-try again (e.g. '$example').
+tracking information in your configuration file.
+Please specify which branch you want to $op_type $op_prep.
 See git-${cmd}(1) for details.
 
-If you often $op_type $op_prep the same branch, you may want to
-use something like the following in your configuration file:
-    [branch \"${branch_name#refs/heads/}\"]
-    remote = <nickname>
-    merge = <remote-ref>"
-		test rebase = "$op_type" &&
-		echo "    rebase = true"
-		echo "
-    [remote \"<nickname>\"]
-    url = <url>
-    fetch = <refspec>
+    $example"
+	else
+		echo "You asked me to $cmd without specifying a branch to
+$op_type $op_prep, and the current branch doesn't have any tracking
+information. Please specify a branch and try again. See git-${cmd}(1)
+for details. To set the tracking information, you can use
 
-See git-config(1) for details."
+    git branch --set-upstream ${branch_name#refs/heads/} <remote>/<branch>
+"
 	fi
 	exit 1
 }
diff --git a/git-pull.sh b/git-pull.sh
index d8b64d7..309c7db 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -176,7 +176,7 @@ error_on_no_merge_candidates () {
 	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
 		. git-parse-remote
 		error_on_missing_default_upstream "pull" $op_type $op_prep \
-			"git pull <repository> <refspec>"
+			"git pull <remote> <branch>"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
 		echo "from the remote, but no such ref was fetched."
diff --git a/git-rebase.sh b/git-rebase.sh
index 00ca7b9..69c1374 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -380,7 +380,7 @@ then
 		then
 			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
-				"against" "git rebase <upstream branch>"
+				"against" "git rebase <branch>"
 		fi
 		;;
 	*)	upstream_name="$1"
-- 
1.7.8.352.g876a6f
