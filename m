From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/11] sha1_object_info_extended(): expose a bit more info
Date: Sun, 15 May 2011 17:30:22 -0700
Message-ID: <1305505831-31587-3-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLli0-00047D-79
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab1EPAak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab1EPAai (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC1B55F74
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BK7n
	HOdvyiEMlL4dLG30oHHxnZE=; b=VgQE1YcvFXzT9xopu2mPBrDYZeZWOCzwnwId
	lOf+4rQQyc87LZdHJktLVih54UUGl22H+kPk9i6EBUWPr3CpSNGD1PIzTBiP5ls6
	pV5xJIpuywNNRh+z0JM49wfGlw0E0cdwKWaK7RPqe3aEkmHrmKwMEA7gazUOCedu
	2IGc8Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Bj0Kji
	YjITgco09CQIYWGUr9Ya/N5IHHZ8VVwaaDCMiit3ivttWzzvhKWKVspyq8MOpTWB
	KtCftpussg3I0kr9nCz0+TiWXg/VuGYMT5A4Sq0fZJVLwic/gzVMTvzXNlAw5N2h
	uaoJff/c/9MVwF/gNhQjfGn9QKuladAZ+vz2s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A94335F73
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 013605F72 for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:32:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 04D3BB02-7F54-11E0-B1EE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173689>

The original interface for sha1_object_info() takes an object name and
gives back a type and its size (the latter is given only when it was
asked).  The new interface wraps its implementation and exposes a bit
more pieces of information that the interface used to discard, namely:

 - where the object is stored (loose? cached? packed?)
 - if packed, where in which packfile?

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |   29 +++++++++++++++++++++++++++++
 sha1_file.c |   46 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index cdb5112..dfd2d61 100644
--- a/cache.h
+++ b/cache.h
@@ -1022,6 +1022,35 @@ extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsig
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
+struct object_info {
+	/* Request */
+	unsigned long *sizep;
+	int want_deltainfo;
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
+			off_t offset;
+			unsigned int delta;
+			struct packed_git *pack;
+		} packed;
+	} u;
+};
+extern int sha1_object_info_extended(const unsigned char *, struct object_info *);
+
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/sha1_file.c b/sha1_file.c
index 4f96eb1..9b16cd8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2093,7 +2093,8 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	return status;
 }
 
-int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+/* returns enum object_type or negative */
+int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 {
 	struct cached_object *co;
 	struct pack_entry e;
@@ -2101,16 +2102,19 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
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
@@ -2118,15 +2122,43 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 			return status;
 	}
 
-	status = packed_object_info(e.p, e.offset, sizep);
+	if (!oi->want_deltainfo) {
+		status = packed_object_info(e.p, e.offset, oi->sizep);
+	} else {
+		unsigned long size, store_size;
+		unsigned int delta_chain_length;
+		unsigned char base_sha1[20];
+		status = packed_object_info_detail(e.p, e.offset,
+						   &size, &store_size,
+						   &delta_chain_length,
+						   base_sha1);
+		if (0 <= status) {
+			if (oi->sizep)
+				*oi->sizep = size;
+			oi->u.packed.delta = delta_chain_length;
+		}
+	}
 	if (status < 0) {
 		mark_bad_packed_object(e.p, sha1);
-		status = sha1_object_info(sha1, sizep);
+		status = sha1_object_info_extended(sha1, oi);
+	} else {
+		oi->whence = OI_PACKED;
+		oi->u.packed.offset = e.offset;
+		oi->u.packed.pack = e.p;
 	}
 
 	return status;
 }
 
+int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+{
+	struct object_info oi;
+
+	oi.sizep = sizep;
+	oi.want_deltainfo = 0;
+	return sha1_object_info_extended(sha1, &oi);
+}
+
 static void *read_packed_sha1(const unsigned char *sha1,
 			      enum object_type *type, unsigned long *size)
 {
-- 
1.7.5.1.365.g32b65
