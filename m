Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B22C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjHGQ7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjHGQ7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:59:03 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56E1BC9
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:58:53 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 7A813242B6;
        Mon,  7 Aug 2023 12:58:50 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3ZC-nSW-00; Mon, 07 Aug 2023 18:58:50 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3] send-email: prompt-dependent exit codes
Date:   Mon,  7 Aug 2023 18:58:50 +0200
Message-Id: <20230807165850.2335067-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <xmqqttx1l3zp.fsf@gitster.g>
References: <xmqqttx1l3zp.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From the perspective of a scripted caller, failure to send (some) mails
is an error even if it was interactively requested, so it should be
indicated by the exit code.

To make it somewhat specific, the exit code is 10 when only some mails
were skipped, and 11 if the user quit on the first prompt.

For interactive calls from the command line, interactive cancellation is
arguably not really an error, but there the exit code will be more or
less ignored anyway.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
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
 git-send-email.perl | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

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
-- 
2.40.0.152.g15d061e6df

