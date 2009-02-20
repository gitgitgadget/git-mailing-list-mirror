From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make git blame date output format configurable, a la
	git log
Date: Fri, 20 Feb 2009 12:18:25 -0500
Message-ID: <20090220171825.GA4636@coredump.intra.peff.net>
References: <1235136252-29649-1-git-send-email-eletuchy@gmail.com> <20090220142730.GA32751@coredump.intra.peff.net> <fbb390660902200813h2455eak4e72144c7c491ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, marius@trolltech.com,
	Eugene Letuchy <eugene@facebook.com>
To: Eugene Letuchy <eletuchy@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaZ2e-0000zT-0z
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbZBTRS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 12:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbZBTRS2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 12:18:28 -0500
Received: from peff.net ([208.65.91.99]:59310 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753734AbZBTRS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 12:18:27 -0500
Received: (qmail 3564 invoked by uid 107); 20 Feb 2009 17:18:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 12:18:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 12:18:25 -0500
Content-Disposition: inline
In-Reply-To: <fbb390660902200813h2455eak4e72144c7c491ef9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110869>

On Fri, Feb 20, 2009 at 08:13:34AM -0800, Eugene Letuchy wrote:

> Good call. I can change to using --date instead of --date-format. It
> wasn't clear that this was an unused option.

Yeah, it is a slight confusion both to developers and to users that
programs which take revision arguments sometimes accept but ignore them.

But the revs.date_mode set by the revision library is basically just
used by log-tree, which is not used by blame. So it is safe to reuse,
and doing so actually reduces confusion.

> For parity with log.date, config blame.date still makes sense, right?

Sure. It might even make sense to have an unset blame.date default to
the value of log.date. But I don't use log.date, nor do I directly use
blame (I use tig's blame mode). So I don't know what people expect or
would find useful.

> > So there are actually two changes here:
> >
> >  1. support specifying date format
> >
> >  2. changing the default date format
> >
> > I think (1) is a good change, but it should definitely not be lumped in
> > with (2), as people might like one and not the other (and I happen not
> > to like (2)).
> >
> What about consistency with all git-rev-list clients?

I think blame is a bit different than other clients because it is
showing the date on a line with a bunch of other stuff, whereas most
clients use "Date: <whatever>" on a separate line. So it has to be a bit
more careful about how much space is used.

That being said, I think this discussion proves my main point, which is
that it should be split into two patches. Then discussion over the
default format will not hold up the --date support.

> >     gives me relative output on some lines, and not on others. E.g.,
> [...]
> According to date.c comments, this is a "feature" of DATE_RELATIVE:

Oh, right. Sorry for the noise, I totally forgot about that that feature
(which I now remember annoying me in the past, too).

>                 /* Say months for the past 12 months or so */
>                 if (diff < 360) {
>                         snprintf(timebuf, sizeof(timebuf), "%lu months
> ago", (diff + 15) / 30);
>                         return timebuf;
>                 }
>                 /* Else fall back on absolute format.. */
> 
> A single line fixes that to be a bit more logical:
> -               /* Else fall back on absolute format.. */
> +               /* Else fall back to the short format */
> +                mode = DATE_SHORT;
> 
> but i think that's a separate commit, no?

I do think that's a reasonable change; there's no point in giving a very
precise date for things more than a year past when we have already
dropped precision to "month" for everything else. But definitely a
separate commit.

Personally, I think I would rather see "months" up until about 2-3
years, and then simply "N years ago" after that.

> I have a patch to fix the alignment issues: it figures out the max
> width of each date format and memsets in that number of spaces in
> format_time. Is it better to submit that as a separate commit, or send
> a revised patch?

I think it makes sense to send a revised patch with all of the changes
we've discussed (please mark it as v2 and give a brief summary of what's
changed below the "---" marker to help out other reviewers).

-Peff
