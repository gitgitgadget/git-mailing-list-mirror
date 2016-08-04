Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2909620193
	for <e@80x24.org>; Thu,  4 Aug 2016 20:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758987AbcHDUCE (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:02:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54947 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934070AbcHDUCC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:02:02 -0400
Received: (qmail 12472 invoked by uid 102); 4 Aug 2016 20:02:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 16:02:01 -0400
Received: (qmail 15445 invoked by uid 107); 4 Aug 2016 20:02:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 16:02:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 16:01:58 -0400
Date:	Thu, 4 Aug 2016 16:01:58 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/8] Better heuristics make prettier diffs
Message-ID: <20160804200157.6xq67ceulwyvl7mv@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <20160804073833.7s3hh26hkalifima@sigill.intra.peff.net>
 <xmqqy44c1f90.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy44c1f90.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:54:51PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Not that you probably need more random cases of C code, but I happened
> > to be looking at a diff in git.git today, b333d0d6, which is another
> > regression for the compaction heuristic.
> 
> Wow, that one is _really_ bad.  Does it have something to do with
> the removal being at the very end of the file?

I think so. If it were:

  func1() {
     ... unique stuff ...
     ... shared ending ...
  }

  func2() {
     ... more unique stuff ...
     ... shared ending ...
  }

  unrelated_func() {
  }

and we dropped func2, then I think the blank line between func2() and
unrelated_func() would cause the compaction heuristic to stop shifting.

OTOH, if it were:

  func2() {
     ...
  }
  unrelated_func() {
  }

with no newline, you get a similar badly-shifted diff (which is not
surprising, as we were given no syntactic hint that "func2" is a
separate unit from "unrelated_func").

-Peff
