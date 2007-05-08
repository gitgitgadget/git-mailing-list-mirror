From: Dana How <danahow@gmail.com>
Subject: [PATCH 2/4] git-repack --max-pack-size: write_{object,one}() respect
 pack limit
Date: Tue, 08 May 2007 13:03:02 -0700
Message-ID: <4640D776.7030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVvC-0005rY-G8
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031980AbXEHUDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031981AbXEHUD1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:03:27 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:8937 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031975AbXEHUDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:03:22 -0400
Received: by py-out-1112.google.com with SMTP id a29so1581619pyi
        for <git@vger.kernel.org>; Tue, 08 May 2007 13:03:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=L6JHmy/9OSPz53HYAq52+ElcgK139Luu2vcY1rvEiN/m358IlVcKtRtcUzcZGRNhnA4aD55/cn7xtJ/3+Q82Y3QlzzASxGWZjDPHEEZ3OYzViKfuRbp1l/BfyeCgXmcAcBqXa4/se5kENbF76TjWjjZmNP/x2Btwss6Y5TIkfRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ENqosY7ljFO2bt7Y+4EMggNn0lfB1VVNpIhSV7DrlJ39ABkipQpDPtIjk853qffPe9xRG0psL8vAM1sTbdT34LsT+PNtoAxzQeTix/uHmPFDqe7Lh6cYdKuwHjjht3CuchWr63HcQZZg5ch2NDMQRY4V4YgdsPbT16w5h+TAPZ8=
Received: by 10.35.134.19 with SMTP id l19mr13887669pyn.1178654601254;
        Tue, 08 May 2007 13:03:21 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id a70sm17401096pye.2007.05.08.13.03.09;
        Tue, 08 May 2007 13:03:14 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46614>


With --max-pack-size,  generate the appropriate write limit
for each object and check against it before each group of writes.
Update delta usability rules to handle base being in a previously-
written pack.  Inline sha1write_compress() so we know the
exact size of the written data when it needs to be compressed.
Detect and return write "failure".

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |  135 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 108 insertions(+), 27 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d832e2d..fbff8fa 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -399,16 +399,31 @@ static int revalidate_loose_object(struct object_entry *entry,
 }
 
 static unsigned long write_object(struct sha1file *f,
-				  struct object_entry *entry)
+				  struct object_entry *entry,
+				  off_t write_offset)
 {
 	unsigned long size;
 	enum object_type type;
 	void *buf;
 	unsigned char header[10];
+	unsigned char dheader[10];
 	unsigned hdrlen;
 	off_t datalen;
 	enum object_type obj_type;
 	int to_reuse = 0;
+	/* write limit if limited packsize and not first object */
+	unsigned long limit = pack_size_limit && nr_written ?
+				pack_size_limit - write_offset : 0;
+				/* no if no delta */
+	int usable_delta =	!entry->delta ? 0 :
+				/* yes if unlimited packfile */
+				!pack_size_limit ? 1 :
+				/* no if base written to previous pack */
+				entry->delta->offset == (off_t)-1 ? 0 :
+				/* otherwise double-check written to this
+				 * pack,  like we do below
+				 */
+				entry->delta->offset ? 1 : 0;
 
 	if (!pack_to_stdout)
 		crc32_begin(f);
@@ -417,7 +432,9 @@ static unsigned long write_object(struct sha1file *f,
 	if (! entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (obj_type == OBJ_REF_DELTA || obj_type == OBJ_OFS_DELTA)
-		to_reuse = 1;	/* check_object() decided it for us */
+				/* check_object() decided it for us ... */
+		to_reuse = usable_delta;
+				/* ... but pack split may override that */
 	else if (obj_type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
 	else if (entry->delta)
@@ -436,6 +453,10 @@ static unsigned long write_object(struct sha1file *f,
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
@@ -447,24 +468,48 @@ static unsigned long write_object(struct sha1file *f,
 	}
 
 	if (!to_reuse) {
+		z_stream stream;
+		unsigned long maxsize;
+		void *out;
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
+		} else {
+			/*
+			 * recover real object type in case
+			 * check_object() wanted to re-use a delta,
+			 * but we couldn't since base was in previous split pack
+			 */
+			obj_type = type;
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
@@ -473,21 +518,41 @@ static unsigned long write_object(struct sha1file *f,
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
@@ -502,20 +567,6 @@ static unsigned long write_object(struct sha1file *f,
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
@@ -524,6 +575,29 @@ static unsigned long write_object(struct sha1file *f,
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
@@ -531,7 +605,7 @@ static unsigned long write_object(struct sha1file *f,
 		unuse_pack(&w_curs);
 		reused++;
 	}
-	if (entry->delta)
+	if (usable_delta)
 		written_delta++;
 	written++;
 	if (!pack_to_stdout)
@@ -550,11 +624,18 @@ static off_t write_one(struct sha1file *f,
 		return offset;
 
 	/* if we are deltified, write out base object first. */
-	if (e->delta)
+	if (e->delta) {
 		offset = write_one(f, e->delta, offset);
+		if (!offset)
+			return 0;
+	}
 
 	e->offset = offset;
-	size = write_object(f, e);
+	size = write_object(f, e, offset);
+	if (!size) {
+		e->offset = 0;
+		return 0;
+	}
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
-- 
1.5.2.rc0.787.g0014
