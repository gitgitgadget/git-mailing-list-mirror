Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90604C433E2
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F4220776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q1mF++TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbgFSR4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393787AbgFSR41 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AECD360A6C;
        Fri, 19 Jun 2020 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589381;
        bh=smmJElpsjDUJ3khU5WIlomu9EU1J8x04QmZc/+KQYhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=q1mF++TPP+JMA/Fbbir+ickZxheOH9jo8UXyHHjlARW1+rqv6fwBASpLHMrgQWZOV
         Ly5ts6Cl/kuaOiMoQOJnAYGCPYv/+Zaw5Fpil+v42TnEprf7RzFyhv1ycO1su3wqZa
         kQ58jYHHn2V01ESZK9CgEJWb3fj57uGLo7lpJzgkji+v0A+/HDInNKdhtrel9oSykh
         E36x+Ogp2Ys4zAvSb5FjNhP8LVOM08+720FJhyAmc9krViafuf4x8+0KESiEbhdJXZ
         zxO11DSKGbaH8tkjWRUsP9/EAb92/B8dXFWLXeTavfSM0Az4iUp0FTffW93PV0fPkx
         ElFWELdD9iJkOPYivdwuFssIY9nWetFQZBNRpQhpOzO1ZMemWr/Nv1bfKIQJ+jPAhe
         QR2fUy7dXYh0ExjfTd9piDXVSH1tSbDBI3xYLlGBZz2uHk0D2+jxOLyngscrR8drBB
         eNJADezk5VEcpN+3Eye7AWs8vbp9ADKUt1aIkh49/BNN5RMTfap
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 15/44] builtin/receive-pack: detect when the server doesn't support our hash
Date:   Fri, 19 Jun 2020 17:55:32 +0000
Message-Id: <20200619175601.569856-16-sandals@crustytoothpaste.net>
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

Detect when the server doesn't support our hash algorithm and abort.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4ffa501dce..d43663bb0a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1625,6 +1625,8 @@ static struct command *read_head_info(struct packet_reader *reader,
 		linelen = strlen(reader->line);
 		if (linelen < reader->pktlen) {
 			const char *feature_list = reader->line + linelen + 1;
+			const char *hash = NULL;
+			int len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
 			if (parse_feature_request(feature_list, "side-band-64k"))
@@ -1637,6 +1639,13 @@ static struct command *read_head_info(struct packet_reader *reader,
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
