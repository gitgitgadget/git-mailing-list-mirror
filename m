From: Dana How <danahow@gmail.com>
Subject: [PATCH 5/8] git-repack --max-pack-size: write_object() takes "limit"
 arg
Date: Mon, 30 Apr 2007 16:22:20 -0700
Message-ID: <46367A2C.3030804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:22:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifCl-0002wO-5N
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946886AbXD3XWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946885AbXD3XWZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:22:25 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42254 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946883AbXD3XWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:22:23 -0400
Received: by py-out-1112.google.com with SMTP id a29so1463202pyi
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:22:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=qioT4tgovbE6p7aXKIoZkUui0nA7m3/+5j8AFm4cGwJubj/p7XsNavFopswyCfibcTqzcA6cByJqaPXoqxEd/2mflgtdvFSWM1o+krj60NIWpL/L3LwWCmo5EBTXMhU6O4+yEqKKj8ndIAySbN2aKVAIUaJNTXuWnhlaKCVVLqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Rms7iIMG3WXloYdmPPww4GCNuqERLFFyx/cAL8h/6Zfp/0V2iz4rKuC+9t3t4D0YBLAMTw7Rh8DarNGXVybtUWel1aK3pUJBYAkWOPn2cacpuMbyDVR5INuLtfprB6ikyqKa373l7V3RLzgiBWpcPkiiFKcqXC9vrJYZYIazXWk=
Received: by 10.65.239.14 with SMTP id q14mr12852682qbr.1177975342920;
        Mon, 30 Apr 2007 16:22:22 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id j7sm7909897nzd.2007.04.30.16.22.21;
        Mon, 30 Apr 2007 16:22:22 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45896>


