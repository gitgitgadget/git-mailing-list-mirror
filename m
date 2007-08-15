From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 16:49:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708151500510.5415@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <20070815053231.GJ27913@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILPp1-0007LR-3i
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 22:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936193AbXHOUth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 16:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936110AbXHOUtg
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 16:49:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50378 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936022AbXHOUte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 16:49:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMU003YI1UIIB50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Aug 2007 16:49:32 -0400 (EDT)
In-reply-to: <20070815053231.GJ27913@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55946>

On Wed, 15 Aug 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 13 Aug 2007, Shawn O. Pearce wrote:
> > 
> > > I'm not sure its that complex to run all try_delta calls of the
> > > current window in parallel.
> > 
> > Well, here's my quick attempt at it.  Unfortunately, performance isn't 
> > as good as I'd expected, especially with relatively small blobs like 
> > those found in the linux kernel repo.  It looks like the overhead of 
> > thread creation/joining might be significant compared to the actual 
> > delta computation.  I have a P4 with HT which might behave differently 
> > from a real SMP machine, or whatever, but the CPU usage never exceeded 
> > 110% according to top (sometimes it even dropped below 95%). Actually, a 
> > git-repack gets much slower due to 2m27s of system time compared to 
> > 0m03s without threads.  And this is with NPTL.
> 
> Yea, I'm not surprised.  This is quick and dirty but is really the
> wrong approach.  The kernel is spending lots of time setting up the
> thread and its stack, then scheduling it onto a CPU, only to likely
> find it finish before it even yields the CPU or is interrupted off.
> So I'd expect to get huge system times here.

So... Here's a variation on the previous attempt.  A thread is created 
for each delta window slot and it is awakened when there is a delta to 
compute.  Now top is reporting an average of 175% CPU usage when delta 
searching on the linux repo. The threading overhead when down a lot, 
from 2m of system time to 42s.  Still a far cry from the usual 3s when 
no threads are used though.

> > With a repo containing big blobs it is different though.  CPU usage 
> > firmly gets to 200% hence all cores are saturated with work.
> 
> Right, that's what we want to see.  ;-)
> 
> What makes this bloody complex (yes, I just did disagree with
> myself) is you need to use a pool of threads, one per core, keep
> them running for the life of the delta phase (so we amortize the
> thread start/stop time) and also give them large enough bursts of
> data that they can almost always use their full time slice before
> being interrupted by the kernel.

This is still way suboptimal.  The thread synchronization that has to be 
involved for _each_ delta attempt simply puts too much overhead.

Also, all threads have to be done before sliding the window to the 
next object since deltification of the new object depends on the results 
from the previous window position. However, it is highly unlikely that 
all threads will be done with their share of work at the same time and 
therefore there will always be a certain amount of time when most 
threads will be idle while the last ones are still busy, up to the point 
where there is only one thread to wait after before moving the window 
forward.  This is what explains why I get around 175% CPU usage instead 
of 200% when repacking the linux kernel repo.

And still, the total amount of CPU cycles spent on the whole task is far 
greater than without any thread because, as I mentioned before, running 
delta computations in parallel doesn't allow early abort of 
create_delta() calls based on a good max_size value from a previous 
delta results because there is no such previous results when everything 
is computed in parallel.  So, while the repack might be faster from a 
wall clock point of view, it wastes more CPU cycles in the end which is 
not really nice.

> > Remains the approach of calling find_deltas() n times with 1/n of the 
> > delta_list, one call per thread, for the bulk of the delta search work.  
> > This might even be much simpler than my current patch is.  However this 
> > approach will require n times the memory for the delta window data.  
> > Thread creation overhead will occur only once.
> 
> Yea, that I agree with.  The other thing is the main thread may need
> to push a couple of windows worth of work into the threads, so that
> if this window's 1/n unit goes really fast on that thread it doesn't
> stall out waiting for the main thread to get it more data.

It is easier to keep 4 threads busy with 100000 objects each to deal 
with in a conventional way than keeping 10 threads busy when processing 
a single delta window in parallel.  Or the delta_list can be partitioned 
in smaller chunks and anytime one of the find_deltas() thread is done 
then it is fed another chunk.

