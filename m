From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improve diff-delta with sparse and/or repetitive data
Date: Tue, 02 May 2006 23:31:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605022226070.28543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 05:31:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb84x-0003Zh-Cl
	for gcvg-git@gmane.org; Wed, 03 May 2006 05:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWECDbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 23:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWECDbD
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 23:31:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48708 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965080AbWECDbC
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 May 2006 23:31:02 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYO00FYN73OXQ90@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 May 2006 23:31:01 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19452>

It is useless to preserve multiple hash entries for consecutive blocks 
with the same hash.  Keeping only the first one will allow for matching 
the longest string of identical bytes while subsequent blocks will only 
allow for shorter matches.  The backward matching code will match the 
end of it as necessary.

This improves both performances (no repeated string compare with long 
successions of identical bytes, or even small group of bytes), as well 
as compression (less likely to need random hash bucket entry culling), 
especially with sparse files.

With well behaved data sets this patch doesn't change much.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/diff-delta.c b/diff-delta.c
index 35e517d..c618875 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -136,11 +136,12 @@ struct delta_index {
 
 struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 {
-	unsigned int i, hsize, hmask, entries, *hash_count;
+	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
 	struct delta_index *index;
 	struct index_entry *entry, **hash;
 	void *mem;
+	unsigned long memsize;
 
 	if (!buf || !bufsize)
 		return NULL;
@@ -155,9 +156,10 @@ struct delta_index * create_delta_index(
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	mem = malloc(sizeof(*index) +
-		     sizeof(*hash) * hsize +
-		     sizeof(*entry) * entries);
+	memsize = sizeof(*index) +
+		  sizeof(*hash) * hsize +
+		  sizeof(*entry) * entries;
+	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
 	index = mem;
@@ -179,18 +181,26 @@ struct delta_index * create_delta_index(
 	}
 
 	/* then populate the index */
-	data = buffer + entries * RABIN_WINDOW - RABIN_WINDOW;
-	while (data >= buffer) {
+	prev_val = ~0;
+	for (data = buffer + entries * RABIN_WINDOW - RABIN_WINDOW;
+	     data >= buffer;
+	     data -= RABIN_WINDOW) {
 		unsigned int val = 0;
 		for (i = 1; i <= RABIN_WINDOW; i++)
 			val = ((val << 8) | data[i]) ^ T[val >> RABIN_SHIFT];
-		i = val & hmask;
-		entry->ptr = data + RABIN_WINDOW;
-		entry->val = val;
-		entry->next = hash[i];
-		hash[i] = entry++;
-		hash_count[i]++;
-		data -= RABIN_WINDOW;
+		if (val == prev_val) {
+			/* keep the lowest of consecutive identical blocks */
+			entry[-1].ptr = data + RABIN_WINDOW;
+		} else {
+			prev_val = val;
+			i = val & hmask;
+			entry->ptr = data + RABIN_WINDOW;
+			entry->val = val;
+			entry->next = hash[i];
+			hash[i] = entry++;
+			hash_count[i]++;
+			entries--;
+		}
 	}
 
 	/*
@@ -220,6 +230,10 @@ struct delta_index * create_delta_index(
 	}
 	free(hash_count);
 
+	/* If we didn't use all hash entries, free the unused memory. */
+	if (entries)
+		index = realloc(index, memsize - entries * sizeof(*entry));
+
 	return index;
 }
 
