From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] fsck: clarify semantics of mark_object_reachable()
Date: Mon, 27 Jun 2011 10:50:58 -0700
Message-ID: <1309197059-7177-2-git-send-email-gitster@pobox.com>
References: <1309197059-7177-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 19:53:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbG04-00007z-5W
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 19:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab1F0Rw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 13:52:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab1F0RvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 13:51:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA469657A
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6wl8
	6RmkWe9NnGoCXFL/JZr4vjM=; b=vh/c1fisQZROooE+TbhgNEAMNx2QOTCBiDKk
	6dGSFs181tNNmvxbvisvcPtZI75GJHmB0SysU/U4htoe2KxoAiKnvAstZuit1qby
	A1Hv4VkJdBXfKY2ZEQzr1GBgAoTg0W15dXJiHRfOPd8XshphkuXxOh8PiV0Iv4JU
	NiRzDNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=E8MCz8
	keGHSMRJFKtKGGiuBKbfp7LsP4d9oeYEf2ccRzzTikpkQoPpnxLPiL+oHL12E3Yc
	aKLnzcEMIq8o/ZxoI0VtpShnsWrKg53FIg9/Offawm5uj/TW0TFbI4LDkUaV7drQ
	6WvU+cItNKmrxX7sbDxQViTnEc7ec1qyyn1mo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4DB16579
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CAB16578 for
 <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1309197059-7177-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 550789BA-A0E6-11E0-B861-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176355>

Any object that is directly reachable from refs, in the index or in the
cache tree, are obviously "used", and indeed all the existing callers of
mark_object_reachable() function sets this bit.  Move the assignment from
the callers to this function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c |   33 ++++++++-------------------------
 1 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 64f30d4..90f5c2c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -113,7 +113,10 @@ static int mark_object(struct object *obj, int type, void *data)
 
 static void mark_object_reachable(struct object *obj)
 {
-	mark_object(obj, OBJ_ANY, NULL);
+	if (obj) {
+		obj->used = 1;
+		mark_object(obj, OBJ_ANY, NULL);
+	}
 }
 
 static int traverse_one_object(struct object *obj)
@@ -435,24 +438,13 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct object *obj;
-
 	if (verbose)
 		fprintf(stderr, "Checking reflog %s->%s\n",
 			sha1_to_hex(osha1), sha1_to_hex(nsha1));
 
-	if (!is_null_sha1(osha1)) {
-		obj = lookup_object(osha1);
-		if (obj) {
-			obj->used = 1;
-			mark_object_reachable(obj);
-		}
-	}
-	obj = lookup_object(nsha1);
-	if (obj) {
-		obj->used = 1;
-		mark_object_reachable(obj);
-	}
+	if (!is_null_sha1(osha1))
+		mark_object_reachable(lookup_object(osha1));
+	mark_object_reachable(lookup_object(nsha1));
 	return 0;
 }
 
@@ -480,7 +472,6 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 	if (obj->type != OBJ_COMMIT && is_branch(refname))
 		error("%s: not a commit", refname);
 	default_refs++;
-	obj->used = 1;
 	mark_object_reachable(obj);
 
 	return 0;
@@ -568,7 +559,6 @@ static int fsck_cache_tree(struct cache_tree *it)
 			      sha1_to_hex(it->sha1));
 			return 1;
 		}
-		obj->used = 1;
 		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
@@ -647,12 +637,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		unsigned char sha1[20];
 		if (!get_sha1(arg, sha1)) {
 			struct object *obj = lookup_object(sha1);
-
-			/* Error is printed by lookup_object(). */
 			if (!obj)
 				continue;
-
-			obj->used = 1;
 			mark_object_reachable(obj);
 			heads++;
 			continue;
@@ -675,7 +661,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
-			struct object *obj;
 
 			mode = active_cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
@@ -683,9 +668,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			blob = lookup_blob(active_cache[i]->sha1);
 			if (!blob)
 				continue;
-			obj = &blob->object;
-			obj->used = 1;
-			mark_object_reachable(obj);
+			mark_object_reachable(&blob->object);
 		}
 		if (active_cache_tree)
 			fsck_cache_tree(active_cache_tree);
-- 
1.7.6
