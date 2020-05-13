Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003CCC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DE22078C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uDPg+MEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgEMAyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38140 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAyp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0C5EA60D03;
        Wed, 13 May 2020 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331284;
        bh=4MbzblCa/1wSvFdfUtTRCZg6R1LpC0SauaVEGykTrhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uDPg+MEsw96TeuAoLJS5swP/bV0ppoXUmhJalZp7raSNiPQNgkI9+EJhUvISNEONS
         5nyo6H/5Bfe1XlfFHbK4JV6mipOwmJdrsQlmWEkYnw1oul5bsL8YARcs+e6Xob+hfu
         Se46HjD5n20p32YR3OmmXwiwFCZDJjo1Dp+J/VBV7RjjPv3KQyyc15Y1R620jgdRJm
         sjJl7xmHnaKwFE+2pvgzEOrjyvWSx9aL8MrIFPCgxJzjZnEReJdSGBJ6UibTmzxCEI
         icEaCRX/EL7k1VxpM592vcM3o2guMctxeDVJyBUJRpb/RxJFDeoBLghT2qovpc2XeU
         4nAN5RW7Am7qyfT6fb6DX+eSSSTIYbwttGYkyMEf2aBNJUX1CJxkM+yGlXhl+MmTQv
         fJ7l5AELFqW3GD2ZuKaEKq8p05SEvbVWnX656WGmU67qp67+2jrpHn7TGWF3biIS2h
         YEDisHdET1ce+Z5mrnwdF8bKn/d16UOUmFLIdP8CZMilPbyXbcG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 15/44] builtin/receive-pack: detect when the server doesn't support our hash
Date:   Wed, 13 May 2020 00:53:55 +0000
Message-Id: <20200513005424.81369-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Detect when the server doesn't support our hash algorithm and abort.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a4159b559e..8755fa2463 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1624,6 +1624,8 @@ static struct command *read_head_info(struct packet_reader *reader,
 		linelen = strlen(reader->line);
 		if (linelen < reader->pktlen) {
 			const char *feature_list = reader->line + linelen + 1;
+			const char *hash;
+			int len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
 			if (parse_feature_request(feature_list, "side-band-64k"))
@@ -1636,6 +1638,13 @@ static struct command *read_head_info(struct packet_reader *reader,
 			if (advertise_push_options
 			    && parse_feature_request(feature_list, "push-options"))
 				use_push_options = 1;
+			hash = parse_feature_value(feature_list, "object-format", &len, NULL);
+			if (!hash) {
+				hash = hash_algos[GIT_HASH_SHA1].name;
+				len = strlen(hash);
+			}
+			if (xstrncmpz(the_hash_algo->name, hash, len))
+				die("error: unsupported object format '%s'", hash);
 		}
 
 		if (!strcmp(reader->line, "push-cert")) {
