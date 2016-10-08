Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4FD207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935080AbcJHLZx (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36424 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935049AbcJHLZp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id 123so6631340wmb.3
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6Lg0Z6S9nQOfGaApobmqUYu6f/1vq5DjfcUkP1rQKY=;
        b=jEear3fuw7IO1oWhuNP7GTIODVARMxUQlNMlhu1CJgnY9RuP2ui6lTpkgogNfZNVpx
         ZJsZ4N511MwIfUV8TwJD0eKSXNny/zDDjadURI8mAPur8autEATE3rssndxFOodOObq2
         cW0lJw3aaKtBtXnq0keuGVVdOdA69dmkXQ2EY4s3z+NZH2jhhZR1e0DlhFZ/NU1pyHDD
         RX8p+i2MTW+uCANkjKAMTgA7Ml/31LpnLPbKgF5RCuHdORTe1qo3Fnd2Tnl9e6avNG8z
         avWaKZ0NQiOBHy1pT4knDx/zab6ED2EJ/7eoEtHYsDu9PqIk5BxWSeL/N98IcpaK+8h7
         h6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6Lg0Z6S9nQOfGaApobmqUYu6f/1vq5DjfcUkP1rQKY=;
        b=ZoKUuW1y5sPpZ7/bYrQh/IJoJjLrXbrlsV8ZDCC3nX7+RAYvRMvyxMnaw8cYBvyciv
         JWP27cpL3f1/kL2sPvTnxhYYx2tqb4aCfc1wXLO0E4D43fBN8hsCIMJlyP96A5esUESP
         IQGOaufmY8ogslZIqT8DVyXyPGYOSkZxsCMg8ifYUzCELhkh/hKPaBVrxQtrFOm7x5Ib
         FkCQMMTGzmL+zpwoPuDDjyic0R0IHtjC+61IFVC9s+qbttkPA//6o19x7ljX+KyiD5lr
         iL2YnsU5nFCzpjeBdjLMRqojihgwxNLdQyvBV4tAk/IphOFtw1MceWugne59ZByga06Z
         rnng==
X-Gm-Message-State: AA6/9Rk+3N3ohI55TPHoBMycjAKhER4975B0+/s/UFtOuz62Rr1s9goO76D1wfekPeI93w==
X-Received: by 10.28.6.6 with SMTP id 6mr2932409wmg.27.1475925943762;
        Sat, 08 Oct 2016 04:25:43 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:43 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 08/14] pkt-line: add packet_flush_gently()
Date:   Sat,  8 Oct 2016 13:25:24 +0200
Message-Id: <20161008112530.15506-9-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_flush() would die in case of a write error even though for some
callers an error would be acceptable. Add packet_flush_gently() which
writes a pkt-line flush packet like packet_flush() but does not die in
case of an error. The function is used in a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 8 ++++++++
 pkt-line.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 56915f0..286eb09 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,14 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gently(int fd)
+{
+	packet_trace("0000", 4, 1);
+	if (write_in_full(fd, "0000", 4) == 4)
+		return 0;
+	return error("flush packet write failed");
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
 	packet_trace("0000", 4, 1);
diff --git a/pkt-line.h b/pkt-line.h
index 3caea77..3fa0899 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -23,6 +23,7 @@ void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 /*
-- 
2.10.0

