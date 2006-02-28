From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] diff-delta: allow reusing of the reference buffer index
Date: Mon, 27 Feb 2006 23:38:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602272315370.25336@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 05:38:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDwdN-0000XS-Ff
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 05:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWB1Eic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 23:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWB1Eic
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 23:38:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58748 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750715AbWB1Eic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 23:38:32 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVD00DA4RK4CR40@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 27 Feb 2006 23:38:29 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16912>


When a reference buffer is used multiple times then its index can be 
computed only once and reused multiple times.  This patch adds an extra 
pointer to a pointer argument (from_index) to diff_delta() for this.

If from_index is NULL then everything is like before.

If from_index is non NULL and *from_index is NULL then the index is 
created and its location stored to *from_index.  In this case the caller 
has the responsibility to free the memory pointed to by *from_index.

If from_index and *from_index are non NULL then the index is reused as 
is.

This currently saves about 10% of CPU time to repack the git archive.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

This is partly what Linus suggested recently.  However I only made the 
minimum changes to pack-objects.c to try it out and demonstrate how it 
works.  I however don't feel confortable enough with the changes 
required to implement the full solution which is to turn the window 
processing around i.e. keep the reference buffer stable while different 
targets are tested against this reference.  This is something worth 
doing since that would reduce memory usage significantly.  But Like I 
said, pack-objects as grown more complex with Junio latest additions 
so...

 delta.h           |    3 ++-
 diff-delta.c      |   41 +++++++++++++++++++++++++++--------------
 diffcore-break.c  |    2 +-
 diffcore-rename.c |    2 +-
 pack-objects.c    |   11 ++++++++---
 test-delta.c      |    2 +-
 6 files changed, 40 insertions(+), 21 deletions(-)

f660c44250f5c02a7e773ed991316f7f16950f3e
diff --git a/delta.h b/delta.h
index a15350d..00fef0b 100644
--- a/delta.h
+++ b/delta.h
@@ -4,7 +4,8 @@
 /* handling of delta buffers */
 extern void *diff_delta(void *from_buf, unsigned long from_size,
 			void *to_buf, unsigned long to_size,
-		        unsigned long *delta_size, unsigned long max_size);
+		        unsigned long *delta_size, unsigned long max_size,
+			void **from_index);
 extern void *patch_delta(void *src_buf, unsigned long src_size,
 			 void *delta_buf, unsigned long delta_size,
 			 unsigned long *dst_size);
