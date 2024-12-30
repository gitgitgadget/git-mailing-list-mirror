Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2193171C9
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735532612; cv=none; b=e5A9dWdGRBRsj8nzZkVGI5w3VAOw19yr8hnzzVCUlP/8TX9aQeg0AS4RALP6+pbh0aUpu+TLfN4ASY7kq5BxEj3OxQ66QkZw+vu47tyyVfzKZRUs4/EYyvYQu9iLwXbKmdkVec1Z/lKtOb07fTgn42I03PFlAQ6BqTVdwAVgbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735532612; c=relaxed/simple;
	bh=f4GL0aJB2Ialky9Etj6w72O1REE6QzfVWMhFLOj5ECg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nm0nb19gaNNgenS981jf+KwJTQB4SDT4zVxgw9MC3f6itE01C0cKuURkVsDSAROTSQmOXkdKl/zNUkTOlbMinFE6XDiDdwSTp+VG0SsektdgnovtuVTCD+TdiUHKgPI9unp/xlfnXlfml/CcKtsWCWZmw/jiB5RWaFq+/ZT6Y84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bgOUXH6i; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bgOUXH6i"
Received: (qmail 14705 invoked by uid 109); 30 Dec 2024 04:23:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=f4GL0aJB2Ialky9Etj6w72O1REE6QzfVWMhFLOj5ECg=; b=bgOUXH6iSxM/o9RLRrZ/6rS7u4FaYINXF813ynejKR1fWmr4Ew7yw5dW+omSR3BUefWh53P2dW7yHRC05Iz4gk8Xb9djgyVSKIvAzBnro6Du78t1scyHme9NPoehAr/KO5RqnLFCw/Og9/oQ5ksnPN9ll6gMU1E6/WQQf5FdIZQABSe6wZzVUIaoJbBswrIV0o0c7mfk/ZCsJhbC/R07AL8SuyPfX0XvSZXTpsfUnDuOKivGOSn5GSn6V5KgkvHwkS7uIPLwRTSSwXC4fEpdyl2q7/d5xcWr8GqJb0lDNJghKPEXmK8B1EkskgMNnRpuza0LOEvZBoElVG9e7RuHpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:23:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14237 invoked by uid 111); 30 Dec 2024 04:23:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:23:26 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:23:25 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] fixing thread races in linux-leaks CI
Message-ID: <20241230042325.GA112439@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series should fix the races we see in linux-leaks CI jobs. Or at
least some of them. We tried previously in 993d38a066 (index-pack: spawn
threads atomically, 2024-01-05), but it wasn't enough. This series
covers index-pack as well as git-grep, which are the two I've seen in
practice. We may run into more, but the general pattern should be
applicable if we do.

This series takes the minimal approach, and only provides a knob to use
pthread_barrier_t if your system supports it (and then turns it on for
our CI jobs). The obvious alternative is to actually implement wrappers
for other systems, and then use it everywhere. That doesn't buy us much
for this problem, but it's possible we'd find a use for barriers
elsewhere.

The even farther alternatives are:

  1. Do nothing. This is arguably an LSan bug, which should be doing its
     own locking to synchronize the at-exit leak check with the
     per-thread setup code. I don't think we've even reported it there,
     so one option would be to work with them. Even if we do that, it
     might be nice to remove the false positive pain in the meantime
     with a series like this (and certainly patches 1 and 2 here are
     worth applying independently).

  2. Change our posture on thread exit. In index-pack, the issue is that
     one worker thread calls exit() via die(), taking down the whole
     program (including other worker threads in unknown states). If it
     installed a die() handler that called pthread_exit() instead, then
     the main thread could see that failure and cancel/join the
     remaining threads.

     But I suspect it's not so simple:

       a. We still want the error in the worker thread to cancel ongoing
	  work immediately. Right now index-pack just called
	  pthread_join() in sequence to wait for all threads to finish.
	  But instead we'd need to use some synchronization primitives
	  to report the error. Probably not too hard, but new
	  potentially tricky code.

       b. In the git-grep case, it's actually the main thread that calls
	  die(). So the rule is not really "threads should install a die
	  handler that calls pthread_exit()", but _any_ die() call when
	  threads are established would need to cleanly ask all threads
	  to stop (whether by signaling them via the work queue, or just
	  hitting them with pthread_cancel; and that's assuming that
	  there's no race between LSan's setup code and cancel).

       c. When we call die(), all bets are off about what state various
          data structures are in. For example, a thread could be holding
	  a lock, and if it's cancelled by another thread, that lock
	  will remain. So it's not safe to do any real work in the other
	  threads, unless we start setting up pthread_cleanup handlers,
	  etc. That seems like a recipe for obscure, racy deadlocks.

     I think that may be an appealing direction in the long run,
     especially since die() itself is not thread-safe. But coupled with
     libification, we probably want less "threads can die() cleanly" and
     more "threads pass errors up the stack and report the problem back
     to the work queue". Either way, though, it's a much bigger approach
     change than I think we want just to try to address LSan races.

So I think we want something like this (either this, or the variant
where we really implement barriers everywhere) in the near-term.

  [1/5]: test-lib: use individual lsan dir for --stress runs
  [2/5]: Revert "index-pack: spawn threads atomically"
  [3/5]: thread-utils: introduce optional barrier type
  [4/5]: index-pack: work around LSan threading race with barrier
  [5/5]: grep: work around LSan threading race with barrier

 Makefile             |  7 +++++++
 builtin/grep.c       |  8 ++++++++
 builtin/index-pack.c |  8 ++++++--
 ci/lib.sh            |  1 +
 t/test-lib.sh        |  2 +-
 thread-utils.h       | 17 +++++++++++++++++
 6 files changed, 40 insertions(+), 3 deletions(-)
