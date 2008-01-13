From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 2/3] Rename z_stream to ext_stream across the sources
Date: Sun, 13 Jan 2008 14:24:37 +0100
Message-ID: <1200230678-18188-2-git-send-email-mcostalba@gmail.com>
References: <1200230678-18188-1-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 14:25:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE2qU-0001OI-NT
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 14:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbYAMNZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 08:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYAMNZV
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 08:25:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:1748 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYAMNZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 08:25:18 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1860514fga.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 05:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rWU4/a6MlJATJFT0VLkvCQBUGFTpZ9enHVdXS4UtoG8=;
        b=NH5xG0i5XVipeRc7mM/myjE9Tb22EHPjbrP70Rphhqh2wMDo1keFVTYvKqwLsSRnlKKEUnHCPBaaB76WG1Jw5KNtz24vM8i8LPxpx07X3K/d6w5FwlfeNRPGsmXw0OTfwtYKb81jcWB4CQIrbni7JHm7djeQe+O4OoVKlvhq2PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CrGZpHnfiXQmlv7oVX79jNLgfgMlfgK4sW869h7IGuj8I1jXZk5+krv3vCZyO/JPLBrHZAf6fe+S27irwICs2DONqwAjhfllglhOGqP/0zUo0zyTDJsGN1qq7ApEgpHasWovt7iW1Bms+XsNhu9J1Ml+shgYkKGoCunB5KbNPQY=
Received: by 10.86.59.2 with SMTP id h2mr5099676fga.78.1200230717129;
        Sun, 13 Jan 2008 05:25:17 -0800 (PST)
Received: from localhost.localdomain ( [151.70.79.87])
        by mx.google.com with ESMTPS id g11sm3987662gve.15.2008.01.13.05.25.14
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 05:25:16 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.98.g58cd2
In-Reply-To: <1200230678-18188-1-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70380>

Also fix the places where z_stream member access
is open coded.

In the future we could hide direct z_stream handling
behind some helpers, but for now leave it like it is
now to better understand what is going on.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-pack-objects.c   |    8 +++---
 builtin-unpack-objects.c |    6 ++--
 http-push.c              |   12 +++++-----
 http-walker.c            |    6 ++--
 index-pack.c             |    6 ++--
 sha1_file.c              |   56 +++++++++++++++++++++++-----------------------
 6 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d2865fe..5165a23 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -300,7 +300,7 @@ static int check_pack_inflate(struct packed_git *p,
 		off_t len,
 		unsigned long expect)
 {
-	z_stream stream;
+	ext_stream stream;
 	unsigned char fakebuf[4096], *in;
 	unsigned int in_size = 0;
 	int st;
@@ -310,12 +310,12 @@ static int check_pack_inflate(struct packed_git *p,
 		decompress_into(&stream, fakebuf, sizeof(fakebuf));
 		in = use_pack(p, w_curs, offset, &in_size);
 		st = decompress_next_from(&stream, in, in_size, Z_FINISH);
-		offset += stream.next_in - in;
+		offset += stream.z.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	decompress_free(&stream);
 	return (st == Z_STREAM_END &&
-		stream.total_out == expect &&
-		stream.total_in == len) ? 0 : -1;
+		stream.z.total_out == expect &&
+		stream.z.total_in == len) ? 0 : -1;
 }
 
 static int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index c996560..066bf06 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -61,7 +61,7 @@ static void use(int bytes)
 
 static void *get_data(unsigned long size)
 {
-	z_stream stream;
+	ext_stream stream;
 	unsigned char *buf = xmalloc(size);;
 
 	decompress_alloc(&stream);
@@ -71,8 +71,8 @@ static void *get_data(unsigned long size)
 		/* fill() modifies len, so be sure is evaluated as first */
 		void* tmp = fill(1);
 		int ret = decompress_next_from(&stream, tmp, len, Z_NO_FLUSH);
-		use(len - stream.avail_in);
-		if (stream.total_out == size && ret == Z_STREAM_END)
+		use(len - stream.z.avail_in);
+		if (stream.z.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK) {
 			error("decompress returned %d\n", ret);
diff --git a/http-push.c b/http-push.c
index ec0568c..c7ea871 100644
--- a/http-push.c
+++ b/http-push.c
@@ -127,7 +127,7 @@ struct transfer_request
 	long http_code;
 	unsigned char real_sha1[20];
 	SHA_CTX c;
-	z_stream stream;
+	ext_stream stream;
 	int zret;
 	int rename;
 	void *userData;
@@ -209,8 +209,8 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		request->zret = decompress_next_into(&request->stream, expn,
 		                                     sizeof(expn), Z_SYNC_FLUSH);
 		SHA1_Update(&request->c, expn,
-			    sizeof(expn) - request->stream.avail_out);
-	} while (request->stream.avail_in && request->zret == Z_OK);
+			    sizeof(expn) - request->stream.z.avail_out);
+	} while (request->stream.z.avail_in && request->zret == Z_OK);
 	data_received++;
 	return size;
 }
