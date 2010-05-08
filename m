From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] Have set_try_to_free_routine return the previous routine
Date: Sat, 8 May 2010 17:13:49 +0200
Message-ID: <201005081713.49937.j6t@kdbg.org>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org> <4BDDDA21.4090304@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 08 17:18:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAln7-0003m9-W6
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 17:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0EHPQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 11:16:29 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:16352 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752271Ab0EHPQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 11:16:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 57D51A7EB0;
	Sat,  8 May 2010 17:16:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 227B319F747;
	Sat,  8 May 2010 17:13:50 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <4BDDDA21.4090304@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146661>

This effectively requires from the callers of set_try_to_free_routine to
treat the try-to-free-routines as a stack.

We will need this for the next patch where the only current caller cannot
depend on that the previously set routine was the default routine.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
On Sonntag, 2. Mai 2010, Johannes Sixt wrote:
> Am 02.05.2010 18:12, schrieb Junio C Hamano:
> > * np/malloc-threading (2010-04-08) 2 commits
> >
> > * js/async-thread (2010-03-09) 7 commits
>
> Note that np/malloc-threading does not help the potential xmalloc race
> condition in js/async-thread topic at all. :-( np/malloc-threading is only
> about a race that is internal in pack-objects.
>
> Now that you force me to think about the problem, I suggest something along
> these lines: Disable try_to_free_routine when GIT_TRACE is set, and require
> callers of set_try_to_free_routine to restore the previous routine.

Here is a 2-patch series that implements this idea. I wrote it on top of
np/malloc-threading, because it implements the infrastructure that is
necessary for this.

 builtin-pack-objects.c |    6 ++++--
 git-compat-util.h      |    3 ++-
 wrapper.c              |    6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 26fc7cd..5279cd9 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1556,6 +1556,8 @@ static void try_to_free_from_threads(size_t size)
 	read_unlock();
 }
 
+try_to_free_t old_try_to_free_routine;
+
 /*
  * The main thread waits on the condition that (at least) one of the workers
  * has stopped working (which is indicated in the .working member of
@@ -1590,12 +1592,12 @@ static void init_threaded_search(void)
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
index 1c171db..828aada 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -346,7 +346,8 @@ static inline char *gitstrchrnul(const char *s, int c)
 
 extern void release_pack_memory(size_t, int);
 
-extern void set_try_to_free_routine(void (*routine)(size_t));
+typedef void (*try_to_free_t)(size_t);
+extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
diff --git a/wrapper.c b/wrapper.c
index 62edb57..8aa9df9 100644
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
-- 
1.7.1.64.ga1799.dirty
