From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Thu, 30 Aug 2007 00:27:50 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708300005110.16727@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <20070815053231.GJ27913@spearce.org>
 <alpine.LFD.0.999.0708151500510.5415@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 06:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQbdk-0002hj-Fh
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 06:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXH3E1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 00:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbXH3E1w
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 00:27:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18921 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbXH3E1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 00:27:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNK0051HKEE9G80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Aug 2007 00:27:51 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0708151500510.5415@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56999>

On Wed, 15 Aug 2007, Nicolas Pitre wrote:

> On Wed, 15 Aug 2007, Shawn O. Pearce wrote:
> 
> > Nicolas Pitre <nico@cam.org> wrote:
> >
> > > Remains the approach of calling find_deltas() n times with 1/n of the 
> > > delta_list, one call per thread, for the bulk of the delta search work.  
> > > This might even be much simpler than my current patch is.  However this 
> > > approach will require n times the memory for the delta window data.  
> > > Thread creation overhead will occur only once.
> > 
> > Yea, that I agree with.  The other thing is the main thread may need
> > to push a couple of windows worth of work into the threads, so that
> > if this window's 1/n unit goes really fast on that thread it doesn't
> > stall out waiting for the main thread to get it more data.
> 
> It is easier to keep 4 threads busy with 100000 objects each to deal 
> with in a conventional way than keeping 10 threads busy when processing 
> a single delta window in parallel.  Or the delta_list can be partitioned 
> in smaller chunks and anytime one of the find_deltas() thread is done 
> then it is fed another chunk.
> 
> The side effect of that is that no delta will cross chunk boundaries.  
> But just like when repacking multiple existing packs into one with 
> delta data reuse, the actual chunk boundaries can be re-fed to 
> find_deltas() in order to find more deltas across chunks.

Well, here is a quick implementation of this idea for those who would 
like to give it a try.  Performance is indeed much better.  The delta 
progress status is however fscked up at the moment, so don't pay too 
much attention to it.  Partitioning is also extremely crude.  But the 
idea looks promizing.

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
index e917e8e..7d68f82 100644
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
@@ -1290,6 +1294,20 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
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
@@ -1348,7 +1366,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
+		read_lock();
 		trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
+		read_unlock();
 		if (!trg->data)
 			die("object %s cannot be read",
 			    sha1_to_hex(trg_entry->idx.sha1));
@@ -1358,7 +1378,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		*mem_usage += sz;
 	}
 	if (!src->data) {
+		read_lock();
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
+		read_unlock();
 		if (!src->data)
 			die("object %s cannot be read",
 			    sha1_to_hex(src_entry->idx.sha1));
@@ -1521,6 +1543,56 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
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
@@ -1557,7 +1629,7 @@ static void prepare_pack(int window, int depth)
 
 	if (nr_deltas) {
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
-		find_deltas(delta_list, n, nr_deltas, window+1, depth);
+		ll_find_deltas(delta_list, n, nr_deltas, window+1, depth);
 	}
 	free(delta_list);
 }
