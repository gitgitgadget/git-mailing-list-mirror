Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084221F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 04:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfACEwC (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 23:52:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:53398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726058AbfACEwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 23:52:02 -0500
Received: (qmail 18319 invoked by uid 109); 3 Jan 2019 04:52:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 04:52:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7432 invoked by uid 111); 3 Jan 2019 04:51:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 02 Jan 2019 23:51:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2019 23:52:00 -0500
Date:   Wed, 2 Jan 2019 23:52:00 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: check Bash version for '-x' without using
 shell arrays
Message-ID: <20190103045200.GB20047@sigill.intra.peff.net>
References: <20190101231949.8184-1-szeder.dev@gmail.com>
 <a82251fa-38e1-233e-50d3-3ed4850b4e11@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a82251fa-38e1-233e-50d3-3ed4850b4e11@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 02, 2019 at 01:20:47AM +0100, Johannes Sixt wrote:

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 0f1faa24b2..f47a191e3b 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -324,9 +324,12 @@ do
> >   		# isn't executed with a suitable Bash version.
> >   		if test -z "$test_untraceable" || {
> >   		     test -n "$BASH_VERSION" && {
> > -		       test ${BASH_VERSINFO[0]} -gt 4 || {
> > -			 test ${BASH_VERSINFO[0]} -eq 4 &&
> > -			 test ${BASH_VERSINFO[1]} -ge 1
> > +		       bash_major=${BASH_VERSION%%.*}
> > +		       bash_minor=${BASH_VERSION#*.}
> > +		       bash_minor=${bash_minor%%.*}
> > +		       test $bash_major -gt 4 || {
> > +			 test $bash_major -eq 4 &&
> > +			 test $bash_minor -ge 1
> >   		       }
> >   		     }
> >   		   }
> > 
> 
> Would it perhaps be simpler to just hide the syntax behind eval? Like
> 
>  		if test -z "$test_untraceable" || {
>  		     test -n "$BASH_VERSION" && eval '
> 		       test ${BASH_VERSINFO[0]} -gt 4 || {
> 			 test ${BASH_VERSINFO[0]} -eq 4 &&
> 			 test ${BASH_VERSINFO[1]} -ge 1
> 		       }
>  		     '

That was my first thought, too. :)

The parsing here is simple enough that I'd be fine either with the
original patch, or an eval-based version (and otherwise, the goal and
description seem quite good to me).

-Peff
