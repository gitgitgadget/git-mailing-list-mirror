From: Junio C Hamano <gitster@pobox.com>
Subject: [Not A PATCH v2 02/11] interdiff
Date: Thu, 19 May 2011 14:44:38 -0700
Message-ID: <7vr57u5prt.fsf_-_@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNB1V-0004RD-Gv
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934876Ab1ESVoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:44:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933194Ab1ESVon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:44:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE94C53F9;
	Thu, 19 May 2011 17:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZJU4onFzmanwAzujg0hgk8P906E=; b=CIH6zy
	ctiyiXpms/p8Zxf9bcx2CDo2pKezzr9kXXVmDN/y6NFyBYJC/lUR8wiOCjNCe/QM
	+Z5gW67iB/fhsJ+fhiJPTVgFfQNTWg+JARo9lX9HeRJZj/+BxZRKsQP7qSZovGn8
	QteOSK3/+mvuH8zdzZBsZ4qHu//N1BiTPj4Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FVg/mw5CJions6Y+aZ2GaJksq+HutHOA
	PdKVD/wjB3bS+AtHOkTn7wFdlh+//kn+Zyucn51wkqBEHOLFgwZjsnvEu17PhmCN
	iuocyoxRgyTIcyi1uKh5T2SKCBc0WrmX0XuciU8+JjeNC4pHYf+bJ2ozO8e9tm23
	K2VtxqykKts=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CCD1653F8;
	Thu, 19 May 2011 17:46:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EF17453F7; Thu, 19 May 2011
 17:46:47 -0400 (EDT)
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 19 May 2011 14:33:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80550596-8261-11E0-9C40-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174026>

This is an interdiff for 02/11 from the earlier round.

As oi->u.packed.delta is renamed to is_delta, and oi->want_deltainfo is
lost with this change, the later patches have necessary adjustments but
they are all trivial so I wouldn't be spamming the list with the interdiff
for them since the first round.

---
 cache.h     |    5 ++---
 sha1_file.c |   30 +++++++++---------------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/cache.h b/cache.h
index dfd2d61..9fbc07e 100644
--- a/cache.h
+++ b/cache.h
@@ -1025,7 +1025,6 @@ extern int packed_object_info_detail(struct packed_git *, off_t, unsigned long *
 struct object_info {
 	/* Request */
 	unsigned long *sizep;
-	int want_deltainfo;
 
 	/* Response */
 	enum {
@@ -1043,9 +1042,9 @@ struct object_info {
 		 * } loose;
 		 */
 		struct {
-			off_t offset;
-			unsigned int delta;
 			struct packed_git *pack;
+			off_t offset;
+			unsigned int is_delta;
 		} packed;
 	} u;
 };
diff --git a/sha1_file.c b/sha1_file.c
index 9b16cd8..7eed316 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1481,7 +1481,7 @@ static off_t get_delta_base(struct packed_git *p,
 
 /* forward declaration for a mutually recursive function */
 static int packed_object_info(struct packed_git *p, off_t offset,
-			      unsigned long *sizep);
+			      unsigned long *sizep, int *rtype);
 
 static int packed_delta_info(struct packed_git *p,
 			     struct pack_window **w_curs,
@@ -1495,7 +1495,7 @@ static int packed_delta_info(struct packed_git *p,
 	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
 	if (!base_offset)
 		return OBJ_BAD;
-	type = packed_object_info(p, base_offset, NULL);
+	type = packed_object_info(p, base_offset, NULL, NULL);
 	if (type <= OBJ_NONE) {
 		struct revindex_entry *revidx;
 		const unsigned char *base_sha1;
@@ -1605,7 +1605,7 @@ int packed_object_info_detail(struct packed_git *p,
 }
 
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      unsigned long *sizep)
+			      unsigned long *sizep, int *rtype)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
@@ -1613,6 +1613,8 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 	enum object_type type;
 
 	type = unpack_object_header(p, &w_curs, &curpos, &size);
+	if (rtype)
+		*rtype = type; /* representation type */
 
 	switch (type) {
 	case OBJ_OFS_DELTA:
@@ -2098,7 +2100,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 {
 	struct cached_object *co;
 	struct pack_entry e;
-	int status;
+	int status, rtype;
 
 	co = find_cached_object(sha1);
 	if (co) {
@@ -2122,22 +2124,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 			return status;
 	}
 
-	if (!oi->want_deltainfo) {
-		status = packed_object_info(e.p, e.offset, oi->sizep);
-	} else {
-		unsigned long size, store_size;
-		unsigned int delta_chain_length;
-		unsigned char base_sha1[20];
-		status = packed_object_info_detail(e.p, e.offset,
-						   &size, &store_size,
-						   &delta_chain_length,
-						   base_sha1);
-		if (0 <= status) {
-			if (oi->sizep)
-				*oi->sizep = size;
-			oi->u.packed.delta = delta_chain_length;
-		}
-	}
+	status = packed_object_info(e.p, e.offset, oi->sizep, &rtype);
 	if (status < 0) {
 		mark_bad_packed_object(e.p, sha1);
 		status = sha1_object_info_extended(sha1, oi);
@@ -2145,6 +2132,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 		oi->whence = OI_PACKED;
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
+		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
+					 rtype == OBJ_OFS_DELTA);
 	}
 
 	return status;
@@ -2155,7 +2144,6 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	struct object_info oi;
 
 	oi.sizep = sizep;
-	oi.want_deltainfo = 0;
 	return sha1_object_info_extended(sha1, &oi);
 }
 
-- 
1.7.5.1.416.gac10c8
