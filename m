From: Dana How <danahow@gmail.com>
Subject: [PATCH 5/8] get-repack --max-pack-size: write_object() takes 'limit'
 arg
Date: Sun, 08 Apr 2007 16:24:04 -0700
Message-ID: <46197994.70009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hagk0-0007l5-Pq
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbXDHXYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXDHXYJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:24:09 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:1364 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbXDHXYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:24:06 -0400
Received: by py-out-1112.google.com with SMTP id a29so897142pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:24:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=FHeth9Sq0hTu+vD//YMBwGo9vXUgEVNKAs/ZxCEF3067xjErCf7oBeBw4tPTr8swd7ewCRaluWaQbVIw70vs7WrYK+LFpA7iERMvgxPBRrBsgAzQcOVQoc0ZasrXKRl2EWwE++lYHG04uGB6D/1M7thTAiWkKoa3ZAHgiZ7XLVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=tlqM/kZxt4i8qrrUTUnGn74mpnUZdJJFmf21PP4FbDE102Ux4A9r4Xq40ZY/aFA/SfN2WPf1L/oHukkOPy0KHAnS/Y8DlAuBp3fUvmQ1NcBbJRUHqkFDsGVc3PhF8vjy3U9oL4tXoX8HMQxaYlySby+HNuBsfCGfyIonlLa13yU=
Received: by 10.65.153.10 with SMTP id f10mr10502644qbo.1176074646299;
        Sun, 08 Apr 2007 16:24:06 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 39sm24576109nzk.2007.04.08.16.24.05;
        Sun, 08 Apr 2007 16:24:05 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44015>


Accept new 'limit' argument and check against it
before each group of writes.  Update delta usability rules
for possibility of delta base being in a previously-
written pack. Inline sha1write_compressed() so we know
the exact size of the written data when it needs to be compressed.

Signed-off-by: Dana How <how@deathvalley.cswitch.com>
---
 builtin-pack-objects.c |   66 ++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7ab0712..9530008 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -373,7 +373,8 @@ static int revalidate_loose_object(struct object_entry *entry,
 }
 
 static off_t write_object(struct sha1file *f,
-				  struct object_entry *entry)
+				  struct object_entry *entry,
+				  unsigned long limit)
 {
 	unsigned long size;
 	enum object_type type;
@@ -407,6 +408,10 @@ static off_t write_object(struct sha1file *f,
 			if (revalidate_loose_object(entry, map, mapsize))
 				die("corrupt loose object %s",
 				    sha1_to_hex(entry->sha1));
+			if ( limit && mapsize + 20 >= limit ) {
+				munmap(map, mapsize);
+				return 0;
+			}
 			sha1write(f, map, mapsize);
 			munmap(map, mapsize);
 			written++;
@@ -418,24 +423,51 @@ static off_t write_object(struct sha1file *f,
 	}
 
 	if (!to_reuse) {
+		z_stream stream;
+		unsigned long maxsize;
+		void *out;
+					/* no if no delta */
+		int usable_delta =	!entry->delta ? 0 :
+					/* yes if unlimited packfile */
+					!offset_limit ? 1 :
+					/* no if base written to previous pack */
+					entry->delta->prev_pack ? 0 :
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
@@ -448,6 +480,12 @@ static off_t write_object(struct sha1file *f,
 			header[pos] = ofs & 127;
 			while (ofs >>= 7)
 				header[--pos] = 128 | (--ofs & 127);
+			if ( limit && hdrlen + sizeof(header) - pos + datalen + 20 >= limit ) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
 			sha1write(f, header + pos, sizeof(header) - pos);
 			hdrlen += sizeof(header) - pos;
 		} else if (obj_type == OBJ_REF_DELTA) {
@@ -455,10 +493,17 @@ static off_t write_object(struct sha1file *f,
 			 * Deltas with a base reference contain
 			 * an additional 20 bytes for the base sha1.
 			 */
+			if ( limit && hdrlen + 20 + datalen + 20 >= limit ) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
 			sha1write(f, entry->delta->sha1, 20);
 			hdrlen += 20;
 		}
-		datalen = sha1write_compressed(f, buf, size);
+		sha1write(f, out, datalen);
+		free(out);
 		free(buf);
 	}
 	else {
@@ -472,23 +517,28 @@ static off_t write_object(struct sha1file *f,
 			reused_delta++;
 		}
 		hdrlen = encode_header(obj_type, entry->size, header);
-		sha1write(f, header, hdrlen);
+		datalen = find_packed_object_size(p, entry->in_pack_offset)
+				- entry->in_pack_header_size;
 		if (obj_type == OBJ_OFS_DELTA) {
 			off_t ofs = entry->offset - entry->delta->offset;
 			unsigned pos = sizeof(header) - 1;
 			header[pos] = ofs & 127;
 			while (ofs >>= 7)
 				header[--pos] = 128 | (--ofs & 127);
+			if ( limit && hdrlen + sizeof(header) - pos + datalen + 20 >= limit )
+				return 0;
+			sha1write(f, header, hdrlen);
 			sha1write(f, header + pos, sizeof(header) - pos);
 			hdrlen += sizeof(header) - pos;
 		} else if (obj_type == OBJ_REF_DELTA) {
+			if ( limit && hdrlen + 20 + datalen + 20 >= limit )
+				return 0;
+			sha1write(f, header, hdrlen);
 			sha1write(f, entry->delta->sha1, 20);
 			hdrlen += 20;
 		}
 
 		offset = entry->in_pack_offset + entry->in_pack_header_size;
-		datalen = find_packed_object_size(p, entry->in_pack_offset)
-				- entry->in_pack_header_size;
 		if (!pack_to_stdout && check_pack_inflate(p, &w_curs,
 				offset, datalen, entry->size))
 			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
@@ -515,7 +565,7 @@ static off_t write_one(struct sha1file *f,
 	if (e->delta)
 		offset = write_one(f, e->delta, offset);
 	e->offset = offset;
-	return offset + write_object(f, e);
+	return offset + write_object(f, e, 0);
 }
 
 /*
-- 
1.5.1.89.g8abf0
