From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 11/11] Convert sha1_file.c to use decompress helpers
Date: Sat,  2 Feb 2008 12:35:56 +0100
Message-ID: <1201952156-6764-11-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-6-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-7-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-8-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-9-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-10-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGhn-0000Z5-7e
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbYBBLhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757270AbYBBLhX
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:37:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:7759 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573AbYBBLhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:37:04 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278412fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R79+4HqXxkZ7Z7j2kT2vcCPz0mPOkiD2M1+Y0M1F29w=;
        b=YRBEVr2PzaDgDn+g5PlDGY/sR+vZtgmo4tkVULIiyqrNY3LWDqgaPtje7KA2AThx8eoSl9KJLi/KNPr+DhzeLRB+UgueHJbcycofa0PyCqtXKEF8ANuABpmJEMepq/q2ZamJ+n1fBa7KZOQzoojTami/FWkza3XUF3qis4iDXgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iT5E81DIkfuNHBGUk/1q26asd8bucbzm9g+/EDb6ykk4SrgniZoHlBVs8Gs1J7vGh4YZ8dvXR90hpJTwBw7gK4yqrynhl5YK571XP2sNMb0BW8ya6SRuoFezwBCH6P/bnbNPKI1dz7iWMrkAGSVpTG5Q5Qb9ueemRHjzo12BuII=
Received: by 10.86.100.7 with SMTP id x7mr4283778fgb.10.1201952222533;
        Sat, 02 Feb 2008 03:37:02 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.37.00
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:37:01 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-10-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72268>

This is "The King".

It is the most difficult file to convert and some
decompression functions have been created just for it.

Anyhow the lines of code removed (45) far surpass the
ones added (26).

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 sha1_file.c |   71 +++++++++++++++++++++-------------------------------------
 1 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f48ad04..6500871 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1079,16 +1079,11 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
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
@@ -1105,9 +1100,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	mapsize -= used;
 
 	/* Set up the stream for the rest.. */
-	stream->next_in = map;
-	stream->avail_in = mapsize;
-	inflateInit(stream);
+	decompress_from(stream, map, mapsize);
 
 	/* And generate the fake traditional header */
 	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
@@ -1141,14 +1134,13 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
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
 
@@ -1233,20 +1225,18 @@ unsigned long get_size_from_delta(struct packed_git *p,
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
 
@@ -1323,7 +1313,7 @@ static int packed_delta_info(struct packed_git *p,
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
 	 * based on a base with a wrong size.  This saves tons of
-	 * inflate() calls.
+	 * decompress() calls.
 	 */
 	if (sizep)
 		*sizep = get_size_from_delta(p, w_curs, curpos);
@@ -1444,21 +1434,18 @@ static void *unpack_compressed_entry(struct packed_git *p,
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
@@ -1804,7 +1791,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else if (sizep)
 		*sizep = size;
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	munmap(map, mapsize);
 	return status;
 }
@@ -2212,21 +2199,15 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 			return error("unable to create temporary sha1 filename %s: %s\n", tmpfile, strerror(errno));
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
+				ret = decompress_next_into(&stream, discard, sizeof(discard), Z_SYNC_FLUSH);
 				SHA1_Update(&c, discard, sizeof(discard) -
 					    stream.avail_out);
 			} while (stream.avail_in && ret == Z_OK);
@@ -2249,7 +2230,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 		}
 		*bufposn += size;
 	} while (1);
-	inflateEnd(&stream);
+	decompress_free(&stream);
 
 	fchmod(local, 0444);
 	if (close(local) != 0)
-- 
1.5.4.rc4.39.g524a
