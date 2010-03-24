From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 16:22:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003241613020.694@xanadu.home>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
 <20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_JvLtG5y0saYmncxTd4vxvw)"
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:22:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuX6A-0000Ia-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294Ab0CXUWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 16:22:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65145 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822Ab0CXUWf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 16:22:35 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZS009NQZ9MYM41@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Mar 2010 16:22:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143116>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_JvLtG5y0saYmncxTd4vxvw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

By providing a hook for the routine responsible for trying to free some 
memory on malloc failure, we can ensure that the  called routine is
protected by the appropriate locks when threads are in play.

The obvious offender here was pack-objects which was calling xmalloc()
within threads while release_pack_memory() is not thread safe.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

On Wed, 24 Mar 2010, Shawn Pearce wrote:

> On Wed, Mar 24, 2010 at 11:54 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Another solution could be for xmalloc() to use a function pointer for
> > the method to use on malloc error path, which would default to a
> > function calling release_pack_memory(size, -1).  Then pack-objects.c
> > would override the default with its own to acquire the read_mutex around
> > the call to release_pack_memory().  That is probably the easiest
> > solution for now.
> 
> Yea, that sounds like the most reasonable solution right now.

So here it is.

Note: there was a dubious usage of fd when calling release_pack_memory() 
in xmmap() which is now removed.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9780258..65f797f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1522,6 +1522,13 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 
 #ifndef NO_PTHREADS
 
+static void try_to_free_from_threads(size_t size)
+{
+	read_lock();
+	release_pack_memory(size, -1);
+	read_unlock();
+}
+
 /*
  * The main thread waits on the condition that (at least) one of the workers
  * has stopped working (which is indicated in the .working member of
@@ -1556,10 +1563,12 @@ static void init_threaded_search(void)
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
+	set_try_to_free_routine(try_to_free_from_threads);
 }
 
 static void cleanup_threaded_search(void)
 {
+	set_try_to_free_routine(NULL);
 	pthread_cond_destroy(&progress_cond);
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&cache_mutex);
diff --git a/git-compat-util.h b/git-compat-util.h
index aebd9cd..53ab5aa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -356,6 +356,8 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 
 extern void release_pack_memory(size_t, int);
 
+extern void set_try_to_free_routine(void (*routine)(size_t));
+
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
diff --git a/wrapper.c b/wrapper.c
index 9c71b21..8a4f3f2 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,11 +3,23 @@
  */
 #include "cache.h"
 
+static void try_to_free_builtin(size_t size)
+{
+	release_pack_memory(size, -1);
+}
+
+static void (*try_to_free_routine)(size_t size) = try_to_free_builtin;
+
+void set_try_to_free_routine(void (*routine)(size_t))
+{
+	try_to_free_routine = (routine) ? routine : try_to_free_builtin;
+}
+
 char *xstrdup(const char *str)
 {
 	char *ret = strdup(str);
 	if (!ret) {
-		release_pack_memory(strlen(str) + 1, -1);
+		try_to_free_routine(strlen(str) + 1);
 		ret = strdup(str);
 		if (!ret)
 			die("Out of memory, strdup failed");
@@ -21,7 +33,7 @@ void *xmalloc(size_t size)
 	if (!ret && !size)
 		ret = malloc(1);
 	if (!ret) {
-		release_pack_memory(size, -1);
+		try_to_free_routine(size);
 		ret = malloc(size);
 		if (!ret && !size)
 			ret = malloc(1);
@@ -67,7 +79,7 @@ void *xrealloc(void *ptr, size_t size)
 	if (!ret && !size)
 		ret = realloc(ptr, 1);
 	if (!ret) {
-		release_pack_memory(size, -1);
+		try_to_free_routine(size);
 		ret = realloc(ptr, size);
 		if (!ret && !size)
 			ret = realloc(ptr, 1);
@@ -83,7 +95,7 @@ void *xcalloc(size_t nmemb, size_t size)
 	if (!ret && (!nmemb || !size))
 		ret = calloc(1, 1);
 	if (!ret) {
-		release_pack_memory(nmemb * size, -1);
+		try_to_free_routine(nmemb * size);
 		ret = calloc(nmemb, size);
 		if (!ret && (!nmemb || !size))
 			ret = calloc(1, 1);
@@ -100,7 +112,7 @@ void *xmmap(void *start, size_t length,
 	if (ret == MAP_FAILED) {
 		if (!length)
 			return NULL;
-		release_pack_memory(length, fd);
+		try_to_free_routine(length);
 		ret = mmap(start, length, prot, flags, fd, offset);
 		if (ret == MAP_FAILED)
 			die_errno("Out of memory? mmap failed");

--Boundary_(ID_JvLtG5y0saYmncxTd4vxvw)--
