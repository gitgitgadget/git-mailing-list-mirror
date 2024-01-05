Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9805219FE
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7838 invoked by uid 109); 5 Jan 2024 08:50:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Jan 2024 08:50:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2940 invoked by uid 111); 5 Jan 2024 08:50:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Jan 2024 03:50:37 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Jan 2024 03:50:34 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] index-pack: spawn threads atomically
Message-ID: <20240105085034.GA3078476@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The t5309 script triggers a racy false positive with SANITIZE=leak on a
multi-core system. Running with "--stress --run=6" usually fails within
10 seconds or so for me, complaining with something like:

    + git index-pack --fix-thin --stdin
    fatal: REF_DELTA at offset 46 already resolved (duplicate base 01d7713666f4de822776c7622c10f1b07de280dc?)

    =================================================================
    ==3904583==ERROR: LeakSanitizer: detected memory leaks

    Direct leak of 32 byte(s) in 1 object(s) allocated from:
        #0 0x7fa790d01986 in __interceptor_realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
        #1 0x7fa790add769 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
        #2 0x7fa790d117c5 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
        #3 0x7fa790d11957 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:598
        #4 0x7fa790d03fe8 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:51
        #5 0x7fa790d013fd in __lsan_thread_start_func ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:440
        #6 0x7fa790adc3eb in start_thread nptl/pthread_create.c:444
        #7 0x7fa790b5ca5b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

    SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).
    Aborted

What happens is this:

  0. We construct a bogus pack with a duplicate object in it and trigger
     index-pack.

  1. We spawn a bunch of worker threads to resolve deltas (on my system
     it is 16 threads).

  2. One of the threads sees the duplicate object and bails by calling
     exit(), taking down all of the threads. This is expected and is the
     point of the test.

  3. At the time exit() is called, we may still be spawning threads from
     the main process via pthread_create(). LSan hooks thread creation
     to update its book-keeping; it has to know where each thread's
     stack is (so it can find entry points for reachable memory). So it
     calls pthread_getattr_np() to get information about the new thread.
     That may allocate memory that must be freed with a matching call to
     pthread_attr_destroy(). Probably LSan does that immediately, but
     if you're unlucky enough, the exit() will happen while it's between
     those two calls, and the allocated pthread_attr_t appears as a
     leak.

This isn't a real leak. It's not even in our code, but rather in the
LSan instrumentation code. So we could just ignore it. But the false
positive can cause people to waste time tracking it down.

It's possibly something that LSan could protect against (e.g., cover the
getattr/destroy pair with a mutex, and then in the final post-exit()
check for leaks try to take the same mutex). But I don't know enough
about LSan to say if that's a reasonable approach or not (or if my
analysis is even completely correct).

In the meantime, it's pretty easy to avoid the race by making creation
of the worker threads "atomic". That is, we'll spawn all of them before
letting any of them start to work. That's easy to do because we already
have a work_lock() mutex for handing out that work. If the main process
takes it, then all of the threads will immediately block until we've
finished spawning and released it.

This shouldn't make any practical difference for non-LSan runs. The
thread spawning is quick, and could happen before any worker thread gets
scheduled anyway.

Probably other spots that use threads are subject to the same issues.
But since we have to manually insert locking (and since this really is
kind of a hack), let's not bother with them unless somebody experiences
a similar racy false-positive in practice.

Signed-off-by: Jeff King <peff@peff.net>
---
Rescuing this from:

  https://lore.kernel.org/git/20231221105124.GD570888@coredump.intra.peff.net/

where it was buried deep in a thread. I still think it's kind of gross,
but it may be the least-bad thing.

 builtin/index-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dda94a9f46..0e94819216 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1257,13 +1257,15 @@ static void resolve_deltas(void)
 	base_cache_limit = delta_base_cache_limit * nr_threads;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
+		work_lock();
 		for (i = 0; i < nr_threads; i++) {
 			int ret = pthread_create(&thread_data[i].thread, NULL,
 						 threaded_second_pass, thread_data + i);
 			if (ret)
 				die(_("unable to create thread: %s"),
 				    strerror(ret));
 		}
+		work_unlock();
 		for (i = 0; i < nr_threads; i++)
 			pthread_join(thread_data[i].thread, NULL);
 		cleanup_thread();
-- 
2.43.0.553.g8113c77dd0
