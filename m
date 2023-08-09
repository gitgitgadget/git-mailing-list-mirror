Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E3C04FDF
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjHIRPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHIRPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:36 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261CF1FFA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:35 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4FD8D2420D;
        Wed,  9 Aug 2023 13:15:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lCu-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4] send-email: prompt-dependent exit codes
Date:   Wed,  9 Aug 2023 19:15:31 +0200
Message-Id: <20230809171531.2564739-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <xmqqmsz1a547.fsf@gitster.g>
References: <xmqqmsz1a547.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From the perspective of a scripted caller, failure to send (some) mails
is an error even if it was interactively requested, so it should be
indicated by a non-zero exit code.

This is technically a backwards-incompatible behavior change, and
therefore would be safer to make opt-in. However, the damage resulting
from reporting the situation too eagerly is expected to be trivial,
while the damage resulting from callers failing to opt-in (which is
obviously the status quo, and is likely to persist in most cases) is
potentially at least somewhat serious.

For interactive calls from the command line, interactive cancellation is
arguably not really an error, but a human user will be able to interpret
the somewhat unusual exit code in light of their immediately preceding
interactions just fine.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v4:
- add tests (which also cover the partial confirmation behavior in the
  first place)
- add docu
- rework commit message again
v3:
- use a tally instead of flags after all, as my seemingly simple idea
  apparently requires lots of thinking to grasp fully
- correct exit code when zero messages are to be sent. this cannot
  actually happen, as it induces an exit via usage() earlier on.
- unfold nested ternary to save junio's sanity (who proved his point by
  unfolding it slightly incorrectly)
- expand commit message
v2:
- fix do_quit() not resetting $sent_all

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 Documentation/git-send-email.txt |  9 ++++++++
 git-send-email.perl              | 32 ++++++++++++++++++++++++----
 t/t9001-send-email.sh            | 36 ++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 492a82323d..d6ce3a0bd9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -480,6 +480,15 @@ include::includes/cmd-config-section-all.txt[]
 
 include::config/sendemail.txt[]
 
+
+EXIT STATUS
+-----------
+
+Zero is returned when all specified patches were sent, while one is returned
+when an error occurs. 10 is returned if the user interactively skips sending
+some patches, and 11 if they skip all patches.
+
+
 EXAMPLES
 --------
 Use gmail as the smtp server
diff --git a/git-send-email.perl b/git-send-email.perl
index affbb88509..cd4db84b7f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -256,6 +256,26 @@ sub system_or_die {
 	die $msg if $msg;
 }
 
+my $sent_files = 0;
+
+sub do_exit {
+	if ($sent_files == @files) {
+		# All specified messages were sent
+		exit(0);
+	} elsif ($sent_files) {
+		# At least some messages were sent
+		exit(10);
+	} else {
+		# User cancelled on first message already
+		exit(11);
+	}
+}
+
+sub do_quit {
+	cleanup_compose_files();
+	do_exit();
+}
+
 sub do_edit {
 	if (!defined($editor)) {
 		$editor = Git::command_oneline('var', 'GIT_EDITOR');
@@ -1195,8 +1215,7 @@ sub validate_address {
 		if (/^d/i) {
 			return undef;
 		} elsif (/^q/i) {
-			cleanup_compose_files();
-			exit(0);
+			do_quit();
 		}
 		$address = ask("$to_whom ",
 			default => "",
@@ -1619,8 +1638,7 @@ sub send_message {
 		} elsif (/^e/i) {
 			return -1;
 		} elsif (/^q/i) {
-			cleanup_compose_files();
-			exit(0);
+			do_quit();
 		} elsif (/^a/i) {
 			$confirm = 'never';
 		}
@@ -2001,6 +2019,10 @@ sub process_file {
 		return 0;
 	}
 
+	if ($message_was_sent) {
+		$sent_files++;
+	}
+
 	# set up for the next message
 	if ($thread) {
 		if ($message_was_sent &&
@@ -2278,3 +2300,5 @@ sub body_or_subject_has_nonascii {
 	}
 	return 0;
 }
+
+do_exit();
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 48bf0af2ee..dce0b1c498 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1187,6 +1187,42 @@ test_expect_success $PREREQ 'confirm does not loop forever' '
 			$patches
 '
 
+test_confirm_many () {
+	clean_fake_sendmail
+	GIT_SEND_EMAIL_NOTTY=1 \
+	git send-email \
+		--confirm=auto \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-2 <replies
+	echo $? >exit_sts
+	test_cmp expected_sts exit_sts || return 1
+	ls commandline* 2>/dev/null | wc -l > num_mails
+	test_cmp expected_num num_mails || return 1
+}
+
+test_expect_success $PREREQ 'interactively skip none' '
+	(echo y && echo y) > replies &&
+	echo 0 > expected_sts &&
+	echo 2 > expected_num &&
+	test_confirm_many
+'
+
+test_expect_success $PREREQ 'interactively skip some' '
+	(echo n && echo y) > replies &&
+	echo 10 > expected_sts &&
+	echo 1 > expected_num &&
+	test_confirm_many
+'
+
+test_expect_success $PREREQ 'interactively skip all' '
+	(echo n && echo n) > replies &&
+	echo 11 > expected_sts &&
+	echo 0 > expected_num &&
+	test_confirm_many
+'
+
 test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
 	clean_fake_sendmail &&
 	rm -fr outdir &&
-- 
2.40.0.152.g15d061e6df

