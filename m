Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796F11F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfBSAGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34794 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732253AbfBSAGI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69DFA6109A;
        Tue, 19 Feb 2019 00:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534766;
        bh=LmHmNgau81+JRvB1Fm95hA1U/DnQxiJww3/uJR+Nepg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=B8iji6YFHbaRBXS5JgpNtLj40g4FdmpTSv1R2FwIuH7osAR8jw8FPfFyBZ9DdUVO3
         io23PMZVEjBpIryIhnZKNWuEq/aAifSEAnnI777q0AwkLjFxfZayQMsQF0XwemjqbZ
         nkR50EyZLfqBWLzT5KiTjulfPb6YtSUEGZS1soUKh8dY587GwFzuyX75ThyXBMKJIq
         guC4ckiG/d4eTvH65dneQyhXWJ1scm0D9ON9Y3ahI9fFkjnd0eX6nQLpKwK35zT0Da
         R37Uk/6W+SbYQbtQc67LyWX9eYiKBNCkwQDMLoRAkgRHP+b4+93B+6ClYYF0jNpIjH
         hevV6XOk6eCBSm2wu6+8q4Et4+opG74FpHzHTYrEabiLempDTiuqJC3nyb8+rT1b/B
         byxGQqCGzYGw9ggaGouieWi6KvC7ZJ6X3I61TBVRR0sQ99Cs53+H8rtTbMGjs2U6tq
         9ecXLIoFoppvDuNMcsf6oQhFWNfVfDd9NZE++Ma4O0zkvwCbpV4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 25/35] remote-curl: make hash size independent
Date:   Tue, 19 Feb 2019 00:05:16 +0000
Message-Id: <20190219000526.476553-26-sandals@crustytoothpaste.net>
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

Change one hard-coded use of the constant 40 to a reference to
the_hash_algo.  In addition, switch a use of get_oid_hex to
parse_oid_hex to avoid the need to use a constant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index bb7421023b..8395b71bbb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -249,7 +249,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		if (data[i] == '\t')
 			mid = &data[i];
 		if (data[i] == '\n') {
-			if (mid - start != 40)
+			if (mid - start != the_hash_algo->hexsz)
 				die("%sinfo/refs not valid: is this a git repository?",
 				    url.buf);
 			data[i] = 0;
@@ -1013,12 +1013,13 @@ static void parse_fetch(struct strbuf *buf)
 			const char *name;
 			struct ref *ref;
 			struct object_id old_oid;
+			const char *q;
 
-			if (get_oid_hex(p, &old_oid))
+			if (parse_oid_hex(p, &old_oid, &q))
 				die("protocol error: expected sha/ref, got %s'", p);
-			if (p[GIT_SHA1_HEXSZ] == ' ')
-				name = p + GIT_SHA1_HEXSZ + 1;
-			else if (!p[GIT_SHA1_HEXSZ])
+			if (*q == ' ')
+				name = q + 1;
+			else if (!*q)
 				name = "";
 			else
 				die("protocol error: expected sha/ref, got %s'", p);
