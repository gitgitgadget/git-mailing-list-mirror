From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Thu, 30 Aug 2007 00:36:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708300033540.16727@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <20070815053231.GJ27913@spearce.org>
 <alpine.LFD.0.999.0708151500510.5415@xanadu.home>
 <alpine.LFD.0.999.0708300005110.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 06:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQblW-0003tK-Rr
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 06:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbXH3EgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 00:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbXH3EgT
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 00:36:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28596 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbXH3EgS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 00:36:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNK00635KSDFM00@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Aug 2007 00:36:14 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0708300005110.16727@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57000>

On Thu, 30 Aug 2007, Nicolas Pitre wrote:

> Well, here is a quick implementation of this idea for those who would 
> like to give it a try.
[...]

Well, that would help if I provided the full diff of course.

---

diff --git a/Makefile b/Makefile
index 4eb4637..c3c6e68 100644
--- a/Makefile
+++ b/Makefile
@@ -122,6 +122,9 @@ all::
 # If not set it defaults to the bare 'wish'. If it is set to the empty
 # string then NO_TCLTK will be forced (this is used by configure script).
 #
+# Define THREADED_DELTA_SEARCH if you have pthreads and wish to exploit
+# parallel delta searching when packing objects.
+#
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -662,6 +665,11 @@ ifdef NO_HSTRERROR
 	COMPAT_OBJS += compat/hstrerror.o
 endif
 
+ifdef THREADED_DELTA_SEARCH
+	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
+	EXTLIBS += -lpthread
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9b3ef94..7d68f82 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -15,6 +15,10 @@
 #include "list-objects.h"
 #include "progress.h"
 
+#ifdef THREADED_DELTA_SEARCH
+#include <pthread.h>
+#endif
+
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--max-pack-size=N] [--local] [--incremental] \n\
@@ -78,7 +82,6 @@ static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 0;
 static unsigned long cache_max_small_delta_size = 1000;
 
-static unsigned long window_memory_usage = 0;
 static unsigned long window_memory_limit = 0;
 
 /*
@@ -1291,6 +1294,20 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
+#ifdef THREADED_DELTA_SEARCH
+
+static pthread_mutex_t read_sha1_file_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+#define read_lock()		pthread_mutex_lock(&read_sha1_file_mutex)
+#define read_unlock()		pthread_mutex_unlock(&read_sha1_file_mutex)
+
+#else
+
+#define read_lock()		0
+#define read_unlock()		0
+
+#endif
+
 /*
  * We search for deltas _backwards_ in a list sorted by type and
  * by size, so that we see progressively smaller and smaller files.
@@ -1300,7 +1317,7 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
  * one.
  */
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth)
+		     unsigned max_depth, unsigned long *mem_usage)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
@@ -1313,12 +1330,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (trg_entry->type != src_entry->type)
 		return -1;
 
-	/* We do not compute delta to *create* objects we are not
-	 * going to pack.
-	 */
-	if (trg_entry->preferred_base)
-		return -1;
-
 	/*
 	 * We do not bother to try a delta that we discarded
 	 * on an earlier try, but only when reusing delta data.
@@ -1355,24 +1366,28 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
+		read_lock();
 		trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
+		read_unlock();
 		if (!trg->data)
 			die("object %s cannot be read",
 			    sha1_to_hex(trg_entry->idx.sha1));
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
-		window_memory_usage += sz;
+		*mem_usage += sz;
 	}
 	if (!src->data) {
+		read_lock();
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
+		read_unlock();
 		if (!src->data)
 			die("object %s cannot be read",
 			    sha1_to_hex(src_entry->idx.sha1));
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
-		window_memory_usage += sz;
+		*mem_usage += sz;
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
@@ -1382,7 +1397,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 				warning("suboptimal pack - out of memory");
 			return 0;
 		}
-		window_memory_usage += sizeof_delta_index(src->index);
+		*mem_usage += sizeof_delta_index(src->index);
 	}
 
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
@@ -1425,68 +1440,59 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
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
 
-static void find_deltas(struct object_entry **list, int window, int depth)
+static void find_deltas(struct object_entry **list, unsigned list_size,
+			unsigned nr_deltas, int window, int depth)
 {
-	uint32_t i = nr_objects, idx = 0, count = 0, processed = 0;
+	uint32_t i = list_size, idx = 0, count = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
-	int max_depth;
+	unsigned long mem_usage = 0;
 
-	if (!nr_objects)
-		return;
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
 	if (progress)
-		start_progress(&progress_state, "Deltifying %u objects...", "", nr_result);
+		start_progress(&progress_state, "Deltifying %u objects...", "", nr_deltas);
 
 	do {
 		struct object_entry *entry = list[--i];
 		struct unpacked *n = array + idx;
-		int j;
-
-		if (!entry->preferred_base)
-			processed++;
+		int j, max_depth;
 
-		if (progress)
-			display_progress(&progress_state, processed);
-
-		if (entry->delta)
-			/* This happens if we decided to reuse existing
-			 * delta from a pack.  "!no_reuse_delta &&" is implied.
-			 */
-			continue;
-
-		if (entry->size < 50)
-			continue;
-
-		if (entry->no_try_delta)
-			continue;
-
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
 
