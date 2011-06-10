From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] zlib: zlib can only process 4GB at a time
Date: Fri, 10 Jun 2011 13:15:48 -0700
Message-ID: <1307736948-16956-7-git-send-email-gitster@pobox.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV87q-00068o-2H
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab1FJUQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:16:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab1FJUQH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:16:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D64D426A
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LDnW
	lb/X55aajMkLoTRzclekFQ0=; b=WnHLHteKA+ZEoi3FgvFmnyYY0OBPbLwJuaSw
	G/bKcKzw+xxTU/OegGfFjOTaIMFxjG8rDdB/ADQ2/ET3nPPeUHSfa3E7FwDXKU4B
	i7UBg5+iIL78UU/d8PZ8ApgyczYL+05oLvhoE9b0BnZW7So0yXBnNkLNa452zsAN
	Ml3pn2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Lzb54b
	aWn1RXx3FUj88j2+aPFQHXTwKg16WUysDf4f5ilzZO0KQJCfAgUpDeRlcNCYxLZg
	kkcJ/2zyIos1Pw0LlWxFKCeuyvPng3AC+5as8TryyWXa4cp7F4HW9Rm0Hl5XIF9E
	LfI7iWiyFesi/rT9oPnfBflQprwm/6j6QM2GI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 783B64269
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36B954266 for
 <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc1.118.ge175b4a
In-Reply-To: <1307736948-16956-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C5CDC542-939E-11E0-8091-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175624>

The size of objects we read from the repository and data we try to put
into the repository are represented in "unsigned long", so that on larger
architectures we can handle objects that weigh more than 4GB.

But the interface defined in zlib.h to communicate with inflate/deflate
limits avail_in (how many bytes of input are we calling zlib with) and
avail_out (how many bytes of output from zlib are we ready to accept)
fields effectively to 4GB by defining their type to be uInt.

In many places in our code, we allocate a large buffer (e.g. mmap'ing a
large loose object file) and tell zlib its size by assigning the size to
avail_in field of the stream, but that will truncate the high octets of
the real size. The worst part of this story is that we often pass around
z_stream (the state object used by zlib) to keep track of the number of
used bytes in input/output buffer by inspecting these two fields, which
practically limits our callchain to the same 4GB limit.

