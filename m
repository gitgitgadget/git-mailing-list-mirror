Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD53C202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbdJPVpP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 17:45:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:54522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932076AbdJPVpP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 17:45:15 -0400
Received: (qmail 9436 invoked by uid 109); 16 Oct 2017 21:45:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 21:45:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16989 invoked by uid 111); 16 Oct 2017 21:45:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 17:45:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 17:45:13 -0400
Date:   Mon, 16 Oct 2017 17:45:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anthony Sottile <asottile@umich.edu>, git@vger.kernel.org
Subject: Re: [PATCH] diff: alias -q to --quiet
Message-ID: <20171016214512.xlp4ctzo37niaarx@sigill.intra.peff.net>
References: <20171013164415.6632-1-asottile@umich.edu>
 <20171013175656.qitarz6lvrppyb5f@sigill.intra.peff.net>
 <xmqq60biv4if.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60biv4if.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 14, 2017 at 11:37:28AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So there are two separate questions/tasks:
> >
> >   1. Should we remove the special handling of "-q" leftover from this
> >      deprecation? I think the answer is yes.
> >
> >   2. Should we teach the diff machinery as a whole to treat "-q" as a
> >      synonym for "--quiet".
> 
> Good questions.  And thanks for archaeology.
> 
> The topic #1 above is something that should have happened when "-q" stopped working
> as "--diff-filter=d", and we probably should have started to error
> out then, so that scripts that relied on the original behaviour
> would have been forced to update.  That did not happen which was a
> grave mistake.
> 
> By doing so, we would have made sure any script that uses "-q" died
> out, and after a while, we can talk about reusing it for other
> purposes, like the topic #2 above.
> 
> Is it worth making "-q" error out while doing #1 and keep it error
> out for a few years?  I have a feeling that the answer might be
> unfortunately yes _if_ we want to also do #2.  Even though we broke
> "-q" for the scripts who wanted to see it ignore only the removals 4
> years ago and left it broken since then.  Removals are much rarer
> than modifications and additions, so it wouldn't be surprising if
> the users of these scripts simply did not notice the old breakage,
> but if we made "-q" to mean "--quiet" without doing #1, they will
> break, as all diffs these scripts work on will suddenly give an
> empty output.

Yeah, after thinking about it, I do think we'd want to restart the
deprecation period. For some features it would be fine, but this one is
sufficiently subtle that I agree there's a good chance scripts might
have been broken without anybody noticing them.

> If we aren't doing #2, then I do not think we need to make "-q"
> error out when we do #1, though.

I don't think we'd add an explicit error-out. But by removing the
leftover code, we would naturally say "no such option: -q", which
amounts to the same thing.

> In any case, if we were to do both of the above two, they must
> happen in that order, not the other way around.

Yep, agreed.

-Peff
