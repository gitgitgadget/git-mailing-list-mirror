From: Thomas Rast <trast@student.ethz.ch>
Subject: [POC PATCH 5/5] sha1_file: make the pack machinery thread-safe
Date: Fri, 9 Dec 2011 09:39:37 +0100
Message-ID: <dd2bf650b382f5aca727b7d93a48598fb1a2f7d9.1323419666.git.trast@student.ethz.ch>
References: <cover.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 09:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYvzi-0005RO-OT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 09:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab1LIIjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 03:39:48 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:15752 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab1LIIjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 03:39:47 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:38 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:39 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323419666.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186619>

More precisely speaking, this pushes the locking down from
read_object() into bits of the pack machinery that cannot (yet) run in
parallel.

There are several hacks here:

a) prepare_packed_git() must be called before any parallel accesses
   happen.  It now unconditionally opens and maps all index files.

b) similarly, prepare_replace_object() must be called before any
   parallel read_sha1_file() happens

This simplification lets us avoid locking outright to guard the index
accesses; locking is then mainly required for open_packed_git(),
[un]use_pack(), and such.

The ultimate goal would of course be to let at least _some_ pack
accesses happen without any locking whatsoever.  But grep already
benefits from it with a nice speed boost on non-worktree greps.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/grep.c   |    9 ++++++
 cache.h          |    1 +
 replace_object.c |    5 ++-
 sha1_file.c      |   81 +++++++++++++++++++++++++++++++++++++++++++++++------
 thread-utils.c   |    9 ++++--
 thread-utils.h   |    3 +-
 6 files changed, 93 insertions(+), 15 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6c5bdfa..212497d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -980,6 +980,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (opt.pre_context || opt.post_context || opt.file_break ||
 		    opt.funcbody)
 			skip_first_line = 1;
+		/*
+		 * This does the non-threadsafe work early.  FIXME:
+		 * grep shouldn't have to know about this mess.
+		 */
+		use_threads = 0;
+		prepare_replace_object();
+		prepare_packed_git();
+		use_threads = 1;
+
 		start_threads(&opt);
 	}
 #endif
diff --git a/cache.h b/cache.h
index 8c98d05..379dd44 100644
--- a/cache.h
+++ b/cache.h
@@ -764,6 +764,7 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
+extern void prepare_replace_object(void);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/replace_object.c b/replace_object.c
index d0b1548..b303392 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -2,6 +2,7 @@
 #include "sha1-lookup.h"
 #include "refs.h"
 #include "commit.h"
