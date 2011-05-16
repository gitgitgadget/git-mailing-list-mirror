From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/11] sha1_object_info_extended(): hint about objects in
 delta-base cache
Date: Sun, 15 May 2011 17:30:23 -0700
Message-ID: <1305505831-31587-4-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:30:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLli0-00047D-PB
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab1EPAam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab1EPAak (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF0665F78
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HAtZ
	f9gtIyxCkEXvkZYeOEO76Ho=; b=ComRuApu29OfvZDW+v+hSkiOGlX7Fi9jjaK9
	0emddeDl+DtihD2UF99+HkQ1uOou5VAQsYM8Nw2iEJeb6gIRrbeqrKKTtbQymxEg
	hwCMHpZbr+0ocDtjw3zhj2UwwmMAvmLsuBEhQ6bEge48hF+frFFQ4WV0BROh+JPK
	47EJhW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=s3sAr6
	Yy7IkP5Ef8aZDhAutic3vIUAREsQ20/g+duIpB+GfrigtOpGKSDtLb0/J60VD6D0
	/tR8al9BOklSB+vBwAUKL9Ed4VJSEoyPjAsWBPKwiI28PBxasmHatpRr6Ko1KRXV
	NWZmRpkRe+CBpX1aV51+PF95Drb4jyo0CkdN0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC28C5F77
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4437D5F76 for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:32:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 061B7478-7F54-11E0-8D98-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173688>

An object found in the delta-base cache is not guaranteed to
stay there, but we know it came from a pack and it is likely
to give us a quick access if we read_sha1_file() it right now,
which is a piece of useful information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    3 ++-
 sha1_file.c |    9 +++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index dfd2d61..7511b07 100644
--- a/cache.h
+++ b/cache.h
@@ -1031,7 +1031,8 @@ struct object_info {
 	enum {
 		OI_CACHED,
 		OI_LOOSE,
-		OI_PACKED
+		OI_PACKED,
+		OI_DBCACHED,
 	} whence;
 	union {
 		/*
diff --git a/sha1_file.c b/sha1_file.c
index 9b16cd8..4d1d3ef 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1695,6 +1695,13 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 	return hash % MAX_DELTA_CACHE;
 }
 
+static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
+{
+	unsigned long hash = pack_entry_hash(p, base_offset);
+	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+	return (ent->data && ent->p == p && ent->base_offset == base_offset);
+}
+
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	unsigned long *base_size, enum object_type *type, int keep_cache)
 {
@@ -2141,6 +2148,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	if (status < 0) {
 		mark_bad_packed_object(e.p, sha1);
 		status = sha1_object_info_extended(sha1, oi);
+	} else if (in_delta_base_cache(e.p, e.offset)) {
+		oi->whence = OI_CACHED;
 	} else {
 		oi->whence = OI_PACKED;
 		oi->u.packed.offset = e.offset;
-- 
1.7.5.1.365.g32b65
