Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA11E25F9
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735762376; cv=none; b=Nh1rGoe1U1RiOUjMHaoveES+Ztcs6t4C1Pwr+/5AvVKcYWhEGRq24zcUL83e5OkYKlUbYgD/LuOlq0hTixQcQuJ6NTLKcSUMJoCtGvaa3tJDR8Z+H5POEJqVQx/gLGU8g0NJwCT+e4fWtdzYQA949tEBQjRQvvI6NmV3FuFA0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735762376; c=relaxed/simple;
	bh=o8M8lrUMrVGDHqKmSFh0aJSUfYc8UuO5EWMnYyrNCWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZl/Spl1riOeEX2lZGH1yA95G5Fzguc8TcjpcuYl0GXUcn7nbelSFBm0fJzrh4JxwMF5jnruOIP7vq5X637CLWl+Rhetwf7Mx5l/i93AT9e+9El+aX5ZDBXm7oE+nFGhmtawQ+2BgTAXlIZC9EMn0mfN54d6ewBIrFniI9oOi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aM96B7oZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aM96B7oZ"
Received: (qmail 22965 invoked by uid 109); 1 Jan 2025 20:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=o8M8lrUMrVGDHqKmSFh0aJSUfYc8UuO5EWMnYyrNCWo=; b=aM96B7oZrcuWwfig7Gxn419o4GfrxVIYr44opkUUww5z8SRfUpyzYi0MhlDmqdYn3y1oFjaonmLQPfP1m0DRNnqyiP6g2j+Kzq8/W5EDP4b8oD+llK60PesjDxDXL3cCSPxrRCoYwlqUtC/SDcZYvbOsk29s36IzJQeUmHfqlymuYORpwLdFjA0WuEIlKP4XP8cWzZoZH13yO+7yomNJhAW4/H3rNGJlaefXNGOvKO6klhpPQFwBzOcOoUPtsBJbU9QfiP5WL7pbX6wyF02cg2INOGTeuXYH3283kDUJpQyxbuK5N+Ksw2cePncDcMzYfvaLsDxZVpxmeh6rXPI7TQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 20:12:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11403 invoked by uid 111); 1 Jan 2025 20:12:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 15:12:53 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 15:12:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH 2/6] Revert "index-pack: spawn threads atomically"
Message-ID: <20250101201252.GB3305462@coredump.intra.peff.net>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250101201226.GA3304465@coredump.intra.peff.net>

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
2.48.0.rc1.363.g2bf91ec010

