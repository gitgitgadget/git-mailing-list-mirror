Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CA14A0B2
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962090; cv=none; b=fEx6UMZHCPSWj0ANj9YiTux0OWSCh2VMkB1YniKitt+hs969qiHX5+d02vl2XrU8I5qIrSgxoXneDbyi5TlQTyg5ckeYdxy4kBGWZF+7ZtpGmU1vG3mNgMpiVrXKWHdFQxK6gpq0bCLK967Zy/IZwZ483/aImYPPyy78tOz5YFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962090; c=relaxed/simple;
	bh=lfVl9keTdEYHhEQRraaV8mBBFFwXcYRhMdYASbUGXB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lbOqcFWIz9ohRqnzFskejsi4Xm5uQhP/5Pgw4c2q9XhpQ9RW+U3ZkzIOgeMhkZ3MhbqGrr7NIBVENqZXejUMWWzdggsZxXsfSOeNi1aW272EZsVHf1rTqUwazglWrW0CSJw5eqbFIQXC01vkLu/AL1JHKAnJiPjxfH9/zwy4LpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5930 invoked by uid 109); 29 Aug 2024 20:08:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 20:08:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10722 invoked by uid 111); 29 Aug 2024 20:08:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 16:08:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 16:08:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] clean up some MAYBE_UNUSED cases
Message-ID: <20240829200807.GA430283@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The discussion about MAYBE_UNUSED over in[1] made me wonder how it was
used in practice. This series cleans up a few spots where I think it is
being misused.

[1] https://lore.kernel.org/git/xmqqseunxtks.fsf_-_@gitster.g/

The remaining grep hits are:

  - fsmonitor has a few functions with sometimes-unused parameters based
    on conditional compilation (try_to_run_foreground_daemon() and
    check_for_incompatible()). This is a good use of MAYBE_UNUSED.

  - builtin/gc.c's check_crontab_process(). The whole function is marked
    as MAYBE_UNUSED here, which is a little funny. It's because
    is_crontab_available() may or may not call us based on __APPLE__.
    Should we conditionally define the function, too, in that case? It
    would mean repeating the #ifdef. Alternatively, we could define it
    like this:

      #ifdef __APPLE__
      static int check_crontab_process(const char *cmd UNUSED)
      {
              return 0;
      }
      #else
      static int check_crontab_process(const char *cmd UNUSED)
      {
              [...the real function...]
      }
      #endif

    But I think we're getting into "well, this is how I would have
    written it" territory, and it doesn't matter much either way in
    practice. It's probably better to just leave it alone.

  - commit-slab marks auto-generated static functions with MAYBE_UNUSED,
    since it doesn't know which ones actually need to be instantiated.
    This was the original thing we added MAYBE_UNUSED for.

  - khash does something similar when auto-generating functions.

  - test_bitmap_commits() marks a local variable as MAYBE_UNUSED! In
    fact it's completely unused by the function itself, but the macro
    expansion of kh_foreach() assigns to it. So we need the variable to
    exist to pass into the macro, but the compiler warning is triggered
    on the expanded code. We have kh_foreach_value(), but not
    kh_foreach_key(), which is what we'd want here. It wouldn't be hard
    to add it, but the MAYBE_UNUSED here is doing a fine job of
    suppressing the warning (and presumably an optimizing compiler
    removes the useless assignment).

I prepared this on top of what's queued in jk/unused-parameters (which
helps with making sure the annotations are all correct), but it could be
applied separately.

  [1/2]: gc: drop MAYBE_UNUSED annotation from used parameter
  [2/2]: grep: prefer UNUSED to MAYBE_UNUSED for pcre allocators

 builtin/gc.c | 2 +-
 grep.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-Peff
