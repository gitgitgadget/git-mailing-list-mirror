From: Thomas Rast <trast@student.ethz.ch>
Subject: [POC PATCH 1/5] Turn grep's use_threads into a global flag
Date: Fri, 9 Dec 2011 09:39:33 +0100
Message-ID: <16b39f83ed64a2705f2db8880680cd5639f94f56.1323419666.git.trast@student.ethz.ch>
References: <cover.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 09:39:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYvzh-0005RO-JS
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 09:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab1LIIjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 03:39:44 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:15752 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab1LIIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 03:39:42 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:38 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:38 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323419666.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186616>

In preparation for further work on this, turn use_threads into a flag
shared across the whole code base.  The supporting (un)lock_if_threaded()
functions are to be used for locking; they return immediately when not
threading.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/grep.c |   20 ++++++++------------
 thread-utils.c |   16 ++++++++++++++++
 thread-utils.h |   16 ++++++++++++++++
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 988ea1d..76f2c4f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,8 +24,6 @@
 	NULL
 };
 
-static int use_threads = 1;
-
 #ifndef NO_PTHREADS
 #define THREADS 8
 static pthread_t threads[THREADS];
@@ -76,14 +74,12 @@ struct work_item {
 
 static inline void grep_lock(void)
 {
-	if (use_threads)
-		pthread_mutex_lock(&grep_mutex);
+	lock_if_threaded(&grep_mutex);
 }
 
 static inline void grep_unlock(void)
 {
-	if (use_threads)
-		pthread_mutex_unlock(&grep_mutex);
+	unlock_if_threaded(&grep_mutex);
 }
 
 /* Used to serialize calls to read_sha1_file. */
@@ -91,14 +87,12 @@ static inline void grep_unlock(void)
 
 static inline void read_sha1_lock(void)
 {
-	if (use_threads)
-		pthread_mutex_lock(&read_sha1_mutex);
+	lock_if_threaded(&read_sha1_mutex);
 }
 
 static inline void read_sha1_unlock(void)
 {
-	if (use_threads)
-		pthread_mutex_unlock(&read_sha1_mutex);
+	unlock_if_threaded(&read_sha1_mutex);
 }
 
 /* Signalled when a new work_item is added to todo. */
@@ -984,6 +978,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
+#ifndef NO_PTHREADS
+	use_threads = 1;
+#endif
+
 	if (show_in_pager == default_pager)
 		show_in_pager = git_pager(1);
 	if (show_in_pager) {
@@ -1011,8 +1009,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
-#else
-	use_threads = 0;
 #endif
 
 	compile_grep_patterns(&opt);
diff --git a/thread-utils.c b/thread-utils.c
index 7f4b76a..fb75a29 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "thread-utils.h"
 
+int use_threads;
+
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
 #endif
@@ -59,3 +61,17 @@ int init_recursive_mutex(pthread_mutex_t *m)
 	}
 	return ret;
 }
+
+#ifndef NO_PTHREADS
+void lock_if_threaded(pthread_mutex_t *m)
+{
+	if (use_threads)
+		pthread_mutex_lock(m);
+}
+
+void unlock_if_threaded(pthread_mutex_t *m)
+{
+	if (use_threads)
+		pthread_mutex_unlock(m);
+}
+#endif
diff --git a/thread-utils.h b/thread-utils.h
index 6fb98c3..9a780a2 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -1,11 +1,27 @@
 #ifndef THREAD_COMPAT_H
 #define THREAD_COMPAT_H
 
+/*
+ * This variable is used by commands to globally tell affected
+ * subsystems that they must use thread-safe mechanisms.
+ */
+extern int use_threads;
+
 #ifndef NO_PTHREADS
 #include <pthread.h>
 
 extern int online_cpus(void);
 extern int init_recursive_mutex(pthread_mutex_t*);
 
+/* These functions do nothing if use_threads==0 or NO_PTHREADS */
+extern void lock_if_threaded(pthread_mutex_t*);
+extern void unlock_if_threaded(pthread_mutex_t*);
+
+#else
+
+#define lock_if_threaded(lock)
+#define unlock_if_threaded(lock)
+
 #endif
+
 #endif /* THREAD_COMPAT_H */
-- 
1.7.8.431.g2abf2
