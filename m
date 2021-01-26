Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E91C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E79206BE
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhA0D5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:57:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:39984 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388139AbhAZXQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 18:16:53 -0500
Received: (qmail 27951 invoked by uid 109); 26 Jan 2021 23:16:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 23:16:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5170 invoked by uid 111); 26 Jan 2021 23:16:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 18:16:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 18:16:04 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/3] ls-refs: report unborn targets of symrefs
Message-ID: <YBCitNb75rpnuW2L@coredump.intra.peff.net>
References: <YAnotHAiuSz4Du/0@coredump.intra.peff.net>
 <20210126181358.2333028-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126181358.2333028-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 10:13:58AM -0800, Jonathan Tan wrote:

> (It was a bit confusing that refs_resolve_ref_unsafe() returns one of
> its input arguments if it succeeds and NULL if it fails, but that's
> outside the scope of this patch, I think.)

Yep. It would probably be much nicer for it to return a numeric success
code, and to take an optional strbuf into which to write the resolved
symref name (if the caller even cares about it). But definitely out of
scope for your patch.

> > This straight-boolean version works as long as you can atomically update
> > the _config_ on each version. But that seems like roughly the same
> > problem (having dealt with this on GitHub servers, they are not
> > equivalent, and depending on your infrastructure, it definitely _can_ be
> > easier to do one versus the other. But it seems like a funny place to
> > leave this upstream feature).
> 
> Well, I was just agreeing with what you said [1]. :-)
> 
> [1] https://lore.kernel.org/git/X9xJLWdFJfNJTn0p@coredump.intra.peff.net/

Oh, I just need to you to agree harder then. ;)

If we are not going to support config that helps you do an atomic
deploy, then I don't really see the point of having config at all.
Here are three plausible implementations I can conceive of:

  - allowUnborn is a tri-state for "accept-but-do-not-advertise",
    "accept-and-advertise", and "disallow". This helps with rollout in a
    cluster by setting it to the accept-but-do-not-advertise.  The
    default would be accept-and-advertise, which is what most servers
    would want. I don't really know why anyone would want "disallow".

  - allowUnborn is a bool for "accept-and-advertise" or "disallow". This
    doesn't help cluster rollout. I don't know why anyone would want to
    switch away from the default of accept-and-advertise.

  - allowUnborn is always on.

The first one helps the cluster case, at the cost of introducing an
extra config knob. The third one doesn't help that case, but is one less
knob for server admins to think about. But the second one has a knob
that I don't understand why anybody would tweak. It seems like the worst
of both.

Perhaps there's a reason for setting "disallow" that I don't know. Or
perhaps you're happy to help the cluster case using a simple bool with
atomic config rollouts (which are outside the scope of Git itself).

> > Or is the intent that an unconfigured reader would silently ignore the
> > unborn flag in that case? That would at least not cause it to bail on
> > the client in a mixed-version environment. But it does feel like a
> > confusing result.
> 
> Right now, an old server would ignore "unborn", yes. I'm not sure of
> what the intent should be - tightening ls-refs and fetch to forbid
> unknown arguments seems like a good idea to me.

If we had a just a bool (case 2 from above), and there was an
always-implied "accept unborn even if not advertised", then that _does_
let the config help out the cluster case (it just turns off
advertisements, basically making the bool "accept-but-do-not-advertise"
versus "disallow").

I don't love it. The protocol spec does say "don't ask for capability
foo if the server didn't say it knows about foo". We'd be loosening the
enforcement of that (if only for capabilities we _do_ in fact know
about), even though we don't know if it was due to a race, or if the
client is just misbehaving. But I wondered if that was the direction you
were going to try to solve your cluster-rollout problem.

-Peff
