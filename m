From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] inline lookup_replace_object() calls
Date: Sun, 15 May 2011 12:54:53 -0700
Message-ID: <1305489294-14341-5-git-send-email-gitster@pobox.com>
References: <1305489294-14341-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhPQ-0004pq-Uf
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab1EOTzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:55:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab1EOTzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:55:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C53794D42
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OBj0
	/3q8vlZy7Un0AxJxiTv7yXc=; b=wUIYbNSvSEdBh+/CG2G0Z8ZKcNVPSRBnc5nc
	d9xwByxhQ7VVZM13X9fxa2NSOChXF2Qkhs5eFvjeRSl1uDb8H9BSiMdyKJHJVdFa
	o1HbekAC4BFzva+UEltko7X8Md2IzgafFWGJpADk1J/+OVah24WwHjy8sUMvSfdZ
	AOFnHPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=l836wc
	1xxkidJ/5N5iXDxvC40ws+cwc+1UD/vuY/GEb3WWrnOijEu6UH6ki1775Fj7Q55G
	X+lkeDxagjwtBK1ZeT/OeBu0/d4Gw+SIdaXu9++9jvo6JZG/JM5xE61HMrh1PkoW
	sr7i2EYQCE8yoB3WXSEN4tJgGnRrtm5v00f7w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0F904D41
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FABA4D3F for
 <git@vger.kernel.org>; Sun, 15 May 2011 15:57:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.334.gdfd07
In-Reply-To: <1305489294-14341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 85D8C386-7F2D-11E0-914B-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173653>

In a repository without object replacement, lookup_replace_object() should
be a no-op. Check the flag "read_replace_refs" on the side of the caller,
and bypess a function call when we know we are not dealing with replacement.

Also, even when we are set up to replace objects, if we do not find any
replacement defined, flip that flag off to avoid function call overhead
for all the later object accesses.

As this change the semantics of the flag from "do we need read the
replacement definition?" to "do we need to check with the lookup table?"
the flag needs to be renamed later to something saner, e.g. "use_replace",
when the codebase is calmer, but not now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h          |   12 ++++++++++--
 environment.c    |    2 +-
 replace_object.c |    4 +++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index a9ae100..c10a91d 100644
--- a/cache.h
+++ b/cache.h
@@ -756,10 +756,18 @@ char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 int offset_1st_component(const char *path);
 
+/* object replacement */
+extern void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
+extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
+{
+	if (!read_replace_refs)
+		return sha1;
+	return do_lookup_replace_object(sha1);
+}
+
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
-extern const unsigned char *lookup_replace_object(const unsigned char *sha1);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
diff --git a/environment.c b/environment.c
index 40185bc..9182820 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,7 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int read_replace_refs = 1;
+int read_replace_refs = 1; /* NEEDSWORK: rename to use_replace_refs */
 enum eol eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
diff --git a/replace_object.c b/replace_object.c
index 7c6c754..d0b1548 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -85,12 +85,14 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
+	if (!replace_object_nr)
+		read_replace_refs = 0;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
 #define MAXREPLACEDEPTH 5
 
-const unsigned char *lookup_replace_object(const unsigned char *sha1)
+const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 {
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
-- 
1.7.5.1.334.gdfd07
