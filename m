Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD016C83F35
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbjHaR4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjHaR4m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:56:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0DBCC
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:56:39 -0700 (PDT)
Received: (qmail 25381 invoked by uid 109); 31 Aug 2023 17:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 17:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9395 invoked by uid 111); 31 Aug 2023 17:56:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 13:56:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 13:56:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 7/8] interpret-trailers: mark unused "unset" parameters
 in option callbacks
Message-ID: <20230831175638.GC3208283@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
 <20230831071945.GE3197751@coredump.intra.peff.net>
 <xmqq4jkfxhx2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jkfxhx2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 10:04:09AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There are a few parse-option callbacks that do not look at their "unset"
> > parameters, but also do not set PARSE_OPT_NONEG. At first glance this
> > seems like a bug, as we'd ignore "--no-if-exists", etc.
> >
> > But they do work fine, because when "unset" is true, then "arg" is NULL.
> > And all three functions pass "arg" on to helper functions which do the
> > right thing with the NULL.
> 
> Yuck.  That is ugly.

Yep. I wondered about adding a comment here warning about the situation,
but it felt kind of content-less. Something like:

  /* if unset, arg is NULL and handled below */
  trailer_set_where(opt->value, arg);

> > Note that this shortcut would not be correct if any callback used
> > PARSE_OPT_NOARG (in which case "arg" would be NULL but "unset" would be
> > false). But none of these do.
> 
> That is even uglier.  Unlike the BUG_ON_OPT_NEG() and BUG_ON_OPT_ARG()
> that catch discrepancies between options[] flags and the expectation
> by the callback function, there is no way for us to protect against
> such mistakes?

I guess it would be something like:

  if (!unset && !arg)
	BUG("unexpected use of PARSE_OPT_OPTARG");

I think it is less important than those other ones, though, because the
mistake here is the OPT_CALLBACK declaration adding a flag that the
callback is not prepared to handle. Whereas in the other ones, the bug
is that the declaration _forgot_ to use a flag, which is a much more
likely bug.

So I dunno. If it were more than this one case (well, three, but they
are all of the same form) I'd be more worried.

-Peff
