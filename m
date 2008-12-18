From: James Pickens <james.e.pickens@intel.com>
Subject: [PATCH 1/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 13:56:50 -0700
Message-ID: <1229633811-3877-1-git-send-email-james.e.pickens@intel.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
Cc: James Pickens <james.e.pickens@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 21:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDPwp-0002HO-Sy
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 21:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbYLRU46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 15:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYLRU45
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 15:56:57 -0500
Received: from mga05.intel.com ([192.55.52.89]:48237 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752228AbYLRU44 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 15:56:56 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 18 Dec 2008 12:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,245,1228118400"; 
   d="scan'208";a="650962957"
Received: from sedona.ch.intel.com ([143.182.201.200])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2008 12:57:28 -0800
Received: from chlr11217.ch.intel.com (chlr11217.ch.intel.com [143.182.208.217])
	by sedona.ch.intel.com (8.12.11.20060308/8.14.3/Standard MailSET/Hub) with ESMTP id mBIKus6w031754;
	Thu, 18 Dec 2008 13:56:54 -0700
Received: from chlr11217.ch.intel.com (localhost [127.0.0.1])
	by chlr11217.ch.intel.com (8.12.11.20060308/8.12.8/MailSET/client) with ESMTP id mBIKuqUu003908;
	Thu, 18 Dec 2008 13:56:52 -0700
Received: (from jepicken@localhost)
	by chlr11217.ch.intel.com (8.12.11.20060308/8.12.8/MailSET/Submit) id mBIKupE5003906;
	Thu, 18 Dec 2008 13:56:51 -0700
X-Mailer: git-send-email 1.6.0.4.1116.gc5d7
In-Reply-To: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103491>

This speeds up operations like 'git clone' on NFS drives tremendously, but
slows down the same operations on local disks.

Partitioning the work and launching threads is done in unpack-trees.c.  The code
is mostly copied from preload_index.c.  The maximum number of threads is set to
8, which seemed to give a reasonable tradeoff between performance improvement on
NFS and degradation on local disks.

Some code was added to entry.c for serialization.  Most of the contents of
checkout_entry and write_entry are serialized, except writing the checked out
files to disk.
---
 entry.c        |   42 +++++++++++++++++---
 unpack-trees.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/entry.c b/entry.c
index aa2ee46..764d2db 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,21 @@
 #include "cache.h"
 #include "blob.h"
 
+#ifdef NO_PTHREADS
+
+#define checkout_lock()		(void)0
+#define checkout_unlock()	(void)0
+
+#else
+
+#include <pthread.h>
+
+static pthread_mutex_t checkout_mutex = PTHREAD_MUTEX_INITIALIZER;
+#define checkout_lock()		pthread_mutex_lock(&checkout_mutex)
+#define checkout_unlock()	pthread_mutex_unlock(&checkout_mutex)
+
+#endif
+
 static void create_directories(const char *path, const struct checkout *state)
 {
 	int len = strlen(path);
@@ -100,7 +115,7 @@ static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned
 
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
-	int fd;
+	int fd, retval;
 	long wrote;
 
 	switch (ce->ce_mode & S_IFMT) {
@@ -109,10 +124,15 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		unsigned long size;
 
 	case S_IFREG:
+		checkout_lock();
 		new = read_blob_entry(ce, path, &size);
-		if (!new)
-			return error("git checkout-index: unable to read sha1 file of %s (%s)",
+
+		if (!new) {
+			retval = error("git checkout-index: unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
+			checkout_unlock();
+			return retval;
+		}
 
 		/*
 		 * Convert from git internal format to working tree format
@@ -124,6 +144,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 			new = strbuf_detach(&buf, &newsize);
 			size = newsize;
 		}
+		checkout_unlock();
 
 		if (to_tempfile) {
 			strcpy(path, ".merge_file_XXXXXX");
@@ -143,10 +164,17 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 			return error("git checkout-index: unable to write file %s", path);
 		break;
 	case S_IFLNK:
+		checkout_lock();
 		new = read_blob_entry(ce, path, &size);
-		if (!new)
-			return error("git checkout-index: unable to read sha1 file of %s (%s)",
+
+		if (!new) {
+			retval = error("git checkout-index: unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
+			checkout_unlock();
+			return retval;
+		}
+		checkout_unlock();
+
 		if (to_tempfile || !has_symlinks) {
 			if (to_tempfile) {
 				strcpy(path, ".merge_link_XXXXXX");
@@ -192,7 +220,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 
 int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath)
 {
-	static char path[PATH_MAX + 1];
+	char path[PATH_MAX + 1];
 	struct stat st;
 	int len = state->base_dir_len;
 
@@ -229,6 +257,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
 	} else if (state->not_new)
 		return 0;
+	checkout_lock();
 	create_directories(path, state);
+	checkout_unlock();
 	return write_entry(ce, path, state, 0);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 54f301d..30b9862 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,10 @@
 #include "progress.h"
 #include "refs.h"
 
+#ifndef NO_PTHREADS
+#include <pthread.h>
+#endif
+
 /*
  * Error messages expected by scripts out of plumbing commands such as
  * read-tree.  Non-scripted Porcelain is not required to use these messages
@@ -85,6 +89,115 @@ static void unlink_entry(struct cache_entry *ce)
 }
 
 static struct checkout state;
+
+#ifdef NO_PTHREADS
+#define progress_lock()		(void)0
+#define progress_unlock()	(void)0
+
+static int threaded_checkout(struct index_state *index, int update, struct progress *prog, unsigned *prog_cnt)
+{
+	return 0; /* do nothing */
+}
+
+#else
+
+#include <pthread.h>
+
+static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
+#define progress_lock()		pthread_mutex_lock(&progress_mutex)
+#define progress_unlock()	pthread_mutex_unlock(&progress_mutex)
+
+/*
+ * Mostly randomly chosen maximum thread counts: we
+ * cap the parallelism to 8 threads, and we want
+ * to have at least 500 files per thread for it to
+ * be worth starting a thread.
+ */
+#define MAX_PARALLEL (8)
+#define THREAD_COST (500)
+
+struct thread_data {
+	pthread_t pthread;
+	struct index_state *index;
+	struct checkout *state;
+	int update, offset, nr, errs;
+	struct progress *progress;
+	unsigned *progress_cnt;
+};
+
+static void *checkout_thread(void *_data)
+{
+	int nr;
+	struct thread_data *p = _data;
+	struct index_state *index = p->index;
+	struct cache_entry **cep = index->cache + p->offset;
+
+	p->errs = 0;
+
+	nr = p->nr;
+	if (0 == nr) {
+		return NULL;
+	}
+
+	if (nr + p->offset > index->cache_nr)
+		nr = index->cache_nr - p->offset;
+
+	do {
+		struct cache_entry *ce = *cep++;
+
+		if (ce->ce_flags & CE_UPDATE) {
+			progress_lock();
+			display_progress(p->progress, ++(*p->progress_cnt));
+			progress_unlock();
+			ce->ce_flags &= ~CE_UPDATE;
+			if (p->update) {
+				p->errs |= checkout_entry(ce, p->state, NULL);
+				fflush(stdout);
+			}
+		}
+	} while (--nr > 0);
+	return NULL;
+}
+
+static int threaded_checkout(struct index_state *index, int update, struct progress *prog, unsigned *prog_cnt)
+{
+	int threads, work, offset, i;
+	struct thread_data data[MAX_PARALLEL];
+	int errs = 0;
+
+	threads = index->cache_nr / THREAD_COST;
+	if (threads > MAX_PARALLEL)
+		threads = MAX_PARALLEL;
+	else if (threads == 0)
+		return 0;
+
+	offset = 0;
+	work = (index->cache_nr + threads - 1) / threads;
+	for (i = 0; i < threads; i++) {
+		struct thread_data *p = data+i;
+		p->index = index;
+		p->offset = offset;
+		p->nr = work;
+		p->state = &state;
+		p->update = update;
+		p->progress = prog;
+		p->progress_cnt = prog_cnt;
+		offset += work;
+		if (pthread_create(&p->pthread, NULL, checkout_thread, p))
+			die("unable to create threaded checkout");
+	}
+	for (i = 0; i < threads; i++) {
+		struct thread_data *p = data+i;
+		if (pthread_join(p->pthread, NULL))
+			die("unable to join threaded checkout");
+		errs |= p->errs;
+	}
+
+	return errs;
+}
+
+#endif
+
 static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
@@ -118,6 +231,8 @@ static int check_updates(struct unpack_trees_options *o)
 		}
 	}
 
+	errs |= threaded_checkout(index, o->update, progress, &cnt);
+
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
-- 
1.6.0.4.1116.gc5d7
