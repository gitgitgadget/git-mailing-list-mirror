Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20438F92F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000340; cv=none; b=jSFLnjsAwfpmluEXlA1yFB+xWFd27GUXP63/+1mXTEq+ZG4UNnEHEqcGGWPIDA257HlHcEomNl3fPyFEHyqX14SAtwkZZU22SSkAzQQQqjYDgeV4azHjR2oWQTI7mH6lL29HtQW6jkU4v9MD+lQXd/pQ+geBDz5W+V/oxxG/B9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000340; c=relaxed/simple;
	bh=eUEWxIYrwhl4WM9kl5oCT+hSZhpfS6GYWnPA5et36A0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DEFWRFnEvn3hvKIx4EXAHNQgRZYtFimLAhU7HiI3gMUoBWAuXlT/81dxY5BPKF9p6Ms7xyQkETzRAs4IeqJcw1rsbo24r2sT1uf2rxkhu9jpJeNxADEmvkSS82kXTl0E1JApDRELq7Mi0qWPPbsjUuoczvGUdPaQ1YwJvxGUOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X7iKBOYZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X7iKBOYZ"
Received: (qmail 206567 invoked by uid 106); 31 Mar 2026 23:38:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=eUEWxIYrwhl4WM9kl5oCT+hSZhpfS6GYWnPA5et36A0=; b=X7iKBOYZQoIPeNoZvGvbmfzbWV0o7bqQ+nWJMlQGxsjr20vi0QuvF9+xfObTHB0L76G1L7sQUxdG+FWCjp0PWpOmVX1nIy1SBXObh0vkl/jacmw9pnxbuNSPUSn+VFK3JqHC56odHhvsUv9I8LQUu0RLt/JKHpojoWcLtCjQItk2rp2OE+Uwq/ImllZ7ZG31+dGVXrQFqYZswCdkEiitKyBj7ZINKQqNHJAVH1FpiJ2a6oOC/vgopp21JqnJ9mF0JuKQCkcXU523YSmUgtHL6SyBAXe+5cCepvNYUdeuKFTH4cJrnuFy4bGWP6wjj3kYDmu/3DyKO0NveKRuWwMM/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:38:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326352 invoked by uid 111); 31 Mar 2026 23:38:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:38:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:38:56 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 0/12] fixing the remainder of the C23 strchr warnings
Message-ID: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes the rest of the warnings you might see on recent glibc
or other C23 libc where:

  const char *in = ...;
  char *out = strchr(in, ...);

now complains instead of quietly assigning the const pointer to a
non-const one. It's all textually independent of the other fixes, but
if you want a clean build you'll need the others. I think Collin's fixes
have hit master already, but my jk/c23-const-preserving-fixes are still
slated for 'next'.

Some of my fixes are similar to what Michael posted in:

  https://lore.kernel.org/git/cover.1774537954.git.git@grubix.eu/

but for most of them I took a somewhat different approach. So this would
be applied instead of those patches.

The patches are:

  [01/12]: convert: add const to fix strchr() warnings
  [02/12]: http: add const to fix strchr() warnings
  [03/12]: transport-helper: drop const to fix strchr() warnings

    These ones are obvious fixes that just match the type declarations
    to their uses.

  [04/12]: pager: explicitly cast away strchr() constness
  [05/12]: run-command: explicitly cast away constness when assigning to void

    These are ones where I think an explicit cast is the least-bad
    option.

  [06/12]: find_last_dir_sep(): convert inline function to macro

    This is the one that gets repeated a zillion times when you build
    because it's in a header file. ;) It takes a slightly different
    approach than Collin's in:

      https://lore.kernel.org/git/e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com/

    which I think reduces the fallout through the rest of the codebase.

  [07/12]: pseudo-merge: fix disk reads from find_pseudo_merge()

    This one is...spicy. I think there are probably actual bugs here,
    but my hope is that this takes us in the right direction (and shuts
    up the warning).

  [08/12]: skip_prefix(): check const match between in and out params

    And here is where we might get controversial. It introduces some
    macro hackery that makes it safe and easy to use skip_prefix() with
    const or non-const strings. I _think_ it should just work
    everywhere, but I won't be surprised if some compiler somewhere
    complains about the construct. Coverity does, but it is so full of
    false positives that adding more is not a big deal.

  [09/12]: pkt-line: make packet_reader.line non-const
  [10/12]: range-diff: drop const to fix strstr() warnings
  [11/12]: http: drop const to fix strstr() warning
  [12/12]: refs/files-backend: drop const to fix strchr() warning

     And then these are all obvious fixes that are only made possible by
     the skip_prefix() magic above. Well, possible without extra ugly
     casts everywhere.

 builtin/config.c    |  7 ++++---
 builtin/rev-parse.c | 40 ++++++++++++++++++++--------------------
 convert.c           |  3 ++-
 git-compat-util.h   | 23 ++++++++++++++++++-----
 http-push.c         |  2 +-
 pager.c             |  3 ++-
 pseudo-merge.c      | 32 +++++++++++++++++++-------------
 revision.c          | 25 +++++++++++++++----------
 run-command.c       |  4 ++--
 transport-helper.c  |  3 ++-
 10 files changed, 85 insertions(+), 57 deletions(-)

-Peff
