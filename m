From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] zlib: wrap deflate side of the API
Date: Fri, 10 Jun 2011 13:15:46 -0700
Message-ID: <1307736948-16956-5-git-send-email-gitster@pobox.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:16:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV87o-00068o-TO
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123Ab1FJUQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:16:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab1FJUQB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:16:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D79994258
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dccf
	TWj/FNhG2B3hwpt/wzPSXyg=; b=wt1d3KQB3ZglguvJjT77AEoyt3xme+5huDdr
	f3OzBiH2AkhMM6pcTkSoSxsr5hIIm+EpJIq1ATt+NJUVEK5Qv1MzeTmWoziXgv6n
	ihMv9pgtXOiKVUw9I0rsUEMEBziqLhn88tl0u2E3zBZ3nFNYTybJ/Aefad7g1Vku
	h5+ddR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Zi4P3w
	Mgoc0oQS6JfJFek4FazSZmkOZ2Z0xk/AmJQIOfMRseIG89Jr2lamxc/xXTRyut7e
	2/JoK5shykKYwjzSBSRpsHW1x2M4/yawUROX+eyL6TfTPJHZjA0nv48G44cFnPOt
	PoNBe2dPgdriSJ5MwUSteb7yY0jRZnPmp63AI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A91DD4256
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75CC04254 for
 <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc1.118.ge175b4a
In-Reply-To: <1307736948-16956-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C2586E94-939E-11E0-8091-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175622>

Wrap deflateInit, deflate, and deflateEnd for everybody, and the sole use
of deflateInit2 in remote-curl.c to tell the library to use gzip header
and trailer in git_deflate_init_gzip().

There is only one caller that cares about the status from deflateEnd().
Introduce git_deflate_end_gently() to let that sole caller retrieve the
status and act on it (i.e. die) for now, but we would probably want to
make inflate_end/deflate_end die when they ran out of memory and get
rid of the _gently() kind.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive-zip.c          |    6 ++--
 builtin/index-pack.c   |    6 ++--
 builtin/pack-objects.c |    6 ++--
 cache.h                |    6 ++++
 diff.c                 |    6 ++--
 fast-import.c          |   22 ++++++++--------
 http-push.c            |   12 ++++----
 remote-curl.c          |   10 ++-----
 sha1_file.c            |   10 ++++----
 zlib.c                 |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 105 insertions(+), 41 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index cf28504..081ff83 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -96,7 +96,7 @@ static void *zlib_deflate(void *data, unsigned long size,
 	int result;
 
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, compression_level);
+	git_deflate_init(&stream, compression_level);
 	maxsize = deflateBound(&stream, size);
 	buffer = xmalloc(maxsize);
 
