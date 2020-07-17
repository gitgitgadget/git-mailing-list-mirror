Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E61C433E0
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAA82065D
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 15:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGQPWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:22:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgGQPWw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 11:22:52 -0400
Received: (qmail 30891 invoked by uid 109); 17 Jul 2020 15:22:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jul 2020 15:22:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4017 invoked by uid 111); 17 Jul 2020 15:22:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jul 2020 11:22:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jul 2020 11:22:51 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200717152251.GA1224964@coredump.intra.peff.net>
References: <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062818.GC3242764@google.com>
 <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
 <20200716110007.GD376357@coredump.intra.peff.net>
 <xmqqd04vigpy.fsf@gitster.c.googlers.com>
 <20200716223719.GA899@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716223719.GA899@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 03:37:19PM -0700, Jonathan Nieder wrote:

> For 2.29, I would like to do or see the following:
> 
> - defining the list of repository format v0 supported extensions as
>   "these and no more", futureproofing along the lines suggested in
>   Peff's patch.  I like the general approach taken there since it
>   allows parsing the relevant config in a single pass, so I think
>   it basically takes the right approach.  (That said, it might be
>   possible to simplify a bit with further changes, e.g. by using the
>   configset API.)
> 
>   When doing this for real, we'd want to document the set of
>   supported extensions.  That is especially useful to independent
>   implementers wanting to support Git's formats, since it tells
>   them "this is the minimum set of extensions that you must
>   either handle or error out cleanly on to maintain compatibility
>   with Git's repository format v0".

I think we should still consider people setting v0 along with extensions
to be a bug. It was never documented to work that way and we are being
nice by keeping the existing behavior, but it is still wrong (and
pre-extension versions of Git will silently ignore them). I don't mind
making other implementers aware of the special status, but we should be
careful not to endorse the broken setup.

> - making "git init" use repository format v1 by default.  It's been
>   long enough that users can count on Git implementations supporting
>   it.  This way, users are less likely to run into v0+extensions
>   confusion, just because users are less likely to be using v0.

That's probably reasonable. It will be mildly annoying for people like
me who are often testing old versions of Git, but I'm sure I will
survive.

We should make sure that all major implementations handle v1 reasonably
first, though (and that they did so long enough ago that it's not likely
to cause problems).

> My preference would be to move forward in 2.28 with the first two
> patches in that topic branch (i.e., *not* the third yet), since they
> don't produce any user facing behavior that would create danger for
> users or clash with this plan.  Today, the only extensions we
> recognize are in that set of extensions that we'll want to continue to
> recognize in v0 (except possibly the for-testing extension "noop").
> The steps to take with additional extensions are more subtle so it
> seems reasonable for them to bake in "next" and then "master" for a
> 2.29 release.

I'm OK with the plan to ship the first two patches for 2.28, and leave
my patch for later (or even soften it from "die" to "ignore with a
warning").

I think leaving "noop" in that set of special extensions makes sense,
since it lets us test that case easily (and I added a "noop-v1" in my
patch to test the other one; clearly we could also flip it and have
noop-v0).

-Peff
