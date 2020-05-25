Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981CC433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46AE2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k7seesj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390640AbgEYUAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38728 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390316AbgEYT7y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DDEEB60D09;
        Mon, 25 May 2020 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436792;
        bh=vP7nC3ffY6aR9uRzQGpX+7hdzpsv9yyEoRYuzrjpRQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=k7seesj24Aa76Kh5UqpIOzIoDaqIqVR8tcpcJjtlUJc2Agsl2HC6Vqk4+cIE59pWK
         foma0JU3G8lsDCZ+4v3dNddG/qdr0J7FGAoLIQHqmzlgkKDuhkZiSBg/jGoDs9c5vO
         917pRPYCVulTbw6z/+zIRuz1Dqscn8LgPkrh9k9xoiXRt6ndZbwewHERYlYqAPZH4E
         j268JaWvKn824DIcMCdp17yFAi2F+shwbMDE7r/j2phvj6Ne4dIKOCmKK6mShDfvaZ
         J10q2QxGGqRGF9boKwJNTRQrtjtCbhsFocHqr/6p27LMU8VldW4ZPiJtpV0GNb2Rnl
         JXAW5PSNhVwarQxdrywDsoopXVXp9ULB4UcTl8c0Pni3xyYngWi5T6FgA/MAzK6s/9
         K7oaqtNRStPoNCfMDXqpauBkI6JdDqjyptt6ESob+tBvxUohJcCeBCS/XcCYo9vAF5
         8zPLyb7x70312NqfJ7+0Es/accM9668nnXuJ6nF9wwIuVyQSGXg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 21/44] fetch-pack: parse and advertise the object-format capability
Date:   Mon, 25 May 2020 19:59:07 +0000
Message-Id: <20200525195930.309665-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
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
index 34c339a5fe..ecfb8c3cf5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1180,6 +1180,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      int sideband_all, int seen_ack)
 {
 	int ret = 0;
+	const char *hash_name;
 	struct strbuf req_buf = STRBUF_INIT;
 
 	if (server_supports_v2("fetch", 1))
@@ -1194,6 +1195,17 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 					 args->server_options->items[i].string);
 	}
 
+	if (server_feature_v2("object-format", &hash_name)) {
+		int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
+			die(_("mismatched algorithms: client %s; server %s"),
+			    the_hash_algo->name, hash_name);
+		packet_write_fmt(fd_out, "object-format=%s", the_hash_algo->name);
+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
+		die(_("the server does not support algorithm '%s'"),
+		    the_hash_algo->name);
+	}
+
 	packet_buf_delim(&req_buf);
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