@@ -106,7 +106,7 @@ static void *zlib_deflate(void *data, unsigned long size,
 	stream.avail_out = maxsize;
 
 	do {
-		result = deflate(&stream, Z_FINISH);
+		result = git_deflate(&stream, Z_FINISH);
 	} while (result == Z_OK);
 
 	if (result != Z_STREAM_END) {
@@ -114,7 +114,7 @@ static void *zlib_deflate(void *data, unsigned long size,
 		return NULL;
 	}
 
-	deflateEnd(&stream);
+	git_deflate_end(&stream);
 	*compressed_size = stream.total_out;
 
 	return buffer;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 31f001f..dbfb5da 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -671,21 +671,21 @@ static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 	unsigned char outbuf[4096];
 
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
+	git_deflate_init(&stream, zlib_compression_level);
 	stream.next_in = in;
 	stream.avail_in = size;
 
 	do {
 		stream.next_out = outbuf;
 		stream.avail_out = sizeof(outbuf);
-		status = deflate(&stream, Z_FINISH);
+		status = git_deflate(&stream, Z_FINISH);
 		sha1write(f, outbuf, sizeof(outbuf) - stream.avail_out);
 	} while (status == Z_OK);
 
 	if (status != Z_STREAM_END)
 		die("unable to deflate appended object (%d)", status);
 	size = stream.total_out;
-	deflateEnd(&stream);
+	git_deflate_end(&stream);
 	return size;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f402a84..61f9755 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -131,7 +131,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	unsigned long maxsize;
 
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, pack_compression_level);
+	git_deflate_init(&stream, pack_compression_level);
 	maxsize = deflateBound(&stream, size);
 
 	in = *pptr;
@@ -142,9 +142,9 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	stream.avail_in = size;
 	stream.next_out = out;
 	stream.avail_out = maxsize;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
+	while (git_deflate(&stream, Z_FINISH) == Z_OK)
 		; /* nothing */
-	deflateEnd(&stream);
+	git_deflate_end(&stream);
 
 	free(in);
 	return stream.total_out;
diff --git a/cache.h b/cache.h
index 50f09d0..5eb61ac 100644
--- a/cache.h
+++ b/cache.h
@@ -25,6 +25,12 @@ void git_inflate_init_gzip_only(z_streamp strm);
 void git_inflate_end(z_streamp strm);
 int git_inflate(z_streamp strm, int flush);
 
+void git_deflate_init(z_streamp strm, int level);
+void git_deflate_init_gzip(z_streamp strm, int level);
+void git_deflate_end(z_streamp strm);
+int git_deflate_end_gently(z_streamp strm);
+int git_deflate(z_streamp strm, int flush);
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/diff.c b/diff.c
index 559bf57..c15c70f 100644
--- a/diff.c
+++ b/diff.c
@@ -1732,7 +1732,7 @@ static unsigned char *deflate_it(char *data,
 	z_stream stream;
 
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
+	git_deflate_init(&stream, zlib_compression_level);
 	bound = deflateBound(&stream, size);
 	deflated = xmalloc(bound);
 	stream.next_out = deflated;
@@ -1740,9 +1740,9 @@ static unsigned char *deflate_it(char *data,
 
 	stream.next_in = (unsigned char *)data;
 	stream.avail_in = size;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
+	while (git_deflate(&stream, Z_FINISH) == Z_OK)
 		; /* nothing */
-	deflateEnd(&stream);
+	git_deflate_end(&stream);
 	*result_size = stream.total_out;
 	return deflated;
 }
diff --git a/fast-import.c b/fast-import.c
index 78d9786..42979e6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1050,7 +1050,7 @@ static int store_object(
 		delta = NULL;
 
 	memset(&s, 0, sizeof(s));
-	deflateInit(&s, pack_compression_level);
+	git_deflate_init(&s, pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
 		s.avail_in = deltalen;
@@ -1060,9 +1060,9 @@ static int store_object(
 	}
 	s.avail_out = deflateBound(&s, s.avail_in);
 	s.next_out = out = xmalloc(s.avail_out);
-	while (deflate(&s, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&s);
+	while (git_deflate(&s, Z_FINISH) == Z_OK)
+		; /* nothing */
+	git_deflate_end(&s);
 
 	/* Determine if we should auto-checkpoint. */
 	if ((max_packsize && (pack_size + 60 + s.total_out) > max_packsize)
@@ -1078,14 +1078,14 @@ static int store_object(
 			delta = NULL;
 
 			memset(&s, 0, sizeof(s));
-			deflateInit(&s, pack_compression_level);
+			git_deflate_init(&s, pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
 			s.avail_out = deflateBound(&s, s.avail_in);
 			s.next_out = out = xrealloc(out, s.avail_out);
-			while (deflate(&s, Z_FINISH) == Z_OK)
-				/* nothing */;
-			deflateEnd(&s);
+			while (git_deflate(&s, Z_FINISH) == Z_OK)
+				; /* nothing */
+			git_deflate_end(&s);
 		}
 	}
 
@@ -1187,7 +1187,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	crc32_begin(pack_file);
 
 	memset(&s, 0, sizeof(s));
-	deflateInit(&s, pack_compression_level);
+	git_deflate_init(&s, pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(OBJ_BLOB, len, out_buf);
 	if (out_sz <= hdrlen)
@@ -1209,7 +1209,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 			len -= n;
 		}
 
-		status = deflate(&s, len ? 0 : Z_FINISH);
+		status = git_deflate(&s, len ? 0 : Z_FINISH);
 
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t n = s.next_out - out_buf;
@@ -1228,7 +1228,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 			die("unexpected deflate failure: %d", status);
 		}
 	}
-	deflateEnd(&s);
+	git_deflate_end(&s);
 	git_SHA1_Final(sha1, &c);
 
 	if (sha1out)
diff --git a/http-push.c b/http-push.c
index d18346c..46e68c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -359,7 +359,7 @@ static void start_put(struct transfer_request *request)
 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
+	git_deflate_init(&stream, zlib_compression_level);
 	size = deflateBound(&stream, len + hdrlen);
 	strbuf_init(&request->buffer.buf, size);
 	request->buffer.posn = 0;
@@ -371,15 +371,15 @@ static void start_put(struct transfer_request *request)
 	/* First header.. */
 	stream.next_in = (void *)hdr;
 	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+	while (git_deflate(&stream, 0) == Z_OK)
+		; /* nothing */
 
 	/* Then the data itself.. */
 	stream.next_in = unpacked;
 	stream.avail_in = len;
-	while (deflate(&stream, Z_FINISH) == Z_OK)
-		/* nothing */;
-	deflateEnd(&stream);
+	while (git_deflate(&stream, Z_FINISH) == Z_OK)
+		; /* nothing */
+	git_deflate_end(&stream);
 	free(unpacked);
 
 	request->buffer.buf.len = stream.total_out;
diff --git a/remote-curl.c b/remote-curl.c
index 775d614..3c7621a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -475,11 +475,7 @@ static int post_rpc(struct rpc_state *rpc)
 		int ret;
 
 		memset(&stream, 0, sizeof(stream));
-		ret = deflateInit2(&stream, Z_BEST_COMPRESSION,
-				Z_DEFLATED, (15 + 16),
-				8, Z_DEFAULT_STRATEGY);
-		if (ret != Z_OK)
-			die("cannot deflate request; zlib init error %d", ret);
+		git_deflate_init_gzip(&stream, Z_BEST_COMPRESSION);
 		size = deflateBound(&stream, rpc->len);
 		gzip_body = xmalloc(size);
 
@@ -488,11 +484,11 @@ static int post_rpc(struct rpc_state *rpc)
 		stream.next_out = (unsigned char *)gzip_body;
 		stream.avail_out = size;
 
-		ret = deflate(&stream, Z_FINISH);
+		ret = git_deflate(&stream, Z_FINISH);
 		if (ret != Z_STREAM_END)
 			die("cannot deflate request; zlib deflate error %d", ret);
 
-		ret = deflateEnd(&stream);
+		ret = git_deflate_end_gently(&stream);
 		if (ret != Z_OK)
 			die("cannot deflate request; zlib end error %d", ret);
 
diff --git a/sha1_file.c b/sha1_file.c
index 1a7e410..0eefb61 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2442,7 +2442,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
+	git_deflate_init(&stream, zlib_compression_level);
 	stream.next_out = compressed;
 	stream.avail_out = sizeof(compressed);
 	git_SHA1_Init(&c);
@@ -2450,8 +2450,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	/* First header.. */
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+	while (git_deflate(&stream, 0) == Z_OK)
+		; /* nothing */
 	git_SHA1_Update(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
@@ -2459,7 +2459,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
-		ret = deflate(&stream, Z_FINISH);
+		ret = git_deflate(&stream, Z_FINISH);
 		git_SHA1_Update(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die("unable to write sha1 file");
@@ -2469,7 +2469,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
-	ret = deflateEnd(&stream);
+	ret = git_deflate_end_gently(&stream);
 	if (ret != Z_OK)
 		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
 	git_SHA1_Final(parano_sha1, &c);
diff --git a/zlib.c b/zlib.c
index b613cbd..ee47a3a 100644
--- a/zlib.c
+++ b/zlib.c
@@ -77,3 +77,65 @@ int git_inflate(z_streamp strm, int flush)
 	      strm->msg ? strm->msg : "no message");
 	return status;
 }
+
+void git_deflate_init(z_streamp strm, int level)
+{
+	int status = deflateInit(strm, level);
+
+	if (status == Z_OK)
+		return;
+	die("deflateInit: %s (%s)", zerr_to_string(status),
+	    strm->msg ? strm->msg : "no message");
+}
+
+void git_deflate_init_gzip(z_streamp strm, int level)
+{
+	/*
+	 * Use default 15 bits, +16 is to generate gzip header/trailer
+	 * instead of the zlib wrapper.
+	 */
+	const int windowBits = 15 + 16;
+	int status = deflateInit2(strm, level,
+				  Z_DEFLATED, windowBits,
+				  8, Z_DEFAULT_STRATEGY);
+	if (status == Z_OK)
+		return;
+	die("deflateInit2: %s (%s)", zerr_to_string(status),
+	    strm->msg ? strm->msg : "no message");
+}
+
+void git_deflate_end(z_streamp strm)
+{
+	int status = deflateEnd(strm);
+
+	if (status == Z_OK)
+		return;
+	error("deflateEnd: %s (%s)", zerr_to_string(status),
+	      strm->msg ? strm->msg : "no message");
+}
+
+int git_deflate_end_gently(z_streamp strm)
+{
+	return deflateEnd(strm);
+}
+
+int git_deflate(z_streamp strm, int flush)
+{
+	int status = deflate(strm, flush);
+
+	switch (status) {
+	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
+	case Z_BUF_ERROR:
+	case Z_OK:
+	case Z_STREAM_END:
+		return status;
+
+	case Z_MEM_ERROR:
+		die("deflate: out of memory");
+	default:
+		break;
+	}
+	error("deflate: %s (%s)", zerr_to_string(status),
+	      strm->msg ? strm->msg : "no message");
+	return status;
+}
-- 
1.7.6.rc1.118.ge175b4a
