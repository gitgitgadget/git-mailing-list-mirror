Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E5C202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 22:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966589AbdKQWdt (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 17:33:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:33038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935197AbdKQWds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 17:33:48 -0500
Received: (qmail 10122 invoked by uid 109); 17 Nov 2017 22:33:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Nov 2017 22:33:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29050 invoked by uid 111); 17 Nov 2017 22:34:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 17 Nov 2017 17:34:02 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Nov 2017 17:33:46 -0500
Date:   Fri, 17 Nov 2017 17:33:46 -0500
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Improved error handling (Was: [PATCH 1/2] sequencer: factor out
 rewrite_file())
Message-ID: <20171117223345.s3ihubgda3qdb2j6@sigill.intra.peff.net>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
 <20171104183643.akaazwswysphzuoq@ruderich.org>
 <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net>
 <20171106161315.dmftp6ktk6bu7cah@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171106161315.dmftp6ktk6bu7cah@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 06, 2017 at 05:13:15PM +0100, Simon Ruderich wrote:

> On Sat, Nov 04, 2017 at 10:07:00PM -0400, Jeff King wrote:
> > Yes, I think what you've written here (and below) is quite close to the
> > error_context patches I linked elsewhere in the thread. In other
> > words, I think it's a sane approach.
> 
> In contrast to error_context I'd like to keep all exiting
> behavior (die, ignore, etc.) in the hand of the caller and not
> use any callbacks as that makes the control flow much harder to
> follow.

Yeah, I have mixed feelings on that. I think it does make the control
flow less clear. At the same time, what I found was that handlers like
die/ignore/warn were the thing that gave the most reduction in
complexity in the callers.

> Regarding the API, should it be allowed to pass NULL as error
> pointer to request no additional error handling or should the
> error functions panic on NULL? Allowing NULL makes partial
> conversions possible (e.g. for write_in_full) where old callers
> just pass NULL and check the return values and converted callers
> can use the error struct.

I think it's probably better to be explicit, and pass some "noop" error
handling struct. We'll have to be adding parameters to functions to
handle this anyway, so I don't think there's much opportunity for having
NULL as a fallback for partial conversions.

> How should translations get handled? Appending ": %s" for
> strerror(errno) might be problematic. Same goes for "outer
> message: inner message" where the helper function just inserts ":
> " between the messages. Is _("%s: %s") (with appropriate
> translator comments) enough to handle these cases?

I don't have a real opinion, not having done much translation myself. I
will say that the existing die_errno(), error_errno(), etc just use "%s:
%s", without even allowing for translation (see fmt_with_err in
usage.c). I'm sure that probably sucks for RTL languages, but I think
it would be fine to punt on it for now.

> Suggestions how to name the struct and the corresponding
> functions? My initial idea was struct error and to use error_ as
> prefix, but I'm not sure if struct error is too broad and may
> introduce conflicts with system headers. Also error_ is a little
> long and could be shorted to just err_ but I don't know if that's
> clear enough. The error_ prefix doesn't conflict with many git
> functions, but there are some in usage.c (error_errno, error,
> error_routine).

In my experiments[1] I called the types error_*, and then generally used
"err" as a local variable when necessary. Variants on that seem fine to
me, but yeah, you have to avoid conflicting with error(). We _could_
rename that, but it would be a pretty invasive patch.

> And as general question, is this approach to error handling
> something we should pursue or are there objections? If there's
> consensus that this might be a good idea I'll look into
> converting some parts of the git code (maybe refs.c) to see how
> it pans out.

I dunno. I kind of like the idea, but if the only error context is one
that adds to strbufs, I don't know that it's buying us much over the
status quo (which is passing around strbufs). It's a little more
explicit, I guess.

Other list regulars besides me seem mostly quiet on the subject.

-Peff

[1] This is the jk/error-context-wip branch of https://github.com/peff/git.
    I can't remember if I mentioned that before.
