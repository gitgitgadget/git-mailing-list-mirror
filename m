Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BFE20133
	for <e@80x24.org>; Wed,  8 Mar 2017 06:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754607AbdCHGa0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 01:30:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:40282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbdCHGaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 01:30:25 -0500
Received: (qmail 22877 invoked by uid 109); 8 Mar 2017 06:03:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 06:03:37 +0000
Received: (qmail 15606 invoked by uid 111); 8 Mar 2017 06:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 01:03:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 01:03:34 -0500
Date:   Wed, 8 Mar 2017 01:03:34 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] t*: avoid using pipes
Message-ID: <20170308060334.6ilcjgaxgycuhpxu@sigill.intra.peff.net>
References: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
 <CAGZ79kaYi1OLuOKvbCmDrMCq0fZnO2Ry7JML=Puwmx6TTtEYog@mail.gmail.com>
 <3026648b-a26c-bc67-62dc-170217d6c2ca@kdbg.org>
 <CAGZ79kZhfRiUQndEGB=b34WMCPv0KDjpDix0Ly85aFeyOQAwWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZhfRiUQndEGB=b34WMCPv0KDjpDix0Ly85aFeyOQAwWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 07, 2017 at 12:52:49PM -0800, Stefan Beller wrote:

> On Tue, Mar 7, 2017 at 12:39 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> 
> > Welcome to the Git community!
> 
> >
> > Actually, being a *micro* project, it should stay so. Not doing all of the
> > changes would leave some tasks for other apprentices to get warm with our
> > review process.
> 
> right, so just pick one file.

I also wonder if we really want all invocations of git to be marked up
in this way. If the primary goal of the test is checking that a certain
git command runs successfully and generates the expected output, then I
think it is a good candidate for conversion.

So in a hunk like this:

   test_expect_success 'git commit-tree records the correct tree in a commit' '
   	commit0=$(echo NO | git commit-tree $P) &&
  -	tree=$(git show --pretty=raw $commit0 |
  -		 sed -n -e "s/^tree //p" -e "/^author /q") &&
  +	tree=$(git show --pretty=raw $commit0 >out &&
  +	sed -n -e "s/^tree //p" -e "/^author /q" <out) &&
   	test "z$tree" = "z$P"

we are interested in testing commit-tree, not "git show". Is it worth
avoiding pipes there? I admit the cost to using the intermediate file is
not huge there, but it feels more awkward and un-shell-like to me as a
reader.

-Peff
