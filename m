Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E071F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfHLUuY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 16:50:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:41194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726702AbfHLUuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 16:50:23 -0400
Received: (qmail 28478 invoked by uid 109); 12 Aug 2019 20:50:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 20:50:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26816 invoked by uid 111); 12 Aug 2019 20:53:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 16:53:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 16:50:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, l.s.r@web.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
Message-ID: <20190812205021.GA19712@sigill.intra.peff.net>
References: <20190810220251.3684-1-carenas@gmail.com>
 <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet>
 <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
 <20190812195537.GA14223@sigill.intra.peff.net>
 <xmqqd0ha9ml4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0ha9ml4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 01:04:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think it might be worth just eliminating the whole idea.
> 
> I kinda like the simplification ;-) An even thinner wrapper that
> calls malloc() and dies if it gets NULL, without any "try-to-free"
> logic.

Here it is as a patch. Note that my earlier argument around window size
is a bit questionable; the real impact there is core.packedGitLimit,
which I've clarified below.

-- >8 --
Subject: [PATCH] packfile: drop release_pack_memory()

Long ago, in 97bfeb34df (Release pack windows before reporting out of
memory., 2006-12-24), we taught xmalloc() and friends to try unmapping
pack windows when malloc() failed. It's unlikely that his helps a lot in
practice, and it has some downsides. First, the downsides:

  1. It makes xmalloc() not thread-safe. We've worked around this in
     pack-objects.c, which installs its own locking version of the
     try_to_free_routine(). But other threaded code doesn't.

  2. It makes the system as a whole harder to reason about. Functions
     which allocate heap memory under the hood may have farther-reaching
     effects than expected.

That might be worth the tradeoff if there's a benefit. But in practice,
it seems unlikely. We're generally dealing with mmap'd files, so the OS
is going to do a much better job at responding to memory pressure by
dropping individual pages (the exception is systems with NO_MMAP, but
even there the OS can probably respond just as well with swapping).

So the only thing we're really freeing is address space. On 64-bit
systems, we have plenty of that to go around. On 32-bit systems, it
could possibly help. But around the same time we made two other changes:
77ccc5bbd1 (Introduce new config option for mmap limit., 2006-12-23) and
60bb8b1453 (Fully activate the sliding window pack access., 2006-12-23).
Together that means that a 32-bit system should have no more than 256MB
total of packed-git mmaps at one time, split between a few 32MB windows.
It's unlikely we have any address space problems since then, but we
don't have any data since the features were all added at the same time.

Likewise, xmmap() will try to free memory. At first glance, it seems
like we'd need this (when we try to mmap a new window, we might need to
close an old one to save address space on a 32-bit system). But we're
saved again by core.packedGitLimit: if we're going to exceed our 256MB
limit, we'll close an existing window before we even call mmap().

So it seems unlikely that this feature is actually doing anything
useful. And while we don't have reports of it harming anything (probably
because it rarely if ever kicks in), it would be nice to simplify the
system overall. This patch drops the whole try_to_free system from
xmalloc(), as well as the manual pack memory release in xmmap().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 11 --------
 git-compat-util.h      |  3 --
 packfile.c             | 18 ------------
 sha1-file.c            |  8 ++----
 trace.c                |  2 --
 wrapper.c              | 63 +++++++++---------------------------------
 6 files changed, 15 insertions(+), 90 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 76ce906946..93e92876aa 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2342,15 +2342,6 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 	free(array);
 }
 
