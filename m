Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F5820357
	for <e@80x24.org>; Sun,  9 Jul 2017 11:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdGIL3f (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 07:29:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:34798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751774AbdGIL3e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 07:29:34 -0400
Received: (qmail 7925 invoked by uid 109); 9 Jul 2017 11:29:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 11:29:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 421 invoked by uid 111); 9 Jul 2017 11:29:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 07:29:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 07:29:32 -0400
Date:   Sun, 9 Jul 2017 07:29:32 -0400
From:   Jeff King <peff@peff.net>
To:     s@kazlauskas.me
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: Fetching new refs gets progressively slower
Message-ID: <20170709112932.njac5m6jmgmjywoz@sigill.intra.peff.net>
References: <20170709102506.GA32425@kumabox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170709102506.GA32425@kumabox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 09, 2017 at 01:25:06PM +0300, s@kazlauskas.me wrote:

> I have a weird issue where fetching a large number of refs will start off
> with lines like these:
> 
> * [new ref]               refs/pull/10000/head -> origin/pr/10000
> * [new ref]               refs/pull/10001/head -> origin/pr/10001
> 
> going fairly fast, and then progressively getting slower and slower. By the
> time git is working on 40 thousandth such ref, it seems like it is only
> handling about 3-5 such “new ref”s.
> 
> These are the steps I used to reproduce:
> 
> $ git clone git@github.com:rust-lang/rust
> $ # edit .git/config to add $ # `fetch =
> +refs/pull/*/head:refs/remotes/origin/pr/*` under origin remote
> $ git fetch

Interesting. The CPU is definitely going to user-space, and it does look
like a quadratic case, where we end up re-reading the loose ref
directory for each new ref we write.

The backtrace looks something like:

  #1  0x0000555d86bcaf62 in files_read_raw_ref (ref_store=0x555d88d63a60, 
      refname=0x555d8a4791b0 "refs/remotes/origin/pr/10936", 
      sha1=0x7ffd29cbe1a0 "\003ŕX[\212*\037\064xE\fU\362!z44!<]U", referent=0x555d86efc630 <sb_refname>, 
      type=0x7ffd29cbe0c4) at refs/files-backend.c:686
  #2  0x0000555d86bc845f in refs_read_raw_ref (ref_store=0x555d88d63a60, 
      refname=0x555d8a4791b0 "refs/remotes/origin/pr/10936", 
      sha1=0x7ffd29cbe1a0 "\003ŕX[\212*\037\064xE\fU\362!z44!<]U", referent=0x555d86efc630 <sb_refname>, 
      type=0x7ffd29cbe0c4) at refs.c:1391
  #3  0x0000555d86bc851f in refs_resolve_ref_unsafe (refs=0x555d88d63a60, 
      refname=0x555d8a4791b0 "refs/remotes/origin/pr/10936", resolve_flags=1, 
      sha1=0x7ffd29cbe1a0 "\003ŕX[\212*\037\064xE\fU\362!z44!<]U", flags=0x7ffd29cbe19c) at refs.c:1430
  #4  0x0000555d86bca9de in loose_fill_ref_dir (ref_store=0x555d88d63a60, dir=0x555d8a478cc8, 
      dirname=0x555d8a478cf0 "refs/remotes/origin/pr/") at refs/files-backend.c:485
  #5  0x0000555d86bd1444 in get_ref_dir (entry=0x555d8a478cc0) at refs/ref-cache.c:28
  #6  0x0000555d86bd18d4 in search_for_subdir (dir=0x555d8a478c78, 
      subdirname=0x555d8a414330 "refs/remotes/origin/pr/13832/", len=23, mkdir=0) at refs/ref-cache.c:172
  #7  0x0000555d86bd192d in find_containing_dir (dir=0x555d8a478c78, 
      refname=0x555d8a414330 "refs/remotes/origin/pr/13832/", mkdir=0) at refs/ref-cache.c:191
  #8  0x0000555d86bd23a4 in cache_ref_iterator_begin (cache=0x555d8a418380, 
      prefix=0x555d8a414330 "refs/remotes/origin/pr/13832/", prime_dir=1) at refs/ref-cache.c:567
  #9  0x0000555d86bcb8eb in files_ref_iterator_begin (ref_store=0x555d88d63a60, 
      prefix=0x555d8a414330 "refs/remotes/origin/pr/13832/", flags=1) at refs/files-backend.c:1120
  #10 0x0000555d86bc801a in refs_ref_iterator_begin (refs=0x555d88d63a60, 
      prefix=0x555d8a414330 "refs/remotes/origin/pr/13832/", trim=0, flags=1) at refs.c:1268
  #11 0x0000555d86bc9289 in refs_verify_refname_available (refs=0x555d88d63a60, 
      refname=0x555d88d64b50 "refs/remotes/origin/pr/13832", extras=0x7ffd29cbe620, skip=0x0, err=0x7ffd29cbe710)
      at refs.c:1887
  #12 0x0000555d86bcb553 in lock_raw_ref (refs=0x555d88d63a60, refname=0x555d88d64b50 "refs/remotes/origin/pr/13832", 
      mustexist=0, extras=0x7ffd29cbe620, skip=0x0, lock_p=0x7ffd29cbe588, referent=0x7ffd29cbe590, 
      type=0x555d88d64b38, err=0x7ffd29cbe710) at refs/files-backend.c:956
  #13 0x0000555d86bcf1bc in lock_ref_for_update (refs=0x555d88d63a60, update=0x555d88d64b00, 
      transaction=0x555d88d64d20, head_ref=0x555d8a435630 "refs/heads/master", affected_refnames=0x7ffd29cbe620, 
      err=0x7ffd29cbe710) at refs/files-backend.c:2764

The issue seems recent. Bisecting leads to Michael's 524a9fdb5
(refs_verify_refname_available(): use function in more places,
2017-04-16), which makes sense.

-Peff
