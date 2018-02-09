Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251091F404
	for <e@80x24.org>; Fri,  9 Feb 2018 14:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBIOVg (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 09:21:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:46868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750970AbeBIOVe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 09:21:34 -0500
Received: (qmail 24001 invoked by uid 109); 9 Feb 2018 14:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Feb 2018 14:21:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21649 invoked by uid 111); 9 Feb 2018 14:22:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 09:22:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 09:21:31 -0500
Date:   Fri, 9 Feb 2018 09:21:31 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] t: teach 'test_must_fail' to save the command's
 stderr to a file
Message-ID: <20180209142131.GA18701@sigill.intra.peff.net>
References: <20180209024235.3431-1-szeder.dev@gmail.com>
 <20180209024235.3431-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180209024235.3431-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 03:42:34AM +0100, SZEDER Gábor wrote:

> To check that a git command fails and to inspect its error message we
> usually execute a command like this throughout our test suite:
> 
>   test_must_fail git command --option 2>output.err
> 
> Note that this command doesn't limit the redirection to the git
> command, but it redirects the standard error of the 'test_must_fail'
> helper function as well.  This is wrong for several reasons:
> 
>   - If that git command were to succeed or die for an unexpected
>     reason e.g. signal, then 'test_must_fail's helpful error message
>     would end up in the given file instead of on the terminal or in
>     't/test-results/$T.out', when the test is run with '-v' or
>     '--verbose-log', respectively.
> 
>   - If the test is run with '-x', the trace of executed commands in
>     'test_must_fail' will go to stderr as well (except for more recent
>     Bash versions supporting $BASH_XTRACEFD), and then in turn will
>     end up in the given file.

I have to admit that I'm slightly negative on this approach, just
because:

  1. It requires every caller to do something special, rather than just
     using normal redirection. And the feature isn't as powerful as
     redirection. E.g., some callers do:

       test_must_fail foo >output 2>&1

     But:

       test_must_fail stderr=output foo >output

     is not quite right (stdout and stderr outputs may clobber each
     other, because they have independent position pointers).

  2. The "-x" problems aren't specific to test_must_fail at all. They're
     a general issue with shell functions.

I'm not entirely happy with saying "if you want to use -x, please use
bash". But given that it actually solves the problems everywhere with no
further effort, is it really that bad a solution?

For the error messages from test_must_fail, could we go in the same
direction, and send them to descriptor 4 rather than 2? We've already
staked out descriptor 4 as something magical that must be left alone
(see 9be795fb). If we can rely on that, then it becomes a convenient way
for functions to make sure their output is going to the script's stderr.

-Peff
