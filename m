Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E3C20229
	for <e@80x24.org>; Fri, 21 Oct 2016 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934775AbcJUVmW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 17:42:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:60889 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934208AbcJUVmV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 17:42:21 -0400
Received: (qmail 21130 invoked by uid 109); 21 Oct 2016 21:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 21:42:21 +0000
Received: (qmail 6941 invoked by uid 111); 21 Oct 2016 21:42:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 17:42:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 17:42:18 -0400
Date:   Fri, 21 Oct 2016 17:42:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] fetch output is ugly in 'next'
Message-ID: <20161021214218.u46qf3lch3wwiutp@sigill.intra.peff.net>
References: <20161021002654.qo6kcya4gocp73rs@sigill.intra.peff.net>
 <CACsJy8Bxn1qV+xXNnCpuOQ7qWNsz3oLt5-VG=VXZvV9dvJVvTQ@mail.gmail.com>
 <CACsJy8CkK8K0ty3fv9qyD7wwB+81VPB-P1UUCbDJTJ4iM0Y+Cw@mail.gmail.com>
 <xmqqd1itd4t2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1itd4t2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 09:50:49AM -0700, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Fri, Oct 21, 2016 at 7:11 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> >> Yeah.. replacing the 4 DEFAULT_ABBREV in fetch.c with something
> >> sensible should do it.
> >
> > Correction (if somebody will pick this up), it's
> > TRANSPORT_SUMMARY_WIDTH that needs to be adjusted, not those four.
> 
> Yes, it used to be and it still is (2 * DEFAULT_ABBREV + 3) but in
> the new world order where default-abbrev is often -1 the expression
> does not make much sense.
> 
> Perhaps something along this line?
> 
>  transport.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/transport.h b/transport.h
> index 18d2cf8275..5339fabbad 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -127,7 +127,7 @@ struct transport {
>  #define TRANSPORT_PUSH_CERT 2048
>  #define TRANSPORT_PUSH_ATOMIC 4096
>  
> -#define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
> +#define TRANSPORT_SUMMARY_WIDTH (2 * (DEFAULT_ABBREV < 0 ? 7 : DEFAULT_ABBREV) + 3)
>  #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)

That doesn't apply on 'next', because we have already done the
equivalent there. :)

The right way to spell "7" is FALLBACK_DEFAULT_ABBREV, which is handled
by your 65acfeacaa.

The remaining issue is that the static abbreviation is not nearly long
enough for git.git anymore; the auto-abbrev feature bumps my repo to a
minimum of 10 characters (it may only be 9 on a fresh clone; I have a
couple remotes and active work in progress). So this isn't exactly a
regression; it has always been the case that we may mis-align when the
abbreviations ended up longer than the minimum. It's just that it didn't
happen all that often in most repos (but it probably did constantly in
linux.git).

The simplest band-aid fix would be to compute TRANSPORT_SUMMARY_WIDTH on
the fly, taking into account the minimum found by actually counting the
objects. That at least gets us back to where we were, with it mostly
working and occasionally ugly when there's an oddball collision (for
git.git anyway; it probably makes the kernel output much nicer).

The "right" fix is to queue up the list of ref updates to print, find
the abbreviations for each, and then print them all in one shot, knowing
ahead of time the size necessary to align them. This could also let us
improve the name-alignment.

-Peff
