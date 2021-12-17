Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B24C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhLQL2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhLQL2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:28:51 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A95C061746
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id j11so1823786pgs.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brw6puewM6wIOapjreSySZDw9+q290fiA4aXnkwiQ+A=;
        b=oBwrmOYgsA9i5VmbduC61BTJYhVtjwkrmHhLstdP9upLEEt3a6y5kcznRmKOhyFJGy
         ntVx5K8KtgwpL+Ojvb5ntoJhUvdBKOKMAqQWy4Z1KutlO4bJG3fFsOBj3xs7O9vAw3oU
         GEFPTpJbSAW5RCwt5+OlMxo19ICgttAhaDhAf0tiBvdBu6Jh/SBLBig7NEuFNn2SDO/t
         QD+QKBZHGZm1t1gzl5l6C5aosPgwkn3U4wq8YRLBmdZtIXjBAFOSZqaA1z5Dc52RAq0m
         O6FHzH8oCwcEOPi+mqlrCQ34gX2qQ48OLkWPbGXJoQYY+548vHc05iKQQw2YFSJEFULz
         dPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brw6puewM6wIOapjreSySZDw9+q290fiA4aXnkwiQ+A=;
        b=UBv43wZ6tRqzyy5pYC8SLHP45TsIQFoG2jXBtW0qSNd5EeNNg7f4Fs+qNCbAmuJJvj
         EStT/zpdSdFYEAW70sjgEsnumpyf8YZNuEgsEAk4GbuFFPMTqyTgAuevr78CZ5puftTr
         5Nua8eq9ksOS+FP8+0JwFDGyRdczJM+UEDUI49ohYIHPGgVKscbR/NCrJk/kXOLuTPZ6
         zlIgs3O5crGkOOH0fd6dSdkE7esFtjrnaOD8E1FntHat9c03MN6n2qi3Wb2E5Yrev/v1
         FjOCJoGT6gfiw6EySafuj9VayCU2TT1MGT214bO2DH0pPvb3PDVwPV3CJ0+S30YJgzsB
         hicg==
X-Gm-Message-State: AOAM530wyr70jBsxujkoXfBEUyP7yOzfHv4vXvG2XJIA1ktmehRFz2Ef
        syFEqUlQCY94ZtXAnmmt2fWyR7QLhEC4bcmD
X-Google-Smtp-Source: ABdhPJyM07ExTbTIiDhOGgXrBGcZH3mSvpO4FWiikkjBUSNJZm8fhc70Pu/1Sawd+VXEEmRrXRBzXw==
X-Received: by 2002:a63:1926:: with SMTP id z38mr2575595pgl.3.1639740531142;
        Fri, 17 Dec 2021 03:28:51 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id f10sm5194673pge.33.2021.12.17.03.28.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:28:50 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v6 5/6] unpack-objects.c: add dry_run mode for get_data()
Date:   Fri, 17 Dec 2021 19:26:28 +0800
Message-Id: <20211217112629.12334-6-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gfcc2252aea.agit.6.5.6
In-Reply-To: <20211210103435.83656-1-chiyutianyi@gmail.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
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
 builtin/unpack-objects.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..c4a17bdb44 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,21 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
-static void *get_data(unsigned long size)
+static void *get_data(unsigned long size, int dry_run)
 {
 	git_zstream stream;
-	void *buf = xmallocz(size);
+	unsigned long bufsize;
+	void *buf;
 
 	memset(&stream, 0, sizeof(stream));
+	if (dry_run && size > 8192)
+		bufsize = 8192;
+	else
+		bufsize = size;
+	buf = xmallocz(bufsize);
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -124,6 +130,11 @@ static void *get_data(unsigned long size)
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
@@ -323,7 +334,7 @@ static void added_object(unsigned nr, enum object_type type,
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf = get_data(size, dry_run);
 
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
@@ -357,7 +368,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (type == OBJ_REF_DELTA) {
 		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
@@ -396,7 +407,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		if (base_offset <= 0 || base_offset >= obj_list[nr].offset)
 			die("offset value out of bound for delta base object");
 
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
-- 
2.34.1.52.gfcc2252aea.agit.6.5.6

