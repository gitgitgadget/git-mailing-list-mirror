From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH/RFC 02/10] Teach rebase interactive the reset command
Date: Thu, 10 Apr 2008 01:58:33 +0200
Message-ID: <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkGy-0004V7-F3
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbYDJADJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbYDJADH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:07 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3450 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbYDJADF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:05 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id D6125488046; Thu, 10 Apr 2008 02:03:01 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBe-0004mD-Mq; Thu, 10 Apr 2008 01:58:43 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBd-0007E9-SO; Thu, 10 Apr 2008 01:58:41 +0200
X-Mailer: git-send-email 1.5.4.5
In-Reply-To: <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79152>

---
 git-rebase--interactive.sh    |   20 ++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   10 ++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b001ddf..7dac51b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -258,6 +258,16 @@ parse_mark() {
 	return 1
 }
 
+mark_to_sha1() {
+	local mark
+	if mark=$(parse_mark $1)
+	then
+		cat "$MARKS"/$mark
+	else
+		return 1
+	fi
+}
+
 do_next () {
 	rm -f "$DOTEST"/message "$DOTEST"/author-script \
 		"$DOTEST"/amend || exit
@@ -352,6 +362,15 @@ do_next () {
 		git rev-parse --verify HEAD > "$MARKS"/$mark || \
 			die "HEAD is invalid"
 		;;
+	reset|r)
+		comment_for_reflog reset
+
+		mark_action_done
+		tmp=$(mark_to_sha1 $sha1) || \
+			tmp=$(git rev-parse --verify $sha1) ||
+			die "Invalid parent '$sha1' in $command $sha1 $rest"
+		output git reset --hard $tmp
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -569,6 +588,7 @@ do
 #  edit = use commit, but stop for amending
 #  squash = use commit, but meld into previous commit
 #  mark #NUM = mark the current HEAD for later reference
+#  reset #NUM|commit = reset HEAD to a previous set mark or a commit
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4461674..521206f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -85,6 +85,9 @@ for line in $FAKE_LINES; do
 	mark*)
 		echo "mark ${line#mark}"
 		echo "mark ${line#mark}" >> "$1";;
+	reset*)
+		echo "reset ${line#reset}"
+		echo "reset ${line#reset}" >> "$1";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
 		sed -n "${line}p" < "$1".tmp
@@ -210,6 +213,13 @@ test_expect_success 'setting marks works' '
 	git rebase --abort
 '
 
+test_expect_success 'reset with nonexistent mark fails' '
+	export FAKE_LINES="reset#0 1" &&
+	test_must_fail git rebase -i HEAD~1 &&
+	unset FAKE_LINES &&
+	git rebase --abort
+'
+
 test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
-- 
1.5.4.5
