From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-object: slightly more efficient
Date: Mon, 15 May 2006 13:47:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605151319580.18071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 19:49:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfhBp-0000xm-Bd
	for gcvg-git@gmane.org; Mon, 15 May 2006 19:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWEORrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 13:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEORrU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 13:47:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58502 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965015AbWEORrR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 13:47:17 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZB00JIGIQSM790@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 May 2006 13:47:16 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20071>

Avoid creating a delta index for objects with maximum depth since they 
are not going to be used as delta base anyway.  This also reduce peak 
memory usage slightly as the current object's delta index is not useful 
until the next object in the loop is considered for deltification. This 
saves a bit more than 1% on CPU usage.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/delta.h b/delta.h
index 727ae30..7b3f86d 100644
--- a/delta.h
+++ b/delta.h
@@ -18,6 +18,8 @@ create_delta_index(const void *buf, unsi
 
 /*
  * free_delta_index: free the index created by create_delta_index()
+ *
+ * Given pointer must be what create_delta_index() returned, or NULL.
  */
 extern void free_delta_index(struct delta_index *index);
 
diff --git a/pack-objects.c b/pack-objects.c
index b0388d7..9daf1c1 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1104,17 +1104,14 @@ static void find_deltas(struct object_en
 
 		if (entry->size < 50)
 			continue;
-		if (n->index)
-			free_delta_index(n->index);
+		free_delta_index(n->index);
+		n->index = NULL;
 		free(n->data);
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
 		if (size != entry->size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(entry->sha1), size, entry->size);
-		n->index = create_delta_index(n->data, size);
-		if (!n->index)
-			die("out of memory");
 
 		j = window;
 		while (--j > 0) {
@@ -1134,6 +1131,11 @@ static void find_deltas(struct object_en
 		 */
 		if (entry->delta && depth <= entry->depth)
 			continue;
+
+		n->index = create_delta_index(n->data, size);
+		if (!n->index)
+			die("out of memory");
+
 		idx++;
 		if (idx >= window)
 			idx = 0;
@@ -1143,8 +1145,7 @@ static void find_deltas(struct object_en
 		fputc('\n', stderr);
 
 	for (i = 0; i < window; ++i) {
-		if (array[i].index)
-			free_delta_index(array[i].index);
+		free_delta_index(array[i].index);
 		free(array[i].data);
 	}
 	free(array);
