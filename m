From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for
 configuration variables
Date: Sun, 1 Feb 2015 11:44:36 -0500
Message-ID: <20150201164435.GA17853@peff.net>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
 <1422484393-4414-1-git-send-email-gitster@pobox.com>
 <1422484393-4414-4-git-send-email-gitster@pobox.com>
 <54CDB5C6.3020702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 01 17:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHxdh-0001Lr-Hz
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 17:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbbBAQoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 11:44:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:43825 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753024AbbBAQoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 11:44:38 -0500
Received: (qmail 11612 invoked by uid 102); 1 Feb 2015 16:44:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Feb 2015 10:44:38 -0600
Received: (qmail 6949 invoked by uid 107); 1 Feb 2015 16:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Feb 2015 11:45:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Feb 2015 11:44:36 -0500
Content-Disposition: inline
In-Reply-To: <54CDB5C6.3020702@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263235>

On Sun, Feb 01, 2015 at 06:12:38AM +0100, Michael Haggerty wrote:

> > +   When choosing the variable namespace, do not use variable name for
> > +   specifying possibly unbounded set of things, most notably anything
> > +   an end user can freely come up with (e.g. branch names), but also
> > +   large fixed set defined by the system that can grow over time
> > +   (e.g. what kind of common whitespace problems to notice).
> 
> I think we can all agree with this rule for "anything an end user can
> freely come up with". Such sets are truly unbounded.
> 
> But what is the justification for applying it to "large fixed set
> defined by the system that can grow over time"? Any set of items that
> needs to be programmed one by one is not unbounded in the same sense. It
> is true that it can grow over time, but there is a practical limit on
> how many such options we would ever implement, and at any given time the
> set has a well-defined, finite number of members.

I had the same reaction on reading this.

We should be striving to break config options down as much as possible
to single scalar values, because that is the only format that is
understood systematically by the config code.

If a config option's value is a list, then we have to come up with an
ad-hoc syntax for the list, which we parse in the config callback. And
that leaves users of "git config" to reinvent that parsing themselves
when they want to do simple things like "remove item B from the list".
I think the examples you gave over on the fsck thread all make the same
point.

> > + [...] Use
> > +   subsection names or variable values, like existing variables
> > +   branch.<name>.description and core.whitespace do, instead.
> 
> But there is also a precedent for the opposite approach: "advice.*".

The pager.*, color.* (and color.$program.*) examples come to mind. For
example, we did not add:

  [core]
  usePagerFor = log, diff, -status

but instead:

  [pager]
  log = true
  diff = true
  status = false

Not only is the latter easier to manipulate and examine with the
existing config tools, I think it is more flexible in the long run. We
later extended the syntax to allow:

  [pager]
  log = diff-highlight | less

which would have been even more awkward in the "userPagerFor" format
(you could use "log=...", of course, but now you need to get into
whitespace quoting and other complexities, all of which are handled
already by the config code in the latter case).

-Peff
