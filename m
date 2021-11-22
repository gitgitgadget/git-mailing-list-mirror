Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B5C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 03:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhKVDi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 22:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbhKVDiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 22:38:24 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB1C061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:16 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 28so14083515pgq.8
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sC20LGPj+f+gxZC8VQdLa6H7wX5W1clh4LstrrvGKHQ=;
        b=RJccCgLiidj1tcnkWI6nw7DZ7eE9zlaDdZl+9I9mM1l3GsY2e5W+pG2uCh9f/AT0bF
         oOI0l9pJVgTl31IkZZfdgGNaLAIjETgK5BOK9B6x5WQGjTykxebu0o604RcaR5NRmmgL
         bEv9PyVrKXbnsilIvi/hvyVF5PtDQ317f/scNOkjmJOOTFKgRliH7dEGdmJeCMt0fouC
         EeQXVUgbbfHd72c57PadlDVZmuk5AtVsgO2tX5NHOkLLJAN/ACW5RXT3mWDOlCWOKbiJ
         gfalAm+box75nXIQmw6nzGrOOrhSSmJ1bjVKW+DFazHzXoSOFVJAFhZxc2zk1FxjqsLB
         psGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sC20LGPj+f+gxZC8VQdLa6H7wX5W1clh4LstrrvGKHQ=;
        b=VtMXDAY2GoMhfnX63cD8F/NVlS7TXYVR7vkJCl+V/UCiBCL06QXMPY9XhgyOFOpE4Q
         6V5e0IZxX6nCv6tiB2drs0CCuIpOfFmZDWlRaPA8Xg7DYSaWlags6xYimRW4dt+BVMXW
         vD69QqsHbq3Fo1jd/pMCSUroKKSOQNFu4T56MQlkLi0/nCdC8ESFzczpwEG7nJmmhMPB
         sm4KfoVI6P6B4DtZKc7zAwfu+uj5jomQxXrXWNAqLiVili4zj2ydiX9Uy5KoC5Uo+Vba
         J4vH04dcAkEA2fHB3EDxANG0pjcdRdDO1O3KInGPfbPaI4em8K2WFbYhBBdU/XDmqdlY
         eptQ==
X-Gm-Message-State: AOAM530StJd4PmrTCUWbH4MvyLSVqj6gnjmVGXYeTI7KRYGpJscohmUy
        SxFxap/qq+NJWA+kFRAtW/o=
X-Google-Smtp-Source: ABdhPJySXhZuqTARTSqSLX+zz/Ld96/XxaaCnYdrqeCCdBCi6fha7pnLxxzMEPfaDO1XZRbMr3Kbwg==
X-Received: by 2002:a63:7554:: with SMTP id f20mr32146221pgn.122.1637552116253;
        Sun, 21 Nov 2021 19:35:16 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id q11sm1235714pgt.54.2021.11.21.19.35.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 19:35:15 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v3 1/5] object-file: refactor write_loose_object() to read buffer from stream
Date:   Mon, 22 Nov 2021 11:32:16 +0800
Message-Id: <20211122033220.32883-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0.6.g676eedc724
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We used to call "get_data()" in "unpack_non_delta_entry()" to read the
entire contents of a blob object, no matter how big it is. This
implementation may consume all the memory and cause OOM.

This can be improved by feeding data to "write_loose_object()" in a
stream. The input stream is implemented as an interface. In the first
step, we make a simple implementation, feeding the entire buffer in the
"stream" to "write_loose_object()" as a refactor.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 object-store.h |  5 +++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index c3d866a287..227f53a0de 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1860,8 +1860,26 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
+struct simple_input_stream_data {
+	const void *buf;
+	unsigned long len;
+};
+
+static const void *feed_simple_input_stream(struct input_stream *in_stream, unsigned long *len)
+{
+	struct simple_input_stream_data *data = in_stream->data;
+
+	if (data->len == 0) {
+		*len = 0;
+		return NULL;
+	}
+	*len = data->len;
+	data->len = 0;
+	return data->buf;
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, struct input_stream *in_stream,
 			      time_t mtime, unsigned flags)
 {
 	int fd, ret;
@@ -1871,6 +1889,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
+	const void *buf;
+	unsigned long len;
 
 	loose_object_path(the_repository, &filename, oid);
 
@@ -1898,6 +1918,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
+	buf = in_stream->read(in_stream, &len);
 	stream.next_in = (void *)buf;
 	stream.avail_in = len;
 	do {
@@ -1960,6 +1981,13 @@ int write_object_file_flags(const void *buf, unsigned long len,
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
+	struct input_stream in_stream = {
+		.read = feed_simple_input_stream,
+		.data = (void *)&(struct simple_input_stream_data) {
+			.buf = buf,
+			.len = len,
+		},
+	};
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
@@ -1968,7 +1996,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
-	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
+	return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags);
 }
 
 int hash_object_file_literally(const void *buf, unsigned long len,
@@ -1977,6 +2005,13 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 {
 	char *header;
 	int hdrlen, status = 0;
+	struct input_stream in_stream = {
+		.read = feed_simple_input_stream,
+		.data = (void *)&(struct simple_input_stream_data) {
+			.buf = buf,
+			.len = len,
+		},
+	};
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
@@ -1988,7 +2023,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 		goto cleanup;
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
-	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
+	status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0);
 
 cleanup:
 	free(header);
@@ -2003,14 +2038,21 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 	int ret;
+	struct simple_input_stream_data data;
+	struct input_stream in_stream = {
+		.read = feed_simple_input_stream,
+		.data = &data,
+	};
 
 	if (has_loose_object(oid))
 		return 0;
 	buf = read_object(the_repository, oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
+	data.buf = buf;
+	data.len = len;
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
-	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
+	ret = write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0);
 	free(buf);
 
 	return ret;
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
2.34.0.6.g676eedc724

