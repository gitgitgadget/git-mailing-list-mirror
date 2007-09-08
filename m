From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] diff-delta.c: pack the index structure
Date: Sat, 08 Sep 2007 22:50:20 +0200
Message-ID: <85hcm4ubjn.fsf@lola.goethe.zz>
References: <85fy1q11xv.fsf@lola.goethe.zz>
	<alpine.LFD.0.9999.0709072215420.21186@xanadu.home>
	<854pi5zh8q.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 22:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU7GI-0007VT-IT
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 22:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbXIHUub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 16:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXIHUub
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 16:50:31 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:49395 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752073AbXIHUua (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 16:50:30 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id F3EF1183AF7;
	Sat,  8 Sep 2007 22:50:28 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id CFD0828EE19;
	Sat,  8 Sep 2007 22:50:28 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-082.pools.arcor-ip.net [84.61.20.82])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 7D11735E73F;
	Sat,  8 Sep 2007 22:50:20 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 106B21CAD71D; Sat,  8 Sep 2007 22:50:20 +0200 (CEST)
In-Reply-To: <854pi5zh8q.fsf@lola.goethe.zz> (David Kastrup's message of "Sat\, 08 Sep 2007 10\:36\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4200/Sat Sep  8 21:00:15 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58135>

--=-=-=

David Kastrup <dak@gnu.org> writes:

> Another option avoiding the realloc would be not to use linked lists
> at all but just collect all entries sequentually in "packed" form,
> and sort them into order afterwards.  That's an O(n lg n) operation
> with a large n.  Even if one has a sorting algorithm with good
> memory locality, I doubt that the locality would compensate for the
> lg n factor, even when taking into account that we save ourselves
> the copying.  And that is not even taken the possibility of having
> to cull some buckets into account, another O(n) operation (which
> amounts to copying everything once, too).

As an illustration, I have implemented a proof-of-concept.  This is a
patch (not formatted for submission) against the current master.  It
takes about a 20% performance hit on the whole git-pack-objects run,
so the diffing code itself is likely affected worse.  For the
proof-of-concept I did not do the hash bucket collision culling, nor
did I realloc to the possibly reduced size.  So a fairer comparison
would likely involve removing the culling code from master (or
implementing the culling in the proof-of-concept, but I am too lazy
for that).

I hope this addresses the not-in-place complaint.  It is conceivable
that under tight memory conditions, this approach might actually work
out better.  However, the glibc qsort implementation (at least it did
so at one time) reverts to a mergesort for large numbers, and
allocates a temporary buffer of the same size as the original data.
If that is still the case, the memory impact would actually be worse
here.  One would need to implement a custom _real_ in place sorter to
get around this.  All in all, I don't think this approach is worth the
trouble: the sorting overhead factor of lg n is just too much.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment

diff --git a/diff-delta.c b/diff-delta.c
index 0dde2f2..f6e2416 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -115,7 +115,6 @@ static const unsigned int U[256] = {
 struct index_entry {
 	const unsigned char *ptr;
 	unsigned int val;
-	struct index_entry *next;
 };
 
 struct delta_index {
@@ -126,12 +125,24 @@ struct delta_index {
 	struct index_entry *hash[FLEX_ARRAY];
 };
 
+static unsigned int cmp_hmask;
+
+static int cmp_index_entry(const void *va, const void *vb)
+{
+	const struct index_entry *a = va, *b = vb;
+	if ((a->val & cmp_hmask) != (b->val & cmp_hmask))
+		return (a->val & cmp_hmask) < (b->val & cmp_hmask) ? -1 : 1;
+	if (a->val != b->val)
+		return a->val < b->val ? -1 : 1;
+	return a->ptr < b->ptr ? -1 : 1;
+}
+
 struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 {
-	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
+	unsigned int i, hsize, hmask, entries, prev_val, ihash;
 	const unsigned char *data, *buffer = buf;
 	struct delta_index *index;
-	struct index_entry *entry, **hash;
+	struct index_entry *entry, **hash, *entry_base;
 	void *mem;
 	unsigned long memsize;
 
@@ -149,7 +160,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 
 	/* allocate lookup index */
 	memsize = sizeof(*index) +
-		  sizeof(*hash) * hsize +
+		  sizeof(*hash) * (hsize + 1) +
 		  sizeof(*entry) * entries;
 	mem = malloc(memsize);
 	if (!mem)
@@ -157,21 +168,14 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	index = mem;
 	mem = index + 1;
 	hash = mem;
-	mem = hash + hsize;
-	entry = mem;
+	mem = hash + hsize + 1;
+	entry_base = mem;
+	entry = entry_base;
 
 	index->memsize = memsize;
 	index->src_buf = buf;
 	index->src_size = bufsize;
 	index->hash_mask = hmask;
-	memset(hash, 0, hsize * sizeof(*hash));
-
-	/* allocate an array to count hash entries */
-	hash_count = calloc(hsize, sizeof(*hash_count));
-	if (!hash_count) {
-		free(index);
-		return NULL;
-	}
 
 	/* then populate the index */
 	prev_val = ~0;
@@ -184,29 +188,33 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 		if (val == prev_val) {
 			/* keep the lowest of consecutive identical blocks */
 			entry[-1].ptr = data + RABIN_WINDOW;
+			--entries;
 		} else {
 			prev_val = val;
 			i = val & hmask;
 			entry->ptr = data + RABIN_WINDOW;
 			entry->val = val;
-			entry->next = hash[i];
-			hash[i] = entry++;
-			hash_count[i]++;
+			entry++;
 		}
 	}
+	cmp_hmask = hmask;
+	qsort(entry_base, entries, sizeof(struct index_entry), cmp_index_entry);
+	ihash = 0;
+	
+	for (i=0; i<entries; i++) {
+		entry = &entry_base[i];
+		if ((entry->val & hmask) >= ihash) {
+			/* cull here */
+			do {
+				hash[ihash++] = entry;
+			} while ((entry->val & hmask) >= ihash);
+		}
+	}
+	while (ihash <= hsize) {
+		hash[ihash++] = &entry_base[entries];
+	}
 
-	/*
-	 * Determine a limit on the number of entries in the same hash
-	 * bucket.  This guards us against pathological data sets causing
-	 * really bad hash distribution with most entries in the same hash
-	 * bucket that would bring us to O(m*n) computing costs (m and n
-	 * corresponding to reference and target buffer sizes).
-	 *
-	 * Make sure none of the hash buckets has more entries than
-	 * we're willing to test.  Otherwise we cull the entry list
-	 * uniformly to still preserve a good repartition across
-	 * the reference buffer.
-	 */
+#if 0
 	for (i = 0; i < hsize; i++) {
 		if (hash_count[i] < HASH_LIMIT)
 			continue;
@@ -221,6 +229,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 		} while(entry);
 	}
 	free(hash_count);
+#endif
 
 	return index;
 }
@@ -302,7 +311,7 @@ create_delta(const struct delta_index *index,
 			val ^= U[data[-RABIN_WINDOW]];
 			val = ((val << 8) | *data) ^ T[val >> RABIN_SHIFT];
 			i = val & index->hash_mask;
-			for (entry = index->hash[i]; entry; entry = entry->next) {
+			for (entry = index->hash[i]; entry < index->hash[i+1]; entry++) {
 				const unsigned char *ref = entry->ptr;
 				const unsigned char *src = data;
 				unsigned int ref_size = ref_top - ref;

--=-=-=



-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

--=-=-=--
