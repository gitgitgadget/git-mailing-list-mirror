Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB39C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9336186A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhEKSiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:38:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53557 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKSiV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:38:21 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620758233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XYLQWu7iINu7pq5fQ8O6kQhBvVj+4+OCiuEf7t6Ft3I=;
        b=ojDbxpw1MSXwEV93k57EFnfAcdvBa4AwcB3HsrCX5nt0xJLsXtNwWEXHFC2uMr7+vv+DTV
        V4k5q1VJsGIdZOiASd6crXrhxszzYT2x+XdSCoSEm8IaG5mQFzewPqkdBjMcsbfySsVqyw
        InlRbO6gWLElACxMMjOWwX83tFfaeCgzFxA3zegw/jtJEgXHbPIOOQP7VYQ1fk9D/Cr+OV
        qYpp7gxMn4FJSRafKu1wCGfc3FLA83AmJxUUhNrQpsNrBXnfbVM3BdOe6bz5egRiL8rC7C
        WtAHPp8GdDc4oqRYUgvIy5FyqWzn/1WS15uQytjPsOoGub3cB6hCH69Lh/2kXw==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 54E311BF203;
        Tue, 11 May 2021 18:37:13 +0000 (UTC)
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Gregory Anders <greg@gpanders.com>
Subject: [PATCH] git-send-email: use ! to indicate relative path to command
Date:   Tue, 11 May 2021 12:37:03 -0600
Message-Id: <20210511183703.9488-1-greg@gpanders.com>
X-Mailer: git-send-email 2.31.1.576.gc7e8ed1dea
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the smtpServer config option is prefixed with a ! character, the
value of the option should be interpreted as a command to look up on
PATH.
---

Please note that I am a total perl newbie. It's very likely that I did 
something suboptimally or in a non-idiomatic way. Please let me know if 
that's the case.

 git-send-email.perl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..dbc5a2f51c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1492,7 +1492,11 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif (file_name_is_absolute($smtp_server)) {
+	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {
+		if ($smtp_server =~ s/^!//) {
+			my $smtp_server = map {"$_/$smtp_server"} split /:/, $ENV{PATH};
+		}
+
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-- 
2.31.1.576.gc7e8ed1dea

