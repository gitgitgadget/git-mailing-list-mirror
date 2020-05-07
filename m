Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA38C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B0D20870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgEGLgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 07:36:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:39996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725848AbgEGLgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 07:36:25 -0400
Received: (qmail 30916 invoked by uid 109); 7 May 2020 11:36:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 11:36:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16112 invoked by uid 111); 7 May 2020 11:36:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 07:36:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 07:36:24 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] upload-pack: fix filter options scope
Message-ID: <20200507113624.GA3027470@coredump.intra.peff.net>
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507095829.16894-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 11:58:29AM +0200, Christian Couder wrote:

> I am not sure why upload_pack_v2() is called twice. Also it seems
> that another similar issue might not be fixed by this. So this patch
> is RFC for now.

It's because of the request/response model of v2. The client side of the
conversation looks something like:

  - client connects transport to server

  - client issues command=ls-refs to get the ref advertisement

  - client issues command=fetch and sends wants/have; the server may
    respond with a pack when the negotiation is finished, but may also
    respond with acks, etc, asking for more rounds of negotiation

  - if there's no pack, the client then issues another command=fetch,
    repeating until we get a pack

In stateless git-over-http, each of those request/response pairs happens in
its own server-side process, because the webserver kicks off a separate
CGI for each request. But v2 adapts git://, ssh://, and direct-pipe
connections to use the same request/response model, but all connected to
a single Git process on the other side.

So each upload_pack_v2() call needs to start with a clean slate; it
can't assume anything about previous rounds, and it needs to clean up
any allocated data from those rounds.

So your patch is going in the right direction, but we already have other
similar data handled by upload_pack_data, which has its own init/clear
functions. Probably the filter data should go in there, too.

This is an easy bug to introduce, and I suspect we'll see equivalent
ones in the future (if there aren't already more lurking; there's a lot
of global data in Git, and I really have no idea what subtle
interactions one could see). One thing we could do is to truly run each
v2 command request in its own process, just like git-over-http does. But
there are a lot of complications there around holding the pipe/socket
open, how the parent v2 serving process interacts with the child
requests (e.g., noticing errors), etc. So I'd worry that going that
direction would be just as likely to introduce bugs as fix them.

> diff --git a/upload-pack.c b/upload-pack.c
> index 902d0ad5e1..4e22e46294 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -68,7 +68,6 @@ static const char *pack_objects_hook;
>  static int filter_capability_requested;
>  static int allow_filter;
>  static int allow_ref_in_want;
> -static struct list_objects_filter_options filter_options;

Just looking at nearby bits of global data that might want similar
treatment:

 - allow_filter and allow_ref_in_want are set by the server-side config.
   So they're persisted between upload_pack_v2() calls, but we'd
   overwrite them by calling git_config() in each incarnation

 - filter_capability_requested is set based on client input, but it's
   only used in v1

But boy there are a lot of global variables there to trace through.
Probably a more fruitful way to find similar problems is to look at the
v2 process_args() to see what it touches. It looks like options like
ofs_delta probably ought to be part of upload_pack_data, too. We didn't
notice because it would require a client doing something like:

  command=fetch
  ofs-delta    [claims to support ofs-delta]
  0001
  [wants and haves that don't result in a pack yet...]
  0000
  command=fetch
  [do not claim to support ofs-delta!]
  0001
  [wants and haves that result in a pack]
  0000

The server _shouldn't_ use ofs-delta there (and wouldn't over http,
where the stateless server side that generates the pack knows only about
that second request). But in git-over-ssh, it would.

A client who does this is stupid and wrong (and I didn't check the
protocol spec, but it could very well be violating the spec). So I don't
think it's _that_ big a deal. But it would be nice if all of those
globals got moved into upload_pack_data, and both v1 and v2 just used it
consistently.

-Peff
