From: Paolo Bonzini <bonzini@gnu.org>
Subject: [RFT PATCH 1/2] win32: optimize condition variable implementation
Date: Mon,  7 Jun 2010 15:38:11 +0200
Message-ID: <1275917892-16437-2-git-send-email-bonzini@gnu.org>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org>
Cc: j.sixt@viscovery.net
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 15:38:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLcX3-00077y-9a
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 15:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab0FGNiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 09:38:18 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:55383 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0FGNiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 09:38:17 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.69)
	(envelope-from <bonzini@gnu.org>)
	id 1OLcWu-0004u0-Kz; Mon, 07 Jun 2010 09:38:16 -0400
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1275917892-16437-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148596>

The fact that the condition variable mutex must be held
(in this implementation) at the time of pthread_cond_signal
and pthread_cond_broadcast means that most of the time the
waiters_lock is useless.  There is exactly one place where
the mutex is not held, and an atomic decrement suffices
there.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 compat/win32/pthread.c |   54 +++++++++++++++++++++++++----------------------
 compat/win32/pthread.h |    1 -
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 010e875..1a38981 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -61,7 +61,6 @@ int pthread_cond_init(pthread_cond_t *cond, const void *unused)
 {
 	cond->waiters = 0;
 	cond->was_broadcast = 0;
-	InitializeCriticalSection(&cond->waiters_lock);
 
 	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
 	if (!cond->sema)
@@ -81,17 +80,17 @@ int pthread_cond_destroy(pthread_cond_t *cond)
 {
 	CloseHandle(cond->sema);
 	CloseHandle(cond->continue_broadcast);
-	DeleteCriticalSection(&cond->waiters_lock);
 	return 0;
 }
 
 int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 {
-	int last_waiter;
+	int num_waiters;
 
-	EnterCriticalSection(&cond->waiters_lock);
+	/*
+	 * This access is protected under the mutex.
+	 */
 	cond->waiters++;
-	LeaveCriticalSection(&cond->waiters_lock);
 
 	/*
 	 * Unlock external mutex and wait for signal.
@@ -105,17 +104,17 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 	WaitForSingleObject(cond->sema, INFINITE);
 
 	/*
-	 * Decrease waiters count. If we are the last waiter, then we must
+	 * Decrease waiters count.  The mutex prevents concurrent increments,
+	 * so doing this decrement atomically is enough.
+	 */
+	num_waiters = InterlockedDecrement(&cond->waiters);
+
+	/* If we are the last waiter, then we must
 	 * notify the broadcasting thread that it can continue.
 	 * But if we continued due to cond_signal, we do not have to do that
 	 * because the signaling thread knows that only one waiter continued.
 	 */
-	EnterCriticalSection(&cond->waiters_lock);
-	cond->waiters--;
-	last_waiter = cond->was_broadcast && cond->waiters == 0;
-	LeaveCriticalSection(&cond->waiters_lock);
-
-	if (last_waiter) {
+	if (num_waiters == 0 && cond->was_broadcast) {
 		/*
 		 * cond_broadcast was issued while mutex was held. This means
 		 * that all other waiters have continued, but are contending
@@ -145,16 +144,17 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
  */
 int pthread_cond_signal(pthread_cond_t *cond)
 {
-	int have_waiters;
-
-	EnterCriticalSection(&cond->waiters_lock);
-	have_waiters = cond->waiters > 0;
-	LeaveCriticalSection(&cond->waiters_lock);
-
 	/*
-	 * Signal only when there are waiters
+	 * Signal only when there are waiters.  cond->waiters is
+	 * incremented by pthread_cond_wait under the external lock,
+	 * so we are safe about that.
+	 *
+	 * Waiting threads decrement it outside the external lock, but
+	 * only if another thread is executing pthread_cond_signal or
+	 * pthread_cond_broadcast---which means it also cannot be
+	 * decremented concurrently with this particular access.
 	 */
-	if (have_waiters)
+	if (cond->waiters > 0)
 		return ReleaseSemaphore(cond->sema, 1, NULL) ?
 			0 : err_win_to_posix(GetLastError());
 	else
@@ -168,12 +168,18 @@ int pthread_cond_signal(pthread_cond_t *cond)
  */
 int pthread_cond_broadcast(pthread_cond_t *cond)
 {
-	EnterCriticalSection(&cond->waiters_lock);
+	/*
+	 * As in pthread_cond_signal, access to cond->waiters and
+	 * cond->was_broadcast is locked via the external mutex.
+	 */
 
 	if ((cond->was_broadcast = cond->waiters > 0)) {
+		BOOLEAN result;
 		/* wake up all waiters */
-		ReleaseSemaphore(cond->sema, cond->waiters, NULL);
-		LeaveCriticalSection(&cond->waiters_lock);
+		result = ReleaseSemaphore(cond->sema, cond->waiters, NULL);
+		if (!result)
+			return err_win_to_posix(GetLastError());
+
 		/*
 		 * At this point all waiters continue. Each one takes its
 		 * slice of the semaphor. Now it's our turn to wait: Since
@@ -189,8 +195,6 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
 		 * without cond->waiters_lock held.
 		 */
 		cond->was_broadcast = 0;
-	} else {
-		LeaveCriticalSection(&cond->waiters_lock);
 	}
 	return 0;
 }
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 2e20548..f38c556 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -40,7 +40,6 @@ typedef int pthread_mutexattr_t;
 typedef struct {
 	LONG waiters;
 	int was_broadcast;
-	CRITICAL_SECTION waiters_lock;
 	HANDLE sema;
 	HANDLE continue_broadcast;
 } pthread_cond_t;
-- 
1.7.0.1
