Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC34171C9
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735532981; cv=none; b=k53lFlTla0p7ozAPMSWzanuKnV1tAQHWo6n0JS6DQrlYwX3/VGCsZniJRwQl+Z4k5sIlJTNVX1vRLRfoybUXG0CkB8hX1gNKq4gGlvMvjD25eZS/0tUBnzyeEBnkcduz1U/bi177P7SgBEUYWobtj6PDlYScL9dxHHJfN3L5Uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735532981; c=relaxed/simple;
	bh=MYdf5MuZU5+Y3IuEXL9t8ozpNE20MSs1q/2G6VsYyx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9W49Zpfppnh0OCpFHKySq75HsglhDsu+59RTOeMFlH/mS5jgzK5SjqLoHGjn52FxRLso0YIOLia5p6Kf0CuV4aOOjRjc0wmb2G5NLv9uiPen04aChQEYgRquczgpy2op0ce5XFfEsTy6wfHFHdAHRZLh62m50VK7g0HJ6JScVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X7FTmD4J; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X7FTmD4J"
Received: (qmail 14761 invoked by uid 109); 30 Dec 2024 04:29:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MYdf5MuZU5+Y3IuEXL9t8ozpNE20MSs1q/2G6VsYyx0=; b=X7FTmD4JMANjMUKCpWJbmSDSLr2WGfcvVgjLM42orlvudjFgQMA37fj+WNDDhesAoHHZ8fpxT5KTGIZ5yg0vCAV6B2g8xusG2Wo+OQGe8tZYNxytze3euEA3c55TWxpv+xNX5wE8y2uhvFGNlkyGo+TNkRlZNtD8d1Blj8DnZAvV8fNcAu0lKH+MnERefqbJaYFvndhUkFxoIkqNn2uf0gU5XbOZuG7RHQj5vTAwwestJlJ0qg/p0a14IjPY3X/61OGtdXCV9LvXwjGe3klGjBL2c4j7/Y2h5XOILZDuMEjMGgZFc30/aMJweivJNg04UwASJaPzJLJ9Zahqe3QGDw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:29:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14313 invoked by uid 111); 30 Dec 2024 04:29:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:29:38 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:29:38 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] index-pack: work around LSan threading race with barrier
Message-ID: <20241230042938.GD113400@coredump.intra.peff.net>
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

We sometimes get false positives from our linux-leaks CI job because of
a race in LSan itself. The problem is that one thread is still
initializing its stack in LSan's code (and allocating memory to do so)
while anothe thread calls die(), taking down the whole process and
triggering a leak check.

The problem is described in more detail in 993d38a066 (index-pack: spawn
threads atomically, 2024-01-05), which tried to fix it by pausing worker
threads until all calls to pthread_create() had completed. But that's
not enough to fix the problem, because the LSan setup code runs in the
threads themselves. So even though pthread_create() has returned, we
have no idea if all threads actually finished their setup before letting
any of them do real work.

We can fix that by using a barrier inside the threads themselves,
waiting for all of them to hit the start of their main function before
any of them proceed.

You can test for the race by running:

  make SANITIZE=leak THREAD_BARRIER_PTHREAD=YesOnLinux
  cd t
  ./t5309-pack-delta-cycles.sh --stress

which fails quickly before this patch, and should run indefinitely
without it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0b62b2589f..27b120f26c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -185,6 +185,8 @@ static pthread_mutex_t deepest_delta_mutex;
 
 static pthread_key_t key;
 
+static maybe_thread_barrier_t start_barrier;
+
 static inline void lock_mutex(pthread_mutex_t *mutex)
 {
 	if (threads_active)
@@ -209,6 +211,7 @@ static void init_thread(void)
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
+	maybe_thread_barrier_init(&start_barrier, NULL, nr_threads);
 	CALLOC_ARRAY(thread_data, nr_threads);
 	for (i = 0; i < nr_threads; i++) {
 		thread_data[i].pack_fd = xopen(curr_pack, O_RDONLY);
@@ -231,6 +234,7 @@ static void cleanup_thread(void)
 	for (i = 0; i < nr_threads; i++)
 		close(thread_data[i].pack_fd);
 	pthread_key_delete(key);
+	maybe_thread_barrier_destroy(&start_barrier);
 	free(thread_data);
 }
 
@@ -1100,6 +1104,8 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 
 static void *threaded_second_pass(void *data)
 {
+	if (threads_active)
+		maybe_thread_barrier_wait(&start_barrier);
 	if (data)
 		set_thread_data(data);
 	for (;;) {
-- 
bar

