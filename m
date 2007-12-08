From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2] pack-objects: reverse the delta search sort list
Date: Sat, 08 Dec 2007 00:00:08 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712072357050.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 06:00:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0rnz-0006F1-92
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 06:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXLHFAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 00:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXLHFAM
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 00:00:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30769 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbXLHFAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 00:00:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP00GVUSK8VC70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Dec 2007 00:00:09 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67511>


It is currently sorted and then walked backward.  Not only this doesn't
feel natural for my poor brain, but it would make the next patch less
obvious as well.

So reverse the sort order, and reverse the list walking direction,
which effectively produce the exact same end result as before.

Also bring the relevant comment nearer the actual code and adjust it
accordingly, with minor additional clarifications.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4f44658..5002cc6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1245,28 +1245,37 @@ static void get_object_details(void)
 	free(sorted_by_offset);
 }
 
+/*
+ * We search for deltas in a list sorted by type, by filename hash, and then
+ * by size, so that we see progressively smaller and smaller files.
+ * That's because we prefer deltas to be from the bigger file
+ * to the smaller -- deletes are potentially cheaper, but perhaps
+ * more importantly, the bigger file is likely the more recent
+ * one.  The deepest deltas are therefore the oldest objects which are
+ * less susceptible to be accessed often.
+ */
 static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
 
-	if (a->type < b->type)
-		return -1;
 	if (a->type > b->type)
-		return 1;
-	if (a->hash < b->hash)
 		return -1;
-	if (a->hash > b->hash)
+	if (a->type < b->type)
 		return 1;
-	if (a->preferred_base < b->preferred_base)
+	if (a->hash > b->hash)
 		return -1;
-	if (a->preferred_base > b->preferred_base)
+	if (a->hash < b->hash)
 		return 1;
-	if (a->size < b->size)
+	if (a->preferred_base > b->preferred_base)
 		return -1;
+	if (a->preferred_base < b->preferred_base)
+		return 1;
 	if (a->size > b->size)
+		return -1;
+	if (a->size < b->size)
 		return 1;
-	return a > b ? -1 : (a < b);  /* newest last */
+	return a < b ? -1 : (a > b);  /* newest first */
 }
 
 struct unpacked {
@@ -1317,14 +1326,6 @@ static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 #endif
 
-/*
- * We search for deltas _backwards_ in a list sorted by type and
- * by size, so that we see progressively smaller and smaller files.
- * That's because we prefer deltas to be from the bigger file
- * to the smaller - deletes are potentially cheaper, but perhaps
- * more importantly, the bigger file is likely the more recent
- * one.
- */
 static int try_delta(struct unpacked *trg, struct unpacked *src,
 		     unsigned max_depth, unsigned long *mem_usage)
 {
@@ -1481,7 +1482,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 static void find_deltas(struct object_entry **list, unsigned list_size,
 			int window, int depth, unsigned *processed)
 {
-	uint32_t i = list_size, idx = 0, count = 0;
+	uint32_t i = 0, idx = 0, count = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
 	unsigned long mem_usage = 0;
@@ -1490,7 +1491,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 	memset(array, 0, array_size);
 
 	do {
-		struct object_entry *entry = list[--i];
+		struct object_entry *entry = list[i++];
 		struct unpacked *n = array + idx;
 		int j, max_depth, best_base = -1;
 
@@ -1575,7 +1576,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 			count++;
 		if (idx >= window)
 			idx = 0;
-	} while (i > 0);
+	} while (i < list_size);
 
 	for (i = 0; i < window; ++i) {
 		free_delta_index(array[i].index);
-- 
1.5.3.7.2184.ge321d-dirty
