From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Thread-safe xmalloc and xrealloc needs a recursive mutex
Date: Thu, 08 Apr 2010 09:15:39 +0200
Message-ID: <4BBD829B.8040700@viscovery.net>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com> <alpine.LFD.2.00.1003241435300.694@xanadu.home> <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com> <alpine.LFD.2.00.1003241613020.694@xanadu.home> <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com> <alpine.LFD.2.00.1004062152260.7232@xanadu.home> <20100407031655.GA7156@spearce.org> <alpine.LFD.2.00.1004070043450.7232@xanadu.home> <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com> <alpine.LFD.2.00.1004070859540.7232@xanadu.home> <20100407144555.GA23911@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:15:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzlxu-0001Ic-DL
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758371Ab0DHHPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:15:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65077 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab0DHHPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:15:45 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nzlxj-0006X0-Ut; Thu, 08 Apr 2010 09:15:40 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9A8DE1660F;
	Thu,  8 Apr 2010 09:15:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100407144555.GA23911@fredrik-laptop>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144339>

From: Johannes Sixt <j6t@kdbg.org>

The mutex used to protect object access (read_mutex) may need to be
acquired recursively.  Introduce init_recursive_mutex() helper function
in thread-utils.c that constructs a mutex with the PHREAD_MUTEX_RECURSIVE
attribute.

pthread_mutex_init() emulation on Win32 is already recursive as it is
implemented on top of the CRITICAL_SECTION type, which is recursive.

    http://msdn.microsoft.com/en-us/library/ms682530%28VS.85%29.aspx

Add do-nothing compatibility wrappers for pthread_mutexattr* functions.

Initial-version-by: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 4/7/2010 16:45, schrieb Fredrik Kuivinen:
> We only need something like the following (on top of Nico's previous
> patch). Warning: It hasn't even been compile tested on WIN32.

Unfortunately, it doesn't build. This patch replaces the tip of
nd/malloc-threading.

BTW, your uses of strerror(errno) in init_recursive_mutex() were wrong
(pthread functions do not set errno), but it is better in any case to
avoid die() in this function.

-- Hannes

 builtin-grep.c         |    2 +-
 builtin-pack-objects.c |    4 ++--
 compat/win32/pthread.h |    8 +++++++-
 thread-utils.c         |   16 ++++++++++++++++
 thread-utils.h         |    1 +
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 371db0a..52137f4 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -16,8 +16,8 @@
 #include "quote.h"
 
 #ifndef NO_PTHREADS
-#include "thread-utils.h"
 #include <pthread.h>
+#include "thread-utils.h"
 #endif
 
 static char const * const grep_usage[] = {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 0ecc198..26fc7cd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -18,8 +18,8 @@
 #include "refs.h"
 
 #ifndef NO_PTHREADS
-#include "thread-utils.h"
 #include <pthread.h>
+#include "thread-utils.h"
 #endif
 
 static const char pack_usage[] =
@@ -1586,7 +1586,7 @@ static pthread_cond_t progress_cond;
  */
 static void init_threaded_search(void)
 {
-	pthread_mutex_init(&read_mutex, NULL);
+	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index c72f100..a45f8d6 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -18,11 +18,17 @@
  */
 #define pthread_mutex_t CRITICAL_SECTION
 
-#define pthread_mutex_init(a,b) InitializeCriticalSection((a))
+#define pthread_mutex_init(a,b) (InitializeCriticalSection((a)), 0)
 #define pthread_mutex_destroy(a) DeleteCriticalSection((a))
 #define pthread_mutex_lock EnterCriticalSection
 #define pthread_mutex_unlock LeaveCriticalSection
 
+typedef int pthread_mutexattr_t;
+#define pthread_mutexattr_init(a) (*(a) = 0)
+#define pthread_mutexattr_destroy(a) do {} while (0)
+#define pthread_mutexattr_settype(a, t) 0
+#define PTHREAD_MUTEX_RECURSIVE 0
+
 /*
  * Implement simple condition variable for Windows threads, based on ACE
  * implementation.
diff --git a/thread-utils.c b/thread-utils.c
index 4f9c829..589f838 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include <pthread.h>
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
@@ -43,3 +44,18 @@ int online_cpus(void)
 
 	return 1;
 }
+
+int init_recursive_mutex(pthread_mutex_t *m)
+{
+	pthread_mutexattr_t a;
+	int ret;
+
+	ret = pthread_mutexattr_init(&a);
+	if (!ret) {
+		ret = pthread_mutexattr_settype(&a, PTHREAD_MUTEX_RECURSIVE);
+		if (!ret)
+			ret = pthread_mutex_init(m, &a);
+		pthread_mutexattr_destroy(&a);
+	}
+	return ret;
+}
diff --git a/thread-utils.h b/thread-utils.h
index cce4b77..1727a03 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -2,5 +2,6 @@
 #define THREAD_COMPAT_H
 
 extern int online_cpus(void);
+extern int init_recursive_mutex(pthread_mutex_t*);
 
 #endif /* THREAD_COMPAT_H */
-- 
1.7.0.3.1356.g75346
