Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA269207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034333AbcIZODO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 10:03:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:48090 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030407AbcIZODM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 10:03:12 -0400
Received: (qmail 25836 invoked by uid 109); 26 Sep 2016 14:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 14:03:11 +0000
Received: (qmail 5028 invoked by uid 111); 26 Sep 2016 14:03:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 10:03:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 10:03:09 -0400
Date:   Mon, 26 Sep 2016 10:03:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: Re: [PATCH] unpack_sha1_header(): detect malformed object header
Message-ID: <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
 <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
 <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016 at 09:29:04PM -0700, Junio C Hamano wrote:

> To correct this, do these three things:
> 
>  - rename unpack_sha1_header() to unpack_sha1_short_header() and
>    have unpack_sha1_header_to_strbuf() keep calling that as its
>    helper function.  This will detect and report zlib errors, but is
>    not aware of the format of a loose object (as before).

This step makes sense to me, and is a problem in the original you posted
(i.e., we may not see all of the header in the strbuf variant). Your
refactor looks good.

>  - introduce unpack_sha1_header() that calls the same helper
>    function, and when zlib reports it inflated OK into the buffer,
>    check if the buffer has both SP and NUL in this order.  This
>    would ensure that parsing function will terminate within the
>    buffer that holds the inflated header.
> 
>  - update unpack_sha1_header_to_strbuf() to check if the resulting
>    buffer has both SP and NUL in this order for the same effect.

This part I don't understand, though. We clearly need to look for the
NUL. But why do we need to look for the space? The loop in
parse_sha1_header() can easily detect this as it looks for the end of
the type name (and if it hits the end-of-string, can bail as in your
original patch).

I.e., the root of the problem is that we pass parse_sha1_header() a the
"ptr" half of a ptr/len buffer, and it has no idea how much we read.
But once we get it that information (either by passing the length, or by
ensuring that the buffer is NUL-terminated, it should be easy for it to
do the right thing.

Anyway, here's my ptr/len version (which passes the length back out of
unpack_sha1_header via an in/out pointer). After thinking on it, though,
I'm of the opinion that we're better off just ensuring that "hdr" is
NUL-terminated. We end up assuming that anyway later, since we have to
know how much of the header buffer was consumed by parsing.

Do note the final call below in the streaming loose-open code, which
exhibits that, but also seems to call parse_sha1_header() without
checking its return value. I think that needs fixed regardless of the
approach.

---
diff --git a/cache.h b/cache.h
index d0494c8..e89dcff 100644
--- a/cache.h
+++ b/cache.h
@@ -1121,8 +1121,9 @@ extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned c
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_noatime(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
-extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
+extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned
+			      long mapsize, void *buffer, size_t *bufsiz);
+extern int parse_sha1_header(const char *hdr, size_t len, unsigned long *sizep);
 
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
diff --git a/sha1_file.c b/sha1_file.c
index b9c1fa3..326593b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1646,41 +1646,50 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
+int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize,
+		       void *buffer, size_t *bufsiz)
 {
+	int ret;
+
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
 	stream->next_in = map;
 	stream->avail_in = mapsize;
 	stream->next_out = buffer;
-	stream->avail_out = bufsiz;
+	stream->avail_out = *bufsiz;
 
 	git_inflate_init(stream);
-	return git_inflate(stream, 0);
+	ret = git_inflate(stream, 0);
+	*bufsiz -= stream->avail_out;
+	return ret;
 }
 
-static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
-					unsigned long mapsize, void *buffer,
-					unsigned long bufsiz, struct strbuf *header)
+static int unpack_sha1_header_to_strbuf(git_zstream *stream,
+					unsigned char *map, unsigned long mapsize,
+					void *buffer, size_t *bufsiz,
+					struct strbuf *header)
 {
+	size_t initial_len = *bufsiz;
 	int status;
 
-	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
+	status = unpack_sha1_header(stream, map, mapsize, buffer, &initial_len);
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
 	 */
-	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
+	if (memchr(buffer, '\0', initial_len)) {
+		*bufsiz = initial_len;
 		return 0;
+	}
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
 	 * result out to header, and then append the result of further
 	 * reading the stream.
 	 */
-	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
+	strbuf_add(header, buffer, initial_len);
 	stream->next_out = buffer;
-	stream->avail_out = bufsiz;
+	stream->avail_out = *bufsiz;
 
 	do {
 		status = git_inflate(stream, 0);
@@ -1688,7 +1697,7 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 			return 0;
 		stream->next_out = buffer;
-		stream->avail_out = bufsiz;
+		stream->avail_out = *bufsiz;
 	} while (status != Z_STREAM_END);
 	return -1;
 }
