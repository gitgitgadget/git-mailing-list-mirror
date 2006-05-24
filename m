From: Linus Torvalds <torvalds@osdl.org>
Subject: Clean up sha1 file writing
Date: Wed, 24 May 2006 08:30:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 24 17:31:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FivKL-0003tA-AO
	for gcvg-git@gmane.org; Wed, 24 May 2006 17:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWEXPbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 11:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWEXPbK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 11:31:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932653AbWEXPbJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 11:31:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4OFV3tH007445
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 08:31:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4OFUtGk020228;
	Wed, 24 May 2006 08:30:58 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20691>


This cleans up and future-proofs the sha1 file writing in sha1_file.c.

In particular, instead of doing a simple "write()" call and just verifying 
that it succeeds (or - as in one place - just assuming it does), it uses 
"write_buffer()" to write data to the file descriptor while correctly 
checking for partial writes, EINTR etc.

It also splits up write_sha1_to_fd() to be a lot more readable: if we need 
to re-create the compressed object, we do so in a separate helper 
function, making the logic a whole lot more modular and obvious.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This shouldn't change any behaviour, and it's obviously touching some core 
code, so maybe it's not worth it. On the other hand, from a longer-term 
maintenance standpoint and from a "be much more careful when doing file 
writes" standpoint, I think it's worth it.

The re-write is "obviously correct" (famous last words) and is mostly 
just moving code around and getting rid of a few temporaries that become 
unnecessary as a result.

The patch looks a bit messy: the changes aren't actually that big, but the 
split-up and the resulting re-indentation makes the patch fairly 
unreadable, so the cleanups are more obvious when you look at the 
before-and-after side by side rather than when looking at the unified 
diff..)

diff --git a/sha1_file.c b/sha1_file.c
index 2230010..c2fe7c2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1399,6 +1399,25 @@ int move_temp_to_file(const char *tmpfil
 	return 0;
 }
 
+static int write_buffer(int fd, const void *buf, size_t len)
+{
+	while (len) {
+		ssize_t size;
+
+		size = write(fd, buf, len);
+		if (!size)
+			return error("file write: disk full");
+		if (size < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			return error("file write error (%s)", strerror(errno));
+		}
+		len -= size;
+		buf += size;
+	}
+	return 0;
+}
+
 int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	int size;
@@ -1465,8 +1484,8 @@ int write_sha1_file(void *buf, unsigned 
 	deflateEnd(&stream);
 	size = stream.total_out;
 
-	if (write(fd, compressed, size) != size)
-		die("unable to write file");
+	if (write_buffer(fd, compressed, size) < 0)
+		die("unable to write sha1 file");
 	fchmod(fd, 0444);
 	close(fd);
 	free(compressed);
@@ -1474,73 +1493,70 @@ int write_sha1_file(void *buf, unsigned 
 	return move_temp_to_file(tmpfile, filename);
 }
 
-int write_sha1_to_fd(int fd, const unsigned char *sha1)
+/*
+ * We need to unpack and recompress the object for writing
+ * it out to a different file.
+ */
+static void *repack_object(const unsigned char *sha1, unsigned long *objsize)
 {
-	ssize_t size;
-	unsigned long objsize;
-	int posn = 0;
-	void *map = map_sha1_file_internal(sha1, &objsize);
-	void *buf = map;
-	void *temp_obj = NULL;
+	size_t size;
 	z_stream stream;
+	unsigned char *unpacked;
+	unsigned long len;
+	char type[20];
+	char hdr[50];
+	int hdrlen;
+	void *buf;
 
-	if (!buf) {
-		unsigned char *unpacked;
-		unsigned long len;
-		char type[20];
-		char hdr[50];
-		int hdrlen;
-		// need to unpack and recompress it by itself
-		unpacked = read_packed_sha1(sha1, type, &len);
+	// need to unpack and recompress it by itself
+	unpacked = read_packed_sha1(sha1, type, &len);
 
-		hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
+	hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
 
-		/* Set it up */
-		memset(&stream, 0, sizeof(stream));
-		deflateInit(&stream, Z_BEST_COMPRESSION);
-		size = deflateBound(&stream, len + hdrlen);
-		temp_obj = buf = xmalloc(size);
+	/* Set it up */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	size = deflateBound(&stream, len + hdrlen);
+	buf = xmalloc(size);
 
-		/* Compress it */
-		stream.next_out = buf;
-		stream.avail_out = size;
+	/* Compress it */
+	stream.next_out = buf;
+	stream.avail_out = size;
 		
-		/* First header.. */
-		stream.next_in = (void *)hdr;
-		stream.avail_in = hdrlen;
-		while (deflate(&stream, 0) == Z_OK)
-			/* nothing */;
+	/* First header.. */
+	stream.next_in = (void *)hdr;
+	stream.avail_in = hdrlen;
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
 
-		/* Then the data itself.. */
-		stream.next_in = unpacked;
-		stream.avail_in = len;
-		while (deflate(&stream, Z_FINISH) == Z_OK)
-			/* nothing */;
-		deflateEnd(&stream);
-		free(unpacked);
-		
-		objsize = stream.total_out;
-	}
+	/* Then the data itself.. */
+	stream.next_in = unpacked;
+	stream.avail_in = len;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+	free(unpacked);
 
-	do {
-		size = write(fd, buf + posn, objsize - posn);
-		if (size <= 0) {
-			if (!size) {
-				fprintf(stderr, "write closed\n");
-			} else {
-				perror("write ");
-			}
-			return -1;
-		}
-		posn += size;
-	} while (posn < objsize);
+	*objsize = stream.total_out;
+	return buf;
+}
 
-	if (map)
-		munmap(map, objsize);
-	if (temp_obj)
-		free(temp_obj);
+int write_sha1_to_fd(int fd, const unsigned char *sha1)
+{
+	int retval;
+	unsigned long objsize;
+	void *buf = map_sha1_file_internal(sha1, &objsize);
 
-	return 0;
+	if (buf) {
+		retval = write_buffer(fd, buf, objsize);
+		munmap(buf, objsize);
+		return retval;
+	}
+
+	buf = repack_object(sha1, &objsize);
+	retval = write_buffer(fd, buf, objsize);    
+	free(buf);
+	return retval;
 }
 
 int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
@@ -1579,7 +1595,8 @@ int write_sha1_from_fd(const unsigned ch
 				SHA1_Update(&c, discard, sizeof(discard) -
 					    stream.avail_out);
 			} while (stream.avail_in && ret == Z_OK);
-			write(local, buffer, *bufposn - stream.avail_in);
+			if (write_buffer(local, buffer, *bufposn - stream.avail_in) < 0)
+				die("unable to write sha1 file");
 			memmove(buffer, buffer + *bufposn - stream.avail_in,
 				stream.avail_in);
 			*bufposn = stream.avail_in;
