From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/11] sha1_object_info_extended(): hint about objects in
 delta-base cache
Date: Thu, 19 May 2011 14:33:38 -0700
Message-ID: <1305840826-7783-4-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:34:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAr1-0006FC-N2
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934825Ab1ESVd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:33:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934815Ab1ESVd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:33:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2A7E52A6
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=21ay
	NSJdTntvpdGuTVf8wv9Qt2Y=; b=dQPZZ2i787SukYdu6wdY4fNVCyS8VU3UN0pQ
	4CclHmOgLeZQCZUjrOig9pDQ4ZPubCJ9rm4KVESUbzYPsQLZvb5CYxcvZuOrO3he
	QNyXw/z2H5tr45TTRZtMWWs+MbpFU4aPu4pi0nQZpAIgXt3I09o0pklpT9/dWLGF
	Twad81A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ermRI2
	nxRL4/S9XLCtXUNDQpqmRik4Mrm+/nM7sxw3jZPAv1hSgcexc/KmVpR6KHZ1TYBW
	1FxFRHV99asS2VVk2b7iKD9wXU43/pvTIVzuZm0g9NwfiTYQT3vgp8E7MCHhRV7p
	c2qNJrI/+yDlE0K1RH8qkjHOAoG/UzZ9iMM4E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AED7252A5
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16F2452A4 for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:36:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FF3164F6-825F-11E0-AE6D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174014>

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
index 9fbc07e..e3f235f 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,7 +1030,8 @@ struct object_info {
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
index 7eed316..1d6f93d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1697,6 +1697,13 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
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
@@ -2128,6 +2135,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	if (status < 0) {
 		mark_bad_packed_object(e.p, sha1);
 		status = sha1_object_info_extended(sha1, oi);
+	} else if (in_delta_base_cache(e.p, e.offset)) {
+		oi->whence = OI_DBCACHED;
 	} else {
 		oi->whence = OI_PACKED;
 		oi->u.packed.offset = e.offset;
-- 
1.7.5.1.416.gac10c8
