From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2] index-pack: rationalize delta resolution code
Date: Fri, 17 Oct 2008 15:57:57 -0400
Message-ID: <1224273478-18384-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 21:59:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqvUG-0002Wq-A1
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 21:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbYJQT6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbYJQT6i
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 15:58:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53877 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbYJQT6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 15:58:37 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8W0078JFGMEWZ1@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 17 Oct 2008 15:57:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.711.gf1ba4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98492>

Instead of having strange loops for walking unresolved deltas with the
same base duplicated in many places, let's rework the code so this is
done in a single place instead.  This simplifies callers quite a bit too.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |  123 +++++++++++++++++++++++++++------------------------------
 1 files changed, 58 insertions(+), 65 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index d3a4d31..82843e7 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -244,7 +244,8 @@ static void link_base_data(struct base_data *base, struct base_data *c)
 
 	c->base = base;
 	c->child = NULL;
-	base_cache_used += c->size;
+	if (c->data)
+		base_cache_used += c->size;
 	prune_base_data(c);
 }
 
@@ -494,8 +495,10 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, "failed to apply delta");
-		} else
+		} else {
 			c->data = get_data_from_pack(obj);
+			c->size = obj->size;
+		}
 
 		base_cache_used += c->size;
 		prune_base_data(c);
@@ -504,49 +507,73 @@ static void *get_base_data(struct base_data *c)
 }
 
 static void resolve_delta(struct object_entry *delta_obj,
-			  struct base_data *base_obj, enum object_type type)
+			  struct base_data *base, struct base_data *result)
 {
 	void *delta_data;
 	unsigned long delta_size;
-	union delta_base delta_base;
-	int j, first, last;
-	struct base_data result;
 
-	delta_obj->real_type = type;
+	delta_obj->real_type = base->obj->type;
 	delta_data = get_data_from_pack(delta_obj);
 	delta_size = delta_obj->size;
-	result.data = patch_delta(get_base_data(base_obj), base_obj->size,
-			     delta_data, delta_size,
-			     &result.size);
+	result->obj = delta_obj;
+	result->data = patch_delta(get_base_data(base), base->obj->size,
+				   delta_data, delta_size, &result->size);
 	free(delta_data);
-	if (!result.data)
+	if (!result->data)
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
-	sha1_object(result.data, result.size, type, delta_obj->idx.sha1);
+	sha1_object(result->data, result->size, delta_obj->real_type,
+		    delta_obj->idx.sha1);
 	nr_resolved_deltas++;
+}
+
+static void find_unresolved_deltas(struct base_data *base,
+				   struct base_data *prev_base)
+{
+	int i, ref, ref_first, ref_last, ofs, ofs_first, ofs_last;
+
+	/*
+	 * This is a recursive function. Those brackets should help reducing
+	 * stack usage by limiting the scope of the delta_base union.
+	 */
+	{
+		union delta_base base_spec;
+
+		hashcpy(base_spec.sha1, base->obj->idx.sha1);
+		ref = !find_delta_children(&base_spec, &ref_first, &ref_last);
+
+		memset(&base_spec, 0, sizeof(base_spec));
+		base_spec.offset = base->obj->idx.offset;
+		ofs = !find_delta_children(&base_spec, &ofs_first, &ofs_last);
+	}
+
+	if (!ref && !ofs)
+		return;
 
-	result.obj = delta_obj;
-	link_base_data(base_obj, &result);
+	link_base_data(prev_base, base);
 
-	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
-	if (!find_delta_children(&delta_base, &first, &last)) {
-		for (j = first; j <= last; j++) {
-			struct object_entry *child = objects + deltas[j].obj_no;
-			if (child->real_type == OBJ_REF_DELTA)
-				resolve_delta(child, &result, type);
+	if (ref) {
+		for (i = ref_first; i <= ref_last; i++) {
+			struct object_entry *child = objects + deltas[i].obj_no;
+			if (child->real_type == OBJ_REF_DELTA) {
+				struct base_data result;
+				resolve_delta(child, base, &result);
+				find_unresolved_deltas(&result, base);
+			}
 		}
 	}
 
-	memset(&delta_base, 0, sizeof(delta_base));
-	delta_base.offset = delta_obj->idx.offset;
-	if (!find_delta_children(&delta_base, &first, &last)) {
-		for (j = first; j <= last; j++) {
-			struct object_entry *child = objects + deltas[j].obj_no;
-			if (child->real_type == OBJ_OFS_DELTA)
-				resolve_delta(child, &result, type);
+	if (ofs) {
+		for (i = ofs_first; i <= ofs_last; i++) {
+			struct object_entry *child = objects + deltas[i].obj_no;
+			if (child->real_type == OBJ_OFS_DELTA) {
+				struct base_data result;
+				resolve_delta(child, base, &result);
+				find_unresolved_deltas(&result, base);
+			}
 		}
 	}
 
-	unlink_base_data(&result);
+	unlink_base_data(base);
 }
 
 static int compare_delta_entry(const void *a, const void *b)
@@ -622,37 +649,13 @@ static void parse_pack_objects(unsigned char *sha1)
 		progress = start_progress("Resolving deltas", nr_deltas);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
-		union delta_base base;
-		int j, ref, ref_first, ref_last, ofs, ofs_first, ofs_last;
 		struct base_data base_obj;
 
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
 			continue;
-		hashcpy(base.sha1, obj->idx.sha1);
-		ref = !find_delta_children(&base, &ref_first, &ref_last);
-		memset(&base, 0, sizeof(base));
-		base.offset = obj->idx.offset;
-		ofs = !find_delta_children(&base, &ofs_first, &ofs_last);
-		if (!ref && !ofs)
-			continue;
-		base_obj.data = get_data_from_pack(obj);
-		base_obj.size = obj->size;
 		base_obj.obj = obj;
-		link_base_data(NULL, &base_obj);
-
-		if (ref)
-			for (j = ref_first; j <= ref_last; j++) {
-				struct object_entry *child = objects + deltas[j].obj_no;
-				if (child->real_type == OBJ_REF_DELTA)
-					resolve_delta(child, &base_obj, obj->type);
-			}
-		if (ofs)
-			for (j = ofs_first; j <= ofs_last; j++) {
-				struct object_entry *child = objects + deltas[j].obj_no;
-				if (child->real_type == OBJ_OFS_DELTA)
-					resolve_delta(child, &base_obj, obj->type);
-			}
-		unlink_base_data(&base_obj);
+		base_obj.data = NULL;
+		find_unresolved_deltas(&base_obj, NULL);
 		display_progress(progress, nr_resolved_deltas);
 	}
 }
@@ -745,7 +748,6 @@ static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolved)
 	for (i = 0; i < n; i++) {
 		struct delta_entry *d = sorted_by_pos[i];
 		enum object_type type;
-		int j, first, last;
 		struct base_data base_obj;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
@@ -759,16 +761,7 @@ static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolved)
 			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
 		base_obj.obj = append_obj_to_pack(f, d->base.sha1,
 					base_obj.data, base_obj.size, type);
-		link_base_data(NULL, &base_obj);
-
-		find_delta_children(&d->base, &first, &last);
-		for (j = first; j <= last; j++) {
-			struct object_entry *child = objects + deltas[j].obj_no;
-			if (child->real_type == OBJ_REF_DELTA)
-				resolve_delta(child, &base_obj, type);
-		}
-
-		unlink_base_data(&base_obj);
+		find_unresolved_deltas(&base_obj, NULL);
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-- 
1.6.0.2.711.gf1ba4
