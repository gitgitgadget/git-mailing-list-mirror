From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Thu, 10 Apr 2008 01:58:32 +0200
Message-ID: <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkGz-0004V7-6W
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbYDJADL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYDJADJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:09 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3449 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633AbYDJADF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:05 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 51C1D48804E; Thu, 10 Apr 2008 02:03:01 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBe-0004mC-LD; Thu, 10 Apr 2008 01:58:43 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBd-0007E7-PT; Thu, 10 Apr 2008 01:58:41 +0200
X-Mailer: git-send-email 1.5.4.5
In-Reply-To: <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79158>

This new command can be used to set symbolic marks for an commit while
doing a rebase. This symbolic name can later be used for merges or
resets.
---
 git-rebase--interactive.sh    |   36 ++++++++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   21 +++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8aa7371..b001ddf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -23,6 +23,7 @@ DONE="$DOTEST"/done
 MSG="$DOTEST"/message
 SQUASH_MSG="$DOTEST"/message-squash
 REWRITTEN="$DOTEST"/rewritten
+MARKS="$DOTEST"/marks
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
@@ -240,6 +241,23 @@ peek_next_command () {
 	sed -n "1s/ .*$//p" < "$TODO"
 }
 
+parse_mark() {
+	local tmp
+	tmp="$*"
+
+	case "$tmp" in
+	'#'[0-9]*)
+		tmp="${tmp#\#}"
+		if test "$tmp" = $(printf %d "$tmp")
+		then
+			echo $tmp
+			return 0
+		fi
+		;;
+	esac
+	return 1
+}
+
 do_next () {
 	rm -f "$DOTEST"/message "$DOTEST"/author-script \
 		"$DOTEST"/amend || exit
@@ -317,6 +335,23 @@ do_next () {
 			die_with_patch $sha1 ""
 		fi
 		;;
+	mark|a)
+		if ! mark=$(parse_mark $sha1)
+		then
+			warn "Invalid mark given: $command $sha1 $rest"
+			die_with_patch $sha1 \
+				"Please fix this in the file $TODO."
+		fi
+		mark_action_done
+
+		test -d "$MARKS" || mkdir "$MARKS"
+
+		test -e "$MARKS"/$mark && \
+			warn "mark $mark already exist; overwriting it"
+
+		git rev-parse --verify HEAD > "$MARKS"/$mark || \
+			die "HEAD is invalid"
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -533,6 +568,7 @@ do
 #  pick = use commit
 #  edit = use commit, but stop for amending
 #  squash = use commit, but meld into previous commit
+#  mark #NUM = mark the current HEAD for later reference
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9cf873f..4461674 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -82,6 +82,9 @@ for line in $FAKE_LINES; do
 	case $line in
 	squash|edit)
 		action="$line";;
+	mark*)
+		echo "mark ${line#mark}"
+		echo "mark ${line#mark}" >> "$1";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
 		sed -n "${line}p" < "$1".tmp
@@ -189,6 +192,24 @@ test_expect_success '-p handles "no changes" gracefully' '
 	test $HEAD = $(git rev-parse HEAD)
 '
 
+test_expect_success 'setting an invalid mark fails' '
+	export FAKE_LINES="mark12 1" && \
+	test_must_fail git rebase -i HEAD~1 &&
+	unset FAKE_LINES &&
+	git rebase --abort
+'
+
+test_expect_success 'setting marks works' '
+	git checkout master &&
+	FAKE_LINES="mark#0 2 1 mark#42 3 edit 4" git rebase -i HEAD~4 &&
+	marks_dir=.git/.dotest-merge/marks
+	test -d $marks_dir &&
+	test $(ls $marks_dir | wc -l) -eq 2 &&
+	test "$(git rev-parse HEAD~4)" = "$(cat $marks_dir/0)" &&
+	test "$(git rev-parse HEAD~2)" = "$(cat $marks_dir/42)" &&
+	git rebase --abort
+'
+
 test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
-- 
1.5.4.5
