Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C6C1FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 21:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbcFTVQV (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 17:16:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:57494 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752232AbcFTVQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 17:16:19 -0400
Received: (qmail 9332 invoked by uid 102); 20 Jun 2016 21:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:09:04 -0400
Received: (qmail 18066 invoked by uid 107); 20 Jun 2016 21:09:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:09:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 17:09:01 -0400
Date:	Mon, 20 Jun 2016 17:09:01 -0400
From:	Jeff King <peff@peff.net>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 0/3] fix local_tzoffset with far-in-future dates
Message-ID: <20160620210901.GE3631@sigill.intra.peff.net>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
 <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
 <20160620193928.GA3631@sigill.intra.peff.net>
 <20160620194648.GB3631@sigill.intra.peff.net>
 <20160620200011.GC3631@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160620200011.GC3631@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 04:00:12PM -0400, Jeff King wrote:

> You _should_ be able to get the right answer by asking git for
> --date=local, but it doesn't seem to work. Looks like it is because our
> tm_to_time_t hits this code:
> 
>   if (year < 0 || year > 129) /* algo only works for 1970-2099 */
> 	return -1;
> 
> and the caller does not actually check the error. The resulting timezone
> is the screwed-up -40643156, which is perhaps how it got into the commit
> in the first place.

So here's a patch to fix that (along with some test infrastructure to
support it). I still don't know how that screwed-up timestamp got _into_
a commit, so perhaps there is another bug lurking.  I couldn't convince
git to parse anything beyond 2100, and committing with
GIT_AUTHOR_DATE='@5758122296 +0000' works just fine.

  [1/3]: t0006: rename test-date's "show" to "relative"
  [2/3]: t0006: test various date formats
  [3/3]: local_tzoffset: detect errors from tm_to_time_t

-Peff