diff --git a/diff-delta.c b/diff-delta.c
index bb07926..67561cd 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -30,8 +30,7 @@ struct index {
 
 static struct index ** delta_index(const unsigned char *buf,
 				   unsigned long bufsize,
-				   unsigned long trg_bufsize,
-				   unsigned int *hash_shift)
+				   unsigned long trg_bufsize)
 {
 	unsigned long hsize;
 	unsigned int i, hshift, hlimit, *hash_count;
@@ -44,14 +43,17 @@ static struct index ** delta_index(const
 	for (i = 8; (1 << i) < hsize && i < 24; i += 2);
 	hsize = 1 << i;
 	hshift = (i - 8) / 2;
-	*hash_shift = hshift;
 
-	/* allocate lookup index */
-	mem = malloc(hsize * sizeof(*hash) + bufsize * sizeof(*entry));
+	/*
+	 * Allocate lookup index.  Note the first hash pointer
+	 * is used to store the hash shift value.
+	 */
+	mem = malloc((1 + hsize) * sizeof(*hash) + bufsize * sizeof(*entry));
 	if (!mem)
 		return NULL;
 	hash = mem;
-	entry = mem + hsize * sizeof(*hash);
+	*hash++ = (void *)hshift;
+	entry = mem + (1 + hsize) * sizeof(*hash);
 	memset(hash, 0, hsize * sizeof(*hash));
 
 	/* allocate an array to count hash entries */
@@ -107,7 +109,7 @@ static struct index ** delta_index(const
 	}
 	free(hash_count);
 
-	return hash;
+	return hash-1;
 }
 
 /* provide the size of the copy opcode given the block offset and size */
@@ -121,7 +123,8 @@ static struct index ** delta_index(const
 void *diff_delta(void *from_buf, unsigned long from_size,
 		 void *to_buf, unsigned long to_size,
 		 unsigned long *delta_size,
-		 unsigned long max_size)
+		 unsigned long max_size,
+		 void **from_index)
 {
 	unsigned int i, outpos, outsize, inscnt, hash_shift;
 	const unsigned char *ref_data, *ref_top, *data, *top;
@@ -130,9 +133,16 @@ void *diff_delta(void *from_buf, unsigne
 
 	if (!from_size || !to_size)
 		return NULL;
-	hash = delta_index(from_buf, from_size, to_size, &hash_shift);
-	if (!hash)
-		return NULL;
+	if (from_index && *from_index) {
+		hash = *from_index;
+	} else {
+		hash = delta_index(from_buf, from_size, to_size);
+		if (!hash)
+			return NULL;
+		if (from_index)
+			*from_index = hash;
+	}
+	hash_shift = (unsigned int)(*hash++);
 
 	outpos = 0;
 	outsize = 8192;
@@ -140,7 +150,8 @@ void *diff_delta(void *from_buf, unsigne
 		outsize = max_size + MAX_OP_SIZE + 1;
 	out = malloc(outsize);
 	if (!out) {
-		free(hash);
+		if (!from_index)
+			free(hash-1);
 		return NULL;
 	}
 
@@ -241,7 +252,8 @@ void *diff_delta(void *from_buf, unsigne
 				out = realloc(out, outsize);
 			if (!out) {
 				free(tmp);
-				free(hash);
+				if (!from_index)
+					free(hash-1);
 				return NULL;
 			}
 		}
@@ -250,7 +262,8 @@ void *diff_delta(void *from_buf, unsigne
 	if (inscnt)
 		out[outpos - inscnt - 1] = inscnt;
 
-	free(hash);
+	if (!from_index)
+		free(hash-1);
 	*delta_size = outpos;
 	return out;
 }
diff --git a/diffcore-break.c b/diffcore-break.c
index c57513a..6dc22d5 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -67,7 +67,7 @@ static int should_break(struct diff_file
 
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
-			   &delta_size, 0);
+			   &delta_size, 0, NULL);
 	if (!delta)
 		return 0; /* error but caught downstream */
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 39d9126..5b4cde4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -168,7 +168,7 @@ static int estimate_similarity(struct di
 	delta_limit = base_size * (MAX_SCORE-minimum_score) / MAX_SCORE;
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
-			   &delta_size, delta_limit);
+			   &delta_size, delta_limit, NULL);
 	if (!delta)
 		/* If delta_limit is exceeded, we have too much differences */
 		return 0;
diff --git a/pack-objects.c b/pack-objects.c
index ceb107f..2b2d9a9 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -202,7 +202,7 @@ static void *delta_against(void *buf, un
 	if (!otherbuf)
 		die("unable to read %s", sha1_to_hex(entry->delta->sha1));
         delta_buf = diff_delta(otherbuf, othersize,
-			       buf, size, &delta_size, 0);
+			       buf, size, &delta_size, 0, NULL);
         if (!delta_buf || delta_size != entry->delta_size)
         	die("delta size changed");
         free(buf);
@@ -707,6 +707,7 @@ static int type_size_sort(const struct o
 struct unpacked {
 	struct object_entry *entry;
 	void *data;
+	void **delta_index;
 };
 
 /*
@@ -789,7 +790,8 @@ static int try_delta(struct unpacked *cu
 	if (sizediff >= max_size)
 		return -1;
 	delta_buf = diff_delta(old->data, oldsize,
-			       cur->data, size, &delta_size, max_size);
+			       cur->data, size, &delta_size,
+			       max_size, old->delta_index);
 	if (!delta_buf)
 		return 0;
 	cur_entry->delta = old_entry;
@@ -830,6 +832,7 @@ static void find_deltas(struct object_en
 			 */
 			continue;
 
+		free(n->delta_index);
 		free(n->data);
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
@@ -853,8 +856,10 @@ static void find_deltas(struct object_en
 			idx = 0;
 	}
 
-	for (i = 0; i < window; ++i)
+	for (i = 0; i < window; ++i) {
+		free(array[i].delta_index);
 		free(array[i].data);
+	}
 	free(array);
 }
 
diff --git a/test-delta.c b/test-delta.c
index 1be8ee0..89eb68e 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -63,7 +63,7 @@ int main(int argc, char *argv[])
 	if (argv[1][1] == 'd')
 		out_buf = diff_delta(from_buf, from_size,
 				     data_buf, data_size,
-				     &out_size, 0);
+				     &out_size, 0, NULL);
 	else
 		out_buf = patch_delta(from_buf, from_size,
 				      data_buf, data_size,
-- 
1.2.3.g8fcf1-dirty
