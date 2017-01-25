Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B9B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdAYTy2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:54:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:44699 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751446AbdAYTy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:54:27 -0500
Received: (qmail 30287 invoked by uid 109); 25 Jan 2017 19:54:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 19:54:27 +0000
Received: (qmail 15152 invoked by uid 111); 25 Jan 2017 19:54:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 14:54:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 14:54:25 -0500
Date:   Wed, 25 Jan 2017 14:54:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/12] receive-pack: use oidset to de-duplicate .have
 lines
Message-ID: <20170125195425.q4fpvc4ten5mfjgl@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004739.5aowmmkesbanyohm@sigill.intra.peff.net>
 <xmqqefzraqbu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefzraqbu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 11:32:05AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If you have an alternate object store with a very large
> > number of refs, the peak memory usage of the sha1_array can
> > grow high, even if most of them are duplicates that end up
> > not being printed at all.
> > ...
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  builtin/receive-pack.c | 26 ++++++++++++--------------
> >  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> Nice.  
> 
> Incidentally, this also shows that the refnames in alternate ref
> namespace will not matter.  We are to only show just one of many
> anyway (and that name is masked and replaced with ".have").  Perhaps
> we want to do 04/12 without refname?

I kept the refnames there as a "plausible" thing that a callback might
want. But I have ulterior motives. :)

I have another series which uses alternate refs as part of
check_connected(). Since that function calls rev-list, it needs to add
something like "rev-list --alternate-refs". Even check_connected() does
not care about the refnames, it seems like that rev-list option should
have some useful name for each ref. It can make things like "--source"
more sensible, instead of just reporting everything as a blank ".have".

I could be persuaded otherwise, though.  I don't think we pay a huge for
the refnames here. The generating for-each-ref has them either way, and
the receiving side only keeps one in memory at a time. So we are really
only paying to send them across the pipe and parse them, which doesn't
seem extravagant. I didn't actually measure it, though.

-Peff
