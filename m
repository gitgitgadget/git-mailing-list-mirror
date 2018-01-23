Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B29C1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeAWQzs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:55:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:54570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751599AbeAWQzr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:55:47 -0500
Received: (qmail 25780 invoked by uid 109); 23 Jan 2018 16:55:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 16:55:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17408 invoked by uid 111); 23 Jan 2018 16:56:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 11:56:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 11:55:45 -0500
Date:   Tue, 23 Jan 2018 11:55:45 -0500
From:   Jeff King <peff@peff.net>
To:     Aleksey Bykov <aleksey.bykov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The original file that was split in 2 other files, is there a
 way in git to see what went where?
Message-ID: <20180123165545.GI13068@sigill.intra.peff.net>
References: <CAMAMitCV3xvaSr00H574Pww=r_c3=0NqT1Ge13kc=gWJqDJ3Ug@mail.gmail.com>
 <CAMAMitC-iyH_YOAsJcPpLcUbmX-Zun4MCL89Pxn2rr7Lu_m2cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMAMitC-iyH_YOAsJcPpLcUbmX-Zun4MCL89Pxn2rr7Lu_m2cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 10:22:21PM -0500, Aleksey Bykov wrote:

> I am a code reviewer, I have a situation in GIT:
> 
> - before: a.txt
> 
> Then a developer decided to split the content of a.txt into 2 files
> and add a few changes all in one commit:
> 
> - after: b.txt + few changes and c.txt + few changes
> 
> Is there an easy way to see:
> 
> 1. what came to b from a?
> 2 .what came to c from a?
> 3. all extra changes apart from just moving stuff?

Jonathan suggested the new "--color-moved", which I second as a good way
of seeing what was moved, and which lines were changed.

For seeing which line came from where, you might try "git blame -C",
which will cross file boundaries looking for the source of lines.

For instance, here's a case in git where some code was moved:

  git blame -C ae563542bf10fa8c33abd2a354e4b28aca4264d7 revision.c

You can see which lines are new to the file, and which ones were moved
from elsewhere.

If you want to simplify the "noise" of seeing the actual origin of each
line, you can ask blame not to go further back. Like:

  commit=ae563542bf10fa8c33abd2a354e4b28aca4264d7
  git blame -b -C $commit^..$commit revision.c

That will leave the commit id blank for every line that wasn't touched
as part of the commit (or if you had a whole series of commits, replace
"$commit^" with the parent of the series).

And finally, if you're going to do a lot with "git blame", I'd look into
the "tig" tool as a prettier interface. You should be able to do "tig
blame -C ..." in the same way.

-Peff
