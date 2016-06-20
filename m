Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CC41FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 22:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbcFTWVz (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 18:21:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:57556 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751235AbcFTWVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 18:21:53 -0400
Received: (qmail 12444 invoked by uid 102); 20 Jun 2016 22:21:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 18:21:15 -0400
Received: (qmail 18916 invoked by uid 107); 20 Jun 2016 22:21:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 18:21:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 18:21:12 -0400
Date:	Mon, 20 Jun 2016 18:21:12 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Norbert Kiesel <nkiesel@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] fix local_tzoffset with far-in-future dates
Message-ID: <20160620222112.GB6431@sigill.intra.peff.net>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
 <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
 <20160620193928.GA3631@sigill.intra.peff.net>
 <20160620194648.GB3631@sigill.intra.peff.net>
 <20160620200011.GC3631@sigill.intra.peff.net>
 <20160620210901.GE3631@sigill.intra.peff.net>
 <xmqqy45zse7o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy45zse7o.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 03:11:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I still don't know how that screwed-up timestamp got _into_
> > a commit, so perhaps there is another bug lurking.  I couldn't convince
> > git to parse anything beyond 2100, and committing with
> > GIT_AUTHOR_DATE='@5758122296 +0000' works just fine.
> 
> Interesting.  The weirdest I could come up with was with
> 
>     GIT_AUTHOR_DATE='@5758122296 -9999
> 
> which gets turned into the same timestamp but with -10039 timezone
> (simply because 99 minutes is an hour and 39 minutes).

Yeah, as weird as that is, I think it's reasonable. We _could_ turn
nonsense timezones into "+0000". That doesn't necessarily help the user
much, but at least it's less bizarre than making a 46-year timezone
offset.

I also looked for other uses of tm_to_time_t without checking for an
error return. Most of them do check. The exception is datestamp(), but
is calling it on the output of localtime(time()), which should generally
be sensible.

-Peff
