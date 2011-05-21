From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/12] sha1_object_info_extended(): hint about objects in
 delta-base cache
Date: Fri, 20 May 2011 23:56:26 -0700
Message-ID: <1305960995-25738-4-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg7j-00064k-Cd
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab1EUG5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:57:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1EUG5O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:57:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C4E75DA6
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pLle
	OHYDZV/yg6nfVEXejxlKPe4=; b=egAq7RQh6ldF0s1N0Ffx2cQtoU5yido6DntM
	L+5+8yweC8tZAQrQ6uMV5S9l/OfOQ7ry+RfNUj0BciR1a4cTgcrs9s94QuQ9Bx1g
	iFIk9hK+vOBNc+jkQrFjYj2a08Ze2SVBW59CC73yYFTwhcGtCcXIwnNb5BNJVDoI
	nIQr8MI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QUBYyd
	FFpJV7oNkwxgYNaShDXCjRxik+PsRfr0M7y6e9pgUlnL6komniivQcqKrFdLLRDv
	TB+0mjP3NgOrPuNKOAgTjEw//fg6Up8vG2xb2gohfHu7mJBmHsqZtIVpw5JLizwM
	5Y6G8DO5RC4fnYD8KdLX1J8L91Um37+xZt5gs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87FF95DA5
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0343E5DA1 for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:59:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DA1BA348-8377-11E0-89B7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174097>

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
index 9fbc07e..3a1af9d 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,7 +1030,8 @@ struct object_info {
 	enum {
 		OI_CACHED,
 		OI_LOOSE,
-		OI_PACKED
+		OI_PACKED,
+		OI_DBCACHED
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
1.7.5.2.369.g8fc017
