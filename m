Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531B5208DB
	for <e@80x24.org>; Sun, 27 Aug 2017 07:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdH0Hhr (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 03:37:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36561 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdH0Hhq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 03:37:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id p8so2280386wrf.3
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McihewxtIsXAyseDnR48xjmRGH0kCgjykAfeBDslOcM=;
        b=anXezBs15dEF+h89qBXnADnR8yGjPldsfKbOsaCr4MEtj2q6bSoVyOruRARMP0BFQ7
         GjluRRDwuy/MOmh6hvNKd6ZG2mFHxqOSX9cuQMwU9/rHvYfoptxIcU4xezbXzuynjldV
         SsYi8iEQYUvwRiKhl4ipJ6HpiP87ElHBo1ygYf/PAw3dY8G8tbPGUv9DW2a0Ga+unpcy
         wvaGGQE9plvFYrmbRIruYVPvSj0HlxLm6GQwvOU7iGrERL23v30sCwwNRWSqP2HR48uM
         kFYSgVs10bYtpbCsj34ZtNHh6oTPwwppQO0q8VacCYjSN0M/PlwtWp1MonIp9PY/1fUa
         0xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McihewxtIsXAyseDnR48xjmRGH0kCgjykAfeBDslOcM=;
        b=azPo6WZ7X/YtkuHHX+7EY+iV2RHs7DOeITuCnGLBxUn7BAhHvYjQKR10U76m8f0ZBA
         RTn4zG3M3PB/AM/c8T6IvQNIhMitp5PRYi1RXwsD2asrpywilhdX+lGX3zLvoXVZnsm5
         XaerBee0u2fffCvOEoH/7/iHL5WbZZ0UK+XxqrffWgeNXPuIr5mEstiE0I9x5eisGTlQ
         6/q2D9uEE2LyVptGoORAUWhG3BHJFJCOXWayyqGk4cgclHNhbs9fxhKlUER2WXeq+3uV
         u8XiWWOScO4E7mlnudIiadq6YF8+HjPG3pElvz/0xSit8pECdocrWuJwbaa/1blPvj8+
         kRkQ==
X-Gm-Message-State: AHYfb5h6oolVKeVPjgMiiZOXQ5+OZl07P7iyKRRB/BrU26hVXZA+i8s3
        Dwo8lGQn99xuo7Zj
X-Received: by 10.223.155.218 with SMTP id e26mr112671wrc.55.1503819464570;
        Sun, 27 Aug 2017 00:37:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id 189sm5692529wmu.26.2017.08.27.00.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Aug 2017 00:37:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Date:   Sun, 27 Aug 2017 09:37:32 +0200
Message-Id: <20170827073732.546-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The static-ness was silently dropped in commit 70428d1a5 ("pkt-line: add
packet_write_fmt_gently()", 2016-10-16). As a result, for each call to
packet_write_fmt_1, we allocate and leak a buffer.

We could keep the strbuf non-static and instead make sure we always
release it before returning (but not before we die, so that we don't
touch errno). That would also prepare us for threaded use. But until
that needs to happen, let's just restore the static-ness so that we get
back to a situation where we (eventually) do not continuosly keep
allocating memory.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I waffled between "fixing the memory leak" by releasing the buffer and
"fixing the static-ness" as in this patch. I can see arguments both ways
and don't have any strong opinion.

 pkt-line.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 7db911957..f364944b9 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -136,9 +136,10 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 static int packet_write_fmt_1(int fd, int gently,
 			      const char *fmt, va_list args)
 {
-	struct strbuf buf = STRBUF_INIT;
+	static struct strbuf buf = STRBUF_INIT;
 	ssize_t count;
 
+	strbuf_reset(&buf);
 	format_packet(&buf, fmt, args);
 	count = write_in_full(fd, buf.buf, buf.len);
 	if (count == buf.len)
-- 
2.14.1.151.g45c1275a3.dirty

