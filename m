From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 3/2] fix race in win32 pthread_cond_signal causing spurious wakeups
Date: Sun, 13 Jun 2010 12:16:52 +0200
Message-ID: <1276424212-13634-1-git-send-email-bonzini@gnu.org>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org>
Cc: j.sixt@viscovery.net
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 13 12:17:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONkFS-0008P6-CQ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 12:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab0FMKQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 06:16:57 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60805 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0FMKQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 06:16:56 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.69)
	(envelope-from <bonzini@gnu.org>)
	id 1ONkFL-00046I-AR; Sun, 13 Jun 2010 06:16:55 -0400
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1275917892-16437-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149041>

This patch fixes a bug in the win32 condvar implementation.  The bug
existed originally in pthread_cond_signal before my other recent patches;
however, my patches extended the bug to pthread_cond_broadcast because
they made it behave exactly like pthread_cond_signal when there is only
one waiter.

The bug causes spurious wakeups in pthread_cond_wait.  These are explicitly
allowed by POSIX, but it's better to prevent them in the first place.
It occurs if pthread_cond_signal is called two times with only one waiter,
and the waiter is not scheduled between the two calls.  In this case, the
second call will find cond->num_waiters == 1 and ReleaseSemaphore will
make the semaphore's count positive, thus causing a spurious wakeup on
the next pthread_cond_wait.

The solution is to decrease cond->waiters in pthread_cond_signal.  This
maintains the invariant that _before_ the external mutex is unlocked
cond->num_waiters matches the waiters count of the semaphore.  This
invariant holds for all three functions.

Broadcasting does not have the problem and uses the same algorithm as
before.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
        I numbered this patch 3/2 because it's on top of the other two,
        but it can be backported to master pretty easily.

 compat/win32/pthread.c |   68 ++++++++++++++++++++++++------------------------
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index d46a51c..9aaac89 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -103,32 +103,27 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 	WaitForSingleObject(cond->sema, INFINITE);
 
 	/*
-	 * Decrease waiters count.  The mutex is not taken, so we have to
-	 * do this atomically.
-	 */
-	num_waiters = InterlockedDecrement(&cond->waiters);
-
-	/* If we are the last waiter, then we must
-	 * notify the broadcasting thread that it can continue.
-	 * But if we continued due to cond_signal, we do not have to do that
-	 * because the signaling thread knows that only one waiter continued.
+	 * If the condvar was broadcast, then waiters cooperate to notify
+	 * the broadcasting thread that they have woken, so that it can
+	 * continue.  For cond_signal we do not have to do that because the
+	 * signaling thread knows that only one waiter continued.  Also,
+	 * cond_signal will decrement num_waiters itself, to ensure it is
+	 * always a faithful reproduction of the semaphore's state.
 	 */
-	if (num_waiters == 0 && cond->was_broadcast) {
+	if (cond->was_broadcast) {
 		/*
-		 * cond_broadcast was issued while mutex was held. This means
-		 * that all other waiters have continued, but are contending
-		 * for the mutex at the end of this function because the
-		 * broadcasting thread did not leave cond_broadcast, yet.
-		 * (This is so that it can be sure that each waiter has
-		 * consumed exactly one slice of the semaphor.)
-		 * The last waiter must tell the broadcasting thread that it
-		 * can go on.
-		 */
-		SetEvent(cond->continue_broadcast);
-		/*
-		 * Now we go on to contend with all other waiters for
-		 * the mutex. Auf in den Kampf!
+		 * Decrease waiters count.  The mutex is not taken, so we have
+		 * to do this atomically.
+		 *
+		 * cond_broadcast was issued while mutex was held, so all
+		 * waiters contend for the mutex at the end of this function
+		 * until the broadcasting thread relinquishes it.  To ensure
+		 * each waiter consumes exactly one slice of the semaphore,
+		 * the broadcasting thread stops until it is told by the last
+		 * waiter that it can go on.
 		 */
+		if (InterlockedDecrement(&cond->waiters) == 0)
+			SetEvent(cond->continue_broadcast);
 	}
 	/* lock external mutex again */
 	EnterCriticalSection(mutex);
@@ -150,14 +144,15 @@ int pthread_cond_signal(pthread_cond_t *cond)
 	 * so we are safe about that.
 	 *
 	 * Waiting threads decrement it outside the external lock, but
-	 * only if another thread is executing pthread_cond_signal or
-	 * pthread_cond_broadcast---which means it also cannot be
-	 * decremented concurrently with this particular access.
+	 * only if another thread is executing pthread_cond_broadcast.
+	 * So, it also cannot be decremented concurrently with this
+	 * particular access.
 	 */
-	if (cond->waiters > 0)
+	if (cond->waiters > 0) {
+		cond->waiters--;
 		return ReleaseSemaphore(cond->sema, 1, NULL) ?
 			0 : err_win_to_posix(GetLastError());
-	else
+	} else
 		return 0;
 }
 
@@ -174,7 +169,15 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
 	 */
 	if (cond->waiters > 0) {
 		BOOLEAN result;
-		cond->was_broadcast = cond->waiters > 1;
+		/*
+		 * As an optimization, when there was exactly one waiter
+		 * broadcast is the same as signal, so we use the asynchronous
+		 * algorithm that signal uses.
+		 */
+		if (cond->waiters == 1)
+			cond->waiters = 0;
+		else
+			cond->was_broadcast = 1;
 
 		/* wake up all waiters */
 		result = ReleaseSemaphore(cond->sema, cond->waiters, NULL);
@@ -183,14 +186,11 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
 
 		/*
 		 * At this point all waiters continue. Each one takes its
-		 * slice of the semaphor. Now it's our turn to wait: Since
+		 * slice of the semaphore. Now it's our turn to wait: Since
 		 * the external mutex is held, no thread can leave cond_wait,
 		 * yet. For this reason, we can be sure that no thread gets
 		 * a chance to eat *more* than one slice. OTOH, it means
 		 * that the last waiter must send us a wake-up.
-		 *
-		 * As an optimization, when there was exactly one waiter
-		 * broadcast is the same as signal and we can skip this step.
 		 */
 		if (cond->was_broadcast) {
 			WaitForSingleObject(cond->continue_broadcast, INFINITE);
-- 
1.7.0.1