@@ -1743,9 +1752,11 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
-			       unsigned int flags)
+static int parse_sha1_header_extended(const char *hdr, size_t len,
+				      struct object_info *oi,
+				      unsigned int flags)
 {
+	const char *end = hdr + len;
 	const char *type_buf = hdr;
 	unsigned long size;
 	int type, type_len = 0;
@@ -1754,12 +1765,14 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	 * The type can be of any size but is followed by
 	 * a space.
 	 */
-	for (;;) {
+	while (hdr < end) {
 		char c = *hdr++;
 		if (c == ' ')
 			break;
 		type_len++;
 	}
+	if (hdr >= end)
+		return -1;
 
 	type = type_from_string_gently(type_buf, type_len, 1);
 	if (oi->typename)
@@ -1781,10 +1794,10 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	 * decimal format (ie "010" is not valid).
 	 */
 	size = *hdr++ - '0';
-	if (size > 9)
+	if (size > 9 || hdr >= end)
 		return -1;
 	if (size) {
-		for (;;) {
+		while (hdr >= end) {
 			unsigned long c = *hdr - '0';
 			if (c > 9)
 				break;
@@ -1799,17 +1812,17 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type;
+	return hdr >= end || *hdr ? -1 : type;
 }
 
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+int parse_sha1_header(const char *hdr, size_t len, unsigned long *sizep)
 {
 	struct object_info oi;
 
 	oi.sizep = sizep;
 	oi.typename = NULL;
 	oi.typep = NULL;
-	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
+	return parse_sha1_header_extended(hdr, len, &oi, LOOKUP_REPLACE_OBJECT);
 }
 
 static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
@@ -1817,9 +1830,11 @@ static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type
 	int ret;
 	git_zstream stream;
 	char hdr[8192];
+	size_t hdr_len = sizeof(hdr);
 
-	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
-	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
+	ret = unpack_sha1_header(&stream, map, mapsize, hdr, &hdr_len);
+	if (ret < Z_OK ||
+	    (*type = parse_sha1_header(hdr, hdr_len, size)) < 0)
 		return NULL;
 
 	return unpack_sha1_rest(&stream, hdr, *size, sha1);
@@ -2697,6 +2712,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	void *map;
 	git_zstream stream;
 	char hdr[32];
+	size_t hdr_len = sizeof(hdr);
 	struct strbuf hdrbuf = STRBUF_INIT;
 
 	if (oi->delta_base_sha1)
@@ -2725,19 +2741,19 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
-		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
+		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, &hdr_len, &hdrbuf) < 0)
 			status = error("unable to unpack %s header with --allow-unknown-type",
 				       sha1_to_hex(sha1));
-	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, &hdr_len) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
-		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
+		if ((status = parse_sha1_header_extended(hdrbuf.buf, hdrbuf.len, oi, flags)) < 0)
 			status = error("unable to parse %s header with --allow-unknown-type",
 				       sha1_to_hex(sha1));
-	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
+	} else if ((status = parse_sha1_header_extended(hdr, hdr_len, oi, flags)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
diff --git a/streaming.c b/streaming.c
index 3c48f04..ee73544 100644
--- a/streaming.c
+++ b/streaming.c
@@ -334,6 +334,7 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
+	size_t len = sizeof(st->u.loose.hdr);
 	st->u.loose.mapped = map_sha1_file(sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
@@ -341,13 +342,14 @@ static open_method_decl(loose)
 			       st->u.loose.mapped,
 			       st->u.loose.mapsize,
 			       st->u.loose.hdr,
-			       sizeof(st->u.loose.hdr)) < 0) {
+			       &len) < 0) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
 		return -1;
 	}
 
-	parse_sha1_header(st->u.loose.hdr, &st->size);
+	if (parse_sha1_header(st->u.loose.hdr, len, &st->size) < 0)
+		return -1;
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
 	st->u.loose.hdr_avail = st->z.total_out;
 	st->z_state = z_used;
