Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC29C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3CE206F4
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgKFRwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:52:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:50092 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFRwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:52:42 -0500
Received: (qmail 20088 invoked by uid 109); 6 Nov 2020 17:52:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Nov 2020 17:52:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2454 invoked by uid 111); 6 Nov 2020 17:52:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Nov 2020 12:52:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Nov 2020 12:52:41 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] update-ref: Allow creation of multiple transactions
Message-ID: <20201106175241.GA182486@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <eec7c2e8ec3e49b34066190d59fc45276bed637f.1604501265.git.ps@pks.im>
 <20201105192901.GA121650@coredump.intra.peff.net>
 <xmqqa6vvij37.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6vvij37.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 05, 2020 at 01:34:20PM -0800, Junio C Hamano wrote:

> > The tests all look quite reasonable to me. Touching .git/refs like this
> > is a bit gross (and something we may have to deal with if we introduce
> > reftables, etc). But it's pretty pervasive in this file, so matching
> > the existing style is the best option for now.
> 
> 
> Shouldn't "git show-ref --verify" be usable portably across ref backends
> to test if a well-formed ref was created (or was not created)?
> 
> On the ref-creation side, there are cases where we need to directly
> futz with the filesystem entity.  For example, "git update-ref"
> cannot be used to place a non-commit at "refs/heads/foo", so
> something like
> 
> 	git rev-parse HEAD^{tree} >.git/refs/heads/bad-branch
> 
> cannot be avoided (this is a tangent but we probably should add a
> way to force setting _any_ value to any ref, that may not even point
> at an existing object or an object of a wrong type, to help test
> scripts).
> 
> But I do not think this is such a case.

Yeah, I agree completely that we could be using rev-parse in this
instance. But it's definitely not alone there:

  $ git grep -c test_path_is.*.git/refs t/t1400-update-ref.sh
  t/t1400-update-ref.sh:13

So it is a question of "do an ugly thing that fits in with neighbors" or
"be inconsistent but set a good example". And I am OK with either. Of
course, "improve the neighbors on top" would be better still. :)

-Peff

PS And yeah, I agree in the long run we may need some mechanism to
   override internal safeties in order to test broken cases with
   reftable. We have sometimes resorted to manually munging on-disk
   files in similar tests (e.g., for broken packs, etc), but it gets
   rather tricky.