-static void try_to_free_from_threads(size_t size)
-{
-	packing_data_lock(&to_pack);
-	release_pack_memory(size);
-	packing_data_unlock(&to_pack);
-}
-
-static try_to_free_t old_try_to_free_routine;
-
 /*
  * The main object list is split into smaller lists, each is handed to
  * one worker.
@@ -2391,12 +2382,10 @@ static void init_threaded_search(void)
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
-	old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
 }
 
 static void cleanup_threaded_search(void)
 {
-	set_try_to_free_routine(old_try_to_free_routine);
 	pthread_cond_destroy(&progress_cond);
 	pthread_mutex_destroy(&cache_mutex);
 	pthread_mutex_destroy(&progress_mutex);
diff --git a/git-compat-util.h b/git-compat-util.h
index 83be89de0a..f0d13e4e28 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -818,9 +818,6 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 int git_atexit(void (*handler)(void));
 #endif
 
-typedef void (*try_to_free_t)(size_t);
-try_to_free_t set_try_to_free_routine(try_to_free_t);
-
 static inline size_t st_add(size_t a, size_t b)
 {
 	if (unsigned_add_overflows(a, b))
diff --git a/packfile.c b/packfile.c
index fc43a6c52c..d98ac22876 100644
--- a/packfile.c
+++ b/packfile.c
@@ -287,13 +287,6 @@ static int unuse_one_window(struct packed_git *current)
 	return 0;
 }
 
-void release_pack_memory(size_t need)
-{
-	size_t cur = pack_mapped;
-	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
-		; /* nothing */
-}
-
 void close_pack_windows(struct packed_git *p)
 {
 	while (p->windows) {
@@ -710,23 +703,12 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-static void try_to_free_pack_memory(size_t size)
-{
-	release_pack_memory(size);
-}
-
 struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 {
-	static int have_set_try_to_free_routine;
 	struct stat st;
 	size_t alloc;
 	struct packed_git *p;
 
-	if (!have_set_try_to_free_routine) {
-		have_set_try_to_free_routine = 1;
-		set_try_to_free_routine(try_to_free_pack_memory);
-	}
-
 	/*
 	 * Make sure a corresponding .pack file exists and that
 	 * the index looks sane.
diff --git a/sha1-file.c b/sha1-file.c
index 487ea35d2d..4895408e1e 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -952,12 +952,8 @@ void *xmmap_gently(void *start, size_t length,
 
 	mmap_limit_check(length);
 	ret = mmap(start, length, prot, flags, fd, offset);
-	if (ret == MAP_FAILED) {
-		if (!length)
-			return NULL;
-		release_pack_memory(length);
-		ret = mmap(start, length, prot, flags, fd, offset);
-	}
+	if (ret == MAP_FAILED && !length)
+		ret = NULL;
 	return ret;
 }
 
diff --git a/trace.c b/trace.c
index fa4a2e7120..b3ef0e627f 100644
--- a/trace.c
+++ b/trace.c
@@ -88,8 +88,6 @@ static int prepare_trace_line(const char *file, int line,
 	if (!trace_want(key))
 		return 0;
 
-	set_try_to_free_routine(NULL);	/* is never reset */
-
 	/* unit tests may want to disable additional trace output */
 	if (trace_want(&trace_bare))
 		return 1;
diff --git a/wrapper.c b/wrapper.c
index 1e45ab7b92..c55d7722d7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -4,12 +4,6 @@
 #include "cache.h"
 #include "config.h"
 
-static void do_nothing(size_t size)
-{
-}
-
-static void (*try_to_free_routine)(size_t size) = do_nothing;
-
 static int memory_limit_check(size_t size, int gentle)
 {
 	static size_t limit = 0;
@@ -30,24 +24,11 @@ static int memory_limit_check(size_t size, int gentle)
 	return 0;
 }
 
-try_to_free_t set_try_to_free_routine(try_to_free_t routine)
-{
-	try_to_free_t old = try_to_free_routine;
-	if (!routine)
-		routine = do_nothing;
-	try_to_free_routine = routine;
-	return old;
-}
-
 char *xstrdup(const char *str)
 {
 	char *ret = strdup(str);
-	if (!ret) {
-		try_to_free_routine(strlen(str) + 1);
-		ret = strdup(str);
-		if (!ret)
-			die("Out of memory, strdup failed");
-	}
+	if (!ret)
+		die("Out of memory, strdup failed");
 	return ret;
 }
 
@@ -61,19 +42,13 @@ static void *do_xmalloc(size_t size, int gentle)
 	if (!ret && !size)
 		ret = malloc(1);
 	if (!ret) {
-		try_to_free_routine(size);
-		ret = malloc(size);
-		if (!ret && !size)
-			ret = malloc(1);
-		if (!ret) {
-			if (!gentle)
-				die("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				    (unsigned long)size);
-			else {
-				error("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				      (unsigned long)size);
-				return NULL;
-			}
+		if (!gentle)
+			die("Out of memory, malloc failed (tried to allocate %lu bytes)",
+			    (unsigned long)size);
+		else {
+			error("Out of memory, malloc failed (tried to allocate %lu bytes)",
+			      (unsigned long)size);
+			return NULL;
 		}
 	}
 #ifdef XMALLOC_POISON
@@ -138,14 +113,8 @@ void *xrealloc(void *ptr, size_t size)
 	ret = realloc(ptr, size);
 	if (!ret && !size)
 		ret = realloc(ptr, 1);
-	if (!ret) {
-		try_to_free_routine(size);
-		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
-	}
+	if (!ret)
+		die("Out of memory, realloc failed");
 	return ret;
 }
 
@@ -160,14 +129,8 @@ void *xcalloc(size_t nmemb, size_t size)
 	ret = calloc(nmemb, size);
 	if (!ret && (!nmemb || !size))
 		ret = calloc(1, 1);
-	if (!ret) {
-		try_to_free_routine(nmemb * size);
-		ret = calloc(nmemb, size);
-		if (!ret && (!nmemb || !size))
-			ret = calloc(1, 1);
-		if (!ret)
-			die("Out of memory, calloc failed");
-	}
+	if (!ret)
+		die("Out of memory, calloc failed");
 	return ret;
 }
 
-- 
2.23.0.rc2.466.gd4688353c7

