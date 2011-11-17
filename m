From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pack-object: tolerate broken packs that have duplicated
 objects
Date: Wed, 16 Nov 2011 22:04:03 -0800
Message-ID: <7v8vnfnv3g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 07:04:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQv53-0001Ej-OT
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 07:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab1KQGEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 01:04:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab1KQGEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 01:04:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C7035EF;
	Thu, 17 Nov 2011 01:04:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=w
	xoEFSsy1Ft7TIR7m0JUmJNfVCA=; b=Jfe6sdrm+Qom3JB6YfCSnd9FwHwcBVPsO
	9ORBSV+msDu8MR020OaOo5IRXFOWM9gsHXlQ5DIMcAdJ59kOIgvXOQ2cQZeXPfHN
	+PGyPV2FiLvyDJhYZ4HXDSe7gLyPfwfHC0kIWLXgKwNUSIbdHuOTRC1f3WeGDVxf
	+EY4BCv79U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=yWhQlVzqmor8UMK3jPYqZofrU0xwwNvpT1Bm6wKJjZ4zbuxBCkq8+hLI
	mkdDasViLAKOwGD2tM5OGbsyER5NIjzvc9wbYMNzi3qJmU1AwSKryUMWWwfZRJ14
	MPs4MC2AGzC4odT4WD1MtcHsl9Qfo9YGXzR+QgbWiMv+5mb8SiE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D48235EE;
	Thu, 17 Nov 2011 01:04:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C62C935EB; Thu, 17 Nov 2011
 01:04:04 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F42EF620-10E1-11E1-B256-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185573>

When --reuse-delta is in effect (which is the default), and an existing
pack in the repository has the same object registered twice (e.g. one copy
in a non-delta format and the other copy in a delta against some other
object), an attempt to repack the repository can result in a cyclic delta
dependency, causing write_one() function to infinitely recurse into
itself.

Detect such a case and break the loopy dependency by writing out an object
that is involved in such a loop in the non-delta format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This may need to be cherry-picked to earlier maintenance series. The
   topic I queued tonight is built on v1.7.6.4.   

 builtin/pack-objects.c |   55 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c6e2d87..5ae808b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -404,25 +404,56 @@ static unsigned long write_object(struct sha1file *f,
 	return hdrlen + datalen;
 }
 
-static int write_one(struct sha1file *f,
-			       struct object_entry *e,
-			       off_t *offset)
+enum write_one_status {
+	WRITE_ONE_SKIP = -1, /* already written */
+	WRITE_ONE_BREAK = 0, /* writing this will bust the limit; not written */
+	WRITE_ONE_WRITTEN = 1, /* normal */
+	WRITE_ONE_RECURSIVE = 2 /* already scheduled to be written */
+};
+
+static enum write_one_status write_one(struct sha1file *f,
+				       struct object_entry *e,
+				       off_t *offset)
 {
 	unsigned long size;
+	int recursing;
 
-	/* offset is non zero if object is written already. */
-	if (e->idx.offset || e->preferred_base)
-		return -1;
+	/*
+	 * we set offset to 1 (which is an impossible value) to mark
+	 * the fact that this object is involved in "write its base
+	 * first before writing a deltified object" recursion.
+	 */
+	recursing = (e->idx.offset == 1);
+	if (recursing) {
+		warning("recursive delta detected for object %s",
+			sha1_to_hex(e->idx.sha1));
+		return WRITE_ONE_RECURSIVE;
+	} else if (e->idx.offset || e->preferred_base) {
+		/* offset is non zero if object is written already. */
+		return WRITE_ONE_SKIP;
+	}
 
 	/* if we are deltified, write out base object first. */
-	if (e->delta && !write_one(f, e->delta, offset))
-		return 0;
+	if (e->delta) {
+		e->idx.offset = 1; /* now recurse */
+		switch (write_one(f, e->delta, offset)) {
+		case WRITE_ONE_RECURSIVE:
+			/* we cannot depend on this one */
+			e->delta = NULL;
+			break;
+		default:
+			break;
+		case WRITE_ONE_BREAK:
+			e->idx.offset = recursing;
+			return WRITE_ONE_BREAK;
+		}
+	}
 
 	e->idx.offset = *offset;
 	size = write_object(f, e, *offset);
 	if (!size) {
-		e->idx.offset = 0;
-		return 0;
+		e->idx.offset = recursing;
+		return WRITE_ONE_BREAK;
 	}
 	written_list[nr_written++] = &e->idx;
 
@@ -430,7 +461,7 @@ static int write_one(struct sha1file *f,
 	if (signed_add_overflows(*offset, size))
 		die("pack too large for current definition of off_t");
 	*offset += size;
-	return 1;
+	return WRITE_ONE_WRITTEN;
 }
 
 static void write_pack_file(void)
@@ -468,7 +499,7 @@ static void write_pack_file(void)
 		offset = sizeof(hdr);
 		nr_written = 0;
 		for (; i < nr_objects; i++) {
-			if (!write_one(f, objects + i, &offset))
+			if (write_one(f, objects + i, &offset) == WRITE_ONE_BREAK)
 				break;
 			display_progress(progress_state, written);
 		}
-- 
1.7.8.rc2.109.g72037
