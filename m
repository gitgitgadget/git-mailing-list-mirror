From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] localize window memory usage accounting
Date: Thu, 06 Sep 2007 02:13:09 -0400
Message-ID: <11890591923123-git-send-email-nico@cam.org>
References: <11890591912193-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAcC-0001tc-2s
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbXIFGNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbXIFGNP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:13:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43542 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbXIFGNN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:13:13 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNX00D3NNXZGQ30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 02:13:12 -0400 (EDT)
In-reply-to: <11890591912193-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.3.1.844.g0a05-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57825>

This is to help threadification of delta searching.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b1c64be..b8495bf 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -78,7 +78,6 @@ static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 0;
 static unsigned long cache_max_small_delta_size = 1000;
 
-static unsigned long window_memory_usage = 0;
 static unsigned long window_memory_limit = 0;
 
 /*
@@ -1300,7 +1299,7 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
  * one.
  */
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth)
+		     unsigned max_depth, unsigned long *mem_usage)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
@@ -1356,7 +1355,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
-		window_memory_usage += sz;
+		*mem_usage += sz;
 	}
 	if (!src->data) {
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
@@ -1366,7 +1365,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
-		window_memory_usage += sz;
+		*mem_usage += sz;
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
@@ -1376,7 +1375,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 				warning("suboptimal pack - out of memory");
 			return 0;
 		}
-		window_memory_usage += sizeof_delta_index(src->index);
+		*mem_usage += sizeof_delta_index(src->index);
 	}
 
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
@@ -1423,18 +1422,19 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
-static void free_unpacked(struct unpacked *n)
+static unsigned long free_unpacked(struct unpacked *n)
 {
-	window_memory_usage -= sizeof_delta_index(n->index);
+	unsigned long freed_mem = sizeof_delta_index(n->index);
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
+		freed_mem += n->entry->size;
 		free(n->data);
 		n->data = NULL;
-		window_memory_usage -= n->entry->size;
 	}
 	n->entry = NULL;
 	n->depth = 0;
+	return freed_mem;
 }
 
 static void find_deltas(struct object_entry **list, unsigned list_size,
@@ -1443,7 +1443,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 	uint32_t i = list_size, idx = 0, count = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
-	int max_depth;
+	unsigned long mem_usage = 0;
 
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
@@ -1453,16 +1453,16 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 	do {
 		struct object_entry *entry = list[--i];
 		struct unpacked *n = array + idx;
-		int j, best_base = -1;
+		int j, max_depth, best_base = -1;
 
-		free_unpacked(n);
+		mem_usage -= free_unpacked(n);
 		n->entry = entry;
 
 		while (window_memory_limit &&
-		       window_memory_usage > window_memory_limit &&
+		       mem_usage > window_memory_limit &&
 		       count > 1) {
 			uint32_t tail = (idx + window - count) % window;
-			free_unpacked(array + tail);
+			mem_usage -= free_unpacked(array + tail);
 			count--;
 		}
 
@@ -1497,7 +1497,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			ret = try_delta(n, m, max_depth);
+			ret = try_delta(n, m, max_depth, &mem_usage);
 			if (ret < 0)
 				break;
 			else if (ret > 0)
-- 
1.5.3.1.844.g0a05-dirty
