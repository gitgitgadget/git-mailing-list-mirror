From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/6] new representation types in the packstream
Date: Thu,  1 Dec 2011 16:40:46 -0800
Message-ID: <1322786449-25753-4-git-send-email-gitster@pobox.com>
References: <1322699263-14475-6-git-send-email-gitster@pobox.com>
 <1322786449-25753-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:41:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWHBe-0006z8-9T
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 01:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab1LBAlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 19:41:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab1LBAk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 19:40:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56BAE6B2B
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9ZtF
	SrfEwiySjiaHHOjbBzL/rWY=; b=QjhoF5Vmy+W/NKlnTXtclBwHRnRBlb5oUYer
	T3/JsAcK1sofBtV5TCjQygS5qbhil8QtMr3J1PpV4UkYfpu2habfnhWcl3yXHVAx
	RQKNeoO2N4jfVZsy1zu0TCTabzIZRgMUleUxAV0ol8U2FPwj/cfJ6z6uvIpupBTQ
	bcpIILA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vbRsXP
	fd0/+xLZhvWI6XLaJmUQ6FBYnhahgrFsIYW0g1qmTmhQhtldghX80cnm2udXUk8e
	vlQwDMOwNjDBWE12rCs0qjmyZqNsDskU3wqOrsItiVtkKw/oxqMVIsHKzPXONZ9l
	oqwbLzTZxLNQGjpwcutdLnzITkDimLYx+Xwkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DEE86B2A
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A654B6B27 for
 <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:57 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322786449-25753-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4CBF9C7A-1C7E-11E1-BC2F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186203>

In addition to four basic types (commit, tree, blob and tag), the pack
stream can encode a few other "representation" types, such as REF_DELTA
and OFS_DELTA. As we allocate 3 bits in the first byte for this purpose,
we do not have much room to add new representation types in place, but we
do have one value reserved for future expansion.

When encoding a new representation type, the early part of the in-pack
object header is encoded as if its type is OBJ_EXT (= 5) using exactly the
same way as before. That is, the lower 4-bit of the first byte is used for
the lowest 4-bit of the size information, the next 3-bit has the type
information, and the MSB says if the subsequent bytes encodes higher bits
for the size information.

An in-pack object header that records OBJ_EXT as the type is followed by
an integer in the same variable-length encoding as OFS_DELTA offset is
encoded. This value is the real type of the representation minus 8 (as we
do not need to use OBJ_EXT to encode types smaller than 8).  Because we do
not foresee very many representation types, in practice we would have a
single byte with its MSB clear, to represent types 8-135.

The code does not type=8 and upwards for anything yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      |    4 +++-
 pack-write.c |   23 +++++++++++++++++------
 sha1_file.c  |   11 +++++++++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 4f20861..4a3b421 100644
--- a/cache.h
+++ b/cache.h
@@ -381,12 +381,14 @@ enum object_type {
 	OBJ_TREE = 2,
 	OBJ_BLOB = 3,
 	OBJ_TAG = 4,
-	/* 5 for future expansion */
+	OBJ_EXT = 5,
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
 	OBJ_ANY,
 	OBJ_MAX
 };
+#define OBJ_LAST_BASE_TYPE OBJ_REF_DELTA
+#define OBJ_LAST_VALID_TYPE OBJ_REF_DELTA
 
 static inline enum object_type object_type(unsigned int mode)
 {
diff --git a/pack-write.c b/pack-write.c
index 5702cec..9309dd1 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -338,22 +338,33 @@ int encode_in_pack_varint(uintmax_t value, unsigned char *buf)
  */
 int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned char *hdr)
 {
-	int n = 1;
+	unsigned char *hdr_base;
 	unsigned char c;
+	enum object_type header_type;
 
-	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
+	if (type < OBJ_COMMIT || OBJ_LAST_VALID_TYPE < type)
 		die("bad type %d", type);
+	else if (OBJ_LAST_BASE_TYPE < type)
+		header_type = OBJ_EXT;
+	else
+		header_type = type;
 
-	c = (type << 4) | (size & 15);
+	c = (header_type << 4) | (size & 15);
 	size >>= 4;
+	hdr_base = hdr;
 	while (size) {
 		*hdr++ = c | 0x80;
 		c = size & 0x7f;
 		size >>= 7;
-		n++;
 	}
-	*hdr = c;
-	return n;
+	*hdr++ = c;
+	if (header_type != type) {
+		int sz;
+		type = type - (OBJ_LAST_BASE_TYPE + 1);
+		sz = encode_in_pack_varint(type, hdr);
+		hdr += sz;
+	}
+	return hdr - hdr_base;
 }
 
 struct sha1file *create_tmp_packfile(char **pack_tmp_name)
diff --git a/sha1_file.c b/sha1_file.c
index f066c2b..14902cc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1275,6 +1275,17 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		shift += 7;
 	}
 	*sizep = size;
+	if (*type == OBJ_EXT) {
+		const unsigned char *p = buf + used;
+		uintmax_t val = decode_in_pack_varint(&p);
+
+		if (p == buf + used && !val) {
+			error("bad extended object type");
+			return 0;
+		}
+		*type = val + (OBJ_LAST_BASE_TYPE + 1);
+		used = p - buf;
+	}
 	return used;
 }
 
-- 
1.7.8.rc4.177.g4d64
