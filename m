Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980E81FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934249AbcLAUTV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:19:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:50127 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934190AbcLAUTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:19:20 -0500
Received: (qmail 14176 invoked by uid 109); 1 Dec 2016 20:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 20:19:20 +0000
Received: (qmail 3298 invoked by uid 111); 1 Dec 2016 20:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 15:19:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 15:19:18 -0500
Date:   Thu, 1 Dec 2016 15:19:17 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
Message-ID: <20161201201917.nqx3v5fl2ptl3bhr@sigill.intra.peff.net>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
 <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
 <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 12:14:42PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > To make matters more fun, apparently[1] there are multiple variants of
> > qsort_r with different argument orders. _And_ apparently Microsoft
> > defines qsort_s, but it's not quite the same thing. But all of that can
> > be dealt with by having more specific flags (HAVE_GNU_QSORT_R, etc).
> >
> > It just seems like we should be able to do a better job of using the
> > system qsort in many cases.
> 
> If we were to go that route, perhaps we shouldn't have HAVE_QSORT_S
> so that Microsoft folks won't define it by mistake (instead perhaps
> call it HAVE_ISO_QSORT_S or something).
> 
> I like your suggestion in general.  The body of git_qsort_s() on
> systems without ISO_QSORT_S can do 
> 
>  - GNU qsort_r() without any change in the parameters, 
> 
>  - Microsoft qsort_s() with parameter reordered, or 
> 
>  - Apple/BSD qsort_r() with parameter reordered.
> 
> and that would cover the major platforms.
> 
> Eh, wait.  BSD and Microsoft have paramters reordered in the
> callback comparison function.  I suspect that would not fly very
> well.

You can hack around it by passing a wrapper callback that flips the
arguments. Since we have a "void *" data pointer, that would point to a
struct holding the "real" callback and chaining to the original data
pointer.

It does incur the cost of an extra level of indirection for each
comparison, though (not just for each qsort call).

You could do it as zero-cost if you were willing to turn the comparison
function definition into a macro.

-Peff
