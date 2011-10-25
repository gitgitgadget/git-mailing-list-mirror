From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 16:55:09 +0200
Message-ID: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Oct 25 16:55:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIiPO-00064C-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 16:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab1JYOzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 10:55:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63922 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab1JYOzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 10:55:11 -0400
Received: by bkbzt19 with SMTP id zt19so603112bkb.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8MQ1dbda57HcoZ5YdpK0m+E5m7V4Dpye+0HcstvGk08=;
        b=HwWVrrEO2iYmybkEj44qeS/gbXiZ6FHqjlV/LizNOkwww16g0Y2h38U2CodN110gIx
         HggpzkCsPePCX7ZhceBR4LWZCOWoFCSFp45tgq1Rw/GRmh3Fg4LeZrA6RnOe59sBrvNF
         2+ZWrk1c45KqEf/dNegIhyyl848Q37JDV+Vts=
Received: by 10.204.156.73 with SMTP id v9mr21009690bkw.58.1319554509627;
        Tue, 25 Oct 2011 07:55:09 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id f7sm11647931bkv.4.2011.10.25.07.55.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Oct 2011 07:55:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.msysgit.1.1.g7b316
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184208>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
Every now and then, someone suggest using PTHREAD_MUTEX_INITIALIZER,
but some times gets show down by our lack of support on Windows.

I'm working on something myself that could benefit from this, so I
gave it a stab. The result looks promising to me, but I haven't
really debugged it yet.

But is there a fundamental reason why we haven't done something like
this before? :)

 compat/win32/pthread.c |   28 +++++++++++++++++++++++++---
 compat/win32/pthread.h |   18 ++++++++++++------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 010e875..14f91d5 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -57,6 +57,28 @@ pthread_t pthread_self(void)
 	return t;
 }
 
+int pthread_mutex_init(pthread_mutex_t *mutex, const pthread_mutexattr_t *attr)
+{
+	InitializeCriticalSection(&mutex->cs);
+	mutex->autoinit = 0;
+	return 0;
+}
+
+int pthread_mutex_lock(pthread_mutex_t *mutex)
+{
+	if (mutex->autoinit) {
+		if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) != -1) {
+			pthread_mutex_init(mutex, NULL);
+			mutex->autoinit = 0;
+		} else
+			while (mutex->autoinit != 0)
+				; /* wait for other thread */
+	}
+
+	EnterCriticalSection(&mutex->cs);
+	return 0;
+}
+
 int pthread_cond_init(pthread_cond_t *cond, const void *unused)
 {
 	cond->waiters = 0;
@@ -85,7 +107,7 @@ int pthread_cond_destroy(pthread_cond_t *cond)
 	return 0;
 }
 
-int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
+int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
 {
 	int last_waiter;
 
@@ -99,7 +121,7 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 	 * waiters count above, so there's no problem with
 	 * leaving mutex unlocked before we wait on semaphore.
 	 */
-	LeaveCriticalSection(mutex);
+	LeaveCriticalSection(&mutex->cs);
 
 	/* let's wait - ignore return value */
 	WaitForSingleObject(cond->sema, INFINITE);
@@ -133,7 +155,7 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 		 */
 	}
 	/* lock external mutex again */
-	EnterCriticalSection(mutex);
+	EnterCriticalSection(&mutex->cs);
 
 	return 0;
 }
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 2e20548..647e6d4 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -16,14 +16,20 @@
 /*
  * Defines that adapt Windows API threads to pthreads API
  */
-#define pthread_mutex_t CRITICAL_SECTION
+typedef struct {
+	CRITICAL_SECTION cs;
+	LONG volatile autoinit;
+} pthread_mutex_t;
 
-#define pthread_mutex_init(a,b) (InitializeCriticalSection((a)), 0)
-#define pthread_mutex_destroy(a) DeleteCriticalSection((a))
-#define pthread_mutex_lock EnterCriticalSection
-#define pthread_mutex_unlock LeaveCriticalSection
+#define PTHREAD_MUTEX_INITIALIZER { { 0 }, 1 }
 
 typedef int pthread_mutexattr_t;
+
+int pthread_mutex_init(pthread_mutex_t *, const pthread_mutexattr_t *);
+#define pthread_mutex_destroy(a) DeleteCriticalSection(&(a)->cs)
+int pthread_mutex_lock(pthread_mutex_t *);
+#define pthread_mutex_unlock(a) LeaveCriticalSection(&(a)->cs)
+
 #define pthread_mutexattr_init(a) (*(a) = 0)
 #define pthread_mutexattr_destroy(a) do {} while (0)
 #define pthread_mutexattr_settype(a, t) 0
@@ -47,7 +53,7 @@ typedef struct {
 
 extern int pthread_cond_init(pthread_cond_t *cond, const void *unused);
 extern int pthread_cond_destroy(pthread_cond_t *cond);
-extern int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex);
+extern int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex);
 extern int pthread_cond_signal(pthread_cond_t *cond);
 extern int pthread_cond_broadcast(pthread_cond_t *cond);
 
-- 
1.7.7.msysgit.1.1.g7b316
