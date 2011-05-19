From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/11] sha1_object_info_extended(): expose a bit more info
Date: Thu, 19 May 2011 14:33:37 -0700
Message-ID: <1305840826-7783-3-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:34:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNArI-0006Sr-VV
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934833Ab1ESVeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:34:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33309 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934815Ab1ESVd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:33:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9210552A3
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=V0jZ
	7FdiTgsK2PGji+O75N4/Auo=; b=g3nanCRLnuj4kbwrY3YHl+JYvXesBCzygfF8
	sGCV1oavi0EhSHldhApIfW43cYrbCnWk6WAenarrM+GzET3/NDg/dIC9EGgyzxq3
	iYvrNl7muV6YV8Xh11M/++omJG7SFMyd8DMXPXSJOfzbbkizx2xh+BTAZC2G6288
	DEOLzJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VpiUCa
	A5XM3cq6THxQfuFAFEkzLAkvqZW1yfeDnr+gwW0JZmSOY6K8LfvliEzv+8B372bx
	XOubPpgHxPHahWmkV1Z7UjqiBkWNEQdHatYdSn/pNZvQVnC9wYfAtZnphND6zsKz
	bvkd/tlN4WcCtWUgqY9jtxZpPd13mTM85hXk0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E12952A1
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 92AC1529F for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:36:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FDDFFCA2-825F-11E0-B6F9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174015>

The original interface for sha1_object_info() takes an object name and
gives back a type and its size (the latter is given only when it was
asked).  The new interface wraps its implementation and exposes a bit
more pieces of information that the interface used to discard, namely:

 - where the object is stored (loose? cached? packed?)
 - if packed, where in which packfile?

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * In the earlier round, this used u.pack.delta to record the length of
   the delta chain, but the caller is not necessarily interested in the
   length of the delta chain per-se, but may only want to know if it is a
   delta against another object or is stored as a deflated data. Calling
   packed_object_info_detail() involves walking the reverse index chain to
   compute the store size of the object and is unnecessarily expensive.

   We could resurrect the code if a new caller wants to know, but I doubt
   it.
---
 cache.h     |   28 ++++++++++++++++++++++++++++
 sha1_file.c |   42 +++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index cdb5112..9fbc07e 100644
--- a/cache.h
+++ b/cache.h
@@ -1022,6 +1022,34 @@ extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsig
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
+struct object_info {
+	/* Request */
+	unsigned long *sizep;
+
+	/* Response */
+	enum {
+		OI_CACHED,
+		OI_LOOSE,
+		OI_PACKED
+	} whence;
+	union {
+		/*
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } cached;
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } loose;
+		 */
+		struct {
+			struct packed_git *pack;
+			off_t offset;
+			unsigned int is_delta;
+		} packed;
+	} u;
+};
+extern int sha1_object_info_extended(const unsigned char *, struct object_info *);
+
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/sha1_file.c b/sha1_file.c
index 4f96eb1..7eed316 100644
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
@@ -2093,24 +2095,28 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	return status;
 }
 
-int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+/* returns enum object_type or negative */
+int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 {
 	struct cached_object *co;
 	struct pack_entry e;
-	int status;
+	int status, rtype;
 
 	co = find_cached_object(sha1);
 	if (co) {
-		if (sizep)
-			*sizep = co->size;
+		if (oi->sizep)
+			*(oi->sizep) = co->size;
+		oi->whence = OI_CACHED;
 		return co->type;
 	}
 
 	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
-		status = sha1_loose_object_info(sha1, sizep);
-		if (status >= 0)
+		status = sha1_loose_object_info(sha1, oi->sizep);
+		if (status >= 0) {
+			oi->whence = OI_LOOSE;
 			return status;
+		}
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
@@ -2118,15 +2124,29 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 			return status;
 	}
 
-	status = packed_object_info(e.p, e.offset, sizep);
+	status = packed_object_info(e.p, e.offset, oi->sizep, &rtype);
 	if (status < 0) {
 		mark_bad_packed_object(e.p, sha1);
-		status = sha1_object_info(sha1, sizep);
+		status = sha1_object_info_extended(sha1, oi);
+	} else {
+		oi->whence = OI_PACKED;
+		oi->u.packed.offset = e.offset;
+		oi->u.packed.pack = e.p;
+		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
+					 rtype == OBJ_OFS_DELTA);
 	}
 
 	return status;
 }
 
+int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+{
+	struct object_info oi;
+
+	oi.sizep = sizep;
+	return sha1_object_info_extended(sha1, &oi);
+}
+
 static void *read_packed_sha1(const unsigned char *sha1,
 			      enum object_type *type, unsigned long *size)
 {
-- 
1.7.5.1.416.gac10c8
