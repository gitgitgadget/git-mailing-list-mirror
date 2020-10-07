Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE3C47095
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF88E216C4
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgJGPjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:39:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:52244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgJGPjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 11:39:48 -0400
Received: (qmail 20277 invoked by uid 109); 7 Oct 2020 15:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 15:39:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12713 invoked by uid 111); 7 Oct 2020 15:39:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 11:39:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 11:39:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
Message-ID: <20201007153947.GA181281@coredump.intra.peff.net>
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 03:41:24PM -0700, Junio C Hamano wrote:

>  * "git index-pack" learned to resolve deltified objects with greater
>    parallelism.

I noticed a small regression in v2.29 today: we no longer seem to show
progress during the delta resolution phase of index-pack.

E.g., try this in a clone of git.git (or really any decent-sized repo
where the delta resolution takes a few seconds):

  # simulate the pack we'd get from a clone or big fetch
  git pack-objects --all --stdout >foo.pack </dev/null

  # now simulate the index-pack on the receiving side
  rm -rf repo
  git init repo &&
  (cd repo && git index-pack -v --stdin <../foo.pack)

You should see the:

  Receiving objects: 100% (300970/300970), 74.39 MiB | 57.93 MiB/s, done.

progress. We used to follow that with:

  Resolving deltas: 100% (249340/249340), done.

but now you get nothing for several seconds while we resolve deltas.

The problem bisects to f08cbf60fe (index-pack: make quantum of work
smaller, 2020-09-08) at the tip of jt/threaded-index-pack. I haven't dug
further yet.

-Peff
