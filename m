From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] index-pack: smarter memory usage during delta resolution
Date: Fri, 17 Oct 2008 15:57:58 -0400
Message-ID: <1224273478-18384-2-git-send-email-nico@cam.org>
References: <1224273478-18384-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 21:59:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqvUH-0002Wq-Al
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 21:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbYJQT6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbYJQT6n
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 15:58:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53877 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbYJQT6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 15:58:42 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8W0078JFGMEWZ1@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 17 Oct 2008 15:57:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.711.gf1ba4
In-reply-to: <1224273478-18384-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98493>

There is no need to keep the base object data around after its last delta
has been resolved.  This also means that long delta chains with only one
delta per base won't grow the cache size unnecessarily as the base will
be freed before recursing down.

To make it easy, find_delta_children() is modified so the first and last
indices are initialized in all cases.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |   73 +++++++++++++++++++++++++++++++---------------------------
 1 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 82843e7..9def641 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -221,17 +221,23 @@ static void bad_object(unsigned long offset, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
 
+static void free_base_data(struct base_data *c)
+{
+	if (c->data) {
+		free(c->data);
+		c->data = NULL;
+		base_cache_used -= c->size;
+	}
+}
+
 static void prune_base_data(struct base_data *retain)
 {
 	struct base_data *b = base_cache;
 	for (b = base_cache;
 	     base_cache_used > delta_base_cache_limit && b;
 	     b = b->child) {
-		if (b->data && b != retain) {
-			free(b->data);
-			b->data = NULL;
-			base_cache_used -= b->size;
-		}
+		if (b->data && b != retain)
+			free_base_data(b);
 	}
 }
 
@@ -256,10 +262,7 @@ static void unlink_base_data(struct base_data *c)
 		base->child = NULL;
 	else
 		base_cache = NULL;
-	if (c->data) {
-		free(c->data);
-		base_cache_used -= c->size;
-	}
+	free_base_data(c);
 }
 
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
@@ -409,22 +412,24 @@ static int find_delta(const union delta_base *base)
         return -first-1;
 }
 
-static int find_delta_children(const union delta_base *base,
-			       int *first_index, int *last_index)
+static void find_delta_children(const union delta_base *base,
+				int *first_index, int *last_index)
 {
 	int first = find_delta(base);
 	int last = first;
 	int end = nr_deltas - 1;
 
-	if (first < 0)
-		return -1;
+	if (first < 0) {
+		*first_index = 0;
+		*last_index = -1;
+		return;
+	}
 	while (first > 0 && !memcmp(&deltas[first - 1].base, base, UNION_BASE_SZ))
 		--first;
 	while (last < end && !memcmp(&deltas[last + 1].base, base, UNION_BASE_SZ))
 		++last;
 	*first_index = first;
 	*last_index = last;
-	return 0;
 }
 
 static void sha1_object(const void *data, unsigned long size,
@@ -529,7 +534,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 static void find_unresolved_deltas(struct base_data *base,
 				   struct base_data *prev_base)
 {
-	int i, ref, ref_first, ref_last, ofs, ofs_first, ofs_last;
+	int i, ref_first, ref_last, ofs_first, ofs_last;
 
 	/*
 	 * This is a recursive function. Those brackets should help reducing
@@ -539,37 +544,37 @@ static void find_unresolved_deltas(struct base_data *base,
 		union delta_base base_spec;
 
 		hashcpy(base_spec.sha1, base->obj->idx.sha1);
-		ref = !find_delta_children(&base_spec, &ref_first, &ref_last);
+		find_delta_children(&base_spec, &ref_first, &ref_last);
 
 		memset(&base_spec, 0, sizeof(base_spec));
 		base_spec.offset = base->obj->idx.offset;
-		ofs = !find_delta_children(&base_spec, &ofs_first, &ofs_last);
+		find_delta_children(&base_spec, &ofs_first, &ofs_last);
 	}
 
-	if (!ref && !ofs)
+	if (ref_last == -1 && ofs_last == -1)
 		return;
 
 	link_base_data(prev_base, base);
 
-	if (ref) {
-		for (i = ref_first; i <= ref_last; i++) {
-			struct object_entry *child = objects + deltas[i].obj_no;
-			if (child->real_type == OBJ_REF_DELTA) {
-				struct base_data result;
-				resolve_delta(child, base, &result);
-				find_unresolved_deltas(&result, base);
-			}
+	for (i = ref_first; i <= ref_last; i++) {
+		struct object_entry *child = objects + deltas[i].obj_no;
+		if (child->real_type == OBJ_REF_DELTA) {
+			struct base_data result;
+			resolve_delta(child, base, &result);
+			if (i == ref_last && ofs_last == -1)
+				free_base_data(base);
+			find_unresolved_deltas(&result, base);
 		}
 	}
 
-	if (ofs) {
-		for (i = ofs_first; i <= ofs_last; i++) {
-			struct object_entry *child = objects + deltas[i].obj_no;
-			if (child->real_type == OBJ_OFS_DELTA) {
-				struct base_data result;
-				resolve_delta(child, base, &result);
-				find_unresolved_deltas(&result, base);
-			}
+	for (i = ofs_first; i <= ofs_last; i++) {
+		struct object_entry *child = objects + deltas[i].obj_no;
+		if (child->real_type == OBJ_OFS_DELTA) {
+			struct base_data result;
+			resolve_delta(child, base, &result);
+			if (i == ofs_last)
+				free_base_data(base);
+			find_unresolved_deltas(&result, base);
 		}
 	}
 
-- 
1.6.0.2.711.gf1ba4
