Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11881FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 12:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbcFUMSS (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 08:18:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:57818 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751260AbcFUMSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 08:18:16 -0400
Received: (qmail 15519 invoked by uid 102); 21 Jun 2016 12:18:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 08:18:16 -0400
Received: (qmail 23770 invoked by uid 107); 21 Jun 2016 12:18:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 08:18:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 08:18:14 -0400
Date:	Tue, 21 Jun 2016 08:18:14 -0400
From:	Jeff King <peff@peff.net>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] fix local_tzoffset with far-in-future dates
Message-ID: <20160621121813.GA31030@sigill.intra.peff.net>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
 <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
 <20160620193928.GA3631@sigill.intra.peff.net>
 <20160620194648.GB3631@sigill.intra.peff.net>
 <20160620200011.GC3631@sigill.intra.peff.net>
 <20160620210901.GE3631@sigill.intra.peff.net>
 <xmqqy45zse7o.fsf@gitster.mtv.corp.google.com>
 <20160620222112.GB6431@sigill.intra.peff.net>
 <CAM+g_NtGWRCqaNz1DauZRReem0YPC6CaunHSwfhnB5LpvdGGcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM+g_NtGWRCqaNz1DauZRReem0YPC6CaunHSwfhnB5LpvdGGcQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 11:37:50PM -0700, Norbert Kiesel wrote:

> There are more strange things happening with dates.  One example is
> that `git commit --date=@4102444799` produces a commit with the
> correct author date "Thu Dec 31 15:59:59 2099 -0800" (for my local
> timezone which is Americas/Los_Angeles), while `git commit
> --date=@4102444800` produces a commit with "now" as author date, as
> does any other larger number. `date --date=@4102444800` results in
> "Thu Dec 31 16:00:00 PST 2099". So seems 2100-01-01T00:00:00Z is a
> hard limit for git when using this format.

Yes, I noticed that, too. I suspect it comes from the same source; the
date parser calls tm_to_time_t at some point which will refuse to handle
the date, and we fallback to something else. So certainly there is room
for improvement:

  1. We could handle a wider range of dates in tm_to_time_t(). This is
     essentially mktime(), but notice that mktime() was avoided for good
     reasons long ago, so any proposal to just move to that would need
     to figure out all those reasons and whether they are still valid.

  2. We should perhaps be flagging an error here instead of falling back
     to the current time. I suspect this is happening because --date
     falls back to approxidate() when we fail to parse the date (so you
     can say things like "--date=last.friday". Especially for cases with
     "@", which indicate that no approximate parsing is really required.

     Note that using GIT_AUTHOR_DATE _doesn't_ go through the date
     parser, but expects a raw time_t. So that does work for these
     far-future dates.

I'm not planning on working on either of these in the near term, but I'd
be happy to review patches if somebody else wants to.

-Peff
