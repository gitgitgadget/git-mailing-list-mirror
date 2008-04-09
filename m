From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH/RFC 03/10] Teach rebase interactive the merge command
Date: Thu, 10 Apr 2008 01:58:34 +0200
Message-ID: <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkH4-0004V7-9H
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbYDJAD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbYDJAD0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:26 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3454 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754653AbYDJADF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:05 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 4751D488052; Thu, 10 Apr 2008 02:03:02 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBe-0004mE-QT; Thu, 10 Apr 2008 01:58:43 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBd-0007EH-Vy; Thu, 10 Apr 2008 01:58:41 +0200
X-Mailer: git-send-email 1.5.4.5
In-Reply-To: <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79157>

This command redoes merges. It's useful if you rebase a branch that
contains merges and you want to preserve these merges. You can also use
it to add new merges.
---
 git-rebase--interactive.sh    |   25 +++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |    3 +++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7dac51b..18cdf3d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -362,6 +362,29 @@ do_next () {
 		git rev-parse --verify HEAD > "$MARKS"/$mark || \
 			die "HEAD is invalid"
 		;;
+	merge|m)
+		comment_for_reflog merge
+
+		if ! git rev-parse --verify $sha1
+		then
+			die "Invalid reference merge '$sha1' in $command $sha1 $rest"
+		fi
+
+		new_parents=
+		for p in $rest
+		do
+			tmp=$(mark_to_sha1 $p) || \
+				tmp=$(git rev-parse --verify $p) ||
+				die "Invalid parent '$sha1' in $command $sha1 $rest"
+			new_parents="$new_parents $tmp"
+		done
+		new_parents="${new_parents# }"
+		test -n "$new_parents" || \
+			die "You forgot to give the parents for the merge"
+
+		mark_action_done
+		redo_merge $sha1 $new_parents
+		;;
 	reset|r)
 		comment_for_reflog reset
 
@@ -589,6 +612,8 @@ do
 #  squash = use commit, but meld into previous commit
 #  mark #NUM = mark the current HEAD for later reference
 #  reset #NUM|commit = reset HEAD to a previous set mark or a commit
+#  merge commit-M #NUM|commit-P ... = redo merge commit-M with the
+#         current HEAD and the parents marked with #NUM or the commit-P
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 521206f..892fd5d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -88,6 +88,9 @@ for line in $FAKE_LINES; do
 	reset*)
 		echo "reset ${line#reset}"
 		echo "reset ${line#reset}" >> "$1";;
+	merge*)
+		echo "merge ${line#merge}" | tr / ' '
+		echo "merge ${line#merge}" | tr / ' ' >> "$1";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
 		sed -n "${line}p" < "$1".tmp
-- 
1.5.4.5
