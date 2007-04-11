From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] clean up add_object_entry()
Date: Tue, 10 Apr 2007 22:54:36 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704102248270.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 09:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbSz8-0001KT-DQ
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 04:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbXDKCyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 22:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966059AbXDKCyl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 22:54:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18781 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964974AbXDKCyl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 22:54:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGB00HLOC33L4B0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Apr 2007 22:54:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44203>

This function used to call locate_object_entry_hash() _twice_ per added 
object while only once should suffice. Let's reorganize that code a bit.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 687b4b5..bc5f232 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -781,12 +781,19 @@ static unsigned name_hash(const char *name)
 
 static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclude)
 {
-	uint32_t idx = nr_objects;
 	struct object_entry *entry;
-	struct packed_git *p;
+	struct packed_git *p, *found_pack = NULL;
 	off_t found_offset = 0;
-	struct packed_git *found_pack = NULL;
-	int ix, status = 0;
+	int ix;
+
+	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
+	if (ix >= 0) {
+		if (exclude) {
+			entry = objects + object_ix[ix] - 1;
+			entry->preferred_base = 1;
+		}
+		return 0;
+	}
 
 	if (!exclude) {
 		for (p = packed_git; p; p = p->next) {
@@ -803,43 +810,34 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 			}
 		}
 	}
-	if ((entry = locate_object_entry(sha1)) != NULL)
-		goto already_added;
 
-	if (idx >= nr_alloc) {
-		nr_alloc = (idx + 1024) * 3 / 2;
+	if (nr_objects >= nr_alloc) {
+		nr_alloc = (nr_alloc  + 1024) * 3 / 2;
 		objects = xrealloc(objects, nr_alloc * sizeof(*entry));
 	}
-	entry = objects + idx;
-	nr_objects = idx + 1;
+
+	entry = objects + nr_objects++;
 	memset(entry, 0, sizeof(*entry));
 	hashcpy(entry->sha1, sha1);
 	entry->hash = hash;
+	if (exclude)
+		entry->preferred_base = 1;
+	if (found_pack) {
+		entry->in_pack = found_pack;
+		entry->in_pack_offset = found_offset;
+	}
 
 	if (object_ix_hashsz * 3 <= nr_objects * 4)
 		rehash_objects();
-	else {
-		ix = locate_object_entry_hash(entry->sha1);
-		if (0 <= ix)
-			die("internal error in object hashing.");
-		object_ix[-1 - ix] = idx + 1;
-	}
-	status = 1;
+	else
+		object_ix[-1 - ix] = nr_objects;
 
- already_added:
 	if (progress_update) {
 		fprintf(stderr, "Counting objects...%u\r", nr_objects);
 		progress_update = 0;
 	}
-	if (exclude)
-		entry->preferred_base = 1;
-	else {
-		if (found_pack) {
-			entry->in_pack = found_pack;
-			entry->in_pack_offset = found_offset;
-		}
-	}
-	return status;
+
+	return 1;
 }
 
 struct pbase_tree_cache {