@@ -483,7 +483,7 @@ static void start_put(struct transfer_request *request)
 	unsigned long len;
 	int hdrlen;
 	ssize_t size;
-	z_stream stream;
+	ext_stream stream;
 
 	unpacked = read_sha1_file(request->obj->sha1, &type, &len);
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
@@ -501,8 +501,8 @@ static void start_put(struct transfer_request *request)
 	compress_next(&stream, Z_NO_FLUSH);
 
 	/* Then the data itself.. */
-	stream.next_in = unpacked;
-	stream.avail_in = len;
+	stream.z.next_in = unpacked;
+	stream.z.avail_in = len;
 	compress_next(&stream, Z_FINISH);
 
 	request->buffer.buf.len = compress_free(&stream);
diff --git a/http-walker.c b/http-walker.c
index b1d2a28..1581746 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -38,7 +38,7 @@ struct object_request
 	long http_code;
 	unsigned char real_sha1[20];
 	SHA_CTX c;
-	z_stream stream;
+	ext_stream stream;
 	int zret;
 	int rename;
 	struct active_request_slot *slot;
@@ -83,8 +83,8 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		obj_req->zret = decompress_next_into(&obj_req->stream, expn,
                                              sizeof(expn), Z_SYNC_FLUSH);
 		SHA1_Update(&obj_req->c, expn,
-			    sizeof(expn) - obj_req->stream.avail_out);
-	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
+			    sizeof(expn) - obj_req->stream.z.avail_out);
+	} while (obj_req->stream.z.avail_in && obj_req->zret == Z_OK);
 	data_received++;
 	return size;
 }
diff --git a/index-pack.c b/index-pack.c
index 929de39..7881a0b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -166,7 +166,7 @@ static void bad_object(unsigned long offset, const char *format, ...)
 
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
 {
-	z_stream stream;
+	ext_stream stream;
 	void *buf = xmalloc(size);
 
 	decompress_alloc(&stream);
@@ -176,8 +176,8 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 		/* fill() modifies len, so be sure is evaluated as first */
 		void* tmp = fill(1);
 		int ret = decompress_next_from(&stream, tmp, input_len, Z_NO_FLUSH);
-		use(input_len - stream.avail_in);
-		if (stream.total_out == size && ret == Z_STREAM_END)
+		use(input_len - stream.z.avail_in);
+		if (stream.z.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK)
 			bad_object(offset, "decompress returned %d", ret);
diff --git a/sha1_file.c b/sha1_file.c
index 708727a..a978f13 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1052,7 +1052,7 @@ unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned lon
 	return used;
 }
 
-static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
+static int unpack_sha1_header(ext_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
 {
 	unsigned long size, used;
 	static const char valid_loose_object_type[8] = {
@@ -1087,19 +1087,19 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	decompress_from(stream, map, mapsize);
 
 	/* And generate the fake traditional header */
-	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
+	stream->z.total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
 					 typename(type), size);
 	return 0;
 }
 
-static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
+static void *unpack_sha1_rest(ext_stream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmalloc(1+size);
 	unsigned long n;
 	int status = Z_OK;
 
-	n = stream->total_out - bytes;
+	n = stream->z.total_out - bytes;
 	if (n > size)
 		n = size;
 	memcpy(buf, (char *) buffer + bytes, n);
@@ -1123,14 +1123,14 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 			status = decompress_next(stream, Z_FINISH);
 	}
 	buf[size] = 0;
-	if (status == Z_STREAM_END && !stream->avail_in) {
+	if (status == Z_STREAM_END && !stream->z.avail_in) {
 		decompress_free(stream);
 		return buf;
 	}
 
 	if (status < 0)
 		error("corrupt loose object '%s'", sha1_to_hex(sha1));
-	else if (stream->avail_in)
+	else if (stream->z.avail_in)
 		error("garbage at end of loose object '%s'",
 		      sha1_to_hex(sha1));
 	free(buf);
@@ -1191,7 +1191,7 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
 static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
 {
 	int ret;
-	z_stream stream;
+	ext_stream stream;
 	char hdr[8192];
 
 	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
@@ -1207,7 +1207,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
-	z_stream stream;
+	ext_stream stream;
 	int st;
 	unsigned int in_size = 0;
 
@@ -1217,11 +1217,11 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &in_size);
 		st = decompress_next_from(&stream, in, in_size, Z_FINISH);
-		curpos += stream.next_in - in;
+		curpos += stream.z.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
-		 stream.total_out < sizeof(delta_head));
+		 stream.z.total_out < sizeof(delta_head));
 	decompress_free(&stream);
