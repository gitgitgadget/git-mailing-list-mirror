From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] rearrange delta search progress reporting
Date: Thu, 06 Sep 2007 02:13:10 -0400
Message-ID: <11890591923270-git-send-email-nico@cam.org>
References: <11890591912193-git-send-email-nico@cam.org>
 <11890591923123-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAcC-0001tc-LC
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbXIFGNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXIFGNP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:13:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43542 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXIFGNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:13:14 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNX00D3NNXZGQ30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 02:13:13 -0400 (EDT)
In-reply-to: <11890591923123-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.3.1.844.g0a05-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57827>

This is to help threadification of the delta search code, with a bonus
consistency check.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b8495bf..9d56592 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1438,17 +1438,15 @@ static unsigned long free_unpacked(struct unpacked *n)
 }
 
 static void find_deltas(struct object_entry **list, unsigned list_size,
-			unsigned nr_deltas, int window, int depth)
+			int window, int depth, unsigned *processed)
 {
-	uint32_t i = list_size, idx = 0, count = 0, processed = 0;
+	uint32_t i = list_size, idx = 0, count = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
 	unsigned long mem_usage = 0;
 
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
-	if (progress)
-		start_progress(&progress_state, "Deltifying %u objects...", "", nr_deltas);
 
 	do {
 		struct object_entry *entry = list[--i];
@@ -1472,8 +1470,9 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 		if (entry->preferred_base)
 			goto next;
 
+		(*processed)++;
 		if (progress)
-			display_progress(&progress_state, ++processed);
+			display_progress(&progress_state, *processed);
 
 		/*
 		 * If the current object is at pack edge, take the depth the
@@ -1536,9 +1535,6 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 			idx = 0;
 	} while (i > 0);
 
-	if (progress)
-		stop_progress(&progress_state);
-
 	for (i = 0; i < window; ++i) {
 		free_delta_index(array[i].index);
 		free(array[i].data);
@@ -1581,8 +1577,17 @@ static void prepare_pack(int window, int depth)
 	}
 
 	if (nr_deltas) {
+		unsigned nr_done = 0;
+		if (progress)
+			start_progress(&progress_state,
+				       "Deltifying %u objects...", "",
+				       nr_deltas);
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
-		find_deltas(delta_list, n, nr_deltas, window+1, depth);
+		find_deltas(delta_list, n, window+1, depth, &nr_done);
+		if (progress)
+			stop_progress(&progress_state);
+		if (nr_done != nr_deltas)
+			die("inconsistency with delta count");
 	}
 	free(delta_list);
 }
-- 
1.5.3.1.844.g0a05-dirty
