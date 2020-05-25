Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D274AC433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2C02073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sVIodrIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbgEYUAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390412AbgEYT7y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5BC3560D03;
        Mon, 25 May 2020 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436789;
        bh=smmJElpsjDUJ3khU5WIlomu9EU1J8x04QmZc/+KQYhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sVIodrIEk4bhl+4ckn4WE/NdlJv4wxe3/LqaSnespZepUOG/+r+Zba/aNpa2udHaO
         iKwVLPRIzwVpXSjfYRlbh6Bu9RyHHghbSe3SzxKSeDC1LhVth79U1QHFd8Rw/+HBJZ
         CshnRXF8sebja3ZQTxxCgtwRvFjF6LdFJQIbvrqq0j27RBVA98LDXx9TZpzlWn2QAY
         PKsNGQhzKZNu+cpuj8ltYGkZ8YCvObNgNQMCR8IAZVjat7QU3siayBjTxRv7DPgyRi
         42wI6KUs51VrYo88Vl7yyz2SwFbqjganPpWzdlwYOSrIBUP9rAWkNR36q3ujFcdUWE
         U5s7ElBsUvm8vCIFN7l7KMg/Z/4F1Kv/5tx+6PIy6ItVMB8AqCGVUlINfWKhuTB9J6
         2BDFmk++slY0abyMhbbTyy9v3S12XVImyR6XaN1/tAqg1D8G9diUlpUYi2QGDMtSly
         lRszxnyJDyjzxDiI29X1RZTtjrusBFmHJqiA0G7cxlI6tE2ZsRn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 15/44] builtin/receive-pack: detect when the server doesn't support our hash
Date:   Mon, 25 May 2020 19:59:01 +0000
Message-Id: <20200525195930.309665-16-sandals@crustytoothpaste.net>
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
