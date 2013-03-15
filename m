From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive-zip: use deflateInit2() to ask for raw compressed
 data
Date: Fri, 15 Mar 2013 23:21:51 +0100
Message-ID: <51439EFF.3000607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 15 23:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGd17-0000LK-Ow
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 23:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab3COWV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 18:21:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:42618 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab3COWV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 18:21:57 -0400
Received: from [192.168.2.105] (p4FFD93E4.dip.t-dialin.net [79.253.147.228])
	by india601.server4you.de (Postfix) with ESMTPSA id BAC6E323;
	Fri, 15 Mar 2013 23:21:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218266>

We use the function git_deflate_init() -- which wraps the zlib function
deflateInit() -- to initialize compression of ZIP file entries.  This
results in compressed data prefixed with a two-bytes long header and
followed by a four-bytes trailer.  ZIP file entries consist of ZIP
headers and raw compressed data instead, so we remove the zlib wrapper
before writing the result.

We can ask zlib for the the raw compressed data without the unwanted
parts in the first place by using deflateInit2() and specifying a
negative number of bits to size the window.  For that purpose, factor
out the function do_git_deflate_init() and add git_deflate_init_raw(),
which wraps it.  Then use the latter in archive-zip.c and get rid of
the code that stripped the zlib header and trailer.

Also rename the helper function zlib_deflate() to zlib_deflate_raw()
to reflect the change.

Thus we avoid generating data that we throw away anyway, the code
becomes shorter and some magic constants are removed.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c | 36 ++++++++++++++----------------------
 cache.h       |  1 +
 zlib.c        | 25 +++++++++++++++++++------
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index d3aef53..e744d77 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -111,8 +111,9 @@ static void copy_le32(unsigned char *dest, unsigned int n)
 	dest[3] = 0xff & (n >> 030);
 }
 
-static void *zlib_deflate(void *data, unsigned long size,
-		int compression_level, unsigned long *compressed_size)
+static void *zlib_deflate_raw(void *data, unsigned long size,
+			      int compression_level,
+			      unsigned long *compressed_size)
 {
 	git_zstream stream;
 	unsigned long maxsize;
@@ -120,7 +121,7 @@ static void *zlib_deflate(void *data, unsigned long size,
 	int result;
 
 	memset(&stream, 0, sizeof(stream));
-	git_deflate_init(&stream, compression_level);
+	git_deflate_init_raw(&stream, compression_level);
 	maxsize = git_deflate_bound(&stream, size);
 	buffer = xmalloc(maxsize);
 
@@ -265,14 +266,11 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (buffer && method == 8) {
-		deflated = zlib_deflate(buffer, size, args->compression_level,
-				&compressed_size);
-		if (deflated && compressed_size - 6 < size) {
-			/* ZLIB --> raw compressed data (see RFC 1950) */
-			/* CMF and FLG ... */
-			out = (unsigned char *)deflated + 2;
-			compressed_size -= 6;	/* ... and ADLER32 */
-		} else {
+		out = deflated = zlib_deflate_raw(buffer, size,
+						  args->compression_level,
+						  &compressed_size);
+		if (!out || compressed_size >= size) {
+			out = buffer;
 			method = 0;
 			compressed_size = size;
 		}
@@ -353,7 +351,7 @@ static int write_zip_entry(struct archiver_args *args,
 		unsigned char compressed[STREAM_BUFFER_SIZE * 2];
 
 		memset(&zstream, 0, sizeof(zstream));
-		git_deflate_init(&zstream, args->compression_level);
+		git_deflate_init_raw(&zstream, args->compression_level);
 
 		compressed_size = 0;
 		zstream.next_out = compressed;
@@ -370,13 +368,10 @@ static int write_zip_entry(struct archiver_args *args,
 			result = git_deflate(&zstream, 0);
 			if (result != Z_OK)
 				die("deflate error (%d)", result);
-			out = compressed;
-			if (!compressed_size)
-				out += 2;
-			out_len = zstream.next_out - out;
+			out_len = zstream.next_out - compressed;
 
 			if (out_len > 0) {
-				write_or_die(1, out, out_len);
+				write_or_die(1, compressed, out_len);
 				compressed_size += out_len;
 				zstream.next_out = compressed;
 				zstream.avail_out = sizeof(compressed);
@@ -394,11 +389,8 @@ static int write_zip_entry(struct archiver_args *args,
 			die("deflate error (%d)", result);
 
 		git_deflate_end(&zstream);
-		out = compressed;
-		if (!compressed_size)
-			out += 2;
-		out_len = zstream.next_out - out - 4;
-		write_or_die(1, out, out_len);
+		out_len = zstream.next_out - compressed;
+		write_or_die(1, compressed, out_len);
 		compressed_size += out_len;
 		zip_offset += compressed_size;
 
diff --git a/cache.h b/cache.h
index e493563..81a39a2 100644
--- a/cache.h
+++ b/cache.h
@@ -34,6 +34,7 @@ int git_inflate(git_zstream *, int flush);
 
 void git_deflate_init(git_zstream *, int level);
 void git_deflate_init_gzip(git_zstream *, int level);
+void git_deflate_init_raw(git_zstream *, int level);
 void git_deflate_end(git_zstream *);
 int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
diff --git a/zlib.c b/zlib.c
index 2b2c0c7..bbaa081 100644
--- a/zlib.c
+++ b/zlib.c
@@ -168,13 +168,8 @@ void git_deflate_init(git_zstream *strm, int level)
 	    strm->z.msg ? strm->z.msg : "no message");
 }
 
-void git_deflate_init_gzip(git_zstream *strm, int level)
+static void do_git_deflate_init(git_zstream *strm, int level, int windowBits)
 {
-	/*
-	 * Use default 15 bits, +16 is to generate gzip header/trailer
-	 * instead of the zlib wrapper.
-	 */
-	const int windowBits = 15 + 16;
 	int status;
 
 	zlib_pre_call(strm);
@@ -188,6 +183,24 @@ void git_deflate_init_gzip(git_zstream *strm, int level)
 	    strm->z.msg ? strm->z.msg : "no message");
 }
 
+void git_deflate_init_gzip(git_zstream *strm, int level)
+{
+	/*
+	 * Use default 15 bits, +16 is to generate gzip header/trailer
+	 * instead of the zlib wrapper.
+	 */
+	return do_git_deflate_init(strm, level, 15 + 16);
+}
+
+void git_deflate_init_raw(git_zstream *strm, int level)
+{
+	/*
+	 * Use default 15 bits, negate the value to get raw compressed
+	 * data without zlib header and trailer.
+	 */
+	return do_git_deflate_init(strm, level, -15);
+}
+
 int git_deflate_abort(git_zstream *strm)
 {
 	int status;
-- 
1.8.2
