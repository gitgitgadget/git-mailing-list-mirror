Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SUSPICIOUS_RECIPS shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011D91F453
	for <e@80x24.org>; Wed,  1 May 2019 02:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfEACV0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 22:21:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:45412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726123AbfEACV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 22:21:26 -0400
Received: (qmail 32581 invoked by uid 109); 1 May 2019 02:21:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 02:21:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14865 invoked by uid 111); 1 May 2019 02:22:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 22:22:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 22:21:24 -0400
Date:   Tue, 30 Apr 2019 22:21:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Start to implement a built-in version of `git add
 --interactive`
Message-ID: <20190501022123.GA22549@sigill.intra.peff.net>
References: <pull.170.git.gitgitgadget@gmail.com>
 <12978dc248a2cd07c90559691b8a2add84f45394.1554917868.git.gitgitgadget@gmail.com>
 <3149b9ba-2f5a-46ce-ad89-4105ec217795@jeffhostetler.com>
 <20190418160633.GB8054@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904301935400.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904301935400.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 07:40:06PM -0400, Johannes Schindelin wrote:

> > Yeah, I agree this split seems a bit more natural. It is worth
> > propagating errors from add_i_config(), though, like:
> >
> >   if (add_i_config(var, value, data))
> > 	return -1;
> >
> > so that any key-specific errors (e.g., config_error_nonbool) stop the
> > parsing in the usual way.
> 
> The only problem there is that `add_i_config()` (like all the other
> `git_config()` callbacks) does not report whether it consumed the
> key/value pair or not. I tried to avoid deviating from the standard
> practice to avoid calling `git_default_config()` when we already consumed
> the config setting.

I don't think it's worth worrying too much about that. We wouldn't match
the keys in multiple places anyway (and even if we did, it would
arguably be the right thing to give every callback a chance to see
them).

The only thing it does is short-circuit the rest of the checks that we
know won't match. But that doesn't really change the performance
substantially; the worst case is already that we have to hit every
possible strcmp().

And most of our config code does not worry about this, and is OK with
branching (it just needs to propagate errors, as above).  For some more
discussion, see 6680a0874f (drop odd return value semantics from
userdiff_config, 2012-02-07).

All that said...

> And I also tried pretty hard to *not* bleed any internal state of
> `add-interactive` into `builtin/add`, as I wanted the new code to be as
> libified as possible (in a nearby thread, somebody wished for a new `-p`
> mode that would essentially be a combined `git stash -p` and `git add -p`,
> and with properly libified code such a beast is a lot more feasible).
> 
> Any idea how to deal with that?

The most lib-ified thing is to just use the configset code. I.e.,
wherever you need the config, just load it on demand via
git_config_get_int or whatever.

> Or I invent a new convention where `add_i_config()` returns 1 when it
> consumed the key/value pair. But that would set a precedent that is
> inconsistent with the entire existing code base, something I am
> uncomfortable to do for the sake of `add -i`...

Yes, don't do that. :) That was the same thing we finally got rid of for
userdiff_config().

-Peff
