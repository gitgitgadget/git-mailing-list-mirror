From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (May 2010, #01; Sun, 2)
Date: Sun, 02 May 2010 22:01:37 +0200
Message-ID: <4BDDDA21.4090304@kdbg.org>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 22:02:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8fMW-0001ym-4Y
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 22:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532Ab0EBUBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 16:01:47 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:9424 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756911Ab0EBUBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 16:01:46 -0400
Received: from [77.118.71.226] (77.118.71.226.wireless.dyn.drei.com [77.118.71.226])
	by bsmtp.bon.at (Postfix) with ESMTP id CFB37A7EB5;
	Sun,  2 May 2010 22:01:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146197>

Am 02.05.2010 18:12, schrieb Junio C Hamano:
> * np/malloc-threading (2010-04-08) 2 commits
>    (merged to 'next' on 2010-04-10 at e1730fb)
>   + Thread-safe xmalloc and xrealloc needs a recursive mutex
>   + Make xmalloc and xrealloc thread-safe
> 
> The fix should eventually go to 'maint' and 'master'.  This queues the one
> from J6t for Windows compatibility.
> 
> * js/async-thread (2010-03-09) 7 commits
>    (merged to 'next' on 2010-04-22 at ee8874e)
>   + Enable threaded async procedures whenever pthreads is available
>    (merged to 'next' on 2010-03-20 at 9939243)
>   + Dying in an async procedure should only exit the thread, not the process.
>   + Reimplement async procedures using pthreads
>   + Windows: more pthreads functions
>   + Fix signature of fcntl() compatibility dummy
>   + Make report() from usage.c public as vreportf() and use it.
>   + Modernize t5530-upload-pack-error.
> 
> As the malloc-threading topic has been cooking for a while, the tip one
> may not be so bad to unleash to 'next' users, especially because we are in
> the pre-release feature freeze.

Note that np/malloc-threading does not help the potential xmalloc race
condition in js/async-thread topic at all. :-( np/malloc-threading is only
about a race that is internal in pack-objects.

Now that you force me to think about the problem, I suggest something along
these lines: Disable try_to_free_routine when GIT_TRACE is set, and require
callers of set_try_to_free_routine to restore the previous routine.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 214d7ef..0e81673 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,6 +1529,8 @@ static void try_to_free_from_threads(size_t size)
 	read_unlock();
 }
 
+try_to_free_t old_try_to_free_routine;
+
 /*
  * The main thread waits on the condition that (at least) one of the workers
  * has stopped working (which is indicated in the .working member of
@@ -1563,12 +1565,12 @@ static void init_threaded_search(void)
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
-	set_try_to_free_routine(try_to_free_from_threads);
+	old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
 }
 
 static void cleanup_threaded_search(void)
 {
-	set_try_to_free_routine(NULL);
+	set_try_to_free_routine(old_try_to_free_routine);
 	pthread_cond_destroy(&progress_cond);
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&cache_mutex);
diff --git a/git-compat-util.h b/git-compat-util.h
index 4a508c1..51d2a01 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,7 +357,8 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 
 extern void release_pack_memory(size_t, int);
 
-extern void set_try_to_free_routine(void (*routine)(size_t));
+typedef void (*try_to_free_t)(size_t);
+extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
diff --git a/trace.c b/trace.c
index 4229ae1..9816a8b 100644
--- a/trace.c
+++ b/trace.c
@@ -72,6 +72,7 @@ void trace_printf(const char *fmt, ...)
 	if (!fd)
 		return;
 
+	set_try_to_free_routine(NULL);
 	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
@@ -103,6 +104,7 @@ void trace_argv_printf(const char **argv, const char *fmt, ...)
 	if (!fd)
 		return;
 
+	set_try_to_free_routine(NULL);
 	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
diff --git a/wrapper.c b/wrapper.c
index 62edb57..02da613 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -10,9 +10,11 @@ static void try_to_free_builtin(size_t size)
 
 static void (*try_to_free_routine)(size_t size) = try_to_free_builtin;
 
-void set_try_to_free_routine(void (*routine)(size_t))
+try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 {
-	try_to_free_routine = (routine) ? routine : try_to_free_builtin;
+	try_to_free_t old = try_to_free_routine;
+	try_to_free_routine = routine;
+	return old;
 }
 
 char *xstrdup(const char *str)
@@ -33,8 +35,10 @@ void *xmalloc(size_t size)
 	if (!ret && !size)
 		ret = malloc(1);
 	if (!ret) {
-		try_to_free_routine(size);
-		ret = malloc(size);
+		if (try_to_free_routine) {
+			try_to_free_routine(size);
+			ret = malloc(size);
+		}
 		if (!ret && !size)
 			ret = malloc(1);
 		if (!ret)
