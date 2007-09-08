From: David Kastrup <dak@gnu.org>
Subject: [PATCH] diff-delta.c: pack the index structure
Date: Sat, 08 Sep 2007 23:17:44 +0200
Organization: Organization?!?
Message-ID: <851wd8ua9z.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 23:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU7gj-000538-2Y
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 23:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbXIHVRv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 17:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbXIHVRv
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 17:17:51 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:44394 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752607AbXIHVRu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 17:17:50 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9CE8132EA8B
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 23:17:49 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 8BD4D2DAB45
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 23:17:49 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-082.pools.arcor-ip.net [84.61.20.82])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 619682351A4
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 23:17:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DD1ED1CAD71D; Sat,  8 Sep 2007 23:17:44 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4200/Sat Sep  8 21:00:15 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58138>

In normal use cases, the performance wins are not overly impressive:
we get something like 5-10% due to the slightly better locality of
memory accesses using the packed structure.

However, since the data structure for index entries saves 33% of
memory on 32-bit platforms and 40% on 64-bit platforms, the behavior
when memory gets limited should be nicer.

This is a rather well-contained change.  One obvious improvement would
be sorting the elements in one bucket according to their hash, then
using binary probing to find the elements with the right hash value.

As it stands, the output should be strictly the same as previously
unless one uses the option for limiting the amount of used memory, in
which case the created packs might be better.

Signed-off-by: David Kastrup <dak@gnu.org>
Acked-by: Nicolas Pitre <nico@cam.org>
---
 diff-delta.c |   74 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 0dde2f2..d355e5e 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -115,9 +115,13 @@ static const unsigned int U[256] = {
 struct index_entry {
 	const unsigned char *ptr;
 	unsigned int val;
-	struct index_entry *next;
 };
 
+struct unpacked_index_entry {
+	struct index_entry entry;
+	struct unpacked_index_entry *next;
+};	
+
 struct delta_index {
 	unsigned long memsize;
 	const void *src_buf;
@@ -131,7 +135,8 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
 	struct delta_index *index;
-	struct index_entry *entry, **hash;
+	struct unpacked_index_entry *entry, **hash;
+	struct index_entry *packed_entry, **packed_hash;
 	void *mem;
 	unsigned long memsize;
 
@@ -148,28 +153,21 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*index) +
-		  sizeof(*hash) * hsize +
+	memsize = sizeof(*hash) * hsize +
 		  sizeof(*entry) * entries;
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
-	index = mem;
-	mem = index + 1;
 	hash = mem;
 	mem = hash + hsize;
 	entry = mem;
 
-	index->memsize = memsize;
-	index->src_buf = buf;
-	index->src_size = bufsize;
-	index->hash_mask = hmask;
 	memset(hash, 0, hsize * sizeof(*hash));
 
 	/* allocate an array to count hash entries */
 	hash_count = calloc(hsize, sizeof(*hash_count));
 	if (!hash_count) {
-		free(index);
+		free(hash);
 		return NULL;
 	}
 
@@ -183,12 +181,13 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 			val = ((val << 8) | data[i]) ^ T[val >> RABIN_SHIFT];
 		if (val == prev_val) {
 			/* keep the lowest of consecutive identical blocks */
-			entry[-1].ptr = data + RABIN_WINDOW;
+			entry[-1].entry.ptr = data + RABIN_WINDOW;
+			--entries;
 		} else {
 			prev_val = val;
 			i = val & hmask;
-			entry->ptr = data + RABIN_WINDOW;
-			entry->val = val;
+			entry->entry.ptr = data + RABIN_WINDOW;
+			entry->entry.val = val;
 			entry->next = hash[i];
 			hash[i] = entry++;
 			hash_count[i]++;
@@ -212,16 +211,59 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 			continue;
 		entry = hash[i];
 		do {
-			struct index_entry *keep = entry;
+			struct unpacked_index_entry *keep = entry;
 			int skip = hash_count[i] / HASH_LIMIT;
 			do {
+				--entries;
 				entry = entry->next;
 			} while(--skip && entry);
+			++entries;
 			keep->next = entry;
 		} while(entry);
 	}
 	free(hash_count);
 
+	/* Now create the packed index in array form rather than
+	 * linked lists */
+
+	memsize = sizeof(*index)
+		+ sizeof(*packed_hash) * (hsize+1)
+		+ sizeof(*packed_entry) * entries;
+
+	mem = malloc(memsize);
+
+	if (!mem) {
+		free(hash);
+		return NULL;
+	}
+
+	index = mem;
+	index->memsize = memsize;
+	index->src_buf = buf;
+	index->src_size = bufsize;
+	index->hash_mask = hmask;
+
+	mem = index + 1;
+	packed_hash = mem;
+	mem = packed_hash + (hsize+1);
+	packed_entry = mem;
+
+	/* Coalesce all entries belonging to one linked list into
+	 * consecutive array entries */
+
+	for (i = 0; i < hsize; i++) {
+		packed_hash[i] = packed_entry;
+		for (entry = hash[i]; entry; entry = entry->next)
+			*packed_entry++ = entry->entry;
+	}
+
+	/* Sentinel value to indicate the length of the last hash
+	 * bucket */
+
+	packed_hash[hsize] = packed_entry;
+	assert(packed_entry - (struct index_entry *)mem == entries);
+	free(hash);
+
 	return index;
 }
 
@@ -302,7 +344,7 @@ create_delta(const struct delta_index *index,
 			val ^= U[data[-RABIN_WINDOW]];
 			val = ((val << 8) | *data) ^ T[val >> RABIN_SHIFT];
 			i = val & index->hash_mask;
-			for (entry = index->hash[i]; entry; entry = entry->next) {
+			for (entry = index->hash[i]; entry < index->hash[i+1]; entry++) {
 				const unsigned char *ref = entry->ptr;
 				const unsigned char *src = data;
 				unsigned int ref_size = ref_top - ref;
-- 
1.5.3.GIT
