From: David Greene <greened@obbligato.org>
Subject: [PATCH 3/5] Add --skip-redundant-commits option to rebase
Date: Sun, 10 Jan 2016 23:00:19 -0600
Message-ID: <1452488421-26823-4-git-send-email-greened@obbligato.org>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 06:01:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIUbz-0005cL-BP
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 06:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbcAKFBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 00:01:06 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53964 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750743AbcAKFAj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 00:00:39 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIUbz-0005H8-3N; Sun, 10 Jan 2016 23:01:47 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1452488421-26823-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283637>

From: "David A. Greene" <greened@obbligato.org>

Teach rebase to ignore redundant commits if told.  Since rebase
normally automatically skips redundant commits, this only applies
when it has to use cherry-pick to do its work.  In that case,
pass the --skip-redundant-commits flag to cherry-pick.

This allows scripted use of rebase with options like
--preserve-merges that tend to invoke cherry-pick.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 git-rebase--interactive.sh | 14 ++++++++++++--
 git-rebase.sh              |  5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c0cfe88..5891ff5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -269,9 +269,14 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
+	redundant_args=
+	if test -n "$skip_redundant_commits"
+	then
+		redundant_args="--skip-redundant-commits"
+	fi
 	output eval git cherry-pick \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-			"$strategy_args" $empty_args $ff "$@"
+			"$strategy_args" $empty_args $redundant_args $ff "$@"
 
 	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
 	# previous task so this commit is not lost.
@@ -389,9 +394,14 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
+			redundant_args=
+			if test -n "$skip_redundant_commits"
+			then
+				redundant_args="--skip-redundant-commits"
+			fi
 			output eval git cherry-pick \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-				"$strategy_args" "$@" ||
+				"$strategy_args" $redundant_args "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
diff --git a/git-rebase.sh b/git-rebase.sh
index af7ba5f..420a54f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -24,6 +24,7 @@ m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
+skip-redundant-commits ignore redundant commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -86,6 +87,7 @@ action=
 preserve_merges=
 autosquash=
 keep_empty=
+skip_redundant_commits=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 gpg_sign_opt=
 
@@ -255,6 +257,9 @@ do
 	--keep-empty)
 		keep_empty=yes
 		;;
+	--skip-redundant-commits)
+		skip_redundant_commits=yes
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
-- 
2.6.1