+		/* We do not compute delta to *create* objects we are not
+		 * going to pack.
+		 */
+		if (entry->preferred_base)
+			goto next;
+
+		if (progress)
+			display_progress(&progress_state, ++processed);
+
 		/*
 		 * If the current object is at pack edge, take the depth the
 		 * objects that depend on the current object into account
@@ -1508,7 +1514,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, max_depth) < 0)
+			if (try_delta(n, m, max_depth, &mem_usage) < 0)
 				break;
 		}
 
@@ -1537,21 +1543,94 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	free(array);
 }
 
+#ifdef THREADED_DELTA_SEARCH
+
+struct thread_params {
+	pthread_t thread;
+	struct object_entry **list;
+	unsigned list_size;
+	unsigned nr_deltas;
+	int window;
+	int depth;
+};
+
+static void *threaded_find_deltas(void *arg)
+{
+	struct thread_params *p = arg;
+	if (p->list_size)
+		find_deltas(p->list, p->list_size, p->nr_deltas,
+			    p->window, p->depth);
+	return NULL;
+}
+
+static void ll_find_deltas(struct object_entry **list, unsigned list_size,
+			   unsigned nr_deltas, int window, int depth)
+{
+	struct thread_params p[4];
+	int i, ret;
+
+	for (i = 0; i < 4; i++) {
+		unsigned sublist_size = list_size / (4 - i);
+		p[i].list = list;
+		p[i].list_size = sublist_size;
+		p[i].nr_deltas = nr_deltas;
+		p[i].window = window;
+		p[i].depth = depth;
+		ret = pthread_create(&p[i].thread, NULL,
+				     threaded_find_deltas, &p[i]);
+		if (ret)
+			die("unable to create thread: %s", strerror(ret));
+		list += sublist_size;
+		list_size -= sublist_size;
+	}
+
+	for (i = 0; i < 4; i++) {
+		pthread_join(p[i].thread, NULL);
+	}
+}
+
+#else
+#define ll_find_deltas find_deltas
+#endif
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
-	uint32_t i;
+	uint32_t i, n, nr_deltas;
 
 	get_object_details();
 
-	if (!window || !depth)
+	if (!nr_objects || !window || !depth)
 		return;
 
 	delta_list = xmalloc(nr_objects * sizeof(*delta_list));
-	for (i = 0; i < nr_objects; i++)
-		delta_list[i] = objects + i;
-	qsort(delta_list, nr_objects, sizeof(*delta_list), type_size_sort);
-	find_deltas(delta_list, window+1, depth);
+	nr_deltas = n = 0;
+
+	for (i = 0; i < nr_objects; i++) {
+		struct object_entry *entry = objects + i;
+
+		if (entry->delta)
+			/* This happens if we decided to reuse existing
+			 * delta from a pack.  "!no_reuse_delta &&" is implied.
+			 */
+			continue;
+
+		if (entry->size < 50)
+			continue;
+
+		if (entry->no_try_delta)
+			continue;
+
+		if (!entry->preferred_base)
+			nr_deltas++;
+
+		delta_list[n++] = entry;
+	}
+
+	if (nr_deltas) {
+		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
+		ll_find_deltas(delta_list, n, nr_deltas, window+1, depth);
+	}
 	free(delta_list);
 }
 
