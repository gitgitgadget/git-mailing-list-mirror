Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99307C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC5A20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lEYGdzei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbgEMAyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38132 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731857AbgEMAys (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 00A7360D00;
        Wed, 13 May 2020 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331287;
        bh=H2xDoXKjs7NgXARqu+L/reTeQW0Z4AxMrSZY7HFrlT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lEYGdzeiRYX5tNECTxlE9Tz2yTI5uulSStvvQ+g26HqG9XhZpAhY99Q/qFyRuRPEs
         Ut30/tqi+yBiWKJw6QiYzPtcIbVAJYZu/Cs1QKcgzbBe72oEhJWqCMKmWEd7f0KjlJ
         7yNYxUBC0mcanfAEObb0hKTGQ4VoJ1qUeGqusbT2K7QRHRStj62WD8Z95RrDNUd1PO
         XfsRwiaYsl66Gk/ia0X8WXS7bpOOv0vR2eFLwRatSRcR1+CcwBR62OPqKvSBvyU7y0
         5oRNDSo0Wd/6u6MOss2FmbBOVPdLY0rnAfcOuhOQcVa2KKZrojHQp/D1khcI0H66+Y
         Wh4TdcHwSYZkbxsfvOlnOrzo695SFFaZ0V1eaew0wQMGdaCclLHstiYQvIA2bnrtNd
         5c01IXzV/DiI+FFQNBuo68vdSeib3Q4avFSPdhFP69v2I3PxD/YIaRXoGgrqjiWEQA
         gd2Ffaa2gjs+a8G7yOx9iz0hp3/MMuBameVuJYnjGDpnX7eccin
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 22/44] fetch-pack: parse and advertise the object-format capability
Date:   Wed, 13 May 2020 00:54:02 +0000
Message-Id: <20200513005424.81369-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Parse the server's object-format capability and respond accordingly,
dying if there is a mismatch.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1d277190e7..3a48ed4b13 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1179,6 +1179,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      int sideband_all, int seen_ack)
 {
 	int ret = 0;
+	const char *hash_name;
 	struct strbuf req_buf = STRBUF_INIT;
 
 	if (server_supports_v2("fetch", 1))
@@ -1193,6 +1194,17 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 					 args->server_options->items[i].string);
 	}
 
+	if (server_feature_v2("object-format", &hash_name)) {
+		int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
+			die(_("mismatched algorithms: client %s; server %s"),
+			    the_hash_algo->name, hash_name);
+		packet_write_fmt(fd_out, "object-format=%s", the_hash_algo->name);
+	}
+	else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1)
+		die(_("the server does not support algorithm '%s'"),
+		    the_hash_algo->name);
+
 	packet_buf_delim(&req_buf);
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
