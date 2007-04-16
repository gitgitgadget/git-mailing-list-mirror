From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/9] pack-objects: clean up list sorting
Date: Mon, 16 Apr 2007 12:14:52 -0400 (EDT)
Message-ID: <S1030818AbXDPQO4/20070416161458Z+64@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 16 18:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTrS-0002jZ-To
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030820AbXDPQO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030818AbXDPQO4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:14:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39242 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030812AbXDPQOy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:14:54 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL0004IMGSOKS0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:14:52 -0400 (EDT)
Date-warning: Date header was inserted by VL-MH-MR001.ip.videotron.ca
Apparently-To: <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44659>

Get rid of sort_comparator() as it impose a run time double indirect
function call for little compile time type checking gain.

Also get rid of create_sorted_list() as it only has one user which would
as well be just fine doing its sorting locally.  Eventually the list of
deltifiable objects might be shorter than the whole object list.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   53 +++++++++++++++++++----------------------------
 1 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d44b8f4..15119d6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -66,7 +66,7 @@ static int local;
 static int incremental;
 static int allow_ofs_delta;
 
-static struct object_entry **sorted_by_sha, **sorted_by_type;
+static struct object_entry **sorted_by_sha;
 static struct object_entry *objects;
 static uint32_t nr_objects, nr_alloc, nr_result;
 static const char *base_name;
@@ -1181,31 +1181,10 @@ static void get_object_details(void)
 		check_object(entry);
 }
 
-typedef int (*entry_sort_t)(const struct object_entry *, const struct object_entry *);
-
-static entry_sort_t current_sort;
-
-static int sort_comparator(const void *_a, const void *_b)
-{
-	struct object_entry *a = *(struct object_entry **)_a;
-	struct object_entry *b = *(struct object_entry **)_b;
-	return current_sort(a,b);
-}
-
-static struct object_entry **create_sorted_list(entry_sort_t sort)
-{
-	struct object_entry **list = xmalloc(nr_objects * sizeof(struct object_entry *));
-	uint32_t i;
-
-	for (i = 0; i < nr_objects; i++)
-		list[i] = objects + i;
-	current_sort = sort;
-	qsort(list, nr_objects, sizeof(struct object_entry *), sort_comparator);
-	return list;
-}
-
-static int sha1_sort(const struct object_entry *a, const struct object_entry *b)
+static int sha1_sort(const void *_a, const void *_b)
 {
+	const struct object_entry *a = *(struct object_entry **)_a;
+	const struct object_entry *b = *(struct object_entry **)_b;
 	return hashcmp(a->sha1, b->sha1);
 }
 
@@ -1222,13 +1201,15 @@ static struct object_entry **create_final_object_list(void)
 		if (!objects[i].preferred_base)
 			list[j++] = objects + i;
 	}
-	current_sort = sha1_sort;
-	qsort(list, nr_result, sizeof(struct object_entry *), sort_comparator);
+	qsort(list, nr_result, sizeof(struct object_entry *), sha1_sort);
 	return list;
 }
 
-static int type_size_sort(const struct object_entry *a, const struct object_entry *b)
+static int type_size_sort(const void *_a, const void *_b)
 {
+	const struct object_entry *a = *(struct object_entry **)_a;
+	const struct object_entry *b = *(struct object_entry **)_b;
+
 	if (a->type < b->type)
 		return -1;
 	if (a->type > b->type)
@@ -1448,10 +1429,20 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 
 static void prepare_pack(int window, int depth)
 {
+	struct object_entry **delta_list;
+	uint32_t i;
+
 	get_object_details();
-	sorted_by_type = create_sorted_list(type_size_sort);
-	if (window && depth)
-		find_deltas(sorted_by_type, window+1, depth);
+
+	if (!window || !depth)
+		return;
+
+	delta_list = xmalloc(nr_objects * sizeof(*delta_list));
+	for (i = 0; i < nr_objects; i++)
+		delta_list[i] = objects + i;
+	qsort(delta_list, nr_objects, sizeof(*delta_list), type_size_sort);
+	find_deltas(delta_list, window+1, depth);
+	free(delta_list);
 }
 
 static int reuse_cached_pack(unsigned char *sha1)
-- 
1.5.1.1.781.g65e8
