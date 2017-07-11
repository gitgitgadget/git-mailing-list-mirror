Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4549320357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755222AbdGKHGW (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:06:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:36592 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754126AbdGKHGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:06:21 -0400
Received: (qmail 26974 invoked by uid 109); 11 Jul 2017 07:06:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 07:06:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13433 invoked by uid 111); 11 Jul 2017 07:06:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 03:06:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 03:06:19 -0400
Date:   Tue, 11 Jul 2017 03:06:19 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Peter Eckersley <peter.eckersley@gmail.com>, git@vger.kernel.org
Subject: Re: Weirdness with git change detection
Message-ID: <20170711070618.dq52o67ixvjudafg@sigill.intra.peff.net>
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
 <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 06:15:17AM +0200, Torsten Bögershausen wrote:

> On 11/07/17 01:45, Peter Eckersley wrote:
> > I have a local git repo that's in some weird state where changes
> > appear to be detected by "git diff" and prevent operations like "git
> > checkout" from switching branches, but those changes are not removed
> > by a "git reset --hard" or "git stash".
> > 
> > Here's an example of the behaviour, with "git reset --hard" failing to
> > clear a diff in the index:
> > 
> > https://paste.debian.net/975811/
> > 
> > Happy to collect additional debugging information if it's useful.
> > 
> If possible, we need to clone the repo and debug ourselfs - in other
> words, the problem must be reproducible for others.
> 
> It the repo public ?

It looks like https://github.com/AI-metrics/AI-metrics.

I notice it has a .gitattributes file with:

  *.ipynb filter=clean_ipynb

There's a config snippet in the repo with:

  [filter "clean_ipynb"]
    clean = ipynb_drop_output
    smudge = cat

and the drop_output script is included. From the paste we can see that
Peter was at commit c464aaa. Checking out that commit and running the
script shows that it produces the differences that Git is showing.

The problem is that the currently committed contents do not match the
output of the clean filter. So even when "git reset --hard" puts the
content from the repository back into the working tree (putting it
through the smudge filter, which is a noop), running the clean filter on
the result will always have a difference. Either the filter needs to be
disabled, or the cleaned contents committed.

-Peff
