Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59FC21F462
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbfBSAG2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34784 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732272AbfBSAGL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:11 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CA172610A0;
        Tue, 19 Feb 2019 00:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534770;
        bh=/zpJdikSDXgMnhDCMz+ScWFQRvpcHde1awFK5hwKfRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=o1SvExm7JV2Byp4l0GJCvHOhHFw2TWFnEJ1rbs/3mbIu8CGXHtLSFWsl14aHE4lQ8
         nY+pEkRCkVuCB5I5oWZJYJDQ+AtAUWOk9+nU1jbYH+u50JrCDRtLfNa7Fikn5jRemv
         ypUl5Sit0nYhX5mE+toTngzCmIDjQGcZm7gxc5tsHmwumc9hdAKxQkGRJgXpumzyXD
         xPTlusERdDxM1ZWMt9nO0IK6AxDDY271isrqXMjkRZUjUyW4nQNRSc78HpfwsVfEdm
         sQ2mfbQHIdUS6i1ooshoeKGJy0uTulusfbuB6Z+ndftP0o0i7TnFnwSlTbhpZdLh4M
         lwJVUE1UcbbGKLKYBDlqHi7o++W/FJDGrowkg8KSEsITFunS2+GGOnzT5KGoR7X3il
         o1rjxoAp4iySC/YLxc8fnyvugyAAguxrJfW755ueEqAN6WXynmonNn8wgmI+yyiEl4
         /IGZf5wHj4R60vl45i0t0S2e9Qcs3aw7kZqJn70V3WyYrFNTBK5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 28/35] builtin/get-tar-commit-id: make hash size independent
Date:   Tue, 19 Feb 2019 00:05:19 +0000
Message-Id: <20190219000526.476553-29-sandals@crustytoothpaste.net>
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

To make this code independent of the hash size, verify that the length
of the comment is equal to that of any supported hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/get-tar-commit-id.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 312e44ed05..491af9202d 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -41,7 +41,8 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	if (!skip_prefix(end, " comment=", &comment))
 		return 1;
 	len -= comment - content;
-	if (len != GIT_SHA1_HEXSZ + 1)
+	if (len < 1 || !(len % 2) ||
+	    hash_algo_by_length((len - 1) / 2) == GIT_HASH_UNKNOWN)
 		return 1;
 
 	if (write_in_full(1, comment, len) < 0)
