From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] basic threaded delta search
Date: Thu, 06 Sep 2007 02:13:11 -0400
Message-ID: <1189059193250-git-send-email-nico@cam.org>
References: <11890591912193-git-send-email-nico@cam.org>
 <11890591923123-git-send-email-nico@cam.org>
 <11890591923270-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAcD-0001tc-8y
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbXIFGNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbXIFGNQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:13:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43542 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbXIFGNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:13:14 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNX00D3NNXZGQ30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 02:13:13 -0400 (EDT)
In-reply-to: <11890591923270-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.3.1.844.g0a05-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57828>

this is still rough, hence it is disabled by default.  You need to compile
with "make THREADED_DELTA_SEARCH=1 ..." at the moment.

Threading is done on different portions of the object list to be
deltified. This is currently done by spliting the list into n parts and
then a thread is spawned for each of them.  A better method would consist
of spliting the list into more smaller parts and have the n threads
pick the next part available.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Makefile               |    8 +++++
 builtin-pack-objects.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 51af531..a92fb31 100644
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
index 9d56592..1bcee23 100644
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
@@ -1290,6 +1294,25 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
+#ifdef THREADED_DELTA_SEARCH
+
+static pthread_mutex_t read_mutex = PTHREAD_MUTEX_INITIALIZER;
+#define read_lock()		pthread_mutex_lock(&read_mutex)
+#define read_unlock()		pthread_mutex_unlock(&read_mutex)
+
+static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
+#define progress_lock()		pthread_mutex_lock(&progress_mutex)
+#define progress_unlock()	pthread_mutex_unlock(&progress_mutex)
+
+#else
+
+#define read_lock()		0
+#define read_unlock()		0
+#define progress_lock()		0
+#define progress_unlock()	0
+
+#endif
+
 /*
  * We search for deltas _backwards_ in a list sorted by type and
  * by size, so that we see progressively smaller and smaller files.
@@ -1348,7 +1371,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
+		read_lock();
 		trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
+		read_unlock();
 		if (!trg->data)
 			die("object %s cannot be read",
 			    sha1_to_hex(trg_entry->idx.sha1));
@@ -1358,7 +1383,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		*mem_usage += sz;
 	}
 	if (!src->data) {
+		read_lock();
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
+		read_unlock();
 		if (!src->data)
 			die("object %s cannot be read",
 			    sha1_to_hex(src_entry->idx.sha1));
@@ -1470,9 +1497,11 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 		if (entry->preferred_base)
 			goto next;
 
+		progress_lock();
 		(*processed)++;
 		if (progress)
 			display_progress(&progress_state, *processed);
+		progress_unlock();
 
 		/*
 		 * If the current object is at pack edge, take the depth the
@@ -1542,6 +1571,58 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 	free(array);
 }
 
+#ifdef THREADED_DELTA_SEARCH
+
+struct thread_params {
+	pthread_t thread;
+	struct object_entry **list;
+	unsigned list_size;
+	int window;
+	int depth;
+	unsigned *processed;
+};
+
+static void *threaded_find_deltas(void *arg)
+{
+	struct thread_params *p = arg;
+	if (p->list_size)
+		find_deltas(p->list, p->list_size,
+			    p->window, p->depth, p->processed);
+	return NULL;
+}
+
+#define NR_THREADS	8
+
+static void ll_find_deltas(struct object_entry **list, unsigned list_size,
+			   int window, int depth, unsigned *processed)
+{
+	struct thread_params p[NR_THREADS];
+	int i, ret;
+
+	for (i = 0; i < NR_THREADS; i++) {
+		unsigned sublist_size = list_size / (NR_THREADS - i);
+		p[i].list = list;
+		p[i].list_size = sublist_size;
+		p[i].window = window;
+		p[i].depth = depth;
+		p[i].processed = processed;
+		ret = pthread_create(&p[i].thread, NULL,
+				     threaded_find_deltas, &p[i]);
+		if (ret)
+			die("unable to create thread: %s", strerror(ret));
+		list += sublist_size;
+		list_size -= sublist_size;
+	}
+
+	for (i = 0; i < NR_THREADS; i++) {
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
@@ -1583,7 +1664,7 @@ static void prepare_pack(int window, int depth)
 				       "Deltifying %u objects...", "",
 				       nr_deltas);
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
-		find_deltas(delta_list, n, window+1, depth, &nr_done);
+		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
 		if (progress)
 			stop_progress(&progress_state);
 		if (nr_done != nr_deltas)
-- 
1.5.3.1.844.g0a05-dirty