The side effect of that is that no delta will cross chunk boundaries.  
But just like when repacking multiple existing packs into one with 
delta data reuse, the actual chunk boundaries can be re-fed to 
find_deltas() in order to find more deltas across chunks.

This approach will require less code than the patch below, it will have 
almost zero threading overhead and each thread will be sure to be busy 
for a long period of time.  And the early create_delta() abort will just 
work too.

> > Also... read_sha1_file() is currently not thread safe, and threaded 
> > delta searching would requires that its usage be serialized with a 
> > global mutex (not done in this patch which is a bug), or ideally be made 
> > thread aware.
> 
> Yea, that's a problem.  From the Git library perspective that Luiz
> Capitulino has been working on for GSOC this summer being able to
> compile/link Git with -lpthreads and have it actually be thread
> safe would be useful.  Unfortunately its waaaay more than just
> making read_sha1_file() threadsafe.  :-/
> 
> read_sha1_file() is actually a reasonably critical part of the
> major functions of Git.  Slowing that down by making it go through
> pthread_mutex_{lock,unlock} is going to hurt.  I tried something
> like the following, and its a bit slower, and really ain't a great
> multi-thread aware implementation.

I'd say that, since almost none of the GIT code currently need thread 
aware read_sha1_file(), it is best to only serialize its usage at the 
caller level where it is actually needed.


Nicolas

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
index 5e9d1fd..449f9f3 100644
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
@@ -1273,6 +1277,14 @@ struct unpacked {
 	void *data;
 	struct delta_index *index;
 	unsigned depth;
+#ifdef THREADED_DELTA_SEARCH
+	pthread_t thread;
+	pthread_mutex_t mutex;
+	pthread_mutex_t wait;
+	pthread_mutex_t done;
+	struct unpacked *trg;
+	unsigned trg_max_depth;
+#endif
 };
 
 static int delta_cacheable(struct unpacked *trg, struct unpacked *src,
@@ -1292,6 +1304,24 @@ static int delta_cacheable(struct unpacked *trg, struct unpacked *src,
 	return 0;
 }
 
+#ifdef THREADED_DELTA_SEARCH
+
+static pthread_mutex_t read_sha1_file_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+#define read_lock()		pthread_mutex_lock(&read_sha1_file_mutex)
+#define read_unlock()		pthread_mutex_unlock(&read_sha1_file_mutex)
+#define delta_lock(e)		pthread_mutex_lock(&(e)->mutex)
+#define delta_unlock(e)		pthread_mutex_unlock(&(e)->mutex)
+
+#else
+
+#define read_lock()		0
+#define read_unlock()		0
+#define delta_lock(e)		0
+#define delta_unlock(e)		0
+
+#endif
+
 /*
  * We search for deltas _backwards_ in a list sorted by type and
  * by size, so that we see progressively smaller and smaller files.
@@ -1335,6 +1365,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Now some size filtering heuristics. */
+	delta_lock(trg);
 	trg_size = trg_entry->size;
 	if (!trg_entry->delta) {
 		max_size = trg_size/2 - 20;
@@ -1343,6 +1374,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		max_size = trg_entry->delta_size;
 		ref_depth = trg->depth;
 	}
+	delta_unlock(trg);
 	max_size = max_size * (max_depth - src->depth) /
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
@@ -1355,19 +1387,28 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Load data if not already done */
+
+	delta_lock(trg);
 	if (!trg->data) {
+		read_lock();
 		trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
 		window_memory_usage += sz;
+		read_unlock();
 	}
+	delta_unlock(trg);
+
+	delta_lock(src);
 	if (!src->data) {
+		read_lock();
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
 		window_memory_usage += sz;
+		read_unlock();
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
@@ -1375,20 +1416,32 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			static int warned = 0;
 			if (!warned++)
 				warning("suboptimal pack - out of memory");
+			delta_unlock(src);
 			return 0;
 		}
+		read_lock();
 		window_memory_usage += sizeof_delta_index(src->index);
+		read_unlock();
 	}
+	delta_unlock(src);
 
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
 
