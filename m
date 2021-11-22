Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8694DC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 03:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhKVDib (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 22:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbhKVDi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 22:38:29 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179CC06174A
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g28so14120920pgg.3
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DIFfJroC/Tlu2xEKftWDh3qdi8ocVmh14BH4zv3jX+Q=;
        b=ADXjcPIDecyxKMHizl5ZspDS0H4je62rgtyFbN+CWWBLR7RPNN4HiDLQwXnwqk94kh
         evPRuIivJQpfVzsEJwSQy9Fq8Jg8LcysWekfv35JnM6ELvMybPi9BqGbH1inwDppx47f
         t3OKyhmm2oInui5zdjzH2ftIZDLmU+K9TWJfp6yKNngoxVpcXmTIS38w/ckdwuD4TOWo
         m2q1AbdLVQT5l5pHBxlRA5EdXSZ7qiQY83bCPSMHzPFWQNzTkOuPm7jy+2UVJZyjiEa9
         q17TP2/Ae5YO6ouL/qJcLeI7I0mc0Q67BGGapOzQLz8jFZaTToP5ou2LZGofyxhx5FmS
         MaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DIFfJroC/Tlu2xEKftWDh3qdi8ocVmh14BH4zv3jX+Q=;
        b=KKE5o2Vv6gRDirQZ9f4qlfdrdfkMNa3UlZY3NVKbD8tvQo2IWoX+pxTl5hD+JEaBAo
         9yHGN1SsW3ZzPN4fUQD5zIvAQSCe+rNcnW2R20WwUNDK7pG3D2Ya1npA9dCr6SWCEFMJ
         psTVweYO1iCBJQRbKxRioBV/WVBBmnzetYuxF0S93PYXyx4C+PRSYARdrbKvaa4wQbRF
         4aW2dDqDn90knFesNAdGt6cVbV195AwgQpn/1njbCJS6gsUADS5FE92fjRFM8aBiz9Zi
         14kW3av1+wXzeR54BGeHeWxbSWN4Zf3PEKoG+AO89wFD3mO/m3q4lSZq8tiREowj/8SB
         B1kQ==
X-Gm-Message-State: AOAM530I78ZTFgmXq6/ccepD8VWkz373U1Kjg5Cx2C38xMJ9L7q6JlFa
        aLwIcKkg8f9Wwx2+zx6IQ7YANQ8C3IMjz2sL
X-Google-Smtp-Source: ABdhPJy2yTR2Qyy+wGHzqG5hoPZkfwxe191syqYCLmAPhxYE+g8B2yAPOAjyHxRjdzyagGmB21LePw==
X-Received: by 2002:a63:5b66:: with SMTP id l38mr31181319pgm.62.1637552122975;
        Sun, 21 Nov 2021 19:35:22 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id q11sm1235714pgt.54.2021.11.21.19.35.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 19:35:22 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v3 4/5] unpack-objects.c: add dry_run mode for get_data()
Date:   Mon, 22 Nov 2021 11:32:19 +0800
Message-Id: <20211122033220.32883-5-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0.6.g676eedc724
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In dry_run mode, "get_data()" is used to verify the inflation of data,
and the returned buffer will not be used at all and will be freed
immediately. Even in dry_run mode, it is dangerous to allocate a
full-size buffer for a large blob object. Therefore, only allocate a
low memory footprint when calling "get_data()" in dry_run mode.

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..8d68acd662 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,16 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
-static void *get_data(unsigned long size)
+static void *get_data(unsigned long size, int dry_run)
 {
 	git_zstream stream;
-	void *buf = xmallocz(size);
+	unsigned long bufsize = dry_run ? 4096 : size;
+	void *buf = xmallocz(bufsize);
 
 	memset(&stream, 0, sizeof(stream));
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -124,6 +125,11 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		if (dry_run) {
+			/* reuse the buffer in dry_run mode */
+			stream.next_out = buf;
+			stream.avail_out = bufsize;
+		}
 	}
 	git_inflate_end(&stream);
 	return buf;
@@ -323,7 +329,7 @@ static void added_object(unsigned nr, enum object_type type,
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf = get_data(size, dry_run);
 
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
@@ -357,7 +363,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (type == OBJ_REF_DELTA) {
 		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
@@ -396,7 +402,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		if (base_offset <= 0 || base_offset >= obj_list[nr].offset)
 			die("offset value out of bound for delta base object");
 
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
-- 
2.34.0.6.g676eedc724

