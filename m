Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF741F462
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfBSAG3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732214AbfBSAF5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:57 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DC0F261094;
        Tue, 19 Feb 2019 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534755;
        bh=ZgJiDZe71IdN0eGb4vsIIvfqbAhK+NM/W4cs2L7qU7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nWZbRSn0v8WdInG6RIMW8CBkfr4mY9SgqtK+oML6AKxmnvMMo0FdgqhFoX67pADXn
         pwj433TDP2eva+JYz28hJK1LhuLkuZviCBV7uWS1L4VLer5sASwtG4XA21hQYrQEQ5
         WXsTUdIBZaUfnqizq1aKtDtL2xfvFe/j1BpUW9kSBEZo9MUBSwdUByLvsNQxhpgZNn
         uDIo4TVXph827iZ2rpaleBGjua1Q76PmTmqMzrK9rqUFHZYqkPDzfj+EYslD6+xUyi
         G79trZb2e5sBkIIM1nnglBdz4z/UdTvg/qP/E9wlU/kRkO27uTnut7591d7JPW66de
         fmamQaYc9VHL5OQxc403EWR0+3WqrgbN7rHWJxqMM2wvwKQjv+lBGKbeEq2MV9U6qL
         jCQGBi2cnlHBrS0eVrln/By6PTVLlv/9nbfozLH4E7QiO4B/3VpWUxyWAxMq2ZJ/NL
         b+yOxa8gVzj6V+9pKSMI8bHdsBDlL/SM+A6+AP+bWnf1o6ISlPt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 16/35] builtin/am: make hash size independent
Date:   Tue, 19 Feb 2019 00:05:07 +0000
Message-Id: <20190219000526.476553-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
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
