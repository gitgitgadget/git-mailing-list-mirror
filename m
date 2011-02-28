From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] index-pack: group the delta-base array entries also by
 type
Date: Mon, 28 Feb 2011 01:49:39 -0800
Message-ID: <1298886583-30965-2-git-send-email-gitster@pobox.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 10:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzjt-0000rX-Ij
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1B1Jty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:49:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1B1Jtw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:49:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD93E3541;
	Mon, 28 Feb 2011 04:51:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CeYP
	/Cgb63+FHovw+mcnHhfwbwc=; b=VnXAD1ixLouNzOXmps+5E2kRb9xyE4TDFS7a
	k0TGut2+ZwgXdq2zYihrQrQ4lyM7Ag0ZWbCJlfI2MOZ1ItaBfg1FvARH6FJL2UE1
	QT1JSBl+eld83A2OTpiRklM3fpYiGgJuF2/rS03J9ByC+iMonxjC8H+4nGjxExxY
	ZQ+8U3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	K8oW9taplBvjJrQ8a52lvSNQ3MFLP+robdbL1+hh9OFFT/q8njtvGT1TBzqkw3bK
	GD4gCyanCfBvQXh/sbJhWPkOJJ2K8vD/hkC8P427vUpjd5JxFMR7Kv0QdOK6AjfE
	Qti7cBgEfN80bAqnUb/HbsaA/j5XPFZw5qR5r6j5feQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA0073540;
	Mon, 28 Feb 2011 04:51:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A4556353F; Mon, 28 Feb 2011
 04:51:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa72
In-Reply-To: <1298886583-30965-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4464C3B2-4320-11E0-A8BC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168087>

Entries in the delta_base array are only grouped by the bytepattern in
the delta_base union, some of which have 20-byte object name of the base
object (i.e. base for REF_DELTA objects), while others have sizeof(off_t)
bytes followed by enough NULs to fill 20-byte.  The loops to iterate
through a range inside this array still needs to inspect the type of the
delta, and skip over false hits.

Group the entries also by type to eliminate the potential of false hits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is a resend of an earlier patch we already discussed; it is not a
   wrong thing to do per-se, but is somewhat difficult to trigger.  You
   would need to come up with an object name that consists of almost all
   NULs and other bytes that happen to be the same as an offset of some
   other object.

 builtin/index-pack.c |   61 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8dc5c0b..1b5d83a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -391,7 +391,18 @@ static void *get_data_from_pack(struct object_entry *obj)
 	return data;
 }
 
-static int find_delta(const union delta_base *base)
+static int compare_delta_bases(const union delta_base *base1,
+			       const union delta_base *base2,
+			       enum object_type type1,
+			       enum object_type type2)
+{
+	int cmp = type1 - type2;
+	if (cmp)
+		return cmp;
+	return memcmp(base1, base2, UNION_BASE_SZ);
+}
+
+static int find_delta(const union delta_base *base, enum object_type type)
 {
 	int first = 0, last = nr_deltas;
 
@@ -400,7 +411,8 @@ static int find_delta(const union delta_base *base)
                 struct delta_entry *delta = &deltas[next];
                 int cmp;
 
-                cmp = memcmp(base, &delta->base, UNION_BASE_SZ);
+		cmp = compare_delta_bases(base, &delta->base,
+					  type, objects[delta->obj_no].type);
                 if (!cmp)
                         return next;
                 if (cmp < 0) {
@@ -413,9 +425,10 @@ static int find_delta(const union delta_base *base)
 }
 
 static void find_delta_children(const union delta_base *base,
-				int *first_index, int *last_index)
+				int *first_index, int *last_index,
+				enum object_type type)
 {
-	int first = find_delta(base);
+	int first = find_delta(base, type);
 	int last = first;
 	int end = nr_deltas - 1;
 
@@ -543,11 +556,13 @@ static void find_unresolved_deltas(struct base_data *base,
 		union delta_base base_spec;
 
 		hashcpy(base_spec.sha1, base->obj->idx.sha1);
-		find_delta_children(&base_spec, &ref_first, &ref_last);
+		find_delta_children(&base_spec,
+				    &ref_first, &ref_last, OBJ_REF_DELTA);
 
 		memset(&base_spec, 0, sizeof(base_spec));
 		base_spec.offset = base->obj->idx.offset;
-		find_delta_children(&base_spec, &ofs_first, &ofs_last);
+		find_delta_children(&base_spec,
+				    &ofs_first, &ofs_last, OBJ_OFS_DELTA);
 	}
 
 	if (ref_last == -1 && ofs_last == -1) {
@@ -559,24 +574,24 @@ static void find_unresolved_deltas(struct base_data *base,
 
 	for (i = ref_first; i <= ref_last; i++) {
 		struct object_entry *child = objects + deltas[i].obj_no;
-		if (child->real_type == OBJ_REF_DELTA) {
-			struct base_data result;
-			resolve_delta(child, base, &result);
-			if (i == ref_last && ofs_last == -1)
-				free_base_data(base);
-			find_unresolved_deltas(&result, base);
-		}
+		struct base_data result;
+
+		assert(child->real_type == OBJ_REF_DELTA);
+		resolve_delta(child, base, &result);
+		if (i == ref_last && ofs_last == -1)
+			free_base_data(base);
+		find_unresolved_deltas(&result, base);
 	}
 
 	for (i = ofs_first; i <= ofs_last; i++) {
 		struct object_entry *child = objects + deltas[i].obj_no;
-		if (child->real_type == OBJ_OFS_DELTA) {
-			struct base_data result;
-			resolve_delta(child, base, &result);
-			if (i == ofs_last)
-				free_base_data(base);
-			find_unresolved_deltas(&result, base);
-		}
+		struct base_data result;
+
+		assert(child->real_type == OBJ_OFS_DELTA);
+		resolve_delta(child, base, &result);
+		if (i == ofs_last)
+			free_base_data(base);
+		find_unresolved_deltas(&result, base);
 	}
 
 	unlink_base_data(base);
@@ -586,7 +601,11 @@ static int compare_delta_entry(const void *a, const void *b)
 {
 	const struct delta_entry *delta_a = a;
 	const struct delta_entry *delta_b = b;
-	return memcmp(&delta_a->base, &delta_b->base, UNION_BASE_SZ);
+
+	/* group by type (ref vs ofs) and then by value (sha-1 or offset) */
+	return compare_delta_bases(&delta_a->base, &delta_b->base,
+				   objects[delta_a->obj_no].type,
+				   objects[delta_b->obj_no].type);
 }
 
 /* Parse all objects and return the pack content SHA1 hash */
-- 
1.7.4.1.249.g4aa72
