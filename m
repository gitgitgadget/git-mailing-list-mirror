From: Paolo Bonzini <bonzini@gnu.org>
Subject: [RFT PATCH 2/2] win32: optimize pthread_cond_broadcast
Date: Mon,  7 Jun 2010 15:38:12 +0200
Message-ID: <1275917892-16437-3-git-send-email-bonzini@gnu.org>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org>
Cc: j.sixt@viscovery.net
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 15:38:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLcX3-00077y-P1
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 15:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab0FGNiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 09:38:20 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:55385 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0FGNiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 09:38:19 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.69)
	(envelope-from <bonzini@gnu.org>)
	id 1OLcWw-0004u8-M8; Mon, 07 Jun 2010 09:38:18 -0400
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1275917892-16437-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148597>

If there is a single waiting thread, pthread_cond_signal is the
same as pthread_cond_broadcast and no extra synchronization is
necessary.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 compat/win32/pthread.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 1a38981..d46a51c 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -172,9 +172,10 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
 	 * As in pthread_cond_signal, access to cond->waiters and
 	 * cond->was_broadcast is locked via the external mutex.
 	 */
-
-	if ((cond->was_broadcast = cond->waiters > 0)) {
+	if (cond->waiters > 0) {
 		BOOLEAN result;
+		cond->was_broadcast = cond->waiters > 1;
+
 		/* wake up all waiters */
 		result = ReleaseSemaphore(cond->sema, cond->waiters, NULL);
 		if (!result)
@@ -187,14 +188,14 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
 		 * yet. For this reason, we can be sure that no thread gets
 		 * a chance to eat *more* than one slice. OTOH, it means
 		 * that the last waiter must send us a wake-up.
+		 *
+		 * As an optimization, when there was exactly one waiter
+		 * broadcast is the same as signal and we can skip this step.
 		 */
-		WaitForSingleObject(cond->continue_broadcast, INFINITE);
-		/*
-		 * Since the external mutex is held, no thread can enter
-		 * cond_wait, and, hence, it is safe to reset this flag
-		 * without cond->waiters_lock held.
-		 */
-		cond->was_broadcast = 0;
+		if (cond->was_broadcast) {
+			WaitForSingleObject(cond->continue_broadcast, INFINITE);
+			cond->was_broadcast = 0;
+		}
 	}
 	return 0;
 }
-- 
1.7.0.1
