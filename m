From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Wed, 16 Nov 2011 22:04:13 -0800
Message-ID: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 07:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQv5D-0001Ju-DS
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 07:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108Ab1KQGES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 01:04:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab1KQGER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 01:04:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB84C35F8;
	Thu, 17 Nov 2011 01:04:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	D5arm7o10/Kk63bhr7jTvQzx/U=; b=oXPaDDyDzacPagOXyR3BMO0FGDt3SX4EF
	s/3pw033PfPF0ke8mVfv8NtzK1YQshjPNe3F1StHSHqyYYuUmyp7te/Ixi+ALwCo
	VPgYi+ruC0UzcR7cgBV3z0Lc5CPUC9nLxeQCFrKxV+MtZSSlF9jqoH6KlAMMoY1u
	TDgz5i2X78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=sTGwPTLuOgsbMLOPXpiYQg8m9gEtjtV4Z/2QBgHPb5ZCZhsFAQin6eAA
	kMP3Tqj9i76VHHk5ZdDRsBOAU8z0dGQdELtteQ0FLlfgttTn90KYHvLvdFyWqJzi
	RoUcVpC3wWxV8ycAqlHfygoiPwzyNIoMqJvZ+wEHmIOsgpT3pZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C367235F7;
	Thu, 17 Nov 2011 01:04:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B25035F6; Thu, 17 Nov 2011
 01:04:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA5C4778-10E1-11E1-ABB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185574>

When receive-pack & fetch-pack are run and store the pack obtained over
the wire to a local repository, they internally run the index-pack command
with the --strict option. Make sure that we reject incoming packfile that
records objects twice to avoid spreading such a damage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Passing --strict from fetch-pack actually is a recent invention, so
   this will be only useful to 1.7.8 and later.

 builtin/index-pack.c |    4 +++-
 object.c             |    2 ++
 pack-write.c         |    4 ++++
 pack.h               |    3 ++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0945adb..98025da 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1122,8 +1122,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		if (!index_name)
 			die("--verify with no packfile name given");
 		read_idx_option(&opts, index_name);
-		opts.flags |= WRITE_IDX_VERIFY;
+		opts.flags |= WRITE_IDX_VERIFY | WRITE_IDX_STRICT;
 	}
+	if (strict)
+		opts.flags |= WRITE_IDX_STRICT;
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
diff --git a/object.c b/object.c
index 31976b5..d8d09f9 100644
--- a/object.c
+++ b/object.c
@@ -149,6 +149,8 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 		struct tree *tree = lookup_tree(sha1);
 		if (tree) {
 			obj = &tree->object;
+			if (!tree->buffer)
+				tree->object.parsed = 0;
 			if (!tree->object.parsed) {
 				if (parse_tree_buffer(tree, buffer, size))
 					return NULL;
diff --git a/pack-write.c b/pack-write.c
index 9cd3bfb..f84adde 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -129,6 +129,10 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		}
 		sha1write(f, obj->sha1, 20);
 		git_SHA1_Update(&ctx, obj->sha1, 20);
+		if ((opts->flags & WRITE_IDX_STRICT) &&
+		    (i && !hashcmp(list[-2]->sha1, obj->sha1)))
+			die("The same object %s appears twice in the pack",
+			    sha1_to_hex(obj->sha1));
 	}
 
 	if (index_version >= 2) {
diff --git a/pack.h b/pack.h
index 722a54e..aca4739 100644
--- a/pack.h
+++ b/pack.h
@@ -37,7 +37,8 @@ struct pack_header {
 struct pack_idx_option {
 	unsigned flags;
 	/* flag bits */
-#define WRITE_IDX_VERIFY 01
+#define WRITE_IDX_VERIFY 01 /* verify only, do not write the idx file */
+#define WRITE_IDX_STRICT 02
 
 	uint32_t version;
 	uint32_t off32_limit;
-- 
1.7.8.rc2.109.g72037
