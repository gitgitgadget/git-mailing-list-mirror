Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA65B1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 16:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034477AbeCBQzq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 11:55:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1034475AbeCBQzp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 11:55:45 -0500
Received: (qmail 31177 invoked by uid 109); 2 Mar 2018 16:55:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Mar 2018 16:55:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29680 invoked by uid 111); 2 Mar 2018 16:56:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 11:56:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 11:55:43 -0500
Date:   Fri, 2 Mar 2018 11:55:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
Message-ID: <20180302165543.GA4616@sigill.intra.peff.net>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302070434.GG238112@aiede.svl.corp.google.com>
 <20180302104608.GB11074@sigill.intra.peff.net>
 <xmqq1sh2e7w1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sh2e7w1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 02, 2018 at 08:53:34AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Because the array is full of "undef". See parse_diff(), which does this:
> >
> >   my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
> >   ...
> >   @colored = run_cmd_pipe(@display_cmd);
> >   ...
> >   for (my $i = 0; $i < @diff; $i++) {
> >           ...
> >           push @{$hunk[-1]{TEXT}}, $diff[$i];
> >           push @{$hunk[-1]{DISPLAY}},
> >                (@colored ? $colored[$i] : $diff[$i]);
> >   }
> >
> > If the @colored output is shorter than the normal @diff output, we'll
> > push a bunch of "undef" onto the DISPLAY array (the ternary there is
> > because sometimes @colored is completely empty if the user did not ask
> > for color).
> 
> An obvious sanity check would be to ensure @colored == @diff
> 
>                 push @{$hunk[-1]{DISPLAY}},
>         -            (@colored ? $colored[$i] : $diff[$i]);
>         +            (@colored && @colored == @diff ? $colored[$i] : $diff[$i]);
>          }
> 
> or something like that?

That's probably a reasonable sanity check, but I think we need to abort
and not just have a too-small DISPLAY array. Because later code like the
hunk-splitting is going to assume that there's a 1:1 line
correspondence. We definitely don't want to end up in a situation where
we show one thing but apply another.

-Peff
