Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723501F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfBSAGQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34864 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732283AbfBSAGP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:15 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C730B6098B;
        Tue, 19 Feb 2019 00:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534774;
        bh=21R0ZmdwGZwskSohZ4fsvY+8FipoG2XkVVGGawAASGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Po20vAwoVoSdTEZSsPEiePzcPjcqzzzfFhE1Gi1A+gxh6O6Lw+hQZakfvrICWQZAM
         VtgUuXi+dBNHQuj3lmR6RKIoKQDdoliNYqoPeF0V6j4NSQmj+n3MyvVgVv9RxhKe96
         DX2Za3HOt/IOh38U+9Ip68+cWJKorjBguxvUhYgLn7khCD16gC4O11MbksHfmsda2Q
         p4YX4F+H7RrW5f9aNjKiYMDAAmWxOZKqRKMvjwWdV9+GCGxrZfOGTn+8ap0WrrE1kl
         m/F6jxt7S3OKWuqbDwobggwWd7AJ6bibVm14FStJa2TcJIJdRBHdYbICDPGbGMo17T
         jHeRrdYwRY/gqv309kbh2FbLDWlGhyrHVq8T+I5GCoWpnuL1/2k5UVn4GgqmLP0UF4
         yJOInmCIMUPpmImiQ5D6a7NHLLWkXsd1No90kzWXop3dlzrNQWY1j/KV1VQqMUUN7v
         e5PkeZhA1dHMTen+enSaza6YKNCHgo2QWLzkmWD29utel1C3JyK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 31/35] builtin/difftool: use parse_oid_hex
Date:   Tue, 19 Feb 2019 00:05:22 +0000
Message-Id: <20190219000526.476553-32-sandals@crustytoothpaste.net>
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

Instead of using get_oid_hex and adding constants to the result, use
parse_oid_hex to make this code independent of the hash size.

Additionally, correct a typo that would cause us to print one too few
characters on error, since we will already have incremented the pointer
to point to the beginning of the object ID before we get to printing the
error message.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/difftool.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..5fa83f481e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -65,14 +65,12 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
 	*mode2 = (int)strtol(p + 1, &p, 8);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (get_oid_hex(++p, oid1))
-		return error("expected object ID, got '%s'", p + 1);
-	p += GIT_SHA1_HEXSZ;
+	if (parse_oid_hex(++p, oid1, (const char **)&p))
+		return error("expected object ID, got '%s'", p);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (get_oid_hex(++p, oid2))
-		return error("expected object ID, got '%s'", p + 1);
-	p += GIT_SHA1_HEXSZ;
+	if (parse_oid_hex(++p, oid2, (const char **)&p))
+		return error("expected object ID, got '%s'", p);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
 	*status = *++p;
