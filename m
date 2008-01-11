From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 6/6] Convert sha1_file.c to use decompress helpers
Date: Fri, 11 Jan 2008 20:01:58 +0100
Message-ID: <e5bfff550801111101x7148644bqc0e8dc2ee1f63671@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 20:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP9H-0004qr-5s
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 20:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761172AbYAKTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 14:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761569AbYAKTCD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 14:02:03 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:13918 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbYAKTCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 14:02:00 -0500
Received: by py-out-1112.google.com with SMTP id u52so1786070pyb.10
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 11:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=E8bIVfBqFRUMTDV+4tbkASTrcTFG8ek0kX5n0PgCZmc=;
        b=XtuWW3PXq9JyYoyhZWQd5Afpt+y5rMRbVnD5nFkgxGJKzMKot4HpaAehN340rPU7AtJCZSPOZqWeNzw9x+T5ZFVrJ3p07idPxB+e987XMhNPTMkowL1QLacm6ik0NmFxJ+IdG/T3QgBnmN1nvUPLQqm2CRdihsN+Q783+o2fu4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KtxwUy0AEka3O/+tmLwcT+4usEOctwVFkvWPFugj+9kfp4lPPpOAX4XOJVgaaYlzZeUehd/YhizmVSBW6BVVJeTYZRZrTfj4q51u/4zbYha79M3GuklsHWhixUQ0mvi72mFrA12JP3wvmUQO68jiw7fb+mGZn9x9yoKW/g3gKmE=
Received: by 10.140.128.11 with SMTP id a11mr2209043rvd.232.1200078118701;
        Fri, 11 Jan 2008 11:01:58 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 11:01:58 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70192>

This is "The King".

It is the most difficult file to convert and some
decompression functions have been created just for it.

Anyhow the lines of code removed (45) far surpass the
ones added (26).

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This is the last patch all git has been converted to
compress/decompress helpers.


No more open coded zlib calls in git now.


 sha1_file.c |   71 +++++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6c94bd5..708727a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1063,16 +1063,11 @@ static int unpack_sha1_header(z_stream *stream,
 	enum object_type type;

 	/* Get the data stream */
-	memset(stream, 0, sizeof(*stream));
-	stream->next_in = map;
-	stream->avail_in = mapsize;
-	stream->next_out = buffer;
-	stream->avail_out = bufsiz;
+	decompress_alloc(stream);
+	decompress_into(stream, buffer, bufsiz);

-	if (legacy_loose_object(map)) {
-		inflateInit(stream);
-		return inflate(stream, 0);
-	}
+	if (legacy_loose_object(map))
+		return decompress_next_from(stream, map, mapsize, Z_NO_FLUSH);


 	/*
@@ -1089,9 +1084,7 @@ static int unpack_sha1_header(z_stream *stream,
 	mapsize -= used;

 	/* Set up the stream for the rest.. */
-	stream->next_in = map;
-	stream->avail_in = mapsize;
-	inflateInit(stream);
+	decompress_from(stream, map, mapsize);

 	/* And generate the fake traditional header */
 	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
@@ -1125,14 +1118,13 @@ static void *unpack_sha1_rest(z_stream *stream,
 		 * we also want to check that zlib tells us that all
 		 * went well with status == Z_STREAM_END at the end.
 		 */
-		stream->next_out = buf + bytes;
-		stream->avail_out = size - bytes;
+		decompress_into(stream, buf + bytes, size - bytes);
 		while (status == Z_OK)
-			status = inflate(stream, Z_FINISH);
+			status = decompress_next(stream, Z_FINISH);
 	}
 	buf[size] = 0;
 	if (status == Z_STREAM_END && !stream->avail_in) {
-		inflateEnd(stream);
+		decompress_free(stream);
 		return buf;
 	}

@@ -1217,20 +1209,18 @@ unsigned long get_size_from_delta(struct
 	unsigned char delta_head[20], *in;
 	z_stream stream;
 	int st;
+	unsigned int in_size = 0;

-	memset(&stream, 0, sizeof(stream));
-	stream.next_out = delta_head;
-	stream.avail_out = sizeof(delta_head);
+	decompress_alloc(&stream);
+	decompress_into(&stream, delta_head, sizeof(delta_head));

-	inflateInit(&stream);
 	do {
-		in = use_pack(p, w_curs, curpos, &stream.avail_in);
-		stream.next_in = in;
-		st = inflate(&stream, Z_FINISH);
+		in = use_pack(p, w_curs, curpos, &in_size);
+		st = decompress_next_from(&stream, in, in_size, Z_FINISH);
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head))
 		die("delta data unpack-initial failed");

@@ -1307,7 +1297,7 @@ static int packed_delta_info(struct packed_git *p,
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
 	 * based on a base with a wrong size.  This saves tons of
-	 * inflate() calls.
+	 * decompress() calls.
 	 */
 	if (sizep)
 		*sizep = get_size_from_delta(p, w_curs, curpos);
@@ -1428,21 +1418,18 @@ static void *unpack_compressed_entry(struct
 	int st;
 	z_stream stream;
 	unsigned char *buffer, *in;
+	unsigned int in_size = 0;

 	buffer = xmalloc(size + 1);
 	buffer[size] = 0;
-	memset(&stream, 0, sizeof(stream));
-	stream.next_out = buffer;
-	stream.avail_out = size;
-
-	inflateInit(&stream);
+	decompress_alloc(&stream);
+	decompress_into(&stream, buffer, size);
 	do {
-		in = use_pack(p, w_curs, curpos, &stream.avail_in);
-		stream.next_in = in;
-		st = inflate(&stream, Z_FINISH);
+		in = use_pack(p, w_curs, curpos, &in_size);
+		st = decompress_next_from(&stream, in, in_size, Z_FINISH);
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != size) {
 		free(buffer);
 		return NULL;
@@ -1788,7 +1775,7 @@ static int sha1_loose_object_info(const unsigned
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else if (sizep)
 		*sizep = size;
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	munmap(map, mapsize);
 	return status;
 }
@@ -2196,21 +2183,15 @@ int write_sha1_from_fd(const unsigned char
*sha1, int fd,
 			return error("unable to create temporary sha1 filename %s: %s\n",
tmpfile, strerror(errno));
 	}

-	memset(&stream, 0, sizeof(stream));
-
-	inflateInit(&stream);
-
+	decompress_alloc(&stream);
 	SHA1_Init(&c);

 	do {
 		ssize_t size;
 		if (*bufposn) {
-			stream.avail_in = *bufposn;
-			stream.next_in = (unsigned char *) buffer;
+			decompress_from(&stream, (unsigned char *) buffer, *bufposn);
 			do {
-				stream.next_out = discard;
-				stream.avail_out = sizeof(discard);
-				ret = inflate(&stream, Z_SYNC_FLUSH);
+				ret = decompress_next_into(&stream, discard, sizeof(discard),
Z_SYNC_FLUSH);
 				SHA1_Update(&c, discard, sizeof(discard) -
 					    stream.avail_out);
 			} while (stream.avail_in && ret == Z_OK);
@@ -2233,7 +2214,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd,
 		}
 		*bufposn += size;
 	} while (1);
-	inflateEnd(&stream);
+	decompress_free(&stream);

 	fchmod(local, 0444);
 	if (close(local) != 0)
-- 
1.5.4.rc2.90.gf158-dirty
