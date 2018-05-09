Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836461F424
	for <e@80x24.org>; Wed,  9 May 2018 14:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935155AbeEIOuB (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 10:50:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934809AbeEIOuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 10:50:00 -0400
Received: (qmail 1704 invoked by uid 109); 9 May 2018 14:50:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 May 2018 14:50:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15312 invoked by uid 111); 9 May 2018 14:50:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 May 2018 10:50:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2018 10:49:58 -0400
Date:   Wed, 9 May 2018 10:49:58 -0400
From:   Jeff King <peff@peff.net>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] wrap-for-bin.sh: facilitate running Git executables
 under valgrind
Message-ID: <20180509144958.GB14714@sigill.intra.peff.net>
References: <20180509132858.21936-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180509132858.21936-1-ao2@ao2.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 03:28:58PM +0200, Antonio Ospite wrote:

> Testing locally built git executables under valgrind is not immediate.
> 
> Something like the following does not work:
> 
>   $ valgrind ./bin-wrappers/git
> 
> because the wrapper script forks and execs the command and valgrind does
> not track children processes by default.
> 
> Something like the following may work:
> 
>   $ valgrind --trace-children=yes ./bin-wrappers/git
> 
> However it's counterintuitive and not ideal anyways because valgrind is
> supposed to be called on the actual executable, not on wrapper scripts.
> 
> So, following the idea from commit 6a94088cc ("test: facilitate
> debugging Git executables in tests with gdb", 2015-10-30) provide
> a mechanism in the wrapper script to call valgrind directly on the
> actual executable.

Unfortunately this isn't quite enough to get full valgrind coverage,
because Git often execs sub-processes of itself (and for anything that
isn't a builtin, all you're checking is the outer "git" process which
dispatches to "git-foo").

> This mechanism could even be used by the test infrastructure in the
> future, but it is already useful by its own on the command line:
> 
>   $ GIT_TEST_VALGRIND=1 \
>     GIT_VALGRIND_OPTIONS="--leak-check=full" \
>     ./bin-wrappers/git

If you look in t/test-lib.sh, you can see the contortions the test
infrastructure goes through to support --valgrind. Basically it creates
a parallel bin-wrappers directory where everything gets run under
valgrind. ;)

So I dunno. I'm not opposed to this patch in principle if people find it
useful. These days _most_ things are builtins, so it would at least
cover most of the code you'd want to hit for a debugging session, as
long as you're not concerned with full coverage. But I don't think it's
the right approach for instrumenting the test suite.

-Peff
