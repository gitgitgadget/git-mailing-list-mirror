Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54417C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhLJKik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbhLJKih (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:38:37 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E11C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r5so7694486pgi.6
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pYD1ko5Dr86OxJiFYWXfYMN9lM5KBG2alYRQXKafq8=;
        b=MVbUGiLYsNjaYGTJOLUxHe/fnWVUE6GxrbxQSb9adx9PrBNKYRV8FyPnAq8ABIssR/
         GhWJKUD6U/9hZYrHQdIJAwCWb/9KUMQH18/W+l2fsPecHlehuq0xWJbBFupFwcGxTraS
         R/hnkwBwBsV6FeFKkZ2o0xCg0fIAMRZDmyeKlYrTRLfrqNGX93W8M9DXRjg38iUJOKfQ
         u8xBjB2FjXPfVrwLCtvZodA2zXGTE6x9+SE98MJCudjOu3BxylNhdRPFzD74KEFMSTGD
         lL82SveUBL5hirXgDnFchi/mscjLugFzdhxE6+aTedMomB7UM3+pme7XOT0wssvlPbvm
         RCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pYD1ko5Dr86OxJiFYWXfYMN9lM5KBG2alYRQXKafq8=;
        b=7ZQ6kWIRWngearDUrzMN5g9uZyOl695Vsg/HAeJm51iLAh8xQtynVnJByXjx/bQAMg
         doFvsjvWVFUUu4S90+B57AVlUwdo/arlKan7Qr3K91OAjnuBkE347u3o7rkdDrYk9QrC
         E59qNs4xtz5A91EgCLXyR8ISA1axqSCDO4aC8suwGEXLWdwfmdgoeVoBrkUl5MSG8PZH
         D1MzmxZFuBMI/xP92s1oFYtTZ1RyWHiUbnh9Itftljlrz3cggpqqc/saPQVCD3I+GAni
         Sp+Pc5vHqrE9BSMB6H5Zgsr7urRGDyF0l7viO+VzQk11FIaOVuh8o8WCt8RWu1YkJx6V
         w5/Q==
X-Gm-Message-State: AOAM532qVKWPu8hEKNgyi+LwWIDsEUgLtd81c8yydMAngAZaQYul/rjT
        +IShO12y/ZPa4v+AYM9DCgI=
X-Google-Smtp-Source: ABdhPJxIunUehUEdkG5Gu/03z65X3GwR82hFuNqfPUJzulRKeKaPibAYuxcdIEDIRiKXeipYnxQxew==
X-Received: by 2002:a63:5758:: with SMTP id h24mr39015611pgm.110.1639132501823;
        Fri, 10 Dec 2021 02:35:01 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id 204sm2396250pgb.63.2021.12.10.02.34.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:35:01 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 1/6] object-file: refactor write_loose_object() to support read from stream
Date:   Fri, 10 Dec 2021 18:34:30 +0800
Message-Id: <20211210103435.83656-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We used to call "get_data()" in "unpack_non_delta_entry()" to read the
entire contents of a blob object, no matter how big it is. This
implementation may consume all the memory and cause OOM.

This can be improved by feeding data to "write_loose_object()" in a
stream. The input stream is implemented as an interface.

In the first step, we add a new flag called "HASH_STREAM" and make a
simple implementation, feeding the entire buffer in the stream to
"write_loose_object()" as a refactor.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 cache.h        | 1 +
 object-file.c  | 7 ++++++-
 object-store.h | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index eba12487b9..51bd435dea 100644
--- a/cache.h
+++ b/cache.h
@@ -888,6 +888,7 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
 #define HASH_SILENT 8
+#define HASH_STREAM 16
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
diff --git a/object-file.c b/object-file.c
index eb972cdccd..06375a90d6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1898,7 +1898,12 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
-	stream.next_in = (void *)buf;
+	if (flags & HASH_STREAM) {
+		struct input_stream *in_stream = (struct input_stream *)buf;
+		stream.next_in = (void *)in_stream->read(in_stream, &len);
+	} else {
+		stream.next_in = (void *)buf;
+	}
 	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
diff --git a/object-store.h b/object-store.h
index 952efb6a4b..ccc1fc9c1a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,6 +34,11 @@ struct object_directory {
 	char *path;
 };
 
+struct input_stream {
+	const void *(*read)(struct input_stream *, unsigned long *len);
+	void *data;
+};
+
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
-- 
2.34.0

