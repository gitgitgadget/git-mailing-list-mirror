From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix style of a few comments in diff-delta.c
Date: Tue, 18 Dec 2007 10:15:39 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712181012350.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:16:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4eB2-0005de-Ck
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602AbXLRPPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559AbXLRPPl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:15:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58386 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbXLRPPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:15:40 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT9007UG3Q3NU70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Dec 2007 10:15:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68759>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/diff-delta.c b/diff-delta.c
index 601b49e..a4e28df 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -212,11 +212,24 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 		if (hash_count[i] <= HASH_LIMIT)
 			continue;
 
-		entries -= hash_count[i] - HASH_LIMIT;
 		/* We leave exactly HASH_LIMIT entries in the bucket */
+		entries -= hash_count[i] - HASH_LIMIT;
 
 		entry = hash[i];
 		acc = 0;
+
+		/*
+		 * Assume that this loop is gone through exactly
+		 * HASH_LIMIT times and is entered and left with
+		 * acc==0.  So the first statement in the loop
+		 * contributes (hash_count[i]-HASH_LIMIT)*HASH_LIMIT
+		 * to the accumulator, and the inner loop consequently
+		 * is run (hash_count[i]-HASH_LIMIT) times, removing
+		 * one element from the list each time.  Since acc
+		 * balances out to 0 at the final run, the inner loop
+		 * body can't be left with entry==NULL.  So we indeed
+		 * encounter entry==NULL in the outer loop only.
+		 */
 		do {
 			acc += hash_count[i] - HASH_LIMIT;
 			if (acc > 0) {
@@ -229,30 +242,17 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 			}
 			entry = entry->next;
 		} while (entry);
-
-		/* Assume that this loop is gone through exactly
-		 * HASH_LIMIT times and is entered and left with
-		 * acc==0.  So the first statement in the loop
-		 * contributes (hash_count[i]-HASH_LIMIT)*HASH_LIMIT
-		 * to the accumulator, and the inner loop consequently
-		 * is run (hash_count[i]-HASH_LIMIT) times, removing
-		 * one element from the list each time.  Since acc
-		 * balances out to 0 at the final run, the inner loop
-		 * body can't be left with entry==NULL.  So we indeed
-		 * encounter entry==NULL in the outer loop only.
-		 */
 	}
 	free(hash_count);
 
-	/* Now create the packed index in array form rather than
-	 * linked lists */
-
+	/*
+	 * Now create the packed index in array form
+	 * rather than linked lists.
+	 */
 	memsize = sizeof(*index)
 		+ sizeof(*packed_hash) * (hsize+1)
 		+ sizeof(*packed_entry) * entries;
-
 	mem = malloc(memsize);
-
 	if (!mem) {
 		free(hash);
 		return NULL;
@@ -269,19 +269,19 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	mem = packed_hash + (hsize+1);
 	packed_entry = mem;
 
-	/* Coalesce all entries belonging to one linked list into
-	 * consecutive array entries */
-
 	for (i = 0; i < hsize; i++) {
+		/*
+		 * Coalesce all entries belonging to one linked list
+		 * into consecutive array entries.
+		 */
 		packed_hash[i] = packed_entry;
 		for (entry = hash[i]; entry; entry = entry->next)
 			*packed_entry++ = entry->entry;
 	}
 
-	/* Sentinel value to indicate the length of the last hash
-	 * bucket */
-
+	/* Sentinel value to indicate the length of the last hash bucket */
 	packed_hash[hsize] = packed_entry;
+
 	assert(packed_entry - (struct index_entry *)mem == entries);
 	free(hash);
 
