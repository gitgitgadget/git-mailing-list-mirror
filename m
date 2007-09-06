From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] straighten the list of objects to deltify
Date: Thu, 06 Sep 2007 02:13:08 -0400
Message-ID: <11890591912193-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAcB-0001tc-G4
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbXIFGNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbXIFGNO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:13:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43542 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXIFGNN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:13:13 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNX00D3NNXZGQ30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 02:13:12 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.844.g0a05-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57826>

Not all objects are subject to deltification, so avoid carrying those
along, and provide the real count to progress display.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   77 ++++++++++++++++++++++++++----------------------
 1 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e64e3a0..b1c64be 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1313,12 +1313,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (trg_entry->type != src_entry->type)
 		return -1;
 
-	/* We do not compute delta to *create* objects we are not
-	 * going to pack.
-	 */
-	if (trg_entry->preferred_base)
-		return -1;
-
 	/*
 	 * We do not bother to try a delta that we discarded
 	 * on an earlier try, but only when reusing delta data.
@@ -1443,43 +1437,24 @@ static void free_unpacked(struct unpacked *n)
 	n->depth = 0;
 }
 
-static void find_deltas(struct object_entry **list, int window, int depth)
+static void find_deltas(struct object_entry **list, unsigned list_size,
+			unsigned nr_deltas, int window, int depth)
 {
-	uint32_t i = nr_objects, idx = 0, count = 0, processed = 0;
+	uint32_t i = list_size, idx = 0, count = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
 	int max_depth;
 
-	if (!nr_objects)
-		return;
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
 	if (progress)
-		start_progress(&progress_state, "Deltifying %u objects...", "", nr_result);
+		start_progress(&progress_state, "Deltifying %u objects...", "", nr_deltas);
 
 	do {
 		struct object_entry *entry = list[--i];
 		struct unpacked *n = array + idx;
 		int j, best_base = -1;
 
-		if (!entry->preferred_base)
-			processed++;
-
-		if (progress)
-			display_progress(&progress_state, processed);
-
-		if (entry->delta)
-			/* This happens if we decided to reuse existing
-			 * delta from a pack.  "!no_reuse_delta &&" is implied.
-			 */
-			continue;
-
-		if (entry->size < 50)
-			continue;
-
-		if (entry->no_try_delta)
-			continue;
-
 		free_unpacked(n);
 		n->entry = entry;
 
@@ -1491,6 +1466,15 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 			count--;
 		}
 
+		/* We do not compute delta to *create* objects we are not
+		 * going to pack.
+		 */
+		if (entry->preferred_base)
+			goto next;
+
+		if (progress)
+			display_progress(&progress_state, ++processed);
+
 		/*
 		 * If the current object is at pack edge, take the depth the
 		 * objects that depend on the current object into account
@@ -1565,18 +1549,41 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
-	uint32_t i;
+	uint32_t i, n, nr_deltas;
 
 	get_object_details();
 
-	if (!window || !depth)
+	if (!nr_objects || !window || !depth)
 		return;
 
 	delta_list = xmalloc(nr_objects * sizeof(*delta_list));
-	for (i = 0; i < nr_objects; i++)
-		delta_list[i] = objects + i;
-	qsort(delta_list, nr_objects, sizeof(*delta_list), type_size_sort);
-	find_deltas(delta_list, window+1, depth);
+	nr_deltas = n = 0;
+
+	for (i = 0; i < nr_objects; i++) {
+		struct object_entry *entry = objects + i;
+
+		if (entry->delta)
+			/* This happens if we decided to reuse existing
+			 * delta from a pack.  "!no_reuse_delta &&" is implied.
+			 */
+			continue;
+
+		if (entry->size < 50)
+			continue;
+
+		if (entry->no_try_delta)
+			continue;
+
+		if (!entry->preferred_base)
+			nr_deltas++;
+
+		delta_list[n++] = entry;
+	}
+
+	if (nr_deltas) {
+		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
+		find_deltas(delta_list, n, nr_deltas, window+1, depth);
+	}
 	free(delta_list);
 }
 
-- 
1.5.3.1.844.g0a05-dirty
