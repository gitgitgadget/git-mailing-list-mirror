Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C2148832
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723896868; cv=none; b=EkMyQEuYcvzz+gZEvbpJUNCM7b0lK2OpOMsLrDiYlP7cgo46D2pVfk28gmnBKxrf0gkya93zVyb7t4Tn2xj0XqfJkbzxiyD7RZFgngoafShz6HIXrQ/8P8u1yJ5m/b6aduXPJ/7hcCJqpzwhgeqbPWghvGFaBerW/sbhw/F81q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723896868; c=relaxed/simple;
	bh=lHO4iuKyUDjp9SsMF4urEm8ij2DmwC7j2h/3s0ZazDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac4ok1mLx1mYtjZ0eFzq5PnaeI/f/XwtN6vRN6YS8+vmf+A850ui8qoJ9TanGhV/1XD6dYyqYNaTS2PXEVWvP90Xs+95TBp+j5BA4QuhbhvHr0lrseK1Fj4GklGLQcE/Xzp4h5VHLMsQdH3BIE3ZzqA4dzhfYZbL2OI81UnW9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26504 invoked by uid 109); 17 Aug 2024 12:14:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 12:14:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29650 invoked by uid 111); 17 Aug 2024 12:14:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 08:14:24 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 08:14:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <20240817121424.GA2439299@coredump.intra.peff.net>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <9befef7c1f7520d58af2b2db17174b8dbc493d56.1723804990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9befef7c1f7520d58af2b2db17174b8dbc493d56.1723804990.git.ps@pks.im>

On Fri, Aug 16, 2024 at 12:45:17PM +0200, Patrick Steinhardt wrote:

> Fix this bug by asking git-gc(1) to not detach when it is being invoked
> via git-maintenance(1). Instead, git-maintenance(1) now respects a new
> config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
> detaches itself into the background when running as part of our auto
> maintenance. This should continue to behave the same for all users which
> use the git-gc(1) task, only. For others though, it means that we now
> properly perform all tasks in the background. The default behaviour of
> git-maintenance(1) when executed by the user does not change, it will
> remain in the foreground unless they pass the `--detach` option.

This patch seems to cause segfaults in t5616 when combined with the
reftable backend. Try this:

  GIT_TEST_DEFAULT_REF_FORMAT=reftable ./t5616-partial-clone.sh --run=1-16 --stress

which fails for me within a few runs. Bisecting leads to 98077d06b2
(run-command: fix detaching when running auto maintenance, 2024-08-16).
It doesn't trigger with the files ref backend.

Compiling with ASan gets me a stack trace like this:

  + git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 --refetch origin
  AddressSanitizer:DEADLYSIGNAL
  =================================================================
  ==657994==ERROR: AddressSanitizer: SEGV on unknown address 0x7fa0f0ec6089 (pc 0x55f23e52ddf9 bp 0x7ffe7bfa1700 sp 0x7ffe7bfa1700 T0)
  ==657994==The signal is caused by a READ memory access.
      #0 0x55f23e52ddf9 in get_var_int reftable/record.c:29
      #1 0x55f23e53295e in reftable_decode_keylen reftable/record.c:170
      #2 0x55f23e532cc0 in reftable_decode_key reftable/record.c:194
      #3 0x55f23e54e72e in block_iter_next reftable/block.c:398
      #4 0x55f23e5573dc in table_iter_next_in_block reftable/reader.c:240
      #5 0x55f23e5573dc in table_iter_next reftable/reader.c:355
      #6 0x55f23e5573dc in table_iter_next reftable/reader.c:339
      #7 0x55f23e551283 in merged_iter_advance_subiter reftable/merged.c:69
      #8 0x55f23e55169e in merged_iter_next_entry reftable/merged.c:123
      #9 0x55f23e55169e in merged_iter_next_void reftable/merged.c:172
      #10 0x55f23e537625 in reftable_iterator_next_ref reftable/generic.c:175
      #11 0x55f23e2cf9c6 in reftable_ref_iterator_advance refs/reftable-backend.c:464
      #12 0x55f23e2d996e in ref_iterator_advance refs/iterator.c:13
      #13 0x55f23e2d996e in do_for_each_ref_iterator refs/iterator.c:452
      #14 0x55f23dca6767 in get_ref_map builtin/fetch.c:623
      #15 0x55f23dca6767 in do_fetch builtin/fetch.c:1659
      #16 0x55f23dca6767 in fetch_one builtin/fetch.c:2133
      #17 0x55f23dca6767 in cmd_fetch builtin/fetch.c:2432
      #18 0x55f23dba7764 in run_builtin git.c:484
      #19 0x55f23dba7764 in handle_builtin git.c:741
      #20 0x55f23dbab61e in run_argv git.c:805
      #21 0x55f23dbab61e in cmd_main git.c:1000
      #22 0x55f23dba4781 in main common-main.c:64
      #23 0x7fa0f063fc89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
      #24 0x7fa0f063fd44 in __libc_start_main_impl ../csu/libc-start.c:360
      #25 0x55f23dba6ad0 in _start (git+0xadfad0) (BuildId: 803b2b7f59beb03d7849fb8294a8e2145dd4aa27)

My guess based on what I'm seeing and what the patch does is that now
maintenance from a previous command is running in the background while
our foreground git-fetch runs, and it somehow confuses things (perhaps
by trying to compact reftables or something?). So I think there are two
problems:

  1. The reftable code needs to be more robust against whatever race is
     happening. I didn't dig further, but I'm sure it would be possible
     to produce a coredump.

  2. Having racy background maintenance doesn't seem great for test
     robustness. At the very least, it might subject us to the "rm"
     problems mentioned elsewhere, where we fail to clean up. Annotating
     individual "git gc" or "git maintenance" calls with an extra
     descriptor isn't too bad, but in this case it's all happening under
     the hood via fetch. Is it a potential problem for every script,
     then? If so, should we disable background detaching for all test
     repos, and then let the few that want to test it turn it back on?

-Peff
