From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/11] packed_object_info_detail(): do not return a string
Date: Thu, 19 May 2011 14:33:36 -0700
Message-ID: <1305840826-7783-2-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAr0-0006FC-I8
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934823Ab1ESVdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:33:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934815Ab1ESVdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:33:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05C28529E
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:35:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=If/P
	8Zu9OYK3O6/QIS3lh/kOW1k=; b=g3nAlWdEk8wjFoTCCSKvjzywW7UFcm5qKjS1
	3C1Q5izid7j7YiE5FoqX5DWNJVklxsFmY3fsHubSxM5VIRYUJwCoOljXB5Kl47Ro
	mS+pupovi0g4Rzgi3LugVYjs8z+huoj+3UKbSw1cMVwnWmE+QddOpiCHJbTj4sLQ
	ILjqyQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=C8MYjO
	6lPiDFayD5LgwQ8CnuJjdQWwMOQafeoZkPrljrs9RhREoGSdZ/0sy9YS+Q3uWS1A
	wEk6sqM5FJvwCdrhAeVHL2rqvA/o9YhoJBE4Gel4DqntPUpxUbMI+Oxdyr5xdXBX
	/96LqKdW4+1I4WzxsTtR7Gd99fOiIHnko7l44=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F247D529C
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:35:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 660EB529A for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:35:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FC653482-825F-11E0-9C1F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174012>

Instead return an integer that can be given to typename() if
the caller wants a string, just like everybody else does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/verify-pack.c |    4 ++--
 cache.h               |    2 +-
 sha1_file.c           |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index b6079ae..3a919b1 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -33,9 +33,9 @@ static void show_pack_info(struct packed_git *p, unsigned int flags)
 		if (!sha1)
 			die("internal error pack-check nth-packed-object");
 		offset = nth_packed_object_offset(p, i);
-		type = packed_object_info_detail(p, offset, &size, &store_size,
+		type = typename(packed_object_info_detail(p, offset, &size, &store_size,
 						 &delta_chain_length,
-						 base_sha1);
+						 base_sha1));
 		if (!stat_only)
 			printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length) {
diff --git a/cache.h b/cache.h
index b1b5bb5..cdb5112 100644
--- a/cache.h
+++ b/cache.h
@@ -1020,7 +1020,7 @@ extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern int packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index 064a330..4f96eb1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1549,7 +1549,7 @@ static int unpack_object_header(struct packed_git *p,
 	return type;
 }
 
-const char *packed_object_info_detail(struct packed_git *p,
+int packed_object_info_detail(struct packed_git *p,
 				      off_t obj_offset,
 				      unsigned long *size,
 				      unsigned long *store_size,
@@ -1580,7 +1580,7 @@ const char *packed_object_info_detail(struct packed_git *p,
 		case OBJ_BLOB:
 		case OBJ_TAG:
 			unuse_pack(&w_curs);
-			return typename(type);
+			return type;
 		case OBJ_OFS_DELTA:
 			obj_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
 			if (!obj_offset)
-- 
1.7.5.1.416.gac10c8
