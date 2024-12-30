Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E1171C9
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735532774; cv=none; b=H0XZEXB/Y1uktaAB1lnsiZOpTiohYVpIAGRsjzzqiK4aowbYjwRw2DBc8HsT+asIhUVWRZtXkMvn5H0lyhuOJO0TlYDnGqaamkIH8eGMWYLXnBy3wWE5U08MtpWjMV9ppPoUWjx9xZm5cPNn0bZWXe4A7WYQvWHj6f9y1sqUhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735532774; c=relaxed/simple;
	bh=IwJvgDnImmtHi0wqNFu5Dqjt22bM1CWpHxVWhhejdIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5XNoeIf6PGztG+iFIAo9JG1H43IoOkZ/WpiSgvjFJHGzU6Si5DS31CGiwxVeEemNRNv6u9Awc6z9Fssrs3MsTVitsI856q/bAaJZEZfRzAC3ouVqnS2Mapk+3nD9F6qQfKLrSDglHshZ6Nqc9TnhfC96S9UozaY8SPAMnzA8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XlUOBqQb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XlUOBqQb"
Received: (qmail 14732 invoked by uid 109); 30 Dec 2024 04:26:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IwJvgDnImmtHi0wqNFu5Dqjt22bM1CWpHxVWhhejdIk=; b=XlUOBqQbnrJldg2FwxcYWh1J2mX9aoLeSp/m644uuOC5VukLmBT82kyMhkQst9tJDoBXiFD9qaOFCzc7WCKxXO2v4KDib9skT5JY9pC2s03OHZCuFAbweM/Bto1lNOmLxcGb57U7YrDyH6K0xs5yhs9jw2cswkwVMIMrmoyDYlDPNVcN3zPWQzerPXg3g3h1P1LvomFrlvvEQ2DICD5JTC5ouHOK4HFFYLnSLKAJAL3h8gtqfq21khaK5m3Y/LUv9HShQGG+7UfKT2hxgvfYgK+76QtnRyBGH188wL8dEa+YZAAVNxiKXOiXccKIvlXfGgawPK8urhVJHufgNEJxVw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:26:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14285 invoked by uid 111); 30 Dec 2024 04:26:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:26:10 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:26:10 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] Revert "index-pack: spawn threads atomically"
Message-ID: <20241230042610.GB113400@coredump.intra.peff.net>
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

This reverts commit 993d38a0669a8056d496797516e743e26b6b8b54.

That commit was trying to solve a race between LSan setting up the
threads stack and another thread calling exit(), by making sure that all
pthread_create() calls have finished before doing any work that might
trigger the exit().

But that isn't sufficient. The setup code actually runs in the
individual threads themselves, not in the spawning thread's call to
pthread_create(). So while it may have improved the race a bit, you can
still trigger it pretty quickly with:

  make SANITIZE=leak
  cd t
  ./t5309-pack-delta-cycles.sh --stress

Let's back out that failed attempt so we can try again.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm still puzzled why I ever thought 93d38a066 solved this, because the
stress test above is exactly what I was using back then to test it.
Possibly LSan changed in some way, or possibly I just got lucky in my
stress run, but the more likely reason is that I simply bungled the
testing (e.g., if you accidentally use a non-LSan build, then it
naturally appears to work).

 builtin/index-pack.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d773809c4c..0b62b2589f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1336,15 +1336,13 @@ static void resolve_deltas(struct pack_idx_option *opts)
 	base_cache_limit = opts->delta_base_cache_limit * nr_threads;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
-		work_lock();
 		for (i = 0; i < nr_threads; i++) {
 			int ret = pthread_create(&thread_data[i].thread, NULL,
 						 threaded_second_pass, thread_data + i);
 			if (ret)
 				die(_("unable to create thread: %s"),
 				    strerror(ret));
 		}
-		work_unlock();
 		for (i = 0; i < nr_threads; i++)
 			pthread_join(thread_data[i].thread, NULL);
 		cleanup_thread();
-- 
bar