+	delta_lock(trg);
 	if (trg_entry->delta_data) {
-		/* Prefer only shallower same-sized deltas. */
-		if (delta_size == trg_entry->delta_size &&
-		    src->depth + 1 >= trg->depth) {
+#ifdef THREADED_DELTA_SEARCH
+		/* A better match might have been found in the mean time */
+		max_size = trg_entry->delta_size * (max_depth - src->depth) /
+						(max_depth - trg->depth + 1);
+#endif
+		/* ... also prefer only shallower same-sized deltas. */
+		if (delta_size > max_size ||
+		    (delta_size == trg_entry->delta_size &&
+		     src->depth + 1 >= trg->depth)) {
 			free(delta_buf);
+			delta_unlock(trg);
 			return 0;
 		}
 		delta_cache_size -= trg_entry->delta_size;
@@ -1404,9 +1457,27 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		delta_cache_size += trg_entry->delta_size;
 	} else
 		free(delta_buf);
+	delta_unlock(trg);
 	return 1;
 }
 
+#ifdef THREADED_DELTA_SEARCH
+
+static void *threaded_try_delta(void *arg)
+{
+	struct unpacked *src = arg;
+	for (;;) {
+		pthread_mutex_lock(&src->wait);
+		if (!src->trg)
+			break;
+		try_delta(src->trg, src, src->trg_max_depth);
+		pthread_mutex_unlock(&src->done);
+	}
+	return NULL;
+}
+
+#endif
+
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 {
 	struct object_entry *child = me->delta_child;
@@ -1439,19 +1510,32 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	uint32_t i = nr_objects, idx = 0, count = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
-	int max_depth;
+	int j, max_depth;
 
 	if (!nr_objects)
 		return;
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
+#ifdef THREADED_DELTA_SEARCH
+	for (j = 0; j < window; j++) {
+		int ret;
+		pthread_mutex_init(&array[j].mutex, NULL);
+		pthread_mutex_init(&array[j].wait, NULL);
+		pthread_mutex_init(&array[j].done, NULL);
+		pthread_mutex_lock(&array[j].wait);
+		pthread_mutex_lock(&array[j].done);
+		ret = pthread_create(&array[j].thread, NULL,
+				     threaded_try_delta, &array[j]);
+			if (ret)
+				die("unable to create thread: %s", strerror(ret));
+	}
+#endif
 	if (progress)
 		start_progress(&progress_state, "Deltifying %u objects...", "", nr_result);
 
 	do {
 		struct object_entry *entry = list[--i];
 		struct unpacked *n = array + idx;
-		int j;
 
 		if (!entry->preferred_base)
 			processed++;
@@ -1494,6 +1578,31 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 				goto next;
 		}
 
+#ifdef THREADED_DELTA_SEARCH
+		/* Unlock all threads ... */
+		j = window;
+		while (--j > 0) {
+			uint32_t other_idx = idx + j;
+			struct unpacked *m;
+			if (other_idx >= window)
+				other_idx -= window;
+			m = array + other_idx;
+			if (!m->entry)
+				break;
+			m->trg = n;
+			m->trg_max_depth= max_depth;
+			pthread_mutex_unlock(&m->wait);
+		}
+		/* ... then wait for their completion. */
+		while (++j < window) {
+			uint32_t other_idx = idx + j;
+			struct unpacked *m;
+			if (other_idx >= window)
+				other_idx -= window;
+			m = array + other_idx;
+			pthread_mutex_lock(&m->done);
+		}
+#else
 		j = window;
 		while (--j > 0) {
 			uint32_t other_idx = idx + j;
@@ -1506,6 +1615,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 			if (try_delta(n, m, max_depth) < 0)
 				break;
 		}
+#endif
 
 		/* if we made n a delta, and if n is already at max
 		 * depth, leaving it in the window is pointless.  we
@@ -1528,6 +1638,16 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	for (i = 0; i < window; ++i) {
 		free_delta_index(array[i].index);
 		free(array[i].data);
+#ifdef THREADED_DELTA_SEARCH
+		array[i].trg = NULL;
+		pthread_mutex_unlock(&array[i].wait);
+		pthread_join(array[i].thread, NULL);
+		pthread_mutex_unlock(&array[i].wait);
+		pthread_mutex_unlock(&array[i].done);
+		pthread_mutex_destroy(&array[i].mutex);
+		pthread_mutex_destroy(&array[i].wait);
+		pthread_mutex_destroy(&array[i].done);
+#endif
 	}
 	free(array);
 }
