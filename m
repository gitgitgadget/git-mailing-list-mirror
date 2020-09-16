Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54C3C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5E920770
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgIPUri (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:47:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:58410 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgIPRBU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:01:20 -0400
Received: (qmail 24799 invoked by uid 109); 16 Sep 2020 16:34:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 16:34:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29552 invoked by uid 111); 16 Sep 2020 16:34:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 12:34:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 12:34:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200916163427.GB17726@coredump.intra.peff.net>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915140613.GB18984@pflmari>
 <20200915152730.GA2853972@coredump.intra.peff.net>
 <xmqq4kny2461.fsf@gitster.c.googlers.com>
 <20200915212338.GA2868700@coredump.intra.peff.net>
 <xmqqa6xqzpx9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6xqzpx9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 02:32:50PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think the best you could do is:
> >
> >   1. Keep two separate option lists, "parent" and "child". The parent
> >      list has "--all" in it. The child list has stuff like "--ipv6".
> >
> >   2. Parse using the parent list with PARSE_OPT_KEEP_UNKNOWN. That lets
> >      you decide whether we're in a mode that is spawning child fetch
> >      processes.
> 
> Hmph, I vaguely recall discussion about cascading options[] list but
> do not find anything that may be involved in an implementation like
> that in <parse-options.h>.  I agree that neither of the above is so
> attractive.

I think we just use KEEP_UNKNOWN in those cases and ignore any downsides
to it.

> > I guess parse-options could provide a MAYBE_PASSTHRU flag. On the first
> > parse_options() call, it would skip over any such options, leaving them
> > in argv. On the second, the caller would tell it to actually parse them.
> 
> Or calling it USR1, which is a good way to make it crystal clear
> that parse_options() API does not do anything to it.  The code like
> "builtin/fetch.c" can locally give it a more meaningful name with
> "#define PARSE_OPT_RECURSIVE PARSE_OPT_USR1". if recursive is the
> appropriate name for the bit in the context of the options[] array.

Ah, that's a good suggestion. My earlier "USER" suggestion was
tongue-in-cheek, because I think it makes the resulting options list
quite confusing.  But a local #define fixes that nicely.

That said, it sounds from the other part of the thread like we'll need
better parse-options support anyway, so this "noop flag bit" idea
probably isn't a good direction anyway.

-Peff
