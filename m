Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4310C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 06:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbjDZGQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZGQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 02:16:09 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED0E70
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 23:16:07 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 8C61A24221
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 02:16:06 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1prYRi-H5T-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:16:06 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH v2] send-email: prompt-dependent exit codes
Date:   Wed, 26 Apr 2023 08:16:06 +0200
Message-Id: <20230426061606.1495646-1-oswald.buddenhagen@gmx.de>
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
v2:
- fix do_quit() not resetting $sent_all
---
 git-send-email.perl | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbea..7587cd2d20 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -254,6 +254,19 @@ sub system_or_die {
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
+	$sent_all = 0;
+	do_exit();
+}
+
 sub do_edit {
 	if (!defined($editor)) {
 		$editor = Git::command_oneline('var', 'GIT_EDITOR');
@@ -1172,8 +1185,7 @@ sub validate_address {
 		if (/^d/i) {
 			return undef;
 		} elsif (/^q/i) {
-			cleanup_compose_files();
-			exit(0);
+			do_quit();
 		}
 		$address = ask("$to_whom ",
 			default => "",
@@ -1593,8 +1605,7 @@ sub send_message {
 		} elsif (/^e/i) {
 			return -1;
 		} elsif (/^q/i) {
-			cleanup_compose_files();
-			exit(0);
+			do_quit();
 		} elsif (/^a/i) {
 			$confirm = 'never';
 		}
@@ -1968,6 +1979,12 @@ sub process_file {
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
@@ -2187,3 +2204,5 @@ sub body_or_subject_has_nonascii {
 	}
 	return 0;
 }
+
+do_exit();
-- 
2.40.0.152.g15d061e6df

