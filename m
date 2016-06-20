Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625411FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbcFTUAq (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 16:00:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:57446 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752962AbcFTUAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 16:00:43 -0400
Received: (qmail 6444 invoked by uid 102); 20 Jun 2016 20:00:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 16:00:14 -0400
Received: (qmail 17649 invoked by uid 107); 20 Jun 2016 20:00:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 16:00:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 16:00:12 -0400
Date:	Mon, 20 Jun 2016 16:00:12 -0400
From:	Jeff King <peff@peff.net>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unable to pull from remote if commit date is in the future
Message-ID: <20160620200011.GC3631@sigill.intra.peff.net>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
 <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
 <20160620193928.GA3631@sigill.intra.peff.net>
 <20160620194648.GB3631@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160620194648.GB3631@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 03:46:49PM -0400, Jeff King wrote:

> So to answer my own questions:
> 
>   $ git cat-file commit 23c07cc | egrep '^author|committer'
>   author Sean D'Epagnier <seandepagnier@gmail.com> 5758122296 -40643156
>   committer Sean D'Epagnier <seandepagnier@gmail.com> 5758122296 -40643156
> 
> Yes, the timezone really is that ridiculous value. No, the author and
> committer aren't different. According to GNU date, the correct timestamp
> is actually in 2152. Offhand, I'd guess that the timestamp exceeding
> 2^32 is getting converted somewhere inside git to a bogus value, and
> that's how we end up with 2106.

Ah, nope. Everything is working as designed.

5758122296 _is_ in 2152, but that's before we apply the author's
timezone offset. :)

Timezones are supposed to be [+-]HHMM. So the -40643156 timezone is
parsed as -406431 hours, 56 minutes. Which is about 46 years. Hence git
printing 2106.

You _should_ be able to get the right answer by asking git for
--date=local, but it doesn't seem to work. Looks like it is because our
tm_to_time_t hits this code:

  if (year < 0 || year > 129) /* algo only works for 1970-2099 */
	return -1;

and the caller does not actually check the error. The resulting timezone
is the screwed-up -40643156, which is perhaps how it got into the commit
in the first place.

-Peff
