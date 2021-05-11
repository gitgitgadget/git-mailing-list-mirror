Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A46C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59C4613C5
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhEKTCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:02:14 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34367 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhEKTCO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:02:14 -0400
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 41386240004;
        Tue, 11 May 2021 19:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620759666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JYi3yvPra7dcG0m+YFt31G0Q/ndkX2qIcn683+CvBU8=;
        b=NVd4segKiHerrGNZNQZChQSCozs+Z5CHc4/AcTkp/24CE/auA+4wnzP+2TUJmcYg8uK3SZ
        t0qllkEO+oamEOS6kyMamjk1K9tfGbXCUydIwH6kwnTCBEcSKnT1rXe69ixeBNcOcNVqtv
        d+BeK8zabzqmON3BmCfQCw+VWdIgFFfB9w9G0zl8TVKNqC9ZDFmm1ermNrVSeTW5pf/wMq
        bxOcVHAqCEJA+fjm4Ea/wFCyVbdVl87YeRwNvLRCQXCzyRDWR2DwSDuA3zhsIt/bI409j1
        xwDwTN1tHm8HAyQY3Zf9NAQPHkEUu6AOxPMswhh/pX96LDS/dw+pbLaCdmOFeA==
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Gregory Anders <greg@gpanders.com>
Subject: [PATCH v2] git-send-email: use ! to indicate relative path to command
Date:   Tue, 11 May 2021 13:01:01 -0600
Message-Id: <20210511190101.22128-1-greg@gpanders.com>
X-Mailer: git-send-email 2.31.1.576.g55f6e1c2f1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the smtpServer config option is prefixed with a ! character, the
value of the option should be interpreted as a command to look up on
PATH.
---

Fix the implementation to correctly find the absolute path for the given 
command, and report an error if the command is not found on PATH.

 git-send-email.perl | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..6d10901595 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1492,7 +1492,24 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif (file_name_is_absolute($smtp_server)) {
+	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {
+		if ($smtp_server =~ s/^!//) {
+			my $smtp_command;
+			my @progs = map {"$_/$smtp_server"} split /:/, $ENV{PATH};
+			foreach (@progs) {
+				if (-x $_) {
+					$smtp_command = $_;
+					last;
+				}
+			}
+
+			if (!defined $smtp_command) {
+				die __("The command $smtp_server was not found on PATH.")
+			}
+
+			$smtp_server = $smtp_command;
+		}
+
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-- 
2.31.1.576.g55f6e1c2f1

