From: Thomas Rast <trast@student.ethz.ch>
Subject: [POC PATCH 2/5] grep: push locking into read_sha1_*
Date: Fri, 9 Dec 2011 09:39:34 +0100
Message-ID: <c967eb8f334f83ef0cd6272cff709ed556b935d4.1323419666.git.trast@student.ethz.ch>
References: <cover.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 09:40:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYvzw-0005VI-UK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 09:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab1LIIjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 03:39:52 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:15752 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab1LIIjn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 03:39:43 -0500
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186621>

Move the locking away from grep (the user) and into read_sha1_* and
read_object_* (the subsystem).  This will allow future work on the
locking granularity there.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/grep.c |   35 ++++-------------------------------
 sha1_file.c    |   12 ++++++++++--
 thread-utils.c |   11 +++++++++++
 thread-utils.h |    6 ++++++
 4 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 76f2c4f..6c5bdfa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -82,19 +82,6 @@ static inline void grep_unlock(void)
 	unlock_if_threaded(&grep_mutex);
 }
 
-/* Used to serialize calls to read_sha1_file. */
-static pthread_mutex_t read_sha1_mutex;
-
-static inline void read_sha1_lock(void)
-{
-	lock_if_threaded(&read_sha1_mutex);
-}
-
-static inline void read_sha1_unlock(void)
-{
-	unlock_if_threaded(&read_sha1_mutex);
-}
-
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
 
@@ -248,8 +235,8 @@ static void start_threads(struct grep_opt *opt)
 {
 	int i;
 
+	init_subsystem_locks();
 	pthread_mutex_init(&grep_mutex, NULL);
-	pthread_mutex_init(&read_sha1_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
@@ -296,16 +283,14 @@ static int wait_all(void)
 	}
 
 	pthread_mutex_destroy(&grep_mutex);
-	pthread_mutex_destroy(&read_sha1_mutex);
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
+	destroy_subsystem_locks();
 
 	return hit;
 }
 #else /* !NO_PTHREADS */
-#define read_sha1_lock()
-#define read_sha1_unlock()
 
 static int wait_all(void)
 {
@@ -363,21 +348,11 @@ static int grep_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
-{
-	void *data;
-
-	read_sha1_lock();
-	data = read_sha1_file(sha1, type, size);
-	read_sha1_unlock();
-	return data;
-}
-
 static void *load_sha1(const unsigned char *sha1, unsigned long *size,
 		       const char *name)
 {
 	enum object_type type;
-	void *data = lock_and_read_sha1_file(sha1, &type, size);
+	void *data = read_sha1_file(sha1, &type, size);
 
 	if (!data)
 		error(_("'%s': unable to read %s"), name, sha1_to_hex(sha1));
@@ -578,7 +553,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_sha1_file(entry.sha1, &type, &size);
+			data = read_sha1_file(entry.sha1, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    sha1_to_hex(entry.sha1));
@@ -608,10 +583,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		struct strbuf base;
 		int hit, len;
 
-		read_sha1_lock();
 		data = read_object_with_reference(obj->sha1, tree_type,
 						  &size, NULL);
-		read_sha1_unlock();
 
 		if (!data)
 			die(_("unable to read tree (%s)"), sha1_to_hex(obj->sha1));
diff --git a/sha1_file.c b/sha1_file.c
index 956422b..c3595b3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -18,6 +18,7 @@
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
+#include "thread-utils.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -2237,13 +2238,19 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	void *data;
 	char *path;
 	const struct packed_git *p;
-	const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
+	const unsigned char *repl;
+
+	lock_if_threaded(&read_sha1_mutex);
+
+	repl = (flag & READ_SHA1_FILE_REPLACE)
 		? lookup_replace_object(sha1) : sha1;
 
 	errno = 0;
 	data = read_object(repl, type, size);
-	if (data)
+	if (data) {
+		unlock_if_threaded(&read_sha1_mutex);
 		return data;
+	}
 
 	if (errno && errno != ENOENT)
 		die_errno("failed to read object %s", sha1_to_hex(sha1));
@@ -2263,6 +2270,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("packed object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), p->pack_name);
 
+	unlock_if_threaded(&read_sha1_mutex);
 	return NULL;
 }
 
diff --git a/thread-utils.c b/thread-utils.c
index fb75a29..70af3f9 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -62,6 +62,17 @@ int init_recursive_mutex(pthread_mutex_t *m)
 	return ret;
 }
 
+pthread_mutex_t read_sha1_mutex;
+void init_subsystem_locks(void)
+{
+	pthread_mutex_init(&read_sha1_mutex, NULL);
+}
+
+void destroy_subsystem_locks(void)
+{
+	pthread_mutex_destroy(&read_sha1_mutex);
+}
+
 #ifndef NO_PTHREADS
 void lock_if_threaded(pthread_mutex_t *m)
 {
diff --git a/thread-utils.h b/thread-utils.h
index 9a780a2..3906753 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -17,10 +17,16 @@
 extern void lock_if_threaded(pthread_mutex_t*);
 extern void unlock_if_threaded(pthread_mutex_t*);
 
+extern pthread_mutex_t read_sha1_mutex;
+extern void init_subsystem_locks(void);
+extern void destroy_subsystem_locks(void);
+
 #else
 
 #define lock_if_threaded(lock)
 #define unlock_if_threaded(lock)
+#define init_subsystem_locks()
+#define destroy_subsystem_locks()
 
 #endif
 
-- 
1.7.8.431.g2abf2