-	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head))
+	if ((st != Z_STREAM_END) && stream.z.total_out != sizeof(delta_head))
 		die("delta data unpack-initial failed");
 
 	/* Examine the initial part of the delta to figure out
@@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 				    unsigned long size)
 {
 	int st;
-	z_stream stream;
+	ext_stream stream;
 	unsigned char *buffer, *in;
 	unsigned int in_size = 0;
 
@@ -1427,10 +1427,10 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &in_size);
 		st = decompress_next_from(&stream, in, in_size, Z_FINISH);
-		curpos += stream.next_in - in;
+		curpos += stream.z.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	decompress_free(&stream);
-	if ((st != Z_STREAM_END) || stream.total_out != size) {
+	if ((st != Z_STREAM_END) || stream.z.total_out != size) {
 		free(buffer);
 		return NULL;
 	}
@@ -1762,7 +1762,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	int status;
 	unsigned long mapsize, size;
 	void *map;
-	z_stream stream;
+	ext_stream stream;
 	char hdr[32];
 
 	map = map_sha1_file(sha1, &mapsize);
@@ -2033,7 +2033,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 {
 	int size, ret;
 	unsigned char *compressed;
-	z_stream stream;
+	ext_stream stream;
 	unsigned char sha1[20];
 	char *filename;
 	static char tmpfile[PATH_MAX];
@@ -2084,8 +2084,8 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	compress_next(&stream, Z_NO_FLUSH);
 
 	/* Then the data itself.. */
-	stream.next_in = buf;
-	stream.avail_in = len;
+	stream.z.next_in = buf;
+	stream.z.avail_in = len;
 	ret = compress_next(&stream, Z_FINISH);
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
@@ -2109,7 +2109,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 static void *repack_object(const unsigned char *sha1, unsigned long *objsize)
 {
 	size_t size;
-	z_stream stream;
+	ext_stream stream;
 	unsigned char *unpacked;
 	unsigned long len;
 	enum object_type type;
@@ -2135,8 +2135,8 @@ static void *repack_object(const unsigned char *sha1, unsigned long *objsize)
 	compress_next(&stream, Z_NO_FLUSH);
 
 	/* Then the data itself.. */
-	stream.next_in = unpacked;
-	stream.avail_in = len;
+	stream.z.next_in = unpacked;
+	stream.z.avail_in = len;
 	compress_next(&stream, Z_FINISH);
 
 	*objsize = compress_free(&stream);
@@ -2167,7 +2167,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 {
 	char tmpfile[PATH_MAX];
 	int local;
-	z_stream stream;
+	ext_stream stream;
 	unsigned char real_sha1[20];
 	unsigned char discard[4096];
 	int ret;
@@ -2193,13 +2193,13 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 			do {
 				ret = decompress_next_into(&stream, discard, sizeof(discard), Z_SYNC_FLUSH);
 				SHA1_Update(&c, discard, sizeof(discard) -
-					    stream.avail_out);
-			} while (stream.avail_in && ret == Z_OK);
-			if (write_buffer(local, buffer, *bufposn - stream.avail_in) < 0)
+					    stream.z.avail_out);
+			} while (stream.z.avail_in && ret == Z_OK);
+			if (write_buffer(local, buffer, *bufposn - stream.z.avail_in) < 0)
 				die("unable to write sha1 file");
-			memmove(buffer, buffer + *bufposn - stream.avail_in,
-				stream.avail_in);
-			*bufposn = stream.avail_in;
+			memmove(buffer, buffer + *bufposn - stream.z.avail_in,
+				stream.z.avail_in);
+			*bufposn = stream.z.avail_in;
 			if (ret != Z_OK)
 				break;
 		}
-- 
1.5.4.rc2.98.g58cd2
