Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7177BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4334B20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pT0ZQv9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394079AbgFSR4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404378AbgFSR4c (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C1B7260A71;
        Fri, 19 Jun 2020 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589384;
        bh=c1M2lsVO9QupQR/ILz768yfVAsI0fSyuIBI+dEuXceU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pT0ZQv9ga1Rq0v3Zw2QdKxjHitjd716UNJVN1yN9Ij2HyEGLyoUp5caONFA9KgDJ9
         2/rbsuGopRzte8aqREwQuf2hE6t6s8fzX1Qq6+oCwsa4BanLNhMVZXPsguOhUmJSOI
         jsDFQA0C5ATP5l6jY20AhhKTbc9QLugJ3auhoYqZvZXkEJ6fWubpWYCARgBaK5g/sY
         HLh1HUmpAynkosN0kxUZeTtv31tEHf1tNGocUWJjk94ytNsB+lD6+3ilu7TS7eJ8Z0
         dP/LN5TNWn0ibUZSRkFbHJQUSSLrxvB9UDHqvb2UE8K/ZVjCxuUaNq1VP4vJwB+lSd
         anxUpx55GCckhDRIu3sEodivq1ZGgjwfVV8FtfJC4MNoVgcZKTRpt5bP98JqXwxDWO
         qVw7Dhyvvbq3ef0j1JydARSBBhPMjhd93DhG4/GzTlVOnphBeKKZxUi3Kp2K91bxoK
         EXZ5b5MPRJhce0ehJSljYzQLctlB+U0hVGb1AGAIXmbCrtlK7Yf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 21/44] fetch-pack: parse and advertise the object-format capability
Date:   Fri, 19 Jun 2020 17:55:38 +0000
Message-Id: <20200619175601.569856-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
index c090030680..7e58f295f5 100644
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
