Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3064EDE
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735533030; cv=none; b=HZd/66WUDw8eWhIxISa8hjjekfMSgwLZ/K3P5+VhvPgp0xrm3mkXxfwxQiUz00OSP4qYsOb8ZN1z7OVxXbommZmRO2xpM1+y/nmmulcy5piZxVTadk1HvLOfRoObB/7C/25MmFq3GulfTS8Bcj9ZoR2RFThaMj3XW/0GKJp2ZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735533030; c=relaxed/simple;
	bh=kJKgLvx0lks3/5IOmTFtz8TOWEdLNxWhRVZ+K69uG2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+Z8MGW2t1k2Qww9rZ47hdQ6rsYPBqw0aHHQHGD8cLgBgiusEu1h4f6WOXb98Llw4IWNs0n7wf5cCuqCKmVhxzL4rN41FNPLXed27O1qvacmfrRF2WaNf6QD4rtadAjBA/FhOyouZKM8jb6737JyVxycEHOZUo7YXDVmlZYweWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f+VQpoaa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f+VQpoaa"
Received: (qmail 14774 invoked by uid 109); 30 Dec 2024 04:30:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kJKgLvx0lks3/5IOmTFtz8TOWEdLNxWhRVZ+K69uG2o=; b=f+VQpoaaQSFjsUkAEqKedaAXuuypXaCk+MXAm/eoQ/9Ry9M3SK3vPqaglZV/aLj4sNidTIXNeFhWMxFtN80guiwNl0kiB2vwiHYTDO9CY4grmqbudNu5M3dOxuWbCppQ0kT3jBCG81wYRyT61EQqAjamA9qLHEFZ/VM0ZRD5X960kn/plV1mjKk5pSqoETy0rcohTqG1n8S9dFH57UtTjcKkeqXSqGPxVPRBxvcLxWQ2btOpP9+iemSaOJQVHniclwOPrgb5kY7b3Ap8roaEVCy5fs52cIuwhbLssNptqUoqKuJGat7LAI50NTvaaJp/bMo4q+poMiLdqKOf9voigw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:30:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14346 invoked by uid 111); 30 Dec 2024 04:30:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:30:27 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:30:26 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] grep: work around LSan threading race with barrier
Message-ID: <20241230043026.GE113400@coredump.intra.peff.net>
References: <20241230042325.GA112439@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230042325.GA112439@coredump.intra.peff.net>

There's a race with LSan when spawning threads and one of the threads
calls die(). We worked around one such problem with index-pack in the
previous commit, but it exists in git-grep, too. You can see it with:

  make SANITIZE=leak THREAD_BARRIER_PTHREAD=YesOnLinux
  cd t
  ./t0003-attributes.sh --stress

which fails pretty quickly with:

  ==git==4096424==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 32 byte(s) in 1 object(s) allocated from:
      #0 0x7f906de14556 in realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
      #1 0x7f906dc9d2c1 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
      #2 0x7f906de2500d in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
      #3 0x7f906de25187 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:614
      #4 0x7f906de17d18 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:53
      #5 0x7f906de143a9 in ThreadStartFunc<false> ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:431
      #6 0x7f906dc9bf51 in start_thread nptl/pthread_create.c:447
      #7 0x7f906dd1a677 in __clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78

As with the previous commit, we can fix this by inserting a barrier that
makes sure all threads have finished their setup before continuing. But
there's one twist in this case: the thread which calls die() is not one
of the worker threads, but the main thread itself!

So we need the main thread to wait in the barrier, too, until all
threads have gotten to it. And thus we initialize the barrier for
num_threads+1, to account for all of the worker threads plus the main
one.

If we then test as above, t0003 should run indefinitely.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index d00ee76f24..61b2c27490 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -101,6 +101,9 @@ static pthread_cond_t cond_write;
 /* Signalled when we are finished with everything. */
 static pthread_cond_t cond_result;
 
+/* Synchronize the start of all threads */
+static maybe_thread_barrier_t start_barrier;
+
 static int skip_first_line;
 
 static void add_work(struct grep_opt *opt, struct grep_source *gs)
@@ -198,6 +201,8 @@ static void *run(void *arg)
 	int hit = 0;
 	struct grep_opt *opt = arg;
 
+	maybe_thread_barrier_wait(&start_barrier);
+
 	while (1) {
 		struct work_item *w = get_work();
 		if (!w)
@@ -229,6 +234,7 @@ static void start_threads(struct grep_opt *opt)
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
+	maybe_thread_barrier_init(&start_barrier, NULL, num_threads + 1);
 	grep_use_locks = 1;
 	enable_obj_read_lock();
 
@@ -248,6 +254,7 @@ static void start_threads(struct grep_opt *opt)
 			die(_("grep: failed to create thread: %s"),
 			    strerror(err));
 	}
+	maybe_thread_barrier_wait(&start_barrier);
 }
 
 static int wait_all(void)
@@ -284,6 +291,7 @@ static int wait_all(void)
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
+	maybe_thread_barrier_destroy(&start_barrier);
 	grep_use_locks = 0;
 	disable_obj_read_lock();
 
-- 
bar
