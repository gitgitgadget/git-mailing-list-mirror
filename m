From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Windows: a minimal pthread_cond_broadcast
Date: Fri, 29 Jan 2010 23:16:03 +0100
Message-ID: <201001292316.03858.j6t@kdbg.org>
References: <4B62CEAB.5050608@viscovery.net> <1264793213-8805-1-git-send-email-zfuzesi@eaglet.hu> <201001292102.49105.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: =?utf-8?q?Zolt=C3=A1n_F=C3=BCzesi?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naz9Z-00051o-7u
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab0A2WRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755787Ab0A2WRV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:17:21 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:52577 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753762Ab0A2WRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:17:20 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 99877A7EAE;
	Fri, 29 Jan 2010 23:17:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E5C0119F609;
	Fri, 29 Jan 2010 23:16:03 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001292102.49105.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138384>

[Cc msysgit list]

On Freitag, 29. Januar 2010, Johannes Sixt wrote:
> cond_broadcast is not that trivial.

... except when it can be tailor-made for a particular use-case.
What do people think about this?

I had implemented a full-blown pthread_cond_broadcast, taking ACE as
an example, but I had doubts about its correctness. Then I noticed that
we do not need a complete implementation anyway. So here we go...

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Windows: a minimal pthread_cond_broadcast

This is not an implementation, but more a fake of pthread_cond_broadcast.
It is sufficient for the only call site in builtin-grep.c that we have
at this time. It works because the threads that wake up due to this call
do not call pthread_cond_wait anymore and terminate.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/win32/pthread.c |   10 ++++++++++
 compat/win32/pthread.h |    4 +---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 631c0a4..7b5cac1 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -108,3 +108,13 @@ int pthread_cond_signal(pthread_cond_t *cond)
 	else
 		return 0;
 }
+
+/*
+ * FIXME: This is a fake implementation that is tailored for the only
+ * user that we currently have.
+ */
+int pthread_cond_broadcast(pthread_cond_t *cond)
+{
+	ReleaseSemaphore(cond->sema, cond->waiters, NULL);
+	return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index b8e1bcb..7c360d5 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -37,12 +37,10 @@ typedef struct {
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
