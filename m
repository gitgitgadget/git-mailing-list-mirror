Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFB171CD
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735758866; cv=none; b=Rbon7K5PbE8Bl/m3H23JsXLnMLw6SdcymsOvFf59NeAbjfe81LL5yj7p47iPc2PMQytvgNTMH8SCta0Ki+Zx7HCu53RMG7Nw65kZIWXdffX0AJsfMrShpZtVYmsb8/HQv+3ddG2DkQckx+R38h1V1k+f5QJWEX+aKst5lLZhKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735758866; c=relaxed/simple;
	bh=3K5Tt58Mk0J4CMx7RKX/06tNHQusOEFVctebx8XkCeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNjzmvFBAXrVXnLZKbBS+Jg9KRmkp2hA3L0CgGedESvj3gHanzp44TY1SEczfiQoVOAzv1PopjceHBsvkjae44V5y81iwF55Z/v7UZAL3BMrWahi2lm7bAk5Iy+SAx4UxUz/YDrEvISfPxHfZHFxCg2E2LYYb2ZBMEhPzlHZFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DsbHjtab; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DsbHjtab"
Received: (qmail 22068 invoked by uid 109); 1 Jan 2025 19:14:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3K5Tt58Mk0J4CMx7RKX/06tNHQusOEFVctebx8XkCeg=; b=DsbHjtabpeaSMlwzFWJMHsdVHZlR6LRsrjfeivdFlvp1p6OfqtHF4xQ2z2ZwqEdYUa8i5fuYI05WI3Avh/CH5IhETFsTBNjyEV8XPROyC3kMIOHkMMe50U/ZSUiIn2ZuABYXJ+xinmLzAvrSTOVAYzcuO1wLYi3kcSk09+6SLgenXHW6G5XRNCovqektHBI3MWfAETTmIaKCwNxwaQSV2ofitnwWmhB1h96nGFo7vlB4WomAgdF2THSl8sZCLglUHo6mDI/DoaR4vj60DIXBH493DEmUhKdkh4tH652jaOdqIa9hP59fsYfDMcUUDGl6VqEQ1SPdxqvrf7b8hypamw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 19:14:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10942 invoked by uid 111); 1 Jan 2025 19:14:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 14:14:22 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 14:14:22 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: a less-invasive racy-leak fix, was Re: What's cooking in git.git
 (Dec 2024, #11; Mon, 30)
Message-ID: <20250101191422.GC1391912@coredump.intra.peff.net>
References: <xmqqpll9xehr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpll9xehr.fsf@gitster.g>

On Mon, Dec 30, 2024 at 09:33:20AM -0800, Junio C Hamano wrote:

> * jk/lsan-race-with-barrier (2024-12-30) 5 commits
>   (merged to 'next' on 2024-12-30 at 3fc0e14928)
>  + grep: work around LSan threading race with barrier
>  + index-pack: work around LSan threading race with barrier
>  + thread-utils: introduce optional barrier type
>  + Revert "index-pack: spawn threads atomically"
>  + test-lib: use individual lsan dir for --stress runs
> 
>  CI jobs that run threaded programs under LSan has been giving false
>  positives from time to time, which has been worked around.
> 
>  Will merge to 'master'.
>  source: <20241230042325.GA112439@coredump.intra.peff.net>

This graduated faster than I expected. :)

I think the first two patches are obviously good, and we should take
them as-is. But while poking at the problem a bit more, I found
something quite interesting that might let us fix it without any code
change at all.

I wanted a minimal reproduction of the problem so that I could report it
to the sanitizer folks upstream. So I thought this would work:

-- >8 --

cat >foo.c <<\EOF
#include <stdlib.h>
#include <pthread.h>

static void *run(void *data)
{
	return NULL;
}

int main(void)
{
	pthread_t threads[256];

	for (int i = 0; i < sizeof(threads)/sizeof(*threads); i++)
		pthread_create(&threads[i], NULL, run, NULL);
	exit(1);
}
EOF

gcc -fsanitize=leak foo.c
./a.out

-- 8< --

