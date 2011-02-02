From: Junio C Hamano <gitster@pobox.com>
Subject: Q on "index-pack: smarter memory usage during delta resolution,
 2008-10-17"
Date: Wed, 02 Feb 2011 10:11:26 -0800
Message-ID: <7vfws6xq5t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 19:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkhBA-0001i1-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 19:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab1BBSLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 13:11:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab1BBSLh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 13:11:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59B6024F1;
	Wed,  2 Feb 2011 13:12:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=bDAc
	6W9sJfMsd/Oo8MtkmaN3/Ho=; b=Zx3XCFbKJ5CEW7iUbH7j6tC//e1Ncaq7nJO+
	/5LP/CugdhN1fu8sJ07clKGBAZdykHpG/5r4BMmkY8y/ACJL+v40aS9F9MvtC7qU
	+5VDJZAIx28UikItkOU8Is8UzgbwdCgP+EEqfxaH9Ocud157tV7+BnCk7LW3TbkI
	Pwn+0zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	UbxeRo7xKN2NvZEcEtnNx/MivtfnQDJNbPDeh4e9jq3EVSk3s3z8uhWXHXsDG3N0
	fBEdOsjL5J6mUtvC3FIyMFRNHhfzDIYO4+w43kv+KRFDSS4ntdLvdahiTgvzS+nI
	EWlqQmNYS1oOAlt+i9wiNCUJ0Xv0kle7wxrAptFJKM8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29C6A24F0;
	Wed,  2 Feb 2011 13:12:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B05A324EF; Wed,  2 Feb 2011
 13:12:21 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD39AD9A-2EF7-11E0-8987-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165922>

In find_unresolved_deltas(), there are two loops that walk the range of deltas[]
array that potentially share the same base object.  One loop for ref-delta
looks like this:

	for (i = ref_first; i <= ref_last; i++) {
		struct object_entry *child = objects + deltas[i].obj_no;
		if (child->real_type == OBJ_REF_DELTA) {
			struct base_data result;
			resolve_delta(child, base, &result);
			if (i == ref_last && ofs_last == -1)
				free_base_data(base);
			find_unresolved_deltas(&result, base);
		}
	}

I was wondering what happens when the entry at ref_last was a false match
(i.e. the "union delta_base" happened to have the same 20-byte pattern but
was of a wrong kind).

The other loop for ofs-delta has the same "if (i == ofs_last)" condition.

Admittedly this is rather hard to trigger (you have to find an object
as a ofs-delta base object, and then come up with another object whose
object name is the same as the offset of the first base object followed
by bunch of '\0' and use it as a ref-delta base), and even if it did, it
will only retain the memory for slightly longer time in the function.

Is a patch along the following line worth doing, I wonder.

-- >8 --
Subject: index-pack: group the delta-base array entries also by type

Entries in the delta_base array are only grouped by the bytepattern in
the delta_base union, some of which have 20-byte object name of the base
object (i.e. base for REF_DELTA objects), while others have sizeof(off_t)
bytes followed by enough NULs to fill 20-byte.  The loops to iterate
through a range inside this array still needs to inspect the type of the
delta, and skip over false hits.

Group the entries also by type to eliminate the potential of false hits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
