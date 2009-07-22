From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/3] janitor: use NULL and not 0 for pointers.
Date: Wed, 22 Jul 2009 23:34:33 +0200
Message-ID: <1248298475-2990-2-git-send-email-madcoder@debian.org>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjZX-0001k8-OX
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbZGVVlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbZGVVlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:41:09 -0400
Received: from pan.madism.org ([88.191.52.104]:40952 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbZGVVlC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:41:02 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DE4E546503;
	Wed, 22 Jul 2009 23:34:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 114512B1FC; Wed, 22 Jul 2009 23:34:37 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc1.192.g631f9
In-Reply-To: <1248298475-2990-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123781>

Brought to you thanks to coccinelle:

---8<----
@@
expression *E;
@@
(
  E ==
- 0
+ NULL
|
  E !=
- 0
+ NULL
|
  E =
- 0
+ NULL
)

@@
identifier f;
type T;
@@
T *f(...) {
<...
- return 0;
+ return NULL;
...>
}
--->8----

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 compat/nedmalloc/malloc.c.h  |  198 +++++++++++++++++++++---------------------
 compat/nedmalloc/nedmalloc.c |    2 +-
 compat/regex/regex.c         |   28 +++---
 graph.c                      |    2 +-
 upload-pack.c                |    2 +-
 5 files changed, 116 insertions(+), 116 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 74c42e3..36fc2f9 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1544,14 +1544,14 @@ static int dev_zero_fd = -1; /* Cached file descriptor for /dev/zero. */
 /* Win32 MMAP via VirtualAlloc */
 static FORCEINLINE void* win32mmap(size_t size) {
   void* ptr = VirtualAlloc(0, size, MEM_RESERVE|MEM_COMMIT, PAGE_READWRITE);
-  return (ptr != 0)? ptr: MFAIL;
+  return (ptr != NULL)? ptr: MFAIL;
 }
 
 /* For direct MMAP, use MEM_TOP_DOWN to minimize interference */
 static FORCEINLINE void* win32direct_mmap(size_t size) {
   void* ptr = VirtualAlloc(0, size, MEM_RESERVE|MEM_COMMIT|MEM_TOP_DOWN,
 			   PAGE_READWRITE);
-  return (ptr != 0)? ptr: MFAIL;
+  return (ptr != NULL)? ptr: MFAIL;
 }
 
 /* This function supports releasing coalesed segments */
@@ -2611,7 +2611,7 @@ static msegmentptr segment_holding(mstate m, char* addr) {
   for (;;) {
     if (addr >= sp->base && addr < sp->base + sp->size)
       return sp;
-    if ((sp = sp->next) == 0)
+    if ((sp = sp->next) == NULL)
       return 0;
   }
 }
@@ -2622,7 +2622,7 @@ static int has_segment_link(mstate m, msegmentptr ss) {
   for (;;) {
     if ((char*)sp >= ss->base && (char*)sp < ss->base + ss->size)
       return 1;
-    if ((sp = sp->next) == 0)
+    if ((sp = sp->next) == NULL)
       return 0;
   }
 }
@@ -3126,7 +3126,7 @@ static void do_check_any_chunk(mstate m, mchunkptr p) {
 static void do_check_top_chunk(mstate m, mchunkptr p) {
   msegmentptr sp = segment_holding(m, (char*)p);
   size_t  sz = p->head & ~INUSE_BITS; /* third-lowest bit can be set! */
-  assert(sp != 0);
+  assert(sp != NULL);
   assert((is_aligned(chunk2mem(p))) || (p->head == FENCEPOST_HEAD));
   assert(ok_address(m, p));
   assert(sz == m->topsize);
@@ -3186,7 +3186,7 @@ static void do_check_free_chunk(mstate m, mchunkptr p) {
 
 /* Check properties of malloced chunks at the point they are malloced */
 static void do_check_malloced_chunk(mstate m, void* mem, size_t s) {
-  if (mem != 0) {
+  if (mem != NULL) {
     mchunkptr p = mem2chunk(mem);
     size_t sz = p->head & ~(PINUSE_BIT|CINUSE_BIT);
     do_check_inuse_chunk(m, p);
@@ -3219,34 +3219,34 @@ static void do_check_tree(mstate m, tchunkptr t) {
     assert(!next_pinuse(u));
     assert(u->fd->bk == u);
     assert(u->bk->fd == u);
-    if (u->parent == 0) {
-      assert(u->child[0] == 0);
-      assert(u->child[1] == 0);
+    if (u->parent == NULL) {
+      assert(u->child[0] == NULL);
+      assert(u->child[1] == NULL);
     }
     else {
-      assert(head == 0); /* only one node on chain has parent */
+      assert(head == NULL); /* only one node on chain has parent */
       head = u;
       assert(u->parent != u);
       assert (u->parent->child[0] == u ||
 	      u->parent->child[1] == u ||
 	      *((tbinptr*)(u->parent)) == u);
-      if (u->child[0] != 0) {
+      if (u->child[0] != NULL) {
 	assert(u->child[0]->parent == u);
 	assert(u->child[0] != u);
 	do_check_tree(m, u->child[0]);
       }
-      if (u->child[1] != 0) {
+      if (u->child[1] != NULL) {
 	assert(u->child[1]->parent == u);
 	assert(u->child[1] != u);
 	do_check_tree(m, u->child[1]);
       }
-      if (u->child[0] != 0 && u->child[1] != 0) {
+      if (u->child[0] != NULL && u->child[1] != NULL) {
 	assert(chunksize(u->child[0]) < chunksize(u->child[1]));
       }
     }
     u = u->fd;
   } while (u != t);
-  assert(head != 0);
+  assert(head != NULL);
 }
 
 /*  Check all the chunks in a treebin.  */
@@ -3254,7 +3254,7 @@ static void do_check_treebin(mstate m, bindex_t i) {
   tbinptr* tb = treebin_at(m, i);
   tchunkptr t = *tb;
   int empty = (m->treemap & (1U << i)) == 0;
-  if (t == 0)
+  if (t == NULL)
     assert(empty);
   if (!empty)
     do_check_tree(m, t);
@@ -3304,11 +3304,11 @@ static int bin_find(mstate m, mchunkptr x) {
     if (treemap_is_marked(m, tidx)) {
       tchunkptr t = *treebin_at(m, tidx);
       size_t sizebits = size << leftshift_for_tree_index(tidx);
-      while (t != 0 && chunksize(t) != size) {
+      while (t != NULL && chunksize(t) != size) {
 	t = t->child[(sizebits >> (SIZE_T_BITSIZE-SIZE_T_ONE)) & 1];
 	sizebits <<= 1;
       }
-      if (t != 0) {
+      if (t != NULL) {
 	tchunkptr u = t;
 	do {
 	  if (u == (tchunkptr)x)
@@ -3326,7 +3326,7 @@ static size_t traverse_and_check(mstate m) {
   if (is_initialized(m)) {
     msegmentptr s = &m->seg;
     sum += m->topsize + TOP_FOOT_SIZE;
-    while (s != 0) {
+    while (s != NULL) {
       mchunkptr q = align_as_chunk(s->base);
       mchunkptr lastq = 0;
       assert(pinuse(q));
@@ -3339,7 +3339,7 @@ static size_t traverse_and_check(mstate m) {
 	}
 	else {
 	  assert(q == m->dv || bin_find(m, q));
-	  assert(lastq == 0 || cinuse(lastq)); /* Not 2 consecutive free */
+	  assert(lastq == NULL || cinuse(lastq)); /* Not 2 consecutive free */
 	  do_check_free_chunk(m, q);
 	}
 	lastq = q;
@@ -3368,7 +3368,7 @@ static void do_check_malloc_state(mstate m) {
     assert(bin_find(m, m->dv) == 0);
   }
 
-  if (m->top != 0) {   /* check top chunk */
+  if (m->top != NULL) {   /* check top chunk */
     do_check_top_chunk(m, m->top);
     /*assert(m->topsize == chunksize(m->top)); redundant */
     assert(m->topsize > 0);
@@ -3394,7 +3394,7 @@ static struct mallinfo internal_mallinfo(mstate m) {
       size_t mfree = m->topsize + TOP_FOOT_SIZE;
       size_t sum = mfree;
       msegmentptr s = &m->seg;
-      while (s != 0) {
+      while (s != NULL) {
 	mchunkptr q = align_as_chunk(s->base);
 	while (segment_holds(s, q) &&
 	       q != m->top && q->head != FENCEPOST_HEAD) {
@@ -3437,7 +3437,7 @@ static void internal_malloc_stats(mstate m) {
       fp = m->footprint;
       used = fp - (m->topsize + TOP_FOOT_SIZE);
 
-      while (s != 0) {
+      while (s != NULL) {
 	mchunkptr q = align_as_chunk(s->base);
 	while (segment_holds(s, q) &&
 	       q != m->top && q->head != FENCEPOST_HEAD) {
@@ -3560,7 +3560,7 @@ static void internal_malloc_stats(mstate m) {
       if (chunksize(T) != S) {\
 	tchunkptr* C = &(T->child[(K >> (SIZE_T_BITSIZE-SIZE_T_ONE)) & 1]);\
 	K <<= 1;\
-	if (*C != 0)\
+	if (*C != NULL)\
 	  T = *C;\
 	else if (RTCHECK(ok_address(M, C))) {\
 	  *C = X;\
@@ -3627,21 +3627,21 @@ static void internal_malloc_stats(mstate m) {
     if (((R = *(RP = &(X->child[1]))) != 0) ||\
 	((R = *(RP = &(X->child[0]))) != 0)) {\
       tchunkptr* CP;\
-      while ((*(CP = &(R->child[1])) != 0) ||\
-	     (*(CP = &(R->child[0])) != 0)) {\
+      while ((*(CP = &(R->child[1])) != NULL) ||\
+	     (*(CP = &(R->child[0])) != NULL)) {\
 	R = *(RP = CP);\
       }\
       if (RTCHECK(ok_address(M, RP)))\
-	*RP = 0;\
+	*RP = NULL;\
       else {\
 	CORRUPTION_ERROR_ACTION(M);\
       }\
     }\
   }\
-  if (XP != 0) {\
+  if (XP != NULL) {\
     tbinptr* H = treebin_at(M, X->index);\
     if (X == *H) {\
-      if ((*H = R) == 0) \
+      if ((*H = R) == NULL) \
 	clear_treemap(M, X->index);\
     }\
     else if (RTCHECK(ok_address(M, XP))) {\
@@ -3652,7 +3652,7 @@ static void internal_malloc_stats(mstate m) {
     }\
     else\
       CORRUPTION_ERROR_ACTION(M);\
-    if (R != 0) {\
+    if (R != NULL) {\
       if (RTCHECK(ok_address(M, R))) {\
 	tchunkptr C0, C1;\
 	R->parent = XP;\
@@ -3743,7 +3743,7 @@ static void* mmap_alloc(mstate m, size_t nb) {
       return chunk2mem(p);
     }
   }
-  return 0;
+  return NULL;
 }
 
 /* Realloc using mmap */
@@ -3816,10 +3816,10 @@ static void reset_on_error(mstate m) {
   /* Reinitialize fields to forget about all memory */
   m->smallbins = m->treebins = 0;
   m->dvsize = m->topsize = 0;
-  m->seg.base = 0;
+  m->seg.base = NULL;
   m->seg.size = 0;
-  m->seg.next = 0;
-  m->top = m->dv = 0;
+  m->seg.next = NULL;
+  m->top = m->dv = NULL;
   for (i = 0; i < NTREEBINS; ++i)
     *treebin_at(m, i) = 0;
   init_bins(m);
@@ -3934,7 +3934,7 @@ static void* sys_alloc(mstate m, size_t nb) {
   /* Directly map large chunks */
   if (use_mmap(m) && nb >= mparams.mmap_threshold) {
     void* mem = mmap_alloc(m, nb);
-    if (mem != 0)
+    if (mem != NULL)
       return mem;
   }
 
@@ -3962,11 +3962,11 @@ static void* sys_alloc(mstate m, size_t nb) {
 
   if (MORECORE_CONTIGUOUS && !use_noncontiguous(m)) {
     char* br = CMFAIL;
-    msegmentptr ss = (m->top == 0)? 0 : segment_holding(m, (char*)m->top);
+    msegmentptr ss = (m->top == NULL)? 0 : segment_holding(m, (char*)m->top);
     size_t asize = 0;
     ACQUIRE_MALLOC_GLOBAL_LOCK();
 
-    if (ss == 0) {  /* First time through or recovery */
+    if (ss == NULL) {  /* First time through or recovery */
       char* base = (char*)CALL_MORECORE(0);
       if (base != CMFAIL) {
 	asize = granularity_align(nb + SYS_ALLOC_PADDING);
@@ -4078,9 +4078,9 @@ static void* sys_alloc(mstate m, size_t nb) {
       /* Try to merge with an existing segment */
       msegmentptr sp = &m->seg;
       /* Only consider most recent segment if traversal suppressed */
-      while (sp != 0 && tbase != sp->base + sp->size)
+      while (sp != NULL && tbase != sp->base + sp->size)
 	sp = (NO_SEGMENT_TRAVERSAL) ? 0 : sp->next;
-      if (sp != 0 &&
+      if (sp != NULL &&
 	  !is_extern_segment(sp) &&
 	  (sp->sflags & IS_MMAPPED_BIT) == mmap_flag &&
 	  segment_holds(sp, m->top)) { /* append */
@@ -4091,9 +4091,9 @@ static void* sys_alloc(mstate m, size_t nb) {
 	if (tbase < m->least_addr)
 	  m->least_addr = tbase;
 	sp = &m->seg;
-	while (sp != 0 && sp->base != tbase + tsize)
+	while (sp != NULL && sp->base != tbase + tsize)
 	  sp = (NO_SEGMENT_TRAVERSAL) ? 0 : sp->next;
-	if (sp != 0 &&
+	if (sp != NULL &&
 	    !is_extern_segment(sp) &&
 	    (sp->sflags & IS_MMAPPED_BIT) == mmap_flag) {
 	  char* oldbase = sp->base;
@@ -4119,7 +4119,7 @@ static void* sys_alloc(mstate m, size_t nb) {
   }
 
   MALLOC_FAILURE_ACTION;
-  return 0;
+  return NULL;
 }
 
 /* -----------------------  system deallocation -------------------------- */
@@ -4130,7 +4130,7 @@ static size_t release_unused_segments(mstate m) {
   int nsegs = 0;
   msegmentptr pred = &m->seg;
   msegmentptr sp = pred->next;
-  while (sp != 0) {
+  while (sp != NULL) {
     char* base = sp->base;
     size_t size = sp->size;
     msegmentptr next = sp->next;
@@ -4143,7 +4143,7 @@ static size_t release_unused_segments(mstate m) {
 	tchunkptr tp = (tchunkptr)p;
 	assert(segment_holds(sp, (char*)sp));
 	if (p == m->dv) {
-	  m->dv = 0;
+	  m->dv = NULL;
 	  m->dvsize = 0;
 	}
 	else {
@@ -4260,16 +4260,16 @@ static void* tmalloc_large(mstate m, size_t nb) {
       }
       rt = t->child[1];
       t = t->child[(sizebits >> (SIZE_T_BITSIZE-SIZE_T_ONE)) & 1];
-      if (rt != 0 && rt != t)
+      if (rt != NULL && rt != t)
 	rst = rt;
-      if (t == 0) {
+      if (t == NULL) {
 	t = rst; /* set t to least subtree holding sizes > nb */
 	break;
       }
       sizebits <<= 1;
     }
   }
-  if (t == 0 && v == 0) { /* set t to root of next non-empty treebin */
+  if (t == NULL && v == NULL) { /* set t to root of next non-empty treebin */
     binmap_t leftbits = left_bits(idx2bit(idx)) & m->treemap;
     if (leftbits != 0) {
       bindex_t i;
@@ -4279,7 +4279,7 @@ static void* tmalloc_large(mstate m, size_t nb) {
     }
   }
 
-  while (t != 0) { /* find smallest of tree or subtree */
+  while (t != NULL) { /* find smallest of tree or subtree */
     size_t trem = chunksize(t) - nb;
     if (trem < rsize) {
       rsize = trem;
@@ -4289,7 +4289,7 @@ static void* tmalloc_large(mstate m, size_t nb) {
   }
 
   /*  If dv is a better fit, return 0 so malloc will use it */
-  if (v != 0 && rsize < (size_t)(m->dvsize - nb)) {
+  if (v != NULL && rsize < (size_t)(m->dvsize - nb)) {
     if (RTCHECK(ok_address(m, v))) { /* split */
       mchunkptr r = chunk_plus_offset(v, nb);
       assert(chunksize(v) == rsize + nb);
@@ -4307,7 +4307,7 @@ static void* tmalloc_large(mstate m, size_t nb) {
     }
     CORRUPTION_ERROR_ACTION(m);
   }
-  return 0;
+  return NULL;
 }
 
 /* allocate a small request from the best fitting chunk in a treebin */
@@ -4345,7 +4345,7 @@ static void* tmalloc_small(mstate m, size_t nb) {
   }
 
   CORRUPTION_ERROR_ACTION(m);
-  return 0;
+  return NULL;
 }
 
 /* --------------------------- realloc support --------------------------- */
@@ -4353,14 +4353,14 @@ static void* tmalloc_small(mstate m, size_t nb) {
 static void* internal_realloc(mstate m, void* oldmem, size_t bytes) {
   if (bytes >= MAX_REQUEST) {
     MALLOC_FAILURE_ACTION;
-    return 0;
+    return NULL;
   }
   if (!PREACTION(m)) {
     mchunkptr oldp = mem2chunk(oldmem);
     size_t oldsize = chunksize(oldp);
     mchunkptr next = chunk_plus_offset(oldp, oldsize);
     mchunkptr newp = 0;
-    void* extra = 0;
+    void* extra = NULL;
 
     /* Try to either shrink or extend into top. Else malloc-copy-free */
 
@@ -4394,13 +4394,13 @@ static void* internal_realloc(mstate m, void* oldmem, size_t bytes) {
     else {
       USAGE_ERROR_ACTION(m, oldmem);
       POSTACTION(m);
-      return 0;
+      return NULL;
     }
 
     POSTACTION(m);
 
-    if (newp != 0) {
-      if (extra != 0) {
+    if (newp != NULL) {
+      if (extra != NULL) {
 	internal_free(m, extra);
       }
       check_inuse_chunk(m, newp);
@@ -4408,7 +4408,7 @@ static void* internal_realloc(mstate m, void* oldmem, size_t bytes) {
     }
     else {
       void* newmem = internal_malloc(m, bytes);
-      if (newmem != 0) {
+      if (newmem != NULL) {
 	size_t oc = oldsize - overhead_for(oldp);
 	memcpy(newmem, oldmem, (oc < bytes)? oc : bytes);
 	internal_free(m, oldmem);
@@ -4416,7 +4416,7 @@ static void* internal_realloc(mstate m, void* oldmem, size_t bytes) {
       return newmem;
     }
   }
-  return 0;
+  return NULL;
 }
 
 /* --------------------------- memalign support -------------------------- */
@@ -4433,7 +4433,7 @@ static void* internal_memalign(mstate m, size_t alignment, size_t bytes) {
   }
 
   if (bytes >= MAX_REQUEST - alignment) {
-    if (m != 0)  { /* Test isn't needed but avoids compiler warning */
+    if (m != NULL)  { /* Test isn't needed but avoids compiler warning */
       MALLOC_FAILURE_ACTION;
     }
   }
@@ -4441,12 +4441,12 @@ static void* internal_memalign(mstate m, size_t alignment, size_t bytes) {
     size_t nb = request2size(bytes);
     size_t req = nb + alignment + MIN_CHUNK_SIZE - CHUNK_OVERHEAD;
     char* mem = (char*)internal_malloc(m, req);
-    if (mem != 0) {
-      void* leader = 0;
-      void* trailer = 0;
+    if (mem != NULL) {
+      void* leader = NULL;
+      void* trailer = NULL;
       mchunkptr p = mem2chunk(mem);
 
-      if (PREACTION(m)) return 0;
+      if (PREACTION(m)) return NULL;
       if ((((size_t)(mem)) % alignment) != 0) { /* misaligned */
 	/*
 	  Find an aligned spot inside chunk.  Since we need to give
@@ -4494,16 +4494,16 @@ static void* internal_memalign(mstate m, size_t alignment, size_t bytes) {
       assert((((size_t)(chunk2mem(p))) % alignment) == 0);
       check_inuse_chunk(m, p);
       POSTACTION(m);
-      if (leader != 0) {
+      if (leader != NULL) {
 	internal_free(m, leader);
       }
-      if (trailer != 0) {
+      if (trailer != NULL) {
 	internal_free(m, trailer);
       }
       return chunk2mem(p);
     }
   }
-  return 0;
+  return NULL;
 }
 
 /* ------------------------ comalloc/coalloc support --------------------- */
@@ -4546,7 +4546,7 @@ static void** ialloc(mstate m,
     /* if empty req, must still return chunk representing empty array */
     if (n_elements == 0)
       return (void**)internal_malloc(m, 0);
-    marray = 0;
+    marray = NULL;
     array_size = request2size(n_elements * (sizeof(void*)));
   }
 
@@ -4574,10 +4574,10 @@ static void** ialloc(mstate m,
   mem = internal_malloc(m, size - CHUNK_OVERHEAD);
   if (was_enabled)
     enable_mmap(m);
-  if (mem == 0)
-    return 0;
+  if (mem == NULL)
+    return NULL;
 
-  if (PREACTION(m)) return 0;
+  if (PREACTION(m)) return NULL;
   p = mem2chunk(mem);
   remainder_size = chunksize(p);
 
@@ -4588,7 +4588,7 @@ static void** ialloc(mstate m,
   }
 
   /* If not provided, allocate the pointer array as final part of chunk */
-  if (marray == 0) {
+  if (marray == NULL) {
     size_t  array_chunk_size;
     array_chunk = chunk_plus_offset(p, contents_size);
     array_chunk_size = remainder_size - contents_size;
@@ -4718,7 +4718,7 @@ void* dlmalloc(size_t bytes) {
 	  goto postaction;
 	}
 
-	else if (gm->treemap != 0 && (mem = tmalloc_small(gm, nb)) != 0) {
+	else if (gm->treemap != 0 && (mem = tmalloc_small(gm, nb)) != NULL) {
 	  check_malloced_chunk(gm, mem, nb);
 	  goto postaction;
 	}
@@ -4728,7 +4728,7 @@ void* dlmalloc(size_t bytes) {
       nb = MAX_SIZE_T; /* Too big to allocate. Force failure (in sys alloc) */
     else {
       nb = pad_request(bytes);
-      if (gm->treemap != 0 && (mem = tmalloc_large(gm, nb)) != 0) {
+      if (gm->treemap != 0 && (mem = tmalloc_large(gm, nb)) != NULL) {
 	check_malloced_chunk(gm, mem, nb);
 	goto postaction;
       }
@@ -4746,7 +4746,7 @@ void* dlmalloc(size_t bytes) {
       else { /* exhaust dv */
 	size_t dvs = gm->dvsize;
 	gm->dvsize = 0;
-	gm->dv = 0;
+	gm->dv = NULL;
 	set_inuse_and_pinuse(gm, p, dvs);
       }
       mem = chunk2mem(p);
@@ -4773,7 +4773,7 @@ void* dlmalloc(size_t bytes) {
     return mem;
   }
 
-  return 0;
+  return NULL;
 }
 
 void dlfree(void* mem) {
@@ -4783,7 +4783,7 @@ void dlfree(void* mem) {
      with special cases for top, dv, mmapped chunks, and usage errors.
   */
 
-  if (mem != 0) {
+  if (mem != NULL) {
     mchunkptr p  = mem2chunk(mem);
 #if FOOTERS
     mstate fm = get_mstate_for(p);
@@ -4834,7 +4834,7 @@ void dlfree(void* mem) {
 	      fm->top = p;
 	      p->head = tsize | PINUSE_BIT;
 	      if (p == fm->dv) {
-		fm->dv = 0;
+		fm->dv = NULL;
 		fm->dvsize = 0;
 	      }
 	      if (should_trim(fm, tsize))
@@ -4896,18 +4896,18 @@ void* dlcalloc(size_t n_elements, size_t elem_size) {
       req = MAX_SIZE_T; /* force downstream failure on overflow */
   }
   mem = dlmalloc(req);
-  if (mem != 0 && calloc_must_clear(mem2chunk(mem)))
+  if (mem != NULL && calloc_must_clear(mem2chunk(mem)))
     memset(mem, 0, req);
   return mem;
 }
 
 void* dlrealloc(void* oldmem, size_t bytes) {
-  if (oldmem == 0)
+  if (oldmem == NULL)
     return dlmalloc(bytes);
 #ifdef REALLOC_ZERO_BYTES_FREES
   if (bytes == 0) {
     dlfree(oldmem);
-    return 0;
+    return NULL;
   }
 #endif /* REALLOC_ZERO_BYTES_FREES */
   else {
@@ -4917,7 +4917,7 @@ void* dlrealloc(void* oldmem, size_t bytes) {
     mstate m = get_mstate_for(mem2chunk(oldmem));
     if (!ok_magic(m)) {
       USAGE_ERROR_ACTION(m, oldmem);
-      return 0;
+      return NULL;
     }
 #endif /* FOOTERS */
     return internal_realloc(m, oldmem, bytes);
@@ -4988,7 +4988,7 @@ int dlmallopt(int param_number, int value) {
 #endif /* !ONLY_MSPACES */
 
 size_t dlmalloc_usable_size(void* mem) {
-  if (mem != 0) {
+  if (mem != NULL) {
     mchunkptr p = mem2chunk(mem);
     if (cinuse(p))
       return chunksize(p) - overhead_for(p);
@@ -5013,7 +5013,7 @@ static mstate init_user_mstate(char* tbase, size_t tsize) {
   m->magic = mparams.magic;
   m->release_checks = MAX_RELEASE_CHECK_RATE;
   m->mflags = mparams.default_mflags;
-  m->extp = 0;
+  m->extp = NULL;
   m->exts = 0;
   disable_contiguous(m);
   init_bins(m);
@@ -5076,7 +5076,7 @@ size_t destroy_mspace(mspace msp) {
   mstate ms = (mstate)msp;
   if (ok_magic(ms)) {
     msegmentptr sp = &ms->seg;
-    while (sp != 0) {
+    while (sp != NULL) {
       char* base = sp->base;
       size_t size = sp->size;
       flag_t flag = sp->sflags;
@@ -5102,7 +5102,7 @@ void* mspace_malloc(mspace msp, size_t bytes) {
   mstate ms = (mstate)msp;
   if (!ok_magic(ms)) {
     USAGE_ERROR_ACTION(ms,ms);
-    return 0;
+    return NULL;
   }
   if (!PREACTION(ms)) {
     void* mem;
@@ -5154,7 +5154,7 @@ void* mspace_malloc(mspace msp, size_t bytes) {
 	  goto postaction;
 	}
 
-	else if (ms->treemap != 0 && (mem = tmalloc_small(ms, nb)) != 0) {
+	else if (ms->treemap != 0 && (mem = tmalloc_small(ms, nb)) != NULL) {
 	  check_malloced_chunk(ms, mem, nb);
 	  goto postaction;
 	}
@@ -5164,7 +5164,7 @@ void* mspace_malloc(mspace msp, size_t bytes) {
       nb = MAX_SIZE_T; /* Too big to allocate. Force failure (in sys alloc) */
     else {
       nb = pad_request(bytes);
-      if (ms->treemap != 0 && (mem = tmalloc_large(ms, nb)) != 0) {
+      if (ms->treemap != 0 && (mem = tmalloc_large(ms, nb)) != NULL) {
 	check_malloced_chunk(ms, mem, nb);
 	goto postaction;
       }
@@ -5182,7 +5182,7 @@ void* mspace_malloc(mspace msp, size_t bytes) {
       else { /* exhaust dv */
 	size_t dvs = ms->dvsize;
 	ms->dvsize = 0;
-	ms->dv = 0;
+	ms->dv = NULL;
 	set_inuse_and_pinuse(ms, p, dvs);
       }
       mem = chunk2mem(p);
@@ -5209,11 +5209,11 @@ void* mspace_malloc(mspace msp, size_t bytes) {
     return mem;
   }
 
-  return 0;
+  return NULL;
 }
 
 void mspace_free(mspace msp, void* mem) {
-  if (mem != 0) {
+  if (mem != NULL) {
     mchunkptr p  = mem2chunk(mem);
 #if FOOTERS
     mstate fm = get_mstate_for(p);
@@ -5264,7 +5264,7 @@ void mspace_free(mspace msp, void* mem) {
 	      fm->top = p;
 	      p->head = tsize | PINUSE_BIT;
 	      if (p == fm->dv) {
-		fm->dv = 0;
+		fm->dv = NULL;
 		fm->dvsize = 0;
 	      }
 	      if (should_trim(fm, tsize))
@@ -5319,7 +5319,7 @@ void* mspace_calloc(mspace msp, size_t n_elements, size_t elem_size) {
   mstate ms = (mstate)msp;
   if (!ok_magic(ms)) {
     USAGE_ERROR_ACTION(ms,ms);
-    return 0;
+    return NULL;
   }
   if (n_elements != 0) {
     req = n_elements * elem_size;
@@ -5328,18 +5328,18 @@ void* mspace_calloc(mspace msp, size_t n_elements, size_t elem_size) {
       req = MAX_SIZE_T; /* force downstream failure on overflow */
   }
   mem = internal_malloc(ms, req);
-  if (mem != 0 && calloc_must_clear(mem2chunk(mem)))
+  if (mem != NULL && calloc_must_clear(mem2chunk(mem)))
     memset(mem, 0, req);
   return mem;
 }
 
 void* mspace_realloc(mspace msp, void* oldmem, size_t bytes) {
-  if (oldmem == 0)
+  if (oldmem == NULL)
     return mspace_malloc(msp, bytes);
 #ifdef REALLOC_ZERO_BYTES_FREES
   if (bytes == 0) {
     mspace_free(msp, oldmem);
-    return 0;
+    return NULL;
   }
 #endif /* REALLOC_ZERO_BYTES_FREES */
   else {
@@ -5351,7 +5351,7 @@ void* mspace_realloc(mspace msp, void* oldmem, size_t bytes) {
 #endif /* FOOTERS */
     if (!ok_magic(ms)) {
       USAGE_ERROR_ACTION(ms,ms);
-      return 0;
+      return NULL;
     }
     return internal_realloc(ms, oldmem, bytes);
   }
@@ -5361,7 +5361,7 @@ void* mspace_memalign(mspace msp, size_t alignment, size_t bytes) {
   mstate ms = (mstate)msp;
   if (!ok_magic(ms)) {
     USAGE_ERROR_ACTION(ms,ms);
-    return 0;
+    return NULL;
   }
   return internal_memalign(ms, alignment, bytes);
 }
@@ -5372,7 +5372,7 @@ void** mspace_independent_calloc(mspace msp, size_t n_elements,
   mstate ms = (mstate)msp;
   if (!ok_magic(ms)) {
     USAGE_ERROR_ACTION(ms,ms);
-    return 0;
+    return NULL;
   }
   return ialloc(ms, n_elements, &sz, 3, chunks);
 }
@@ -5382,7 +5382,7 @@ void** mspace_independent_comalloc(mspace msp, size_t n_elements,
   mstate ms = (mstate)msp;
   if (!ok_magic(ms)) {
     USAGE_ERROR_ACTION(ms,ms);
-    return 0;
+    return NULL;
   }
   return ialloc(ms, n_elements, sizes, 0, chunks);
 }
@@ -5449,7 +5449,7 @@ struct mallinfo mspace_mallinfo(mspace msp) {
 #endif /* NO_MALLINFO */
 
 size_t mspace_usable_size(void* mem) {
-  if (mem != 0) {
+  if (mem != NULL) {
     mchunkptr p = mem2chunk(mem);
     if (cinuse(p))
       return chunksize(p) - overhead_for(p);
diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index d9a17a8..89940fb 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -952,7 +952,7 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
  */
 char *strdup(const char *s1)
 {
-	char *s2 = 0;
+	char *s2 = NULL;
 	if (s1) {
 		s2 = malloc(strlen(s1) + 1);
 		strcpy(s2, s1);
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5ea0075..d33faa5 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -1063,12 +1063,12 @@ regex_compile (pattern, size, syntax, bufp)
      command.  This makes it possible to tell if a new exact-match
      character can be added to that command or if the character requires
      a new `exactn' command.  */
-  unsigned char *pending_exact = 0;
+  unsigned char *pending_exact = NULL;
 
   /* Address of start of the most recently finished expression.
      This tells, e.g., postfix * where to find the start of its
      operand.  Reset at the beginning of groups and alternatives.  */
-  unsigned char *laststart = 0;
+  unsigned char *laststart = NULL;
 
   /* Address of beginning of regexp, or inside of last group.  */
   unsigned char *begalt;
@@ -1080,7 +1080,7 @@ regex_compile (pattern, size, syntax, bufp)
   /* Address of the place where a forward jump should go to the end of
      the containing expression.  Each alternative of an `or' -- except the
      last -- ends with a forward jump of this sort.  */
-  unsigned char *fixup_alt_jump = 0;
+  unsigned char *fixup_alt_jump = NULL;
 
   /* Counts open-groups as they are encountered.  Remembered for the
      matching close-group on the compile stack, so the same register
@@ -1296,7 +1296,7 @@ regex_compile (pattern, size, syntax, bufp)
 	    INSERT_JUMP (keep_string_p ? on_failure_keep_string_jump
 				       : on_failure_jump,
 			 laststart, b + 3);
-	    pending_exact = 0;
+	    pending_exact = NULL;
 	    b += 3;
 
 	    if (!zero_times_ok)
@@ -1583,13 +1583,13 @@ regex_compile (pattern, size, syntax, bufp)
 
 	      compile_stack.avail++;
 
-	      fixup_alt_jump = 0;
-	      laststart = 0;
+	      fixup_alt_jump = NULL;
+	      laststart = NULL;
 	      begalt = b;
 	      /* If we've reached MAX_REGNUM groups, then this open
 		 won't actually generate any code, so we'll have to
 		 clear pending_exact explicitly.  */
-	      pending_exact = 0;
+	      pending_exact = NULL;
 	      break;
 
 
@@ -1646,7 +1646,7 @@ regex_compile (pattern, size, syntax, bufp)
 		/* If we've reached MAX_REGNUM groups, then this open
 		   won't actually generate any code, so we'll have to
 		   clear pending_exact explicitly.  */
-		pending_exact = 0;
+		pending_exact = NULL;
 
 		/* We're at the end of the group, so now we know how many
 		   groups were inside this one.  */
@@ -1674,7 +1674,7 @@ regex_compile (pattern, size, syntax, bufp)
 		 jumps to this alternative if the former fails.  */
 	      GET_BUFFER_SPACE (3);
 	      INSERT_JUMP (on_failure_jump, begalt, b + 6);
-	      pending_exact = 0;
+	      pending_exact = NULL;
 	      b += 3;
 
 	      /* The alternative before this one has a jump after it
@@ -1703,7 +1703,7 @@ regex_compile (pattern, size, syntax, bufp)
 	      GET_BUFFER_SPACE (3);
 	      b += 3;
 
-	      laststart = 0;
+	      laststart = NULL;
 	      begalt = b;
 	      break;
 
@@ -1856,7 +1856,7 @@ regex_compile (pattern, size, syntax, bufp)
 			 b += 5;
 		       }
 		   }
-		pending_exact = 0;
+		pending_exact = NULL;
 		beg_interval = NULL;
 	      }
 	      break;
@@ -4635,7 +4635,7 @@ re_comp (s)
     {
       if (!re_comp_buf.buffer)
 	return "No previous regular expression";
-      return 0;
+      return NULL;
     }
 
   if (!re_comp_buf.buffer)
@@ -4723,14 +4723,14 @@ regcomp (preg, pattern, cflags)
       RE_SYNTAX_POSIX_EXTENDED : RE_SYNTAX_POSIX_BASIC;
 
   /* regex_compile will allocate the space for the compiled pattern.  */
-  preg->buffer = 0;
+  preg->buffer = NULL;
   preg->allocated = 0;
 
   /* Don't bother to use a fastmap when searching.  This simplifies the
      REG_NEWLINE case: if we used a fastmap, we'd have to put all the
      characters after newlines into the fastmap.  This way, we just try
      every character.  */
-  preg->fastmap = 0;
+  preg->fastmap = NULL;
 
   if (cflags & REG_ICASE)
     {
diff --git a/graph.c b/graph.c
index f8d7a5c..e466770 100644
--- a/graph.c
+++ b/graph.c
@@ -893,7 +893,7 @@ static struct column *find_new_column_by_commit(struct git_graph *graph,
 		if (graph->new_columns[i].commit == commit)
 			return &graph->new_columns[i];
 	}
-	return 0;
+	return NULL;
 }
 
 static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
diff --git a/upload-pack.c b/upload-pack.c
index 4d8be83..5976467 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -156,7 +156,7 @@ static void create_pack_file(void)
 
 	if (shallow_nr) {
 		rev_list.proc = do_rev_list;
-		rev_list.data = 0;
+		rev_list.data = NULL;
 		if (start_async(&rev_list))
 			die("git upload-pack: unable to fork git-rev-list");
 		argv[arg++] = "pack-objects";
-- 
1.6.4.rc1.192.g631f9