Accept new "limit" argument and check against it
before each group of writes.  Update delta usability rules
for possibility of delta base being in a previously-
written pack.  Inline sha1write_compress() so we know
the exact size of the written data when it needs to be compressed.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |  110 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 86 insertions(+), 24 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 98066bf..d3ebe1d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -399,12 +399,14 @@ static int revalidate_loose_object(struct object_entry *entry,
 }
 
 static unsigned long write_object(struct sha1file *f,
-				  struct object_entry *entry)
+				  struct object_entry *entry,
+				  unsigned long limit)
 {
 	unsigned long size;
 	enum object_type type;
 	void *buf;
 	unsigned char header[10];
+	unsigned char dheader[10];
 	unsigned hdrlen;
 	off_t datalen;
 	enum object_type obj_type;
@@ -436,6 +438,10 @@ static unsigned long write_object(struct sha1file *f,
 			if (revalidate_loose_object(entry, map, mapsize))
 				die("corrupt loose object %s",
 				    sha1_to_hex(entry->sha1));
+			if (limit && mapsize + 20 >= limit) {
+				munmap(map, mapsize);
+				return 0;
+			}
 			sha1write(f, map, mapsize);
 			munmap(map, mapsize);
 			written++;
@@ -447,24 +453,51 @@ static unsigned long write_object(struct sha1file *f,
 	}
 
 	if (!to_reuse) {
+		z_stream stream;
+		unsigned long maxsize;
+		void *out;
+					/* no if no delta */
+		int usable_delta =	!entry->delta ? 0 :
+					/* yes if unlimited packfile */
+					!pack_size_limit ? 1 :
+					/* no if base written to previous pack */
+					entry->delta->offset == (off_t)-1 ? 0 :
+					/* otherwise double-check written to this
+					 * pack,  like we do below
+					 */
+					entry->delta->offset ? 1 : 0;
 		buf = read_sha1_file(entry->sha1, &type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
 		if (size != entry->size)
 			die("object %s size inconsistency (%lu vs %lu)",
 			    sha1_to_hex(entry->sha1), size, entry->size);
-		if (entry->delta) {
+		if (usable_delta) {
 			buf = delta_against(buf, size, entry);
 			size = entry->delta_size;
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
+		/* compress the data to store and put compressed length in datalen */
+		memset(&stream, 0, sizeof(stream));
+		deflateInit(&stream, zlib_compression_level);
+		maxsize = deflateBound(&stream, size);
+		out = xmalloc(maxsize);
+		/* Compress it */
+		stream.next_in = buf;
+		stream.avail_in = size;
+		stream.next_out = out;
+		stream.avail_out = maxsize;
+		while (deflate(&stream, Z_FINISH) == Z_OK)
+			/* nothing */;
+		deflateEnd(&stream);
+		datalen = stream.total_out;
+		deflateEnd(&stream);
 		/*
 		 * The object header is a byte of 'type' followed by zero or
 		 * more bytes of length.
 		 */
 		hdrlen = encode_header(obj_type, size, header);
-		sha1write(f, header, hdrlen);
 
 		if (obj_type == OBJ_OFS_DELTA) {
 			/*
@@ -473,21 +506,41 @@ static unsigned long write_object(struct sha1file *f,
 			 * base from this object's position in the pack.
 			 */
 			off_t ofs = entry->offset - entry->delta->offset;
-			unsigned pos = sizeof(header) - 1;
-			header[pos] = ofs & 127;
+			unsigned pos = sizeof(dheader) - 1;
+			dheader[pos] = ofs & 127;
 			while (ofs >>= 7)
-				header[--pos] = 128 | (--ofs & 127);
-			sha1write(f, header + pos, sizeof(header) - pos);
-			hdrlen += sizeof(header) - pos;
+				dheader[--pos] = 128 | (--ofs & 127);
+			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
+			sha1write(f, dheader + pos, sizeof(dheader) - pos);
+			hdrlen += sizeof(dheader) - pos;
 		} else if (obj_type == OBJ_REF_DELTA) {
 			/*
 			 * Deltas with a base reference contain
 			 * an additional 20 bytes for the base sha1.
 			 */
+			if (limit && hdrlen + 20 + datalen + 20 >= limit) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
 			sha1write(f, entry->delta->sha1, 20);
 			hdrlen += 20;
+		} else {
+			if (limit && hdrlen + datalen + 20 >= limit) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
 		}
-		datalen = sha1write_compressed(f, buf, size);
+		sha1write(f, out, datalen);
+		free(out);
 		free(buf);
 	}
 	else {
@@ -502,20 +555,6 @@ static unsigned long write_object(struct sha1file *f,
 			reused_delta++;
 		}
 		hdrlen = encode_header(obj_type, entry->size, header);
-		sha1write(f, header, hdrlen);
-		if (obj_type == OBJ_OFS_DELTA) {
-			off_t ofs = entry->offset - entry->delta->offset;
-			unsigned pos = sizeof(header) - 1;
-			header[pos] = ofs & 127;
-			while (ofs >>= 7)
-				header[--pos] = 128 | (--ofs & 127);
-			sha1write(f, header + pos, sizeof(header) - pos);
-			hdrlen += sizeof(header) - pos;
-		} else if (obj_type == OBJ_REF_DELTA) {
-			sha1write(f, entry->delta->sha1, 20);
-			hdrlen += 20;
-		}
-
 		offset = entry->in_pack_offset;
 		revidx = find_packed_object(p, offset);
 		datalen = revidx[1].offset - offset;
@@ -524,6 +563,29 @@ static unsigned long write_object(struct sha1file *f,
 			die("bad packed object CRC for %s", sha1_to_hex(entry->sha1));
 		offset += entry->in_pack_header_size;
 		datalen -= entry->in_pack_header_size;
+		if (obj_type == OBJ_OFS_DELTA) {
+			off_t ofs = entry->offset - entry->delta->offset;
+			unsigned pos = sizeof(dheader) - 1;
+			dheader[pos] = ofs & 127;
+			while (ofs >>= 7)
+				dheader[--pos] = 128 | (--ofs & 127);
+			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit)
+				return 0;
+			sha1write(f, header, hdrlen);
+			sha1write(f, dheader + pos, sizeof(dheader) - pos);
+			hdrlen += sizeof(dheader) - pos;
+		} else if (obj_type == OBJ_REF_DELTA) {
+			if (limit && hdrlen + 20 + datalen + 20 >= limit)
+				return 0;
+			sha1write(f, header, hdrlen);
+			sha1write(f, entry->delta->sha1, 20);
+			hdrlen += 20;
+		} else {
+			if (limit && hdrlen + datalen + 20 >= limit)
+				return 0;
+			sha1write(f, header, hdrlen);
+		}
+
 		if (!pack_to_stdout && p->index_version == 1 &&
 		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size))
 			die("corrupt packed object for %s", sha1_to_hex(entry->sha1));
@@ -554,7 +616,7 @@ static off_t write_one(struct sha1file *f,
 		offset = write_one(f, e->delta, offset);
 
 	e->offset = offset;
-	size = write_object(f, e);
+	size = write_object(f, e, 0);
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
-- 
1.5.2.rc0.766.gba60-dirty
