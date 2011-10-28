From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] define the way new representation types are encoded in
 the pack
Date: Thu, 27 Oct 2011 23:04:40 -0700
Message-ID: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 08:04:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJfYg-0008P8-0n
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 08:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab1J1GEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 02:04:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab1J1GEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 02:04:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1573C2F14;
	Fri, 28 Oct 2011 02:04:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	LRD/DBvc2g+kOc2LGPvXZBhU1A=; b=IIhzRVnDdoKsycyVZGemuMb3zdj0OeE/i
	WMw85QDcqIZGU9JUpmpTeBh6MMtRTAZfuPUqkH9NP+xumcalajlCPqGeYn6DsVtP
	Njbmx55nnwmhao+SQ24OjcUPpnKMHmpQ0wrpj8JRUwLsuydsMFCkMYHHKC7H7y8/
	rgAyYyO0Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=SA8R9Iyl7HcK8dIFtn07dzzYjP5puLpXmVbxOVmhPt/grO0w+jc3Hpq+
	OSgQC5eg0cTZm/AiqMJ9C1O1qie4NlQgvx3UN4u+yZwlrltf26pFHuzfMHsz2aBo
	pof1P4ghMFU4ixOoS7WkHRHfmZZgdPumurejbfPulYWlapVTXSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6902F13;
	Fri, 28 Oct 2011 02:04:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3FD22F10; Fri, 28 Oct 2011
 02:04:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA025B0C-012A-11E1-A7D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184339>

In addition to four basic types (commit, tree, blob and tag), the pack
stream can encode a few other "representation" types, such as REF_DELTA
and OFS_DELTA. As we allocate 3 bits in the first byte for this purpose,
we do not have much room to add new representation types in place, but we
do have one value reserved for future expansion.

This patch is about defining how that reserved value is used.

The first byte in the pack stream data consists of the following for the
current representation types:

 - Bit 0-3 are used for the low 4-bit of "some" size (not necessarily the
   size of the representation);

 - Bit 4-6 are used for object types 0-7, but we have not used type 5 so
   far and reserved it for future expansion (we could also use type 0
   recorded in the pack stream for future expansion, just like how I
   convert 5 into the real "extended" representation type in this patch);

 - Bit 7 is used to signal if the second byte needs to be read for sizes
   that do not fit in the 4-bit.

When bit 4-6 encodes type 5, the first byte is used this way:

 - Bit 0-3 denotes the real "extended" representation type. Because types
   0-7 can already be encoded without using the extended format, we can
   offset the type by 8 (i.e. if bit 0-3 says 3, it means representation
   type 11 = 3 + 8);

 - Bit 4-6 has the value "5";

 - Bit 7 is used to signal if the _third_ byte needs to be read for larger
   size that cannot be represented with 8-bit.

As it is unlikely for us to pack things that do not need to record any
size, the second byte is always used in full to encode the low 8-bit of
the size.

I haven't started using type=8 and upwards for anything yet, but because
we have only one "future expansion" value left, I want us to be extremely
careful in order to avoid painting us into a corner that we cannot get out
of, so I am sending this out early for a preliminary review.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    3 ++-
 sha1_file.c |   36 ++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 2e6ad36..b02139b 100644
--- a/cache.h
+++ b/cache.h
@@ -380,9 +380,10 @@ enum object_type {
 	OBJ_TREE = 2,
 	OBJ_BLOB = 3,
 	OBJ_TAG = 4,
-	/* 5 for future expansion */
+	OBJ_EXT = 5, /* 5 for future expansion */
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
+	OBJ_CAT_TREE = 8,
 	OBJ_ANY,
 	OBJ_MAX
 };
diff --git a/sha1_file.c b/sha1_file.c
index 27f3b9b..4dcd023 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1254,16 +1254,43 @@ static int experimental_loose_object(unsigned char *map)
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
+	unsigned long len, enum object_type *typep, unsigned long *sizep)
 {
 	unsigned shift;
 	unsigned long size, c;
 	unsigned long used = 0;
+	enum object_type type;
 
+	/*
+	 * MSB of the first byte is used to tell if the second byte
+	 * needs to be read for the size, so type field is only 3-bit
+	 * wide.
+	 */
 	c = buf[used++];
-	*type = (c >> 4) & 7;
-	size = c & 15;
-	shift = 4;
+	type = (c >> 4) & 7;
+
+	if (type != OBJ_EXT) {
+		/*
+		 * For basic types of object representations, the low
+		 * 4-bit of the first byte is used for the lowermost
+		 * 4-bit of the size. The MSB of the first byte tells
+		 * if the second byte needs to be read for size.
+		 */
+		size = c & 15;
+		shift = 4;
+	} else {
+		/*
+		 * For extended types, the low 4-bit of the first byte
+		 * is used for the representation type (offset by 8),
+		 * and the size begins at the second byte. The MSB of
+		 * the first byte is still used to indicate the next
+		 * byte (i.e. the third byte) needs to be read for the
+		 * size.
+		 */
+		type = (c & 15) + 8;
+		size = buf[used++];
+		shift = 8;
+	}
 	while (c & 0x80) {
 		if (len <= used || bitsizeof(long) <= shift) {
 			error("bad object header");
@@ -1274,6 +1301,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		shift += 7;
 	}
 	*sizep = size;
+	*typep = type;
 	return used;
 }
 
