From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] unpack_sha1_file(): detect corrupt loose object files.
Date: Mon, 05 Mar 2007 00:21:37 -0800
Message-ID: <7v1wk42j8u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 09:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8Ry-0007iy-As
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXCEIVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXCEIVi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:21:38 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60191 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbXCEIVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:21:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305082138.LSYZ26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 03:21:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WwMd1W0021kojtg0000000; Mon, 05 Mar 2007 03:21:37 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41413>

We did not detect broken loose object files, either when
underlying inflate() signalled the breakage, nor inflate()
finished and we had garbage trailing at the end.  We do better
now.

We also make unpack_sha1_file() a static function to
sha1_file.c, since it is not used by anybody outside.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 cache.h     |    1 -
 sha1_file.c |   27 +++++++++++++++++++--------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index c291163..4b5a754 100644
--- a/cache.h
+++ b/cache.h
@@ -281,7 +281,6 @@ char *enter_repo(char *path, int strict);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern void * unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
 extern int hash_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
diff --git a/sha1_file.c b/sha1_file.c
index 6d0a72e..ac6b5e0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -956,11 +956,12 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	return 0;
 }
 
-static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size)
+static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmalloc(1+size);
 	unsigned long n;
+	int status = Z_OK;
 
 	n = stream->total_out - bytes;
 	if (n > size)
@@ -970,12 +971,22 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 	if (bytes < size) {
 		stream->next_out = buf + bytes;
 		stream->avail_out = size - bytes;
-		while (inflate(stream, Z_FINISH) == Z_OK)
-			/* nothing */;
+		while (status == Z_OK)
+			status = inflate(stream, Z_FINISH);
 	}
 	buf[size] = 0;
-	inflateEnd(stream);
-	return buf;
+	if ((status == Z_OK || status == Z_STREAM_END) && !stream->avail_in) {
+		inflateEnd(stream);
+		return buf;
+	}
+
+	if (status < 0)
+		error("corrupt loose object '%s'", sha1_to_hex(sha1));
+	else if (stream->avail_in)
+		error("garbage at end of loose object '%s'",
+		      sha1_to_hex(sha1));
+	free(buf);
+	return NULL;
 }
 
 /*
@@ -1029,7 +1040,7 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return *hdr ? -1 : type_from_string(type);
 }
 
-void * unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size)
+static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
 {
 	int ret;
 	z_stream stream;
@@ -1039,7 +1050,7 @@ void * unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type
 	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
 		return NULL;
 
-	return unpack_sha1_rest(&stream, hdr, *size);
+	return unpack_sha1_rest(&stream, hdr, *size, sha1);
 }
 
 static unsigned long get_delta_base(struct packed_git *p,
@@ -1555,7 +1566,7 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 		return buf;
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size);
+		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
 		munmap(map, mapsize);
 		return buf;
 	}
-- 
1.5.0.3.855.ga3b2
