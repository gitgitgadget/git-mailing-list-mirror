From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Tue, 23 Mar 2010 18:31:14 +0100
Message-ID: <20100323173114.GB4218@fredrik-laptop>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 18:31:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu7ws-00044a-5D
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 18:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab0CWRbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 13:31:20 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:55461 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab0CWRbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 13:31:19 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so702013ewy.28
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zOSw03m7ACVO/I91Ob1daeSgw6nrNKtiswtCELM4p8A=;
        b=CkgfQsO/8a6SK8vDKuffNueDGkBL0/zgIytUKreShaY354NpzcM9e0owCevpyQAtxl
         FJtWlYMAsbj2YppQXhpiepe1gVmoH6gylN4izpmbVo3j9aXAYN/iuDVbA9YaOk1R8A+R
         MrSKk9VRzWbppN7I3ZoQ9PtHrY4I9BpKrgKkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ll2WHT2uEqciSZAU1ot/IZrMWMa4Jzr9OL/VenYf9e4gbLdj8xCZWyiKPN3BFAi4/h
         WrAxyB8dP9X2Cy/GSPylbnsrVRfXyocMsA8pj4qzoIS+ifqNbvVcG6pINkdGHZOMvx3V
         yTSzKjTzOVxGe3wL6oVPGd9COohBRCh2fOzOM=
Received: by 10.213.39.144 with SMTP id g16mr1219119ebe.37.1269365478237;
        Tue, 23 Mar 2010 10:31:18 -0700 (PDT)
Received: from fredrik-laptop (c83-250-159-169.bredband.comhem.se [83.250.159.169])
        by mx.google.com with ESMTPS id 14sm3074744ewy.2.2010.03.23.10.31.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 10:31:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100323161713.3183.57927.stgit@fredrik-laptop>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143033>


Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---

 builtin/grep.c         |    2 +-
 builtin/pack-objects.c |    4 ++--
 git-compat-util.h      |    8 ++++++++
 preload-index.c        |    2 +-
 run-command.c          |    3 ++-
 wrapper.c              |   22 ++++++++++++++++------
 6 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9d30ddb..78b0bf4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -236,7 +236,7 @@ static void start_threads(struct grep_opt *opt)
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
 		compile_grep_patterns(o);
-		err = pthread_create(&threads[i], NULL, run, o);
+		err = xpthread_create(&threads[i], NULL, run, o);
 
 		if (err)
 			die("grep: failed to create thread: %s",
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9780258..022b6a8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1651,8 +1651,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			continue;
 		pthread_mutex_init(&p[i].mutex, NULL);
 		pthread_cond_init(&p[i].cond, NULL);
-		ret = pthread_create(&p[i].thread, NULL,
-				     threaded_find_deltas, &p[i]);
+		ret = xpthread_create(&p[i].thread, NULL,
+				      threaded_find_deltas, &p[i]);
 		if (ret)
 			die("unable to create thread: %s", strerror(ret));
 		active_threads++;
diff --git a/git-compat-util.h b/git-compat-util.h
index aebd9cd..fe10901 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -140,6 +140,10 @@ extern char *gitbasename(char *);
 #include <openssl/err.h>
 #endif
 
+#ifndef NO_PTHREADS
+#include <pthread.h>
+#endif
+
 /* On most systems <limits.h> would have given us this, but
  * not on some systems (e.g. GNU/Hurd).
  */
@@ -356,6 +360,10 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 
 extern void release_pack_memory(size_t, int);
 
+#ifndef NO_PTHREADS
+extern int xpthread_create(pthread_t *thread, const pthread_attr_t *attr,
+			   void *(*start_routine)(void*), void *arg);
+#endif
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
diff --git a/preload-index.c b/preload-index.c
index e3d0bda..250bb0b 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -86,7 +86,7 @@ static void preload_index(struct index_state *index, const char **pathspec)
 		p->offset = offset;
 		p->nr = work;
 		offset += work;
-		if (pthread_create(&p->pthread, NULL, preload_thread, p))
+		if (xpthread_create(&p->pthread, NULL, preload_thread, p))
 			die("unable to create threaded lstat");
 	}
 	for (i = 0; i < threads; i++) {
diff --git a/run-command.c b/run-command.c
index e996b21..1e4def4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -568,7 +568,8 @@ int start_async(struct async *async)
 	async->proc_in = proc_in;
 	async->proc_out = proc_out;
 	{
-		int err = pthread_create(&async->tid, NULL, run_thread, async);
+		int err = xpthread_create(&async->tid, NULL, run_thread,
+					  async);
 		if (err) {
 			error("cannot create thread: %s", strerror(err));
 			goto error;
diff --git a/wrapper.c b/wrapper.c
index 9c71b21..e7140d1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -15,19 +15,29 @@ char *xstrdup(const char *str)
 	return ret;
 }
 
+static int multiple_threads;
+#ifndef NO_PTHREADS
+int xpthread_create(pthread_t *thread, const pthread_attr_t *attr,
+		    void *(*start_routine)(void*), void *arg)
+{
+	multiple_threads = 1;
+	return pthread_create(thread, attr, start_routine, arg);
+}
+#endif
+
 void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
 	if (!ret && !size)
 		ret = malloc(1);
-	if (!ret) {
+	if (!ret && !multiple_threads) {
 		release_pack_memory(size, -1);
 		ret = malloc(size);
 		if (!ret && !size)
 			ret = malloc(1);
-		if (!ret)
-			die("Out of memory, malloc failed");
 	}
+	if (!ret)
+		die("Out of memory, malloc failed");
 #ifdef XMALLOC_POISON
 	memset(ret, 0xA5, size);
 #endif
@@ -66,14 +76,14 @@ void *xrealloc(void *ptr, size_t size)
 	void *ret = realloc(ptr, size);
 	if (!ret && !size)
 		ret = realloc(ptr, 1);
-	if (!ret) {
+	if (!ret && !multiple_threads) {
 		release_pack_memory(size, -1);
 		ret = realloc(ptr, size);
 		if (!ret && !size)
 			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
 	}
+	if (!ret)
+		die("Out of memory, realloc failed");
 	return ret;
 }
 
