Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9E920179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbcFQUZs (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:25:48 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52122 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964887AbcFQUYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:25 -0400
Received: (qmail 23720 invoked from network); 17 Jun 2016 20:24:24 -0000
Received: (qmail 6242 invoked from network); 17 Jun 2016 20:24:24 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:23 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 16/38] i18n: rebase-interactive: mark comments of squash for translation
Date:	Fri, 17 Jun 2016 20:21:05 +0000
Message-Id: <1466194887-18236-17-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark comment messages of squash/fixup file ($squash_msg) for
translation.

Helper functions this_nth_commit_message and skip_nth_commit_message
replace the previous method of making the comment messages (such as
"This is the 2nd commit message:") aided by nth_string helper function.
This step was taken as a workaround to enabled translation of entire
sentences. However, doesn't change any text seen in English by the user,
except for string "The first commit's message is:" which was changed to
match the style of other instances.

The test t3404-rebase-interactive.sh resorts to set_fake_editor which
didn't account for GETTEXT_POISON. Fix it by assuming success when we
find dummy gettext poison output where was supposed to find the first
comment line "This is a combination of $count commits.".

For that same message, use plural aware eval_ngettext instead of
eval_gettext, since other languages have more complex plural forms.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-rebase--interactive.sh | 69 +++++++++++++++++++++++++++++++++++++---------
 t/lib-rebase.sh            |  1 +
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a16ce3a..0446efd 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -401,12 +401,52 @@ pick_one_preserving_merges () {
 	esac
 }
 
-nth_string () {
-	case "$1" in
-	*1[0-9]|*[04-9]) echo "$1"th;;
-	*1) echo "$1"st;;
-	*2) echo "$1"nd;;
-	*3) echo "$1"rd;;
+this_nth_commit_message () {
+	n=$1
+	case "$n" in
+	1) gettext "This is the 1st commit message:";;
+	2) gettext "This is the 2nd commit message:";;
+	3) gettext "This is the 3rd commit message:";;
+	4) gettext "This is the 4th commit message:";;
+	5) gettext "This is the 5th commit message:";;
+	6) gettext "This is the 6th commit message:";;
+	7) gettext "This is the 7th commit message:";;
+	8) gettext "This is the 8th commit message:";;
+	9) gettext "This is the 9th commit message:";;
+	10) gettext "This is the 10th commit message:";;
+	# TRANSLATORS: if the language you are translating into
+	# doesn't allow you to compose a sentence in this fashion,
+	# consider translating as if this and the following few strings
+	# were "This is the commit message ${n}:"
+	*1[0-9]|*[04-9]) eval_gettext "This is the \${n}th commit message:";;
+	*1) eval_gettext "This is the \${n}st commit message:";;
+	*2) eval_gettext "This is the \${n}nd commit message:";;
+	*3) eval_gettext "This is the \${n}rd commit message:";;
+	*) eval_gettext "This is the commit message \${n}:";;
+	esac
+}
+skip_nth_commit_message () {
+	n=$1
+	case "$n" in
+	1) gettext "The 1st commit message will be skipped:";;
+	2) gettext "The 2nd commit message will be skipped:";;
+	3) gettext "The 3rd commit message will be skipped:";;
+	4) gettext "The 4th commit message will be skipped:";;
+	5) gettext "The 5th commit message will be skipped:";;
+	6) gettext "The 6th commit message will be skipped:";;
+	7) gettext "The 7th commit message will be skipped:";;
+	8) gettext "The 8th commit message will be skipped:";;
+	9) gettext "The 9th commit message will be skipped:";;
+	10) gettext "The 10th commit message will be skipped:";;
+	# TRANSLATORS: if the language you are translating into
+	# doesn't allow you to compose a sentence in this fashion,
+	# consider translating as if this and the following few strings
+	# were "The commit message ${n} will be skipped:"
+	*1[0-9]|*[04-9]) eval_gettext "The \${n}th commit message will be skipped:";;
+	*1) eval_gettext "The \${n}st commit message will be skipped:";;
+	*2) eval_gettext "The \${n}nd commit message will be skipped:";;
+	*3) eval_gettext "The \${n}rd commit message will be skipped:";;
+	*) eval_gettext "The commit message \${n} will be skipped:";;
 	esac
 }
 
@@ -414,20 +454,23 @@ update_squash_messages () {
 	if test -f "$squash_msg"; then
 		mv "$squash_msg" "$squash_msg".bak || exit
 		count=$(($(sed -n \
-			-e "1s/^. This is a combination of \(.*\) commits\./\1/p" \
+			-e "1s/^$comment_char.*\([0-9][0-9]*\).*/\1/p" \
 			-e "q" < "$squash_msg".bak)+1))
 		{
-			printf '%s\n' "$comment_char This is a combination of $count commits."
+			printf '%s\n' "$comment_char $(eval_ngettext \
+				"This is a combination of \$count commit." \
+				"This is a combination of \$count commits." \
+				$count)"
 			sed -e 1d -e '2,/^./{
 				/^$/d
 			}' <"$squash_msg".bak
 		} >"$squash_msg"
 	else
-		commit_message HEAD > "$fixup_msg" || die "Cannot write $fixup_msg"
+		commit_message HEAD > "$fixup_msg" || die "$(gettext "Cannot write \$fixup_msg")"
 		count=2
 		{
-			printf '%s\n' "$comment_char This is a combination of 2 commits."
-			printf '%s\n' "$comment_char The first commit's message is:"
+			printf '%s\n' "$comment_char $(gettext "This is a combination of 2 commits.")"
+			printf '%s\n' "$comment_char $(gettext "This is the 1st commit message:")"
 			echo
 			cat "$fixup_msg"
 		} >"$squash_msg"
@@ -436,13 +479,13 @@ update_squash_messages () {
 	squash)
 		rm -f "$fixup_msg"
 		echo
-		printf '%s\n' "$comment_char This is the $(nth_string $count) commit message:"
+		printf '%s\n' "$comment_char $(this_nth_commit_message $count)"
 		echo
 		commit_message $2
 		;;
 	fixup)
 		echo
-		printf '%s\n' "$comment_char The $(nth_string $count) commit message will be skipped:"
+		printf '%s\n' "$comment_char $(skip_nth_commit_message $count)"
 		echo
 		# Change the space after the comment character to TAB:
 		commit_message $2 | git stripspace --comment-lines | sed -e 's/ /	/'
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 9a96e15..25a77ee 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -29,6 +29,7 @@ set_fake_editor () {
 	*/COMMIT_EDITMSG)
 		test -z "$EXPECT_HEADER_COUNT" ||
 			test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1")" ||
+			test "# # GETTEXT POISON #" = "$(sed -n '1p' < "$1")" ||
 			exit
 		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
 		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
-- 
2.6.6

