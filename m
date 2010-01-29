From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Implement pthread_cond_broadcast on Windows
Date: Sat, 30 Jan 2010 00:54:05 +0100
Message-ID: <201001300054.05610.j6t@kdbg.org>
References: <4B62CEAB.5050608@viscovery.net> <201001292102.49105.j6t@kdbg.org> <201001292316.03858.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Zolt=C3=A1n_F=C3=BCzesi?= <zfuzesi@eaglet.hu>,
	git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	"Erik Faye-Lund" <kusmabite@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 00:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb0gS-0002yJ-10
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab0A2XzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131Ab0A2XzX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:55:23 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:22899 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752903Ab0A2XzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 18:55:22 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D4478CDF8E;
	Sat, 30 Jan 2010 00:55:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A86C819F609;
	Sat, 30 Jan 2010 00:54:05 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001292316.03858.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138403>

See http://www.cse.wustl.edu/~schmidt/win32-cv-1.html, section "The
SignalObjectAndWait solution". But note that this implementation does not
use SignalObjectAndWait (which is needed to achieve fairness, but we do
not need fairness).

Note that our implementations of pthread_cond_broadcast and
pthread_cond_signal require that they are invoked with the mutex held that
is used in the pthread_cond_wait calls.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Junio,

 please queue this patch for 1.7.0-rc1 even though it has not undergone
 a lot of review - the result is better than a git that does not even
 build on Windows.

 I had another look at this complete implementation of p_c_b and am now
 convinced that it is correct, but an extra set of eye-balls is always
 appreciated. I've Cc'd people who had shown interest in pthreads on
 Windows in the past.

 -- Hannes

 compat/win32/pthread.c |  100 ++++++++++++++++++++++++++++++++++++++++++-----
 compat/win32/pthread.h |    9 ++--
 2 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 631c0a4..e592084 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -52,24 +52,38 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 int pthread_cond_init(pthread_cond_t *cond, const void *unused)
 {
 	cond->waiters = 0;
+	cond->was_broadcast = 0;
+	InitializeCriticalSection(&cond->waiters_lock);
 
 	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
 	if (!cond->sema)
 		die("CreateSemaphore() failed");
+
+	cond->continue_broadcast = CreateEvent(NULL,	/* security */
+				FALSE,			/* auto-reset */
+				FALSE,			/* not signaled */
+				NULL);			/* name */
+	if (!cond->continue_broadcast)
+		die("CreateEvent() failed");
+
 	return 0;
 }
 
 int pthread_cond_destroy(pthread_cond_t *cond)
 {
 	CloseHandle(cond->sema);
-	cond->sema = NULL;
-
+	CloseHandle(cond->continue_broadcast);
+	DeleteCriticalSection(&cond->waiters_lock);
 	return 0;
 }
 
 int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 {
-	InterlockedIncrement(&cond->waiters);
+	int last_waiter;
+
+	EnterCriticalSection(&cond->waiters_lock);
+	cond->waiters++;
+	LeaveCriticalSection(&cond->waiters_lock);
 
 	/*
 	 * Unlock external mutex and wait for signal.
@@ -82,22 +96,52 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 	/* let's wait - ignore return value */
 	WaitForSingleObject(cond->sema, INFINITE);
 
-	/* we're done waiting, so make sure we decrease waiters count */
-	InterlockedDecrement(&cond->waiters);
-
+	/*
+	 * Decrease waiters count. If we are the last waiter, then we must
+	 * notify the broadcasting thread that it can continue.
+	 * But if we continued due to cond_signal, we do not have to do that
+	 * because the signaling thread knows that only one waiter continued.
+	 */
+	EnterCriticalSection(&cond->waiters_lock);
+	cond->waiters--;
+	last_waiter = cond->was_broadcast && cond->waiters == 0;
+	LeaveCriticalSection(&cond->waiters_lock);
+
+	if (last_waiter) {
+		/*
+		 * cond_broadcast was issued while mutex was held. This means
+		 * that all other waiters have continued, but are contending
+		 * for the mutex at the end of this function because the
+		 * broadcasting thread did not leave cond_broadcast, yet.
+		 * (This is so that it can be sure that each waiter has
+		 * consumed exactly one slice of the semaphor.)
+		 * The last waiter must tell the broadcasting thread that it
+		 * can go on.
+		 */
+		SetEvent(cond->continue_broadcast);
+		/*
+		 * Now we go on to contend with all other waiters for
+		 * the mutex. Auf in den Kampf!
+		 */
+	}
 	/* lock external mutex again */
 	EnterCriticalSection(mutex);
 
 	return 0;
 }
 
+/*
+ * IMPORTANT: This implementation requires that pthread_cond_signal
+ * is called while the mutex is held that is used in the corresponding
+ * pthread_cond_wait calls!
+ */
 int pthread_cond_signal(pthread_cond_t *cond)
 {
-	/*
-	 * Access to waiters count is atomic; see "Interlocked Variable Access"
-	 * http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx
-	 */
-	int have_waiters = cond->waiters > 0;
+	int have_waiters;
+	
+	EnterCriticalSection(&cond->waiters_lock);
+	have_waiters = cond->waiters > 0;
+	LeaveCriticalSection(&cond->waiters_lock);
 
 	/*
 	 * Signal only when there are waiters
@@ -108,3 +152,37 @@ int pthread_cond_signal(pthread_cond_t *cond)
 	else
 		return 0;
 }
+
+/*
+ * DOUBLY IMPORTANT: This implementation requires that pthread_cond_broadcast
+ * is called while the mutex is held that is used in the corresponding
+ * pthread_cond_wait calls!
+ */
+int pthread_cond_broadcast(pthread_cond_t *cond)
+{
+	EnterCriticalSection(&cond->waiters_lock);
+
+	if ((cond->was_broadcast = cond->waiters > 0)) {
+		/* wake up all waiters */
+		ReleaseSemaphore(cond->sema, cond->waiters, NULL);
+		LeaveCriticalSection(&cond->waiters_lock);
+		/*
+		 * At this point all waiters continue. Each one takes its
+		 * slice of the semaphor. Now it's our turn to wait: Since
+		 * the external mutex is held, no thread can leave cond_wait,
+		 * yet. For this reason, we can be sure that no thread gets
+		 * a chance to eat *more* than one slice. OTOH, it means
+		 * that the last waiter must send us a wake-up.
+		 */
+		WaitForSingleObject(cond->continue_broadcast, INFINITE);
+		/*
+		 * Since the external mutex is held, no thread can enter
+		 * cond_wait, and, hence, it is safe to reset this flag
+		 * without cond->waiters_lock held.
+		 */
+		cond->was_broadcast = 0;
+	} else {
+		LeaveCriticalSection(&cond->waiters_lock);
+	}
+	return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index b8e1bcb..c72f100 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -32,17 +32,18 @@
  * See also: http://www.cse.wustl.edu/~schmidt/win32-cv-1.html
  */
 typedef struct {
-	volatile LONG waiters;
+	LONG waiters;
+	int was_broadcast;
+	CRITICAL_SECTION waiters_lock;
 	HANDLE sema;
+	HANDLE continue_broadcast;
 } pthread_cond_t;
 
 extern int pthread_cond_init(pthread_cond_t *cond, const void *unused);
-
 extern int pthread_cond_destroy(pthread_cond_t *cond);
-
 extern int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex);
-
 extern int pthread_cond_signal(pthread_cond_t *cond);
+extern int pthread_cond_broadcast(pthread_cond_t *cond);
 
 /*
  * Simple thread creation implementation using pthread API
-- 
1.6.6.264.ga6155
