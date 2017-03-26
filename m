Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5DD20969
	for <e@80x24.org>; Sun, 26 Mar 2017 06:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbdCZGZK (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 02:25:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:51881 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbdCZGZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 02:25:10 -0400
Received: (qmail 17769 invoked by uid 109); 26 Mar 2017 06:18:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 06:18:29 +0000
Received: (qmail 29026 invoked by uid 111); 26 Mar 2017 06:18:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 02:18:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Mar 2017 02:18:26 -0400
Date:   Sun, 26 Mar 2017 02:18:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
Message-ID: <20170326061826.yx6nh3k2ps6uyyz6@sigill.intra.peff.net>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
 <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 11:37:54PM -0700, Junio C Hamano wrote:

> The hash that names a packfile is constructed by sorting all the
> names of the objects contained in the packfile and running SHA-1
> hash over it.  I think this MUST be hashed with collision-attack
> detection.  A malicious site can feed you a packfile that contains
> objects the site crafts so that the sorted object names would result
> in a collision-attack, ending up with one pack that contains a sets
> of objects different from another pack that happens to have the same
> packname, causing Git to say "Ah, this new pack must have the same
> set of objects as the pack we already have" and discard it,
> resulting in lost objects and a corrupt repository with missing
> objects.

I don't think this case really matters for collision detection. What's
important is what Git does when it receives a brand-new packfile that
would overwrite an existing one. It _should_ keep the old one, under the
usual "existing data wins" rule.

It should be easy to test, though:

  $ git init tmp && cd tmp
  $ git commit --allow-empty -m foo
  $ git gc

  $ touch -d yesterday .git/objects/pack/*
  $ ls -l .git/objects/pack
  -r--r--r-- 1 peff peff 1128 Mar 25 02:10 pack-7e9d64ac27adc9ce1b12774dd287ff9bd8a9345b.idx
  -r--r--r-- 1 peff peff  153 Mar 25 02:10 pack-7e9d64ac27adc9ce1b12774dd287ff9bd8a9345b.pack

  $ git index-pack --stdin <.git/objects/pack/*.pack
  pack	7e9d64ac27adc9ce1b12774dd287ff9bd8a9345b

  $ ls -l .git/objects/pack
  -r--r--r-- 1 peff peff 1128 Mar 25 02:10 pack-7e9d64ac27adc9ce1b12774dd287ff9bd8a9345b.idx
  -r--r--r-- 1 peff peff  153 Mar 25 02:10 pack-7e9d64ac27adc9ce1b12774dd287ff9bd8a9345b.pack

Looks like the timestamps were retained. <phew> And if we use strace, we
can see what happens:

  $ strace git index-pac k--stdin <.git/objects/pack/*.pack
  link(".git/objects/pack/tmp_pack_YSrdWU", ".git/objects/pack/pack-7e9d64ac27adc9ce1b12774dd287ff9bd8a9345b.pack") = -1 EEXIST (File exists)
  unlink(".git/objects/pack/tmp_pack_YSrdWU") = 0
  link(".git/objects/pack/tmp_idx_O94NNU", ".git/objects/pack/pack-7e9d64ac27adc9ce1b12774dd287ff9bd8a9345b.idx") = -1 EEXIST (File exists)
  unlink(".git/objects/pack/tmp_idx_O94NNU") = 0

This is due to the link()/EEXIST handling in finalize_object_file. It
has a FIXME for a collision check, so we could actually detect at that
point whether we have a real collision, or if the other side just
happened to send us the same pack.

I wouldn't be surprised if the dumb-http walker is not so careful,
though (but the solution is to make it careful, not to worry about
a weak hash algorithm).

The rest of your email all made sense to me.

-Peff
