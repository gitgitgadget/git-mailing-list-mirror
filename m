Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6D71F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfBLBXb (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34300 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbfBLBXa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:30 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3323660899;
        Tue, 12 Feb 2019 01:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934608;
        bh=ZgJiDZe71IdN0eGb4vsIIvfqbAhK+NM/W4cs2L7qU7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=RyY0LgQ+AotDIbWIP7G9X5AaAskwIcKYl2sS7qwn+1hvg0avBKL+2/+hx+jHhdCnQ
         4M2x3VirzEGU3DbCXj1Lz0xhd9ihFcmdMX8V+HtGtdWIHEM+kYt5zv9Y6BIgOfUqzD
         GOI9mxj7M4whCLwkHX426XsS9wgaUcB5IZi+S293/hxO6DPK3bExMFBipmByXLOQi2
         TagbuIYzGseZi8hY52BAQc1a3IOe46blu4vTOqym/vBIwcLMaxfK5jC2giRCTr/6xi
         sedkK8QAMCGrDJ6jQj7GMblaTj0RLS1Xd4j+roS77lnZLeDbAN4RdgOJgnDMSyaZif
         uxF4C2Gcfsm4gtuyl1Qo5P9nrHjIrxML3pbk0ouxw2XuPgGGDErO8EHoS4vfe7OnEl
         M5Lv2UwgSWdMh0CbdJnGGNM3K+MjlyLOvlcS29J9BtXbpbmk3FQcO/9ymgXI3C5hJe
         6FpYPEbOaWR2dY3drVugg8QxKHbYl21qV6VztNXCiafAESEUcfV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 14/31] builtin/am: make hash size independent
Date:   Tue, 12 Feb 2019 01:22:39 +0000
Message-Id: <20190212012256.1005924-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using GIT_SHA1_HEXSZ, switch to using the_hash_algo and
parse_oid_hex to parse the lines involved in rebasing notes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 58a2aef28b..584baf1c7e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -485,23 +485,24 @@ static int copy_notes_for_rebase(const struct am_state *state)
 
 	while (!strbuf_getline_lf(&sb, fp)) {
 		struct object_id from_obj, to_obj;
+		const char *p;
 
-		if (sb.len != GIT_SHA1_HEXSZ * 2 + 1) {
+		if (sb.len != the_hash_algo->hexsz * 2 + 1) {
 			ret = error(invalid_line, sb.buf);
 			goto finish;
 		}
 
-		if (get_oid_hex(sb.buf, &from_obj)) {
+		if (parse_oid_hex(sb.buf, &from_obj, &p)) {
 			ret = error(invalid_line, sb.buf);
 			goto finish;
 		}
 
-		if (sb.buf[GIT_SHA1_HEXSZ] != ' ') {
+		if (*p != ' ') {
 			ret = error(invalid_line, sb.buf);
 			goto finish;
 		}
 
-		if (get_oid_hex(sb.buf + GIT_SHA1_HEXSZ + 1, &to_obj)) {
+		if (get_oid_hex(p + 1, &to_obj)) {
 			ret = error(invalid_line, sb.buf);
 			goto finish;
 		}
