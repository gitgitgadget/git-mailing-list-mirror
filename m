From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/6] Windows: more pthreads functions
Date: Sat,  6 Mar 2010 16:40:41 +0100
Message-ID: <630b17c350a0014d8099576faeaf113d2804bde6.1267889703.git.j6t@kdbg.org>
References: <cover.1267889703.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15u-0004YU-CT
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab0CFPmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:42:49 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47694 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751557Ab0CFPmo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:42:44 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7C1B32C4013;
	Sat,  6 Mar 2010 16:42:43 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A86BA19F703;
	Sat,  6 Mar 2010 16:41:02 +0100 (CET)
X-Mailer: git-send-email 1.7.0.rc2.65.g7b13a
In-Reply-To: <cover.1267889703.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds:

   pthread_self
   pthread_equal
   pthread_exit
   pthread_key_create
   pthread_setspecific
   pthread_getspecific

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/win32/pthread.c |    8 ++++++++
 compat/win32/pthread.h |   25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 0f949fc..010e875 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -16,6 +16,7 @@
 static unsigned __stdcall win32_start_routine(void *arg)
 {
 	pthread_t *thread = arg;
+	thread->tid = GetCurrentThreadId();
 	thread->arg = thread->start_routine(thread->arg);
 	return 0;
 }
@@ -49,6 +50,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 	}
 }
 
+pthread_t pthread_self(void)
+{
+	pthread_t t = { 0 };
+	t.tid = GetCurrentThreadId();
+	return t;
+}
+
 int pthread_cond_init(pthread_cond_t *cond, const void *unused)
 {
 	cond->waiters = 0;
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index c72f100..c7b8241 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -52,6 +52,7 @@ typedef struct {
 	HANDLE handle;
 	void *(*start_routine)(void*);
 	void *arg;
+	DWORD tid;
 } pthread_t;
 
 extern int pthread_create(pthread_t *thread, const void *unused,
@@ -65,4 +66,28 @@ extern int pthread_create(pthread_t *thread, const void *unused,
 
 extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
 
+#define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
+extern pthread_t pthread_self(void);
+
+static inline int pthread_exit(void *ret)
+{
+	ExitThread((DWORD)ret);
+}
+
+typedef DWORD pthread_key_t;
+static inline int pthread_key_create(pthread_key_t *keyp, void (*destructor)(void *value))
+{
+	return (*keyp = TlsAlloc()) == TLS_OUT_OF_INDEXES ? EAGAIN : 0;
+}
+
+static inline int pthread_setspecific(pthread_key_t key, const void *value)
+{
+	return TlsSetValue(key, (void *)value) ? 0 : EINVAL;
+}
+
+static inline void *pthread_getspecific(pthread_key_t key)
+{
+	return TlsGetValue(key);
+}
+
 #endif /* PTHREAD_H */
-- 
1.7.0.rc2.65.g7b13a
