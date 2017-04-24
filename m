Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17051FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 11:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168958AbdDXLiM (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 07:38:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:38995 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168955AbdDXLiK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 07:38:10 -0400
Received: (qmail 24952 invoked by uid 109); 24 Apr 2017 11:38:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 11:38:00 +0000
Received: (qmail 5827 invoked by uid 111); 24 Apr 2017 11:38:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 07:38:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 07:37:58 -0400
Date:   Mon, 24 Apr 2017 07:37:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 0/9] Introduce timestamp_t for timestamps
Message-ID: <20170424113758.4orsjmicxbxdxdq4@sigill.intra.peff.net>
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
 <cover.1492771484.git.johannes.schindelin@gmx.de>
 <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 08:29:11PM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Changes since v3:
> >
> > - fixed the fix in archive-zip.c that tried to report a too large
> >   timestamp (and would have reported the uninitialized time_t instead)
> >
> > - adjusted the so-far forgotten each_reflog() function (that was
> >   introduced after v1, in 80f2a6097c4 (t/helper: add test-ref-store to
> >   test ref-store functions, 2017-03-26)) to use timestamp_t and PRItime,
> >   too
> >
> > - removed the date_overflows() check from time_to_tm(), as it calls
> >   gm_time_t() which already performs that check
> >
> > - the date_overflows() check in show_ident_date() was removed, as we do
> >   not know at that point yet whether we use the system functions to
> >   render the date or not (and there would not be a problem in the latter
> >   case)
> 
> Assuming that the list consensus is to go with a separate
> timestamp_t (for that added Cc for those whose comments I saw in an
> earlier round), the patches looked mostly good (I didn't read with
> fine toothed comb the largest one 6/8 to see if there were
> inadvertent or missed conversions from ulong to timestamp_t,
> though), modulo a few minor "huh?" comments I sent separately.
> 
> Will queue; thanks.

Sorry, I haven't read the series carefully yet (but from a skim I'm
happy with the overall direction). It does seem to cause failures in
t4212, though. For example:

  expecting success: 
  	commit=$(munge_author_date HEAD 18446744073709551617) &&
  	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
  	git log -1 --format=%ad $commit >actual &&
  	test_cmp expect actual
  
  fatal: Timestamp too large for this system: 18446744073709551615
  not ok 7 - date parser recognizes integer overflow

We used to convert overflows into a sentinel time, but now we die. I
originally chose the sentinel approach because it lets you use the tools
to examine and recover from the broken state. I could be convinced that
dying is better, but clearly we'd need to at least update the tests.

-Peff
