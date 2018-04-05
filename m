Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A811F404
	for <e@80x24.org>; Thu,  5 Apr 2018 16:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDEQj4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 12:39:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:54706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751251AbeDEQjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 12:39:55 -0400
Received: (qmail 29826 invoked by uid 109); 5 Apr 2018 16:39:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 16:39:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16814 invoked by uid 111); 5 Apr 2018 16:40:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 12:40:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 12:39:53 -0400
Date:   Thu, 5 Apr 2018 12:39:53 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Palus <jpalus@fastmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Timing issue in t5570 "daemon log records all attributes"
Message-ID: <20180405163953.GB25224@sigill.intra.peff.net>
References: <1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com>
 <20180403203233.GB15157@sigill.intra.peff.net>
 <20180404215752.6qsipaaskrzwiv4q@kalarepa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404215752.6qsipaaskrzwiv4q@kalarepa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 11:57:52PM +0200, Jan Palus wrote:

> On 03.04.2018 16:32, Jeff King wrote:
> > I'm tempted to say we should just scrap this test. It was added
> > relatively recently and only shows the fix for a pretty minor bug.
> > It's probably not worth the contortions to make it race-proof.
> 
> Thanks for your reply Jeff.
> 
> It appears race condition in reading/writing daemon.log is not the only issue of
> t5570. On a different machine I've just randomly got:
> 
> t5570-git-daemon.sh[163]: can't create git_daemon_output: Interrupted system call
> 
> which I believe might also be associated with concurrent processing of piped
> data connected with a fact that test restarts daemon few times. I can barely
> wrap my head around it but I guess it's somewhat around "shell still tries to
> read fifo while attempt to create new one is made".

That sounds more like your system doesn't handle EINTR gracefully
(presumably it's getting SIGCLD during the mknod() call). Normally that
would be done by an external program, but is mkfifo perhaps a builtin in
your shell?

If I run t5570 on a loop on a loaded system[1], I can't seem to provoke
any failures, using dash.

-Peff

[1] The script I use is:

      https://github.com/peff/git/blob/meta/stress

    which runs the test script over and over in parallel. That's usually
    enough to exhibit practical races, since it creates enough load to
    show timing effects.
