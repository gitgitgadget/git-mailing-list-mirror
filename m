From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/12] packed_object_info_detail(): do not return a string
Date: Fri, 20 May 2011 23:56:24 -0700
Message-ID: <1305960995-25738-2-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg7J-0005xc-I7
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab1EUG4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:56:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab1EUG4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:56:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E31065D91
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=f/hf
	NYV1kVAOhBS2TE4+Als5nO4=; b=vv8b3JMCPpFJigAJ553dHnXJIlYvtnsl198x
	15KuGbd3xekQrTutBb9PsxIQ2R+mUcF+5EYpCjwME6cE24qk3UW54wb/ZIbOIdEu
	BElIxbWvRMYtajG2grwPA5C00uNuC2upod3Z88SJNbDbBmEuL7scQgfJiZFEG8O5
	gq83C+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CvNooU
	GwAL9b8dANiP1SXt+5td2++fgLLzyIwopl7+OPcaoC+Sr8aUqP7U2TKg7GqjKIXl
	vhb3duhGe91iqStGJwXgBqmt+n+cK2knY0K7iEAUORG8iyV3rhRwW8JCokdNx0Be
	ZC+mhML/dCP95+2v97epuWFTyLsbNZHCb6h0I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF89A5D90
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:58:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E86295D8F for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:58:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CA3A3CAA-8377-11E0-ADB3-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174095>

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
1.7.5.2.369.g8fc017
