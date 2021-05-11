Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61CCC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700DD61626
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhEKTQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:16:54 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:16823 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKTQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:16:53 -0400
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9F153240004;
        Tue, 11 May 2021 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620760546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fnGolETO/IYS249cxXbOHuzHSGNwrfX/Yvfpwy0l0GM=;
        b=QQeeZ+TxspPEv9WXvN9N4M86c1ImgyTbj67UsTNUNj3N8Jzkem4D6I9nUQ7J4TVxrHWhnW
        03aekCqJqs5h8zc5R/4GNafWwhtQjHfj0lfUqdAU9R3TLVbXhK2SuvPQMsO4XK30ktc2s5
        ZUR9dzgemx0h1QDO5YUX/H8k4Lqq0RcjAan8RTEhrs7b1G7mOzgkYhj2MZtHMBPwR8r1pT
        lei5eYcCDhBEr5ek5xEYX4vFXJCsnMuc407hi8ShKE0kM3xZhPlsEMgJ7tfOdL6GcvEKjo
        61s1mwDQfVb2gi5hOmPC47AVUjCIshiilkP0Bsn7Ab5ior4g9OI0WmM26VjQRw==
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Gregory Anders <greg@gpanders.com>
Subject: [PATCH v3] git-send-email: use ! to indicate relative path to command
Date:   Tue, 11 May 2021 13:15:11 -0600
Message-Id: <20210511191510.25888-1-greg@gpanders.com>
X-Mailer: git-send-email 2.31.1.576.g06d230b258
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the smtpServer config option is prefixed with a ! character, the
value of the option should be interpreted as a command to look up on
PATH.

Signed-off-by: Gregory Anders <greg@gpanders.com>
---

Remove the PATH lookup, since Perl's exec() does this already.

Thanks to Jeff King for the assist.

 git-send-email.perl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..022dcf0999 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1492,11 +1492,14 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif (file_name_is_absolute($smtp_server)) {
+	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {
+		my $prog = $smtp_server;
+		$prog =~ s/^!//;
+
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-			exec($smtp_server, @sendmail_parameters) or die $!;
+			exec($prog, @sendmail_parameters) or die $!;
 		}
 		print $sm "$header\n$message";
 		close $sm or die $!;
-- 
2.31.1.576.g06d230b258

