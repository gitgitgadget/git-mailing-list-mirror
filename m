Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665882042F
	for <e@80x24.org>; Tue, 13 Dec 2016 12:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbcLMMPQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 07:15:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:55637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932577AbcLMMPP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 07:15:15 -0500
Received: (qmail 31461 invoked by uid 109); 13 Dec 2016 12:15:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 12:15:14 +0000
Received: (qmail 13955 invoked by uid 111); 13 Dec 2016 12:15:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 07:15:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 07:15:10 -0500
Date:   Tue, 13 Dec 2016 07:15:10 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, gitter.spiros@gmail.com
Subject: Re: [RFC/PATCH] Makefile: add cppcheck target
Message-ID: <20161213121510.5o5axuwzztbxcvfd@sigill.intra.peff.net>
References: <20161213092225.15299-1-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161213092225.15299-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 10:22:25PM +1300, Chris Packham wrote:

> $ make cppcheck
> cppcheck --force --quiet --inline-suppr  .
> [compat/nedmalloc/malloc.c.h:4093]: (error) Possible null pointer dereference: sp
> [compat/nedmalloc/malloc.c.h:4106]: (error) Possible null pointer dereference: sp
> [compat/nedmalloc/nedmalloc.c:551]: (error) Expression '*(&p.mycache)=TlsAlloc(),TLS_OUT_OF_INDEXES==*(&p.mycache)' depends on order of evaluation of side effects
> [compat/regex/regcomp.c:3086]: (error) Memory leak: sbcset
> [compat/regex/regcomp.c:3634]: (error) Memory leak: sbcset
> [compat/regex/regcomp.c:3086]: (error) Memory leak: mbcset
> [compat/regex/regcomp.c:3634]: (error) Memory leak: mbcset
> [compat/regex/regcomp.c:2802]: (error) Uninitialized variable: table_size
> [compat/regex/regcomp.c:2805]: (error) Uninitialized variable: table_size
> [compat/regex/regcomp.c:532]: (error) Memory leak: fastmap
> [t/t4051/appended1.c:3]: (error) Invalid number of character '{' when these macros are defined: ''.
> [t/t4051/appended2.c:35]: (error) Invalid number of character '{' when these macros are defined: ''.
> 
> The last 2 are just false positives from test data. I haven't looked
> into any of the others.

I think these last two are a good sign that we need to be feeding the
list of source files to cppcheck. I tried your patch and it also started
looking in t/perf/build, which are old versions of git built to serve
the performance-testing suite.

See the way that the "tags" target is handled for a possible approach.

My main complaint with any static checker is how we can handle false
positives. I think our use of "-Wall -Werror" is successful because it's
not too hard to keep the normal state to zero warnings. Looking at the
output of cppcheck on my system (which is different than on yours!), I
do see a few real problems, but many false positives, too.
Unfortunately, one of the false positives is:

  int foo = foo;

to silence -Wuninitialized, which causes cppcheck to complain that "foo"
is uninitialized. I'm worried we will end up with two static checkers
fighting each other, and no good way to please both.

-Peff
