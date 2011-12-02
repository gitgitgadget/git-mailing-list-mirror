From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/6] varint-in-pack: refactor varint encoding/decoding
Date: Thu,  1 Dec 2011 16:40:45 -0800
Message-ID: <1322786449-25753-3-git-send-email-gitster@pobox.com>
References: <1322699263-14475-6-git-send-email-gitster@pobox.com>
 <1322786449-25753-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:41:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWHCF-0007B0-7D
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 01:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab1LBAk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 19:40:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756085Ab1LBAk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 19:40:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F88E6B25
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jLtz
	viJPUXhUzG+GnxgRxAUjnJc=; b=vQRc4jjHjT2nps5mGwczn5oSw9VYx0fINIZp
	AQTwojJsnXW0o2h4pBZjPpx8rqDti/lyG7Vlb5yG6epxv8BcSHVXW3QZfq1ItoB4
	0Pf7CVYh6sPhdTFR0cqZ0P3uL/DyuKqK8VFcjp2kCUsSKkeTploy9+DrPUsAAvcs
	43XM+gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BuwoBK
	y1cOjMXYBjOMNvxAICcYa8P27UxLm3UkzM9I5jqxDOYFLnPe6IoaI4QCiDJNVcgD
	8CG96sL2b38JlHk/YYDSQjJePm+TTuA5d5EPIO3tDxk0D9UGGshSDEAR5GdPRFOs
	9IUxBMRV89RPF6Fg9jE+jMJvI6g7ayfUtKnd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 571576B24
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A263F6B23 for
 <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:55 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322786449-25753-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4B8C001E-1C7E-11E1-BCA5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186205>

Refactor encode/decode_in_pack_varint() functions from OFS_DELTA codepaths
to read and write variable-length integers in the pack stream.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |   28 +++++++++++++---------------
 pack-write.c           |   27 +++++++++++++++++++++++++++
 pack.h                 |    2 ++
 sha1_file.c            |   18 ++++++------------
 4 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dde913e..72206a9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -210,7 +210,7 @@ static unsigned long write_object(struct sha1file *f,
 {
 	unsigned long size, limit, datalen;
 	void *buf;
-	unsigned char header[10], dheader[10];
+	unsigned char header[10];
 	unsigned hdrlen;
 	enum object_type type;
 	int usable_delta, to_reuse;
@@ -304,17 +304,16 @@ static unsigned long write_object(struct sha1file *f,
 			 * base from this object's position in the pack.
 			 */
 			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
-			unsigned pos = sizeof(dheader) - 1;
-			dheader[pos] = ofs & 127;
-			while (ofs >>= 7)
-				dheader[--pos] = 128 | (--ofs & 127);
-			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
+			unsigned char dheader[10];
+			unsigned pos = encode_in_pack_varint(ofs, dheader);
+
+			if (limit && hdrlen + pos + datalen + 20 >= limit) {
 				free(buf);
 				return 0;
 			}
 			sha1write(f, header, hdrlen);
-			sha1write(f, dheader + pos, sizeof(dheader) - pos);
-			hdrlen += sizeof(dheader) - pos;
+			sha1write(f, dheader, pos);
+			hdrlen += pos;
 		} else if (type == OBJ_REF_DELTA) {
 			/*
 			 * Deltas with a base reference contain
@@ -369,17 +368,16 @@ static unsigned long write_object(struct sha1file *f,
 
 		if (type == OBJ_OFS_DELTA) {
 			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
-			unsigned pos = sizeof(dheader) - 1;
-			dheader[pos] = ofs & 127;
-			while (ofs >>= 7)
-				dheader[--pos] = 128 | (--ofs & 127);
-			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
+			unsigned char dheader[10];
+			unsigned pos = encode_in_pack_varint(ofs, dheader);
+
+			if (limit && hdrlen + pos + datalen + 20 >= limit) {
 				unuse_pack(&w_curs);
 				return 0;
 			}
 			sha1write(f, header, hdrlen);
-			sha1write(f, dheader + pos, sizeof(dheader) - pos);
-			hdrlen += sizeof(dheader) - pos;
+			sha1write(f, dheader, pos);
+			hdrlen += pos;
 			reused_delta++;
 		} else if (type == OBJ_REF_DELTA) {
 			if (limit && hdrlen + 20 + datalen + 20 >= limit) {
diff --git a/pack-write.c b/pack-write.c
index cadc3e1..5702cec 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -302,6 +302,33 @@ char *index_pack_lockfile(int ip_out)
 	return NULL;
 }
 
+uintmax_t decode_in_pack_varint(const unsigned char **bufp)
+{
+	const unsigned char *buf = *bufp;
+	unsigned char c = *buf++;
+	uintmax_t val = c & 127;
+	while (c & 128) {
+		val += 1;
+		if (!val || MSB(val, 7))
+			return 0; /* overflow */
+		c = *buf++;
+		val = (val << 7) + (c & 127);
+	}
+	*bufp = buf;
+	return val;
+}
+
+int encode_in_pack_varint(uintmax_t value, unsigned char *buf)
+{
+	unsigned char varint[16];
+	unsigned pos = sizeof(varint) - 1;
+	varint[pos] = value & 127;
+	while (value >>= 7)
+		varint[--pos] = 128 | (--value & 127);
+	memcpy(buf, varint + pos, sizeof(varint) - pos);
+	return sizeof(varint) - pos;
+}
+
 /*
  * The per-object header is a pretty dense thing, which is
  *  - first byte: low four bits are "size", then three bits of "type",
diff --git a/pack.h b/pack.h
index cfb0f69..d7dc6ca 100644
--- a/pack.h
+++ b/pack.h
@@ -79,6 +79,8 @@ extern off_t write_pack_header(struct sha1file *f, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned char *);
+extern int encode_in_pack_varint(uintmax_t, unsigned char *);
+extern uintmax_t decode_in_pack_varint(const unsigned char **);
 
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
diff --git a/sha1_file.c b/sha1_file.c
index c96e366..f066c2b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1484,20 +1484,14 @@ static off_t get_delta_base(struct packed_git *p,
 	 * is stupid, as then a REF_DELTA would be smaller to store.
 	 */
 	if (type == OBJ_OFS_DELTA) {
-		unsigned used = 0;
-		unsigned char c = base_info[used++];
-		base_offset = c & 127;
-		while (c & 128) {
-			base_offset += 1;
-			if (!base_offset || MSB(base_offset, 7))
-				return 0;  /* overflow */
-			c = base_info[used++];
-			base_offset = (base_offset << 7) + (c & 127);
-		}
-		base_offset = delta_obj_offset - base_offset;
+		const unsigned char *buf = base_info;
+		uintmax_t ofs = decode_in_pack_varint(&buf);
+		if (!ofs && buf == base_info)
+			return 0; /* overflow */
+		base_offset = delta_obj_offset - ofs;
 		if (base_offset <= 0 || base_offset >= delta_obj_offset)
 			return 0;  /* out of bound */
-		*curpos += used;
+		*curpos += buf - base_info;
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset = find_pack_entry_one(base_info, p);
-- 
1.7.8.rc4.177.g4d64
