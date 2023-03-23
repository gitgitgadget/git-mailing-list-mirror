Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA0BC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjCWQr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjCWQrB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:01 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEA9BB93
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:30 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 96621241D7
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:34 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-AxY-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] send-email: prompt-dependent exit codes
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162234.995435-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From the perspective of the caller, failure to send (some) mails is an
error even if it was interactively requested, so it should be indicated
by the exit code.

To make it somewhat specific, the exit code is 10 when only some mails
were skipped, and 11 if the user quit on the first prompt.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 git-send-email.perl | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbea..2ab6766583 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -254,6 +254,18 @@ sub system_or_die {
 	die $msg if $msg;
 }
 
+my $sent_any = 0;
+my $sent_all = 1;
+
+sub do_exit {
+	exit($sent_any ? $sent_all ? 0 : 10 : 11);
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
@@ -1172,8 +1184,7 @@ sub validate_address {
 		if (/^d/i) {
 			return undef;
 		} elsif (/^q/i) {
-			cleanup_compose_files();
-			exit(0);
+			do_quit();
 		}
 		$address = ask("$to_whom ",
 			default => "",
@@ -1593,8 +1604,7 @@ sub send_message {
 		} elsif (/^e/i) {
 			return -1;
 		} elsif (/^q/i) {
-			cleanup_compose_files();
-			exit(0);
+			do_quit();
 		} elsif (/^a/i) {
 			$confirm = 'never';
 		}
@@ -1968,6 +1978,12 @@ sub process_file {
 		return 0;
 	}
 
+	if ($message_was_sent) {
+		$sent_any = 1;
+	} else {
+		$sent_all = 0;
+	}
+
 	# set up for the next message
 	if ($thread) {
 		if ($message_was_sent &&
@@ -2187,3 +2203,5 @@ sub body_or_subject_has_nonascii {
 	}
 	return 0;
 }
+
+do_exit();
-- 
2.40.0.152.g15d061e6df