But it doesn't! Even if I run it thousands of times. And yet if I put
similar code inside of git.c and run it within our test suite, I see the
failure almost immediately.  So there's something about our test suite
that triggers it.  And indeed, the secret sauce turns out to be this
option (depending on system load you might need to run it a couple times
to trigger the failure):

  $ LSAN_OPTIONS=fast_unwind_on_malloc=0 ./a.out
  =================================================================
  ==1836417==ERROR: LeakSanitizer: detected memory leaks
  
  Direct leak of 32 byte(s) in 1 object(s) allocated from:
      #0 0x7ff8bb014556 in realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
      #1 0x7ff8bae9d2c1 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
      #2 0x7ff8bb02500d in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
      #3 0x7ff8bb025187 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:614
      #4 0x7ff8bb017d18 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:53
      #5 0x7ff8bb0143a9 in ThreadStartFunc<false> ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:431
      #6 0x7ff8bae9bf51 in start_thread nptl/pthread_create.c:447
      #7 0x7ff8baf1a677 in __clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
  
  SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).


It seems a little funny to me that the different stack unwinder would
also have different thread setup code, but I'm not at all familiar with
lsan's internals, so who knows. I might dig into that but haven't yet
(and I haven't yet reported it upstream). But anyway, that implies that
we can get rid of the race with just:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 96f2dfb69d..2936e810b5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -80,7 +80,6 @@ prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
 prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
-prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
 export LSAN_OPTIONS
 
 prepend_var UBSAN_OPTIONS : $GIT_SAN_OPTIONS

And indeed, that lets t5309 run successfully under --stress for me (with
the log-dir fix from the base of my series).

That line comes from in 71f26798f2 (test-lib: add "fast_unwind_on_malloc=0"
to LSAN_OPTIONS, 2022-02-27), with the goal of making the backtraces a
bit more readable. I'm not sure how important it is. I tried reverting a
random commit from one of Patrick's recent leak-fix series:

  git revert 58e7568c619cce872b17987f0d14b3de3703129a
  make SANITIZE=leak
  cd t
  ./t1091-sparse-checkout-builtin.sh -i

and the trace looks quite reasonable to me. That old commit 71f2678f2
gives an example from t0006. That script was marked leak-free by
974c919d36 (date API: add and use a date_mode_release(), 2022-02-16). If
we revert its change to test-date like so:

  git diff-tree -Rp 974c919d36 -- t/helper/test-date.c | git apply -3
  make SANITIZE=leak
  cd t
  ./t0006-date.sh -i

then we do get the same crappy trace as mentioned in 71f26798f2 (if I
understand correctly, this is because libc functions which allocate are
not built with -fno-omit-frame-pointer, so we can't walk past them).

So that line is doing something useful. But it may not be worth the racy
pain it's causing. So some alternatives are:

  - we drop that line by default, and then when people are investigating
    a specific leak, they can override LSAN_OPTIONS themselves to get
    better output (though of course knowing that you can even do is
    tricky)

  - we keep that line by default, but override LSAN_OPTIONS for CI to
    avoid the race. That makes all local leak-checking traces
    informative by default. But CI ones may be truncated. I'm not sure
    if people use the CI ones directly, or investigate further
    themselves.

  - we could annotate individual scripts or even tests to disable the
    option (since it's really just threaded programs). This is more
    hassle, but would limit the blast radius.

I don't love any of those, but they may be less bad than all of the
barrier trickery. And it may be that this is even something we could get
fixed in LSan upstream, and it would just be a temporary workaround. I'm
still going to pursue that.

And finally, one other option (that I'm not sure why I didn't consider
before): can we just ignore the false positives, similar to what we did
in 370ef7e40d (test-lib: ignore uninteresting LSan output, 2023-08-28).
I think we'd have to stop doing abort_on_error for the leak checker and
just rely on the logs, but that's OK (we always check the logs these
days). And detecting the false positive is a little involved. But this
seems to work:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 96f2dfb69d..ab7d2d321e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -80,6 +80,7 @@ prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
 prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
+prepend_var LSAN_OPTIONS : exitcode=0
 prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
 export LSAN_OPTIONS
 
@@ -346,7 +347,8 @@ nr_san_dir_leaks_ () {
 	find "$TEST_RESULTS_SAN_DIR" \
 		-type f \
 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
-	xargs grep -lv "Unable to get registers from thread" |
+	xargs grep ^DEDUP_TOKEN |
+	grep -v sanitizer::GetThreadStackTopAndBottom |
 	wc -l
 }
 

A little hacky, but it lets us have our cake and eat it, too. No changes
to the code, and no bad stack traces.

What do you think?

-Peff
