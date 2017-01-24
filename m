Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A200E20A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdAXAhc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:37:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:43546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbdAXAhb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:37:31 -0500
Received: (qmail 9358 invoked by uid 109); 24 Jan 2017 00:37:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:37:31 +0000
Received: (qmail 23007 invoked by uid 111); 24 Jan 2017 00:38:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:38:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:37:29 -0500
Date:   Mon, 23 Jan 2017 19:37:29 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/12] reducing resource usage of for_each_alternate_ref
Message-ID: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I've mentioned before, I have some alternates repositories with
absurd numbers of refs, most of which are duplicates of each other[1].
There are a couple of problems I've seen:

 1. the way that for_each_alternate_ref() works has very high peak memory
    usage for this case

 2. the way that receive-pack de-duplicates the refs has high peak memory
    usage

 3. we access the alternate refs twice in fetch-pack

This fixes all three, along with a few other minor bugfixes, cleanups,
and optimizations. I've tried to order the series to keep bugfixes and
less-contentious changes near the front.

Just to give some numbers, on my worst-case repository (see [1]), this
drops peak RSS for "git clone --reference" from over 25GB to about 40MB.
Sort of, anyway.  You still pay a big CPU and RSS cost on the process in
the alternates repo that accesses packed-refs, but the 25GB came on top
of that. So this is a first pass at the low-hanging fruit.

I'll be the first to admit that this setup is insane. And some of the
optimizations are tradeoffs that help particularly the case where your
refs aren't unique. But for the most part should help _every_ case. And
in the cases where your refs are unique, either you don't have many (so
the tradeoffs are OK) or you have so many that you are pretty much
screwed no matter what (if your fetch is looking at 30 million unique
ref tips, the object storage is your problem, not looking at the refs).

A brief overview of the patches:

  [01/12]: for_each_alternate_ref: handle failure from real_pathdup()
  [02/12]: for_each_alternate_ref: stop trimming trailing slashes
  [03/12]: for_each_alternate_ref: use strbuf for path allocation

    Bugfixes and cleanups (the first one is actually a recent-ish
    regression).

  [04/12]: for_each_alternate_ref: pass name/oid instead of ref struct
  [05/12]: for_each_alternate_ref: replace transport code with for-each-ref
  [06/12]: clone: disable save_commit_buffer

    This gives the 25GB->40MB benefit. There are a bunch of caveats in
    patch 05, but I _think_ it's the right direction for the reasons I
    outlined there.

  [07/12]: fetch-pack: cache results of for_each_alternate_ref

    Just running for-each-ref in the giant alternates repo is about a
    minute of CPU, plus 10GB heap, and fetch-pack wants to do it twice.
    This drops it to once.

  [08/12]: add oidset API
  [09/12]: receive-pack: use oidset to de-duplicate .have lines

    These give another ~12GB RSS improvement when receive-pack looks at
    the alternates in my worst-case repo.

    This is less tested than the earlier ones, as we've disabled
    receive-pack looking at alternates in production (see [1] below).
    I just did them for completeness upstream.

  [10/12]: receive-pack: fix misleading namespace/.have comment
  [11/12]: receive-pack: treat namespace .have lines like alternates
  [12/12]: receive-pack: avoid duplicates between our refs and alternates

    These are optimizations to avoid more duplicate .have lines, and
    should benefit even non-insane cases. As with 8-12, not as well
    tested by me.

 Makefile               |  1 +
 builtin/clone.c        |  1 +
 builtin/receive-pack.c | 41 +++++++++++++++-------------
 fetch-pack.c           | 48 ++++++++++++++++++++++++++++-----
 object.h               |  2 +-
 oidset.c               | 49 ++++++++++++++++++++++++++++++++++
 oidset.h               | 45 +++++++++++++++++++++++++++++++
 t/t5400-send-pack.sh   | 38 ++++++++++++++++++++++++++
 transport.c            | 72 +++++++++++++++++++++++++++++++++++---------------
 transport.h            |  2 +-
 10 files changed, 250 insertions(+), 49 deletions(-)
 create mode 100644 oidset.c
 create mode 100644 oidset.h

-Peff

[1] Background, if you care:

    I've mentioned before that GitHub's repository storage uses a
    fork-network layout. Each user gets their own "fork" repository, and
    it points to "network.git" as shared storage. The network.git
    repository has a ref for each fork that is updated periodically via
    "git fetch".

    So the network.git repo contains O(nr_forks * nr_refs_in_fork) refs.
    Quite a few of these point to the same tip sha1s, as each fork has
    the same tags. One of the most pathological cases is a popular
    public repo that has ~44K tags in it. The network repo has ~80
    million refs, of which ~60K are unique. You can imagine that it
    takes some time to access the refs. Basically anything that loads
    the network.git packed-refs file takes an extra minute of CPU and
    needs ~10G RSS to store the internal cache of `packed-refs`.

    Most operations don't care about this; they work on the fork repo,
    and never look at the network refs. But we _do_ sometimes peek at
    alternate refs from receive-pack and fetch-pack to tell the other
    side about tips we have.

    These optimizations backfire completely in such a setting. Besides
    the CPU and memory spikes on the server, even just the unique refs
    add over 3MB to the ref advertisement. So for the time being, we've
    disabled them. I have patches that add a receive.advertiseAlternates
    config option, if anybody is interested.

    So why do I care?  There is one exception: when we are cloning a
    fork, we turn on the fetch-pack side of the optimizations. This is
    worth it for a large repository, as it saves us having to transfer
    any objects at all (and therefore not process them with index-pack,
    which is expensive).

    This series is also a first step towards other optimizations, like
    asking for just the alternate refs from _one_ of the forks. I hope
    one day to turn alternates optimizations back on everywhere.
