From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] zlib: initialize git_zstream in git_deflate_init{,_gzip,_raw}
Date: Thu, 05 Mar 2015 23:49:46 +0100
Message-ID: <54F8DD8A.8020202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:50:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTeao-0006MF-EB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 23:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbbCEWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 17:50:05 -0500
Received: from mout.web.de ([212.227.17.11]:52189 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbbCEWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 17:50:04 -0500
Received: from [192.168.178.27] ([79.250.191.206]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZUWH-1YB9CX0UaT-00LDoS; Thu, 05 Mar 2015 23:50:00
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Provags-ID: V03:K0:92LwdmY6MmQS7RymH/u7AqzRGZvts4YgDUZ5DGISKkgkQ3c4p0X
 PI9O9laqLPj2Q+1GD2WhRn17yPxyGzGNCClk8Xwt/ASysFo1sgAqFUlJ+sXM44n0kgBWxKZ
 huV5RhkM7mvZjTr4homQrmRk1DM7GczcJSrWWjTWKKqiqLkWpLEnke7r1GSO+juBOVfzb5z
 cbWJZwZbGSKvLnQf5JPHQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264877>

Clear the git_zstream variable at the start of git_deflate_init() etc.
so that callers don't have to do that.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c          | 2 --
 builtin/index-pack.c   | 1 -
 builtin/pack-objects.c | 2 --
 bulk-checkin.c         | 1 -
 diff.c                 | 1 -
 fast-import.c          | 3 ---
 http-push.c            | 1 -
 remote-curl.c          | 1 -
 sha1_file.c            | 1 -
 zlib.c                 | 2 ++
 10 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 4bde019..1a54e1b 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -120,7 +120,6 @@ static void *zlib_deflate_raw(void *data, unsigned long size,
 	void *buffer;
 	int result;
 
-	memset(&stream, 0, sizeof(stream));
 	git_deflate_init_raw(&stream, compression_level);
 	maxsize = git_deflate_bound(&stream, size);
 	buffer = xmalloc(maxsize);
@@ -349,7 +348,6 @@ static int write_zip_entry(struct archiver_args *args,
 		size_t out_len;
 		unsigned char compressed[STREAM_BUFFER_SIZE * 2];
 
-		memset(&zstream, 0, sizeof(zstream));
 		git_deflate_init_raw(&zstream, args->compression_level);
 
 		compressed_size = 0;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4632117..cf654df 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1204,7 +1204,6 @@ static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 	int status;
 	unsigned char outbuf[4096];
 
-	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, zlib_compression_level);
 	stream.next_in = in;
 	stream.avail_in = size;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d816587..c3a7516 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -125,7 +125,6 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	void *in, *out;
 	unsigned long maxsize;
 
-	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, pack_compression_level);
 	maxsize = git_deflate_bound(&stream, size);
 
@@ -153,7 +152,6 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct sha1fi
 	unsigned char obuf[1024 * 16];
 	unsigned long olen = 0;
 
-	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, pack_compression_level);
 
 	for (;;) {
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 0c4b8a7..8d157eb 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -105,7 +105,6 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 	int write_object = (flags & HASH_WRITE_OBJECT);
 	off_t offset = 0;
 
-	memset(&s, 0, sizeof(s));
 	git_deflate_init(&s, pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(type, size, obuf);
diff --git a/diff.c b/diff.c
index d1bd534..dad875c 100644
--- a/diff.c
+++ b/diff.c
@@ -2093,7 +2093,6 @@ static unsigned char *deflate_it(char *data,
 	unsigned char *deflated;
 	git_zstream stream;
 
-	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, zlib_compression_level);
 	bound = git_deflate_bound(&stream, size);
 	deflated = xmalloc(bound);
diff --git a/fast-import.c b/fast-import.c
index aac2c24..77fb2ff 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1062,7 +1062,6 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	memset(&s, 0, sizeof(s));
 	git_deflate_init(&s, pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
@@ -1090,7 +1089,6 @@ static int store_object(
 			free(delta);
 			delta = NULL;
 
-			memset(&s, 0, sizeof(s));
 			git_deflate_init(&s, pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
@@ -1190,7 +1188,6 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 
 	crc32_begin(pack_file);
 
-	memset(&s, 0, sizeof(s));
 	git_deflate_init(&s, pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(OBJ_BLOB, len, out_buf);
diff --git a/http-push.c b/http-push.c
index 0beb7ab..bfb1c96 100644
--- a/http-push.c
+++ b/http-push.c
@@ -365,7 +365,6 @@ static void start_put(struct transfer_request *request)
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, zlib_compression_level);
 	size = git_deflate_bound(&stream, len + hdrlen);
 	strbuf_init(&request->buffer.buf, size);
diff --git a/remote-curl.c b/remote-curl.c
index deb4bfe..af7b678 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -567,7 +567,6 @@ retry:
 		git_zstream stream;
 		int ret;
 
-		memset(&stream, 0, sizeof(stream));
 		git_deflate_init_gzip(&stream, Z_BEST_COMPRESSION);
 		gzip_size = git_deflate_bound(&stream, rpc->len);
 		gzip_body = xmalloc(gzip_size);
diff --git a/sha1_file.c b/sha1_file.c
index 69a60ec..88f06ba 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2943,7 +2943,6 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	}
 
 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, zlib_compression_level);
 	stream.next_out = compressed;
 	stream.avail_out = sizeof(compressed);
diff --git a/zlib.c b/zlib.c
index 61e6df0..4223f1a 100644
--- a/zlib.c
+++ b/zlib.c
@@ -159,6 +159,7 @@ void git_deflate_init(git_zstream *strm, int level)
 {
 	int status;
 
+	memset(strm, 0, sizeof(*strm));
 	zlib_pre_call(strm);
 	status = deflateInit(&strm->z, level);
 	zlib_post_call(strm);
@@ -172,6 +173,7 @@ static void do_git_deflate_init(git_zstream *strm, int level, int windowBits)
 {
 	int status;
 
+	memset(strm, 0, sizeof(*strm));
 	zlib_pre_call(strm);
 	status = deflateInit2(&strm->z, level,
 				  Z_DEFLATED, windowBits,
-- 
2.3.1
