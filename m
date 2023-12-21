Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E36AB9A
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22450 invoked by uid 109); 21 Dec 2023 10:51:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 10:51:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23225 invoked by uid 111); 21 Dec 2023 10:51:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 05:51:24 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 05:51:24 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/26] pack-objects: multi-pack verbatim reuse
Message-ID: <20231221105124.GD570888@coredump.intra.peff.net>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
 <xmqqbkasnxba.fsf@gitster.g>
 <xmqq7clgnvqv.fsf@gitster.g>
 <ZXurD1NTZ4TAs7WZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXurD1NTZ4TAs7WZ@nand.local>

On Thu, Dec 14, 2023 at 08:25:35PM -0500, Taylor Blau wrote:

> On Thu, Dec 14, 2023 at 04:40:40PM -0800, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > I haven't looked into the details yet, but it seems that
> > > t5309-pack-delta-cycles.sh fails under
> > >
> > >     $ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make -j16 test
> >
> > Hmph, this seems to be elusive.  I tried it again and then it did
> > not fail this time.
> 
> Indeed, but I was able to reproduce the failure both on my branch and on
> 'master' under --stress, yielding the following failure in t5309.6:

OK, so it's nothing new, and we can ignore it for your series (I haven't
seen it in the wild yet, but it is something we may need to deal with in
the long run if it keeps popping up).

>     + git index-pack --fix-thin --stdin
>     fatal: REF_DELTA at offset 46 already resolved (duplicate base 01d7713666f4de822776c7622c10f1b07de280dc?)
> 
>     =================================================================
>     ==3904583==ERROR: LeakSanitizer: detected memory leaks
> 
>     Direct leak of 32 byte(s) in 1 object(s) allocated from:
>         #0 0x7fa790d01986 in __interceptor_realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
>         #1 0x7fa790add769 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
>         #2 0x7fa790d117c5 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
>         #3 0x7fa790d11957 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:598
>         #4 0x7fa790d03fe8 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:51
>         #5 0x7fa790d013fd in __lsan_thread_start_func ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:440
>         #6 0x7fa790adc3eb in start_thread nptl/pthread_create.c:444
>         #7 0x7fa790b5ca5b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
>     SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).
>     Aborted
> 
> The duplicate base thing is a red-herring, and is an expected result of
> the test. But the leak is definitely not, and I'm not sure what's going
> on here since the frames listed above are in the LSan runtime, not Git.

I suspect this is a race in LSan caused by a thread calling exit() while
other threads are spawning. Here's my theory.

When a thread is spawned, LSan needs to know where its stack is (so it
can look for points to reachable memory). It calls pthread_getattr_np(),
which gets an attributes object that must be cleaned up with
pthread_attr_destroy(). Presumably it does this shortly after. But
there's a race window where that attr object is allocated and we haven't
yet set up the new thread's info. If another thread calls exit() then,
LSan will run but its book-keeping will be in an inconsistent state.

One way to work around that would be to make the creation of the threads
atomic. That is, create each in a suspended state, and only let them run
once they are all created. There's no option in pthreads to do this, but
we can simulate it by having them block on a mutex before starting. And
indeed, we already have such a lock: the work_lock() that they all use
to get data to process.

After applying this patch:

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

I ran t5309 with "--stress --run=6" for about 5 minutes with no failures
(whereas without the patch, I usually see a failure in 10 seconds or
so).

So it's a pretty easy fix, though I don't love it in general. Every
place that spawns multiple threads that can die() would need the same
treatment. And this isn't a "real" leak in any reasonable sense; it only
happens because we're exiting the program directly, at which point all
of the memory is returned to the OS anyway. So I hate changing
production code to satisfy a leak-checking false positive.

OTOH, dealing with false positives is annoying for humans, and the
run-time cost should be negligible. We can work around this one, and
avoid making the same change in other spots unless somebody sees a racy
failure in practice.

-Peff
