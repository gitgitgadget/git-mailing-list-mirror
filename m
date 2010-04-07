From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Tue, 06 Apr 2010 22:57:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
 <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_3AJPlTdws4MZO9PfHuWj6Q)"
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 04:58:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzLSz-0002ht-Fi
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 04:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0DGC6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 22:58:02 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17793 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0DGC6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 22:58:00 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0H00KUQK8MSD40@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Apr 2010 22:57:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144190>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_3AJPlTdws4MZO9PfHuWj6Q)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

By providing a hook for the routine responsible for trying to free some
memory on malloc failure, we can ensure that the  called routine is
protected by the appropriate locks when threads are in play.

The obvious offender here was pack-objects which was calling xmalloc()
within threads while release_pack_memory() is not thread safe.

To avoid a deadlock if try_to_free_from_threads() is called while
read_lock is already locked within the same thread (may happen through
the read_sha1_file() path), a simple mutex ownership is added. This 
could have been handled automatically with the PTHREAD_MUTEX_RECURSIVE 
type but the Windows pthread emulation would get much more complex.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

On Sat, 27 Mar 2010, Fredrik Kuivinen wrote:

> > +static void try_to_free_from_threads(size_t size)
> > +{
> > +       read_lock();
> > +       release_pack_memory(size, -1);
> > +       read_unlock();
> > +}
> > +
> 
> Will this really work in all cases? In the find_deltas -> try_delta ->
> read_sha1_file -> ... -> xmalloc call path, the mutex is already
> locked when we get to xmalloc.

So here's a fixed version.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9780258..d3ac41f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1211,8 +1211,17 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 #ifndef NO_PTHREADS
 
 static pthread_mutex_t read_mutex;
-#define read_lock()		pthread_mutex_lock(&read_mutex)
-#define read_unlock()		pthread_mutex_unlock(&read_mutex)
+static pthread_t read_mutex_owner;
+#define read_lock() \
+	do { \
+		pthread_mutex_lock(&read_mutex); \
+		read_mutex_owner = pthread_self(); \
+	} while (0)
+#define read_unlock() \
+	do { \
+		memset(&read_mutex_owner, 0, sizeof(read_mutex_owner)); \
+		pthread_mutex_unlock(&read_mutex); \
+	} while (0)
 
 static pthread_mutex_t cache_mutex;
 #define cache_lock()		pthread_mutex_lock(&cache_mutex)
@@ -1522,6 +1531,16 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 
 #ifndef NO_PTHREADS
 
+static void try_to_free_from_threads(size_t size)
+{
+	int self = pthread_equal(read_mutex_owner, pthread_self());
+	if (!self)
+		read_lock();
+	release_pack_memory(size, -1);
+	if (!self)
+		read_unlock();
+}
+
 /*
  * The main thread waits on the condition that (at least) one of the workers
  * has stopped working (which is indicated in the .working member of
@@ -1556,10 +1575,12 @@ static void init_threaded_search(void)
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
index b56c297..4ee8f86 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,6 +357,8 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 
 extern void release_pack_memory(size_t, int);
 
+extern void set_try_to_free_routine(void (*routine)(size_t));
+
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
diff --git a/wrapper.c b/wrapper.c
index 10a6750..58201b6 100644
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

--Boundary_(ID_3AJPlTdws4MZO9PfHuWj6Q)--