Wrap z_stream in another structure git_zstream that can express avail_in
and avail_out in unsigned long. For now, just die() when the caller gives
a size that cannot be given to a single zlib call. In later patches in the
series, we would make git_inflate() and git_deflate() internally loop to
give callers an illusion that our "improved" version of zlib interface can
operate on a buffer larger than 4GB in one go.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive-zip.c            |    2 +-
 builtin/apply.c          |    2 +-
 builtin/index-pack.c     |    6 +-
 builtin/pack-objects.c   |   10 ++--
 builtin/unpack-objects.c |    2 +-
 cache.h                  |   35 +++++++++-----
 diff.c                   |    2 +-
 fast-import.c            |    4 +-
 http-backend.c           |    2 +-
 http-push.c              |    2 +-
 http.h                   |    2 +-
 pack-check.c             |    4 +-
 remote-curl.c            |    2 +-
 sha1_file.c              |   18 ++++----
 zlib.c                   |  119 +++++++++++++++++++++++++++++++++++-----------
 15 files changed, 142 insertions(+), 70 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 8fbac27..72d55a5 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -90,7 +90,7 @@ static void copy_le32(unsigned char *dest, unsigned int n)
 static void *zlib_deflate(void *data, unsigned long size,
 		int compression_level, unsigned long *compressed_size)
 {
-	z_stream stream;
+	git_zstream stream;
 	unsigned long maxsize;
 	void *buffer;
 	int result;
diff --git a/builtin/apply.c b/builtin/apply.c
index 530d4bb..f2edc52 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1634,7 +1634,7 @@ static inline int metadata_changes(struct patch *patch)
 static char *inflate_it(const void *data, unsigned long size,
 			unsigned long inflated_size)
 {
-	z_stream stream;
+	git_zstream stream;
 	void *out;
 	int st;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dbfb5da..f65cb37 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -265,7 +265,7 @@ static void unlink_base_data(struct base_data *c)
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
 {
 	int status;
-	z_stream stream;
+	git_zstream stream;
 	void *buf = xmalloc(size);
 
 	memset(&stream, 0, sizeof(stream));
@@ -355,7 +355,7 @@ static void *get_data_from_pack(struct object_entry *obj)
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
 	unsigned long len = obj[1].idx.offset - from;
 	unsigned char *data, *inbuf;
-	z_stream stream;
+	git_zstream stream;
 	int status;
 
 	data = xmalloc(obj->size);
@@ -666,7 +666,7 @@ static void parse_pack_objects(unsigned char *sha1)
 
 static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 {
-	z_stream stream;
+	git_zstream stream;
 	int status;
 	unsigned char outbuf[4096];
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8981dd6..c6e2d87 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -126,7 +126,7 @@ static void *get_delta(struct object_entry *entry)
 
 static unsigned long do_compress(void **pptr, unsigned long size)
 {
-	z_stream stream;
+	git_zstream stream;
 	void *in, *out;
 	unsigned long maxsize;
 
@@ -160,7 +160,7 @@ static int check_pack_inflate(struct packed_git *p,
 		off_t len,
 		unsigned long expect)
 {
-	z_stream stream;
+	git_zstream stream;
 	unsigned char fakebuf[4096], *in;
 	int st;
 
@@ -187,12 +187,12 @@ static void copy_pack_data(struct sha1file *f,
 		off_t len)
 {
 	unsigned char *in;
-	unsigned int avail;
+	unsigned long avail;
 
 	while (len) {
 		in = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
-			avail = (unsigned int)len;
+			avail = (unsigned long)len;
 		sha1write(f, in, avail);
 		offset += avail;
 		len -= avail;
@@ -994,7 +994,7 @@ static void check_object(struct object_entry *entry)
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
 		unsigned long used, used_0;
-		unsigned int avail;
+		unsigned long avail;
 		off_t ofs;
 		unsigned char *buf, c;
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f63973c..14e04e6 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -90,7 +90,7 @@ static void use(int bytes)
 
 static void *get_data(unsigned long size)
 {
-	z_stream stream;
+	git_zstream stream;
 	void *buf = xmalloc(size);
 
 	memset(&stream, 0, sizeof(stream));
diff --git a/cache.h b/cache.h
index 85ac5ec..1784bab 100644
--- a/cache.h
+++ b/cache.h
@@ -16,18 +16,27 @@
 #endif
 
 #include <zlib.h>
-
-void git_inflate_init(z_streamp strm);
-void git_inflate_init_gzip_only(z_streamp strm);
-void git_inflate_end(z_streamp strm);
-int git_inflate(z_streamp strm, int flush);
-
-void git_deflate_init(z_streamp strm, int level);
-void git_deflate_init_gzip(z_streamp strm, int level);
-void git_deflate_end(z_streamp strm);
-int git_deflate_end_gently(z_streamp strm);
-int git_deflate(z_streamp strm, int flush);
-unsigned long git_deflate_bound(z_streamp, unsigned long);
+typedef struct git_zstream {
+	z_stream z;
+	unsigned long avail_in;
+	unsigned long avail_out;
+	unsigned long total_in;
+	unsigned long total_out;
+	unsigned char *next_in;
+	unsigned char *next_out;
+} git_zstream;
+
+void git_inflate_init(git_zstream *);
+void git_inflate_init_gzip_only(git_zstream *);
+void git_inflate_end(git_zstream *);
+int git_inflate(git_zstream *, int flush);
+
+void git_deflate_init(git_zstream *, int level);
+void git_deflate_init_gzip(git_zstream *, int level);
+void git_deflate_end(git_zstream *);
+int git_deflate_end_gently(git_zstream *);
+int git_deflate(git_zstream *, int flush);
+unsigned long git_deflate_bound(git_zstream *, unsigned long);
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
@@ -991,7 +1000,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
 extern void close_pack_index(struct packed_git *);
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
+extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
diff --git a/diff.c b/diff.c
index bac9a4b..431873d 100644
--- a/diff.c
+++ b/diff.c
@@ -1729,7 +1729,7 @@ static unsigned char *deflate_it(char *data,
 {
 	int bound;
 	unsigned char *deflated;
-	z_stream stream;
+	git_zstream stream;
 
 	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/fast-import.c b/fast-import.c
index e4116a4..1d5e333 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1017,7 +1017,7 @@ static int store_object(
 	unsigned char sha1[20];
 	unsigned long hdrlen, deltalen;
 	git_SHA_CTX c;
-	z_stream s;
+	git_zstream s;
 
 	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
@@ -1163,7 +1163,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	off_t offset;
 	git_SHA_CTX c;
 	git_SHA_CTX pack_file_ctx;
-	z_stream s;
+	git_zstream s;
 	int status = Z_OK;
 
 	/* Determine if we should auto-checkpoint. */
diff --git a/http-backend.c b/http-backend.c
index ab5015d..59ad7da 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -271,7 +271,7 @@ static struct rpc_service *select_service(const char *name)
 
 static void inflate_request(const char *prog_name, int out)
 {
-	z_stream stream;
+	git_zstream stream;
 	unsigned char in_buf[8192];
 	unsigned char out_buf[8192];
 	unsigned long cnt = 0;
diff --git a/http-push.c b/http-push.c
index ecd67cf..1e8a830 100644
--- a/http-push.c
+++ b/http-push.c
@@ -352,7 +352,7 @@ static void start_put(struct transfer_request *request)
 	unsigned long len;
 	int hdrlen;
 	ssize_t size;
-	z_stream stream;
+	git_zstream stream;
 
 	unpacked = read_sha1_file(request->obj->sha1, &type, &len);
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
diff --git a/http.h b/http.h
index e9ed3c2..a39304a 100644
--- a/http.h
+++ b/http.h
@@ -172,7 +172,7 @@ struct http_object_request {
 	unsigned char sha1[20];
 	unsigned char real_sha1[20];
 	git_SHA_CTX c;
-	z_stream stream;
+	git_zstream stream;
 	int zret;
 	int rename;
 	struct active_request_slot *slot;
diff --git a/pack-check.c b/pack-check.c
index a1a5216..0c19b6e 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -26,7 +26,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	uint32_t data_crc = crc32(0, NULL, 0);
 
 	do {
-		unsigned int avail;
+		unsigned long avail;
 		void *data = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = len;
@@ -61,7 +61,7 @@ static int verify_packfile(struct packed_git *p,
 
 	git_SHA1_Init(&ctx);
 	do {
-		unsigned int remaining;
+		unsigned long remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
diff --git a/remote-curl.c b/remote-curl.c
index 13d8cee..bc48a36 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -471,7 +471,7 @@ static int post_rpc(struct rpc_state *rpc)
 		 * the transfer time.
 		 */
 		size_t size;
-		z_stream stream;
+		git_zstream stream;
 		int ret;
 
 		memset(&stream, 0, sizeof(stream));
diff --git a/sha1_file.c b/sha1_file.c
index 0eefb61..94d4319 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -833,7 +833,7 @@ static int in_window(struct pack_window *win, off_t offset)
 unsigned char *use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		off_t offset,
-		unsigned int *left)
+		unsigned long *left)
 {
 	struct pack_window *win = *w_cursor;
 
@@ -1244,7 +1244,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
+static int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
 {
 	unsigned long size, used;
 	static const char valid_loose_object_type[8] = {
@@ -1291,7 +1291,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	return 0;
 }
 
-static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
+static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmallocz(size);
@@ -1390,7 +1390,7 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
 static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
 {
 	int ret;
-	z_stream stream;
+	git_zstream stream;
 	char hdr[8192];
 
 	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
@@ -1406,7 +1406,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
-	z_stream stream;
+	git_zstream stream;
 	int st;
 
 	memset(&stream, 0, sizeof(stream));
@@ -1528,7 +1528,7 @@ static int unpack_object_header(struct packed_git *p,
 				unsigned long *sizep)
 {
 	unsigned char *base;
-	unsigned int left;
+	unsigned long left;
 	unsigned long used;
 	enum object_type type;
 
@@ -1641,7 +1641,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 				    unsigned long size)
 {
 	int st;
-	z_stream stream;
+	git_zstream stream;
 	unsigned char *buffer, *in;
 
 	buffer = xmallocz(size);
@@ -2074,7 +2074,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	int status;
 	unsigned long mapsize, size;
 	void *map;
-	z_stream stream;
+	git_zstream stream;
 	char hdr[32];
 
 	map = map_sha1_file(sha1, &mapsize);
@@ -2425,7 +2425,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 {
 	int fd, ret;
 	unsigned char compressed[4096];
-	z_stream stream;
+	git_zstream stream;
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
 	char *filename;
diff --git a/zlib.c b/zlib.c
index 8f19d2f..fe537e3 100644
--- a/zlib.c
+++ b/zlib.c
@@ -22,45 +22,90 @@ static const char *zerr_to_string(int status)
 	}
 }
 
-void git_inflate_init(z_streamp strm)
+/*
+ * avail_in and avail_out in zlib are counted in uInt, which typically
+ * limits the size of the buffer we can use to 4GB when interacting
+ * with zlib in a single call to inflate/deflate.
+ */
+#define ZLIB_BUF_MAX ((uInt)-1)
+static inline uInt zlib_buf_cap(unsigned long len)
+{
+	if (ZLIB_BUF_MAX < len)
+		die("working buffer for zlib too large");
+	return len;
+}
+
+static void zlib_pre_call(git_zstream *s)
+{
+	s->z.next_in = s->next_in;
+	s->z.next_out = s->next_out;
+	s->z.total_in = s->total_in;
+	s->z.total_out = s->total_out;
+	s->z.avail_in = zlib_buf_cap(s->avail_in);
+	s->z.avail_out = zlib_buf_cap(s->avail_out);
+}
+
+static void zlib_post_call(git_zstream *s)
+{
+	s->next_in = s->z.next_in;
+	s->next_out = s->z.next_out;
+	s->total_in = s->z.total_in;
+	s->total_out = s->z.total_out;
+	s->avail_in = s->z.avail_in;
+	s->avail_out = s->z.avail_out;
+}
+
+void git_inflate_init(git_zstream *strm)
 {
-	int status = inflateInit(strm);
+	int status;
 
+	zlib_pre_call(strm);
+	status = inflateInit(&strm->z);
+	zlib_post_call(strm);
 	if (status == Z_OK)
 		return;
 	die("inflateInit: %s (%s)", zerr_to_string(status),
-	    strm->msg ? strm->msg : "no message");
+	    strm->z.msg ? strm->z.msg : "no message");
 }
 
-void git_inflate_init_gzip_only(z_streamp strm)
+void git_inflate_init_gzip_only(git_zstream *strm)
 {
 	/*
 	 * Use default 15 bits, +16 is to accept only gzip and to
 	 * yield Z_DATA_ERROR when fed zlib format.
 	 */
 	const int windowBits = 15 + 16;
-	int status = inflateInit2(strm, windowBits);
+	int status;
 
+	zlib_pre_call(strm);
+	status = inflateInit2(&strm->z, windowBits);
+	zlib_post_call(strm);
 	if (status == Z_OK)
 		return;
 	die("inflateInit2: %s (%s)", zerr_to_string(status),
-	    strm->msg ? strm->msg : "no message");
+	    strm->z.msg ? strm->z.msg : "no message");
 }
 
-void git_inflate_end(z_streamp strm)
+void git_inflate_end(git_zstream *strm)
 {
-	int status = inflateEnd(strm);
+	int status;
 
+	zlib_pre_call(strm);
+	status = inflateEnd(&strm->z);
+	zlib_post_call(strm);
 	if (status == Z_OK)
 		return;
 	error("inflateEnd: %s (%s)", zerr_to_string(status),
-	      strm->msg ? strm->msg : "no message");
+	      strm->z.msg ? strm->z.msg : "no message");
 }
 
-int git_inflate(z_streamp strm, int flush)
+int git_inflate(git_zstream *strm, int flush)
 {
-	int status = inflate(strm, flush);
+	int status;
 
+	zlib_pre_call(strm);
+	status = inflate(&strm->z, flush);
+	zlib_post_call(strm);
 	switch (status) {
 	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
 	case Z_BUF_ERROR:
@@ -74,7 +119,7 @@ int git_inflate(z_streamp strm, int flush)
 		break;
 	}
 	error("inflate: %s (%s)", zerr_to_string(status),
-	      strm->msg ? strm->msg : "no message");
+	      strm->z.msg ? strm->z.msg : "no message");
 	return status;
 }
 
@@ -82,56 +127,74 @@ int git_inflate(z_streamp strm, int flush)
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
-unsigned long git_deflate_bound(z_streamp strm, unsigned long size)
+unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
 {
-	return deflateBound(strm, size);
+	return deflateBound(&strm->z, size);
 }
 
-void git_deflate_init(z_streamp strm, int level)
+void git_deflate_init(git_zstream *strm, int level)
 {
-	int status = deflateInit(strm, level);
+	int status;
 
+	zlib_pre_call(strm);
+	status = deflateInit(&strm->z, level);
+	zlib_post_call(strm);
 	if (status == Z_OK)
 		return;
 	die("deflateInit: %s (%s)", zerr_to_string(status),
-	    strm->msg ? strm->msg : "no message");
+	    strm->z.msg ? strm->z.msg : "no message");
 }
 
-void git_deflate_init_gzip(z_streamp strm, int level)
+void git_deflate_init_gzip(git_zstream *strm, int level)
 {
 	/*
 	 * Use default 15 bits, +16 is to generate gzip header/trailer
 	 * instead of the zlib wrapper.
 	 */
 	const int windowBits = 15 + 16;
-	int status = deflateInit2(strm, level,
+	int status;
+
+	zlib_pre_call(strm);
+	status = deflateInit2(&strm->z, level,
 				  Z_DEFLATED, windowBits,
 				  8, Z_DEFAULT_STRATEGY);
+	zlib_post_call(strm);
 	if (status == Z_OK)
 		return;
 	die("deflateInit2: %s (%s)", zerr_to_string(status),
-	    strm->msg ? strm->msg : "no message");
+	    strm->z.msg ? strm->z.msg : "no message");
 }
 
-void git_deflate_end(z_streamp strm)
+void git_deflate_end(git_zstream *strm)
 {
-	int status = deflateEnd(strm);
+	int status;
 
+	zlib_pre_call(strm);
+	status = deflateEnd(&strm->z);
+	zlib_post_call(strm);
 	if (status == Z_OK)
 		return;
 	error("deflateEnd: %s (%s)", zerr_to_string(status),
-	      strm->msg ? strm->msg : "no message");
+	      strm->z.msg ? strm->z.msg : "no message");
 }
 
-int git_deflate_end_gently(z_streamp strm)
+int git_deflate_end_gently(git_zstream *strm)
 {
-	return deflateEnd(strm);
+	int status;
+
+	zlib_pre_call(strm);
+	status = deflateEnd(&strm->z);
+	zlib_post_call(strm);
+	return status;
 }
 
-int git_deflate(z_streamp strm, int flush)
+int git_deflate(git_zstream *strm, int flush)
 {
-	int status = deflate(strm, flush);
+	int status;
 
+	zlib_pre_call(strm);
+	status = deflate(&strm->z, flush);
+	zlib_post_call(strm);
 	switch (status) {
 	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
 	case Z_BUF_ERROR:
@@ -145,6 +208,6 @@ int git_deflate(z_streamp strm, int flush)
 		break;
 	}
 	error("deflate: %s (%s)", zerr_to_string(status),
-	      strm->msg ? strm->msg : "no message");
+	      strm->z.msg ? strm->z.msg : "no message");
 	return status;
 }
-- 
1.7.6.rc1.118.ge175b4a
