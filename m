Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2D62070C
	for <e@80x24.org>; Wed,  6 Jul 2016 19:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbcGFTCC (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 15:02:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:41058 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755291AbcGFTCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 15:02:01 -0400
Received: (qmail 5973 invoked by uid 102); 6 Jul 2016 19:02:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jul 2016 15:02:01 -0400
Received: (qmail 28437 invoked by uid 107); 6 Jul 2016 19:02:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jul 2016 15:02:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2016 15:01:58 -0400
Date:	Wed, 6 Jul 2016 15:01:58 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t7610 test for mktemp existence
Message-ID: <20160706190158.GA31148@sigill.intra.peff.net>
References: <57780F9F.3050802@googlemail.com>
 <xmqqr3b6sk08.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3b6sk08.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 06, 2016 at 11:23:51AM -0700, Junio C Hamano wrote:

> > -test_expect_success 'temporary filenames are used with mergetool.writeToTemp' '
> > +test_lazy_prereq MKTEMP '
> > +	tempdir=$(mktemp -d -t foo.XXX) &&
> > +	test -d "$tempdir"
> > +'
> 
> This makes me wonder what would happen to the leftover directory,
> though.  Would it be a better idea to clean it up as well, i.e.
> 
> 	tempdir=$(mktemp -d -t foo.XXXXXX) &&
> 	test -d "$tempdir" &&
>         rmdir "$tempdir"

Lazy prereq's are computed inside a temporary directory[1] that is
automatically cleaned up, so I think the code here does not have to
worry about it.

-Peff

[1] Coincidentally, I recently wanted to have a lazy prereq check
    _another_ prereq inside it. But it turns out you cannot do this:

      test_lazy_prereq RECURSE_INNER '
        echo inner >file
      '
      test_lazy_prereq RECURSE_OUTER '
        echo outer >file &&
	test_have_prereq RECURSE_INNER &&
	echo outer >expect &&
	test_cmp expeect file
      '
      test_expect_success 'lazy prereqs can recurse' '
	test_have_prereq RECURSE_OUTER
      '

    because they both use the same temporary directory (so beyond having
    "outer" see "inner" in the file, it actually complains when the
    inner check removes the directory entirely).

    The fix for that is simple: give the tempdir a unique name. But I
    think this kind of recursion is still not OK in the shell because
    without the "local" keyword, we have no concept of stack variables,
    and so stomp on the globals with each iteration.

    Anyway. Not a big deal, and I ended up simplifying my tests not to
    need it. But I was certainly surprised and confused by it at the
    time, so I figured it was worth sharing the knowledge. :)