+#include "thread-utils.h"
 
 static struct replace_object {
 	unsigned char sha1[2][20];
@@ -76,13 +77,15 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-static void prepare_replace_object(void)
+void prepare_replace_object(void)
 {
 	static int replace_object_prepared;
 
 	if (replace_object_prepared)
 		return;
 
+	assert(!use_threads);
+
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
 	if (!replace_object_nr)
diff --git a/sha1_file.c b/sha1_file.c
index 7c367f9..b61692e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -429,7 +429,8 @@ void prepare_alt_odb(void)
 
 static int has_loose_object_local(const unsigned char *sha1)
 {
-	char *name = sha1_file_name(sha1);
+	char name[PATH_MAX];
+	sha1_file_name_buf(name, sha1);
 	return !access(name, F_OK);
 }
 
@@ -650,9 +651,12 @@ static int unuse_one_window(struct packed_git *current, int keep_fd)
 
 void release_pack_memory(size_t need, int fd)
 {
-	size_t cur = pack_mapped;
+	size_t cur;
+	lock_if_threaded(&pack_access_mutex);
+	cur = pack_mapped;
 	while (need >= (cur - pack_mapped) && unuse_one_window(NULL, fd))
 		; /* nothing */
+	unlock_if_threaded(&pack_access_mutex);
 }
 
 void *xmmap(void *start, size_t length,
@@ -689,9 +693,12 @@ void close_pack_windows(struct packed_git *p)
 void unuse_pack(struct pack_window **w_cursor)
 {
 	struct pack_window *w = *w_cursor;
+
 	if (w) {
+		lock_if_threaded(&pack_access_mutex);
 		w->inuse_cnt--;
 		*w_cursor = NULL;
+		unlock_if_threaded(&pack_access_mutex);
 	}
 }
 
@@ -712,10 +719,13 @@ void close_pack_index(struct packed_git *p)
  * must subsist at this point.  If ever objects from this pack are requested
  * again, the new version of the pack will be reinitialized through
  * reprepare_packed_git().
+ *
+ * NOT THREAD-SAFE
  */
 void free_pack_by_name(const char *pack_name)
 {
 	struct packed_git *p, **pp = &packed_git;
+	assert(!use_threads);
 
 	while (*pp) {
 		p = *pp;
@@ -821,13 +831,33 @@ static int open_packed_git_1(struct packed_git *p)
 
 static int open_packed_git(struct packed_git *p)
 {
-	if (!open_packed_git_1(p))
+	lock_if_threaded(&pack_access_mutex);
+	/*
+	 * is_pack_valid() took the easy route and did not
+	 * lock.  This is probably okay; if the pack was
+	 * *ever* open, it was valid unless another process is
+	 * actively trying to corrupt it, in which case:
+	 * meh.
+	 *
+	 * However, a concurrent open_packed_git() may already have
+	 * opened it before we get here.  So we test again in a locked
+	 * section.  If it beat us to it, then we have no work left to
+	 * do.
+	 */
+	if (p->pack_fd != -1) {
+		unlock_if_threaded(&pack_access_mutex);
 		return 0;
+	}
+	if (!open_packed_git_1(p)) {
+		unlock_if_threaded(&pack_access_mutex);
+		return 0;
+	}
 	if (p->pack_fd != -1) {
 		close(p->pack_fd);
 		pack_open_fds--;
 		p->pack_fd = -1;
 	}
+	unlock_if_threaded(&pack_access_mutex);
 	return -1;
 }
 
@@ -858,6 +888,9 @@ unsigned char *use_pack(struct packed_git *p,
 	 */
 	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
+
+	lock_if_threaded(&pack_access_mutex);
+
 	if (offset > (p->pack_size - 20))
 		die("offset beyond end of packfile (truncated pack?)");
 
@@ -916,6 +949,9 @@ unsigned char *use_pack(struct packed_git *p,
 	offset -= win->offset;
 	if (left)
 		*left = win->len - xsize_t(offset);
+
+	unlock_if_threaded(&pack_access_mutex);
+
 	return win->base + offset;
 }
 
@@ -1044,6 +1080,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (!p)
 			continue;
 		install_packed_git(p);
+		open_pack_index(p);
 	}
 	closedir(dir);
 }
@@ -1102,6 +1139,12 @@ static void rearrange_packed_git(void)
 	free(ary);
 }
 
+/*
+ * NOT THREAD-SAFE
+ *
+ * However, it's ok if you run this early, before starting threads,
+ * and then use the pack machinery from threads.
+ */
 static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
@@ -1109,6 +1152,7 @@ void prepare_packed_git(void)
 
 	if (prepare_packed_git_run_once)
 		return;
+	assert (!use_threads);
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
@@ -1180,8 +1224,10 @@ static int git_open_noatime(const char *name)
 static int open_sha1_file(const unsigned char *sha1)
 {
 	int fd;
-	char *name = sha1_file_name(sha1);
+	char namebuf[PATH_MAX];
+	char *name = namebuf;
 	struct alternate_object_database *alt;
+	sha1_file_name_buf(name, sha1);
 
 	fd = git_open_noatime(name);
 	if (fd >= 0)
@@ -1698,7 +1744,22 @@ static struct pack_context *pack_context_alloc(void)
 	return ctx;
 }
 
+#ifdef NO_PTHREADS
 #define get_thread_pack_context() (&main_pack_context)
+#else
+static struct pack_context *get_thread_pack_context(void)
+{
+	struct pack_context *ctx;
+	if (!use_threads)
+		return &main_pack_context;
+	ctx = pthread_getspecific(pack_context_key);
+	if (ctx)
+		return ctx;
+	ctx = pack_context_alloc();
+	pthread_setspecific(pack_context_key, ctx);
+	return ctx;
+}
+#endif
 
 static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 {
@@ -2219,6 +2280,10 @@ static void *read_packed_sha1(const unsigned char *sha1,
 	return data;
 }
 
+/*
+ * WARNING: must never be called concurrently with read_sha1_file and
+ * friends!  They do lookups in the cached_objects without locking.
+ */
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 		      unsigned char *sha1)
 {
@@ -2280,19 +2345,15 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 			      unsigned flag)
 {
 	void *data;
-	char *path;
 	const struct packed_git *p;
 	const unsigned char *repl;
 
-	lock_if_threaded(&read_sha1_mutex);
-
 	repl = (flag & READ_SHA1_FILE_REPLACE)
 		? lookup_replace_object(sha1) : sha1;
 
 	errno = 0;
 	data = read_object(repl, type, size);
 	if (data) {
-		unlock_if_threaded(&read_sha1_mutex);
 		return data;
 	}
 
@@ -2305,7 +2366,8 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
 	if (has_loose_object(repl)) {
-		path = sha1_file_name(sha1);
+		char path[PATH_MAX];
+		sha1_file_name_buf(path, sha1);
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 	}
@@ -2314,7 +2376,6 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("packed object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), p->pack_name);
 
-	unlock_if_threaded(&read_sha1_mutex);
 	return NULL;
 }
 
diff --git a/thread-utils.c b/thread-utils.c
index 70af3f9..0da2b65 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -62,15 +62,18 @@ int init_recursive_mutex(pthread_mutex_t *m)
 	return ret;
 }
 
-pthread_mutex_t read_sha1_mutex;
+pthread_mutex_t pack_access_mutex;
+pthread_key_t pack_context_key;
 void init_subsystem_locks(void)
 {
-	pthread_mutex_init(&read_sha1_mutex, NULL);
+	init_recursive_mutex(&pack_access_mutex);
+	pthread_key_create(&pack_context_key, NULL);
 }
 
 void destroy_subsystem_locks(void)
 {
-	pthread_mutex_destroy(&read_sha1_mutex);
+	pthread_mutex_destroy(&pack_access_mutex);
+	pthread_key_delete(pack_context_key);
 }
 
 #ifndef NO_PTHREADS
diff --git a/thread-utils.h b/thread-utils.h
index 3906753..7d3cc0a 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -17,7 +17,8 @@
 extern void lock_if_threaded(pthread_mutex_t*);
 extern void unlock_if_threaded(pthread_mutex_t*);
 
-extern pthread_mutex_t read_sha1_mutex;
+extern pthread_mutex_t pack_access_mutex;
+extern pthread_key_t pack_context_key;
 extern void init_subsystem_locks(void);
 extern void destroy_subsystem_locks(void);
 
-- 
1.7.8.431.g2abf2
