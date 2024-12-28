Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45972744D
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735412748; cv=none; b=AwHtRtRMmaVD3gToGeSkPDluKbmKFvg8kJJqNn1n0+YZSicmT4U3nj+5kxmZXzxxmcEBqlHdZ22eiMBuc570m6rh+nMJoJA5VUTX7Axvhl5AQjv1foBMY8bW57iaYWcvBK8buPw5VWiNh5TDU6lg69dgSCcb+Nh5/QWqjxMgy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735412748; c=relaxed/simple;
	bh=cGjhYHjWrJXc+nvvDke4bJDhJHtmlqk+W+WwCfIIy3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aosFfTCjFT6qNXCxVYK2IDWNunfZ8RsN3GLThB1UrcQviWM6AB5O2ovcR2E8mbNDgR4kmngUbOOINk1SY+oyx7TSfJJ6HxOpMBJfXovXCdB1F5ic4l9yzuY7w+UE1yPRZqLw6cF6pqEe9c/T59fkGhfIwV0W/Wp23Er1HBmNQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CPcZ3S2+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CPcZ3S2+"
Received: (qmail 24545 invoked by uid 109); 28 Dec 2024 19:05:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cGjhYHjWrJXc+nvvDke4bJDhJHtmlqk+W+WwCfIIy3I=; b=CPcZ3S2+Nwq1jhAUvNozpIk5xD7UIlsgaAh+CGe6ZgYQDd+MJP0LOVWk+D/JelkarVhM975AP4kLcPqmi2RZWhhOYr08rMtdqmGzlgpXZgLRFAZtYEM7mdsHwGwD6yNvP+HIRF3btV5598LbZCbcKZt6GI4j4UjJPoAj964pRimATj/tgBuIY63qU/YWNrERnC31PggeB+hXfLaHocbfXwcZ+oDoS7hI2tqhpfMc8JBvOWAp63nvLu7V2GNpk82wPn9D5y+vQNKrkNziK6ADWOmK5PCL81pNUfXtgLFNrxfxWrxRvysmAmEfdIkGbX3tUfdYidJmd6g5kGrFj2JonQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Dec 2024 19:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29945 invoked by uid 111); 28 Dec 2024 19:05:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Dec 2024 14:05:42 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 28 Dec 2024 14:05:41 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: racy leak sanitizer builds, was Re: [PATCH 0/9] commit-reach:
 -Wsign-compare follow-ups
Message-ID: <20241228190541.GA815586@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
 <xmqqbjww65i1.fsf@gitster.g>
 <Z2-2dbYVuuLxpNmK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2-2dbYVuuLxpNmK@pks.im>

On Sat, Dec 28, 2024 at 09:27:41AM +0100, Patrick Steinhardt wrote:

>   - The leak-checking jobs fail quite regularly in t0003 with something
>     that feels like either a race caused by a leak or an issue with the
>     sanitizer itself [2]:
> 
>     ==git==17055==ERROR: LeakSanitizer: detected memory leaks
>     Direct leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x7aa0d03c7713 in realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
>     #1 0x7aa0d0221f69 in pthread_getattr_np (/lib/x86_64-linux-gnu/libc.so.6+0x9df69) (BuildId: 6d64b17fbac799e68da7ebd9985ddf9b5cb375e6)
>     #2 0x7aa0d03d9544 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
>     #3 0x7aa0d03d96fa in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:614
>     #4 0x7aa0d03cb2b9 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:53
>     #5 0x7aa0d03c756a in ThreadStartFunc<false> ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:431
>     #6 0x7aa0d0220a93  (/lib/x86_64-linux-gnu/libc.so.6+0x9ca93) (BuildId: 6d64b17fbac799e68da7ebd9985ddf9b5cb375e6)
>     #7 0x7aa0d02adc3b  (/lib/x86_64-linux-gnu/libc.so.6+0x129c3b) (BuildId: 6d64b17fbac799e68da7ebd9985ddf9b5cb375e6)
>     DEDUP_TOKEN: ___interceptor_realloc--pthread_getattr_np--__sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*)--__sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*)--__lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType)--ThreadStartFunc<false>----
>     SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).

I did a bit of digging on this last week, but didn't come up with a very
satisfactory solution. You can reproduce easily by building with
SANITIZE=leak and running t0003 with --stress.

It's the same issue we tried to address in 993d38a066 (index-pack: spawn
threads atomically, 2024-01-05): one thread calls exit() and takes down
the process while other threads are still being spawned (so the leak
checker runs while those other threads are in a weird state where lsan
has allocated some memory but not yet set up the thread stack as a place
to look for reachable memory).

There we dealt with it by making sure no thread started work (and thus
hit the exit call) until all of them were sanitized. I tried doing
something similar here, like:

  diff --git a/builtin/grep.c b/builtin/grep.c
  index 98b85c7fca..866645e6f8 100644
  --- a/builtin/grep.c
  +++ b/builtin/grep.c
  @@ -233,18 +233,20 @@ static void start_threads(struct grep_opt *opt)
                  strbuf_init(&todo[i].out, 0);
          }

  +       grep_lock();
          CALLOC_ARRAY(threads, num_threads);
          for (i = 0; i < num_threads; i++) {
                  int err;
                  struct grep_opt *o = grep_opt_dup(opt);
                  o->output = strbuf_out;
                  compile_grep_patterns(o);
                  err = pthread_create(&threads[i], NULL, run, o);

                  if (err)
                          die(_("grep: failed to create thread: %s"),
                              strerror(err));
          }
  +       grep_unlock();
   }

   static int wait_all(void)

but it doesn't work. In fact, this does nothing at all because each
thread will start by looking for work to do via get_work(), and we do
not call add_work() to give them anything to do until all threads are
spawned.

So I suspect the race is actually trickier, and that the "weird state"
is not something that happens just while pthread_create() is being
called, but is actually running _in the thread itself_. So even though
pthread_create() has returned for each thread, they are still setting
themselves up before running.

It mostly worked in 993d38a066 because index-pack has to do more work to
get to the exit() call. So delaying the start of the threads was enough
to usually win the race. But here, the individual grep threads get to
the exit() call very quickly, and it's not enough.

Which would mean that 993d38a066 is not actually a full fix, either. And
indeed, I can get t5309 to fail even with that patch (which is weird,
because that was how I tested it originally; I wonder if anything on the
LSan side changed?).

So a full fix would actually require synchronization where we spawn each
thread, then wait for all of them to hit the barrier to declare
themselves ready, and then let them all start running. There is a
pthread_barrier type that would help with this, but we've never used it
before (so we'd probably need to at least provide a Windows compat
layer).

One quick workaround is this:

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 3c98b622f2..7ecaf8f4e3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -443,7 +443,7 @@ test_expect_success 'diff without repository with attr source' '
 		cat >expect <<-EOF &&
 		fatal: cannot use --attr-source or GIT_ATTR_SOURCE without repo
 		EOF
-		test_must_fail env GIT_ATTR_SOURCE=HEAD git grep --no-index foo file 2>err &&
+		test_must_fail env GIT_ATTR_SOURCE=HEAD git grep --threads=1 --no-index foo file 2>err &&
 		test_cmp expect err
 	)
 '

Or you could even imagine automatically forcing online_cpus() to "1" for
LSan builds, which would fix it everywhere. But then we'd miss any leaks
that are specific to the threaded code.

Or of course we could try to engage with LSan folks about whether this
can be fixed there. I don't think we've reported it anywhere there.

-Peff
