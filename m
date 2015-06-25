From: Jeff King <peff@peff.net>
Subject: Re: several date related issues
Date: Thu, 25 Jun 2015 08:44:45 -0400
Message-ID: <20150625124445.GA18395@peff.net>
References: <20150625131901.5b962336@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jun 25 14:44:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z86WS-0004ei-Il
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 14:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbFYMou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 08:44:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:51600 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751864AbbFYMos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 08:44:48 -0400
Received: (qmail 2181 invoked by uid 102); 25 Jun 2015 12:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 07:44:47 -0500
Received: (qmail 5912 invoked by uid 107); 25 Jun 2015 12:44:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 08:44:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 08:44:45 -0400
Content-Disposition: inline
In-Reply-To: <20150625131901.5b962336@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272670>

On Thu, Jun 25, 2015 at 01:19:01PM +0200, H.Merijn Brand wrote:

> *** Dates do not respect LC_TIME

Right, we use our own routines for formatting the dates, and not
strftime. And it probably should stay that way in general, as git's
output is often meant to be parsed.

That being said, I do not think it would be wrong to have a date-mode
that just showed strftime("%c"), or some other arbitrary strftime
string.  You could then set log.date as appropriate for human
consumption.

> *** git log --date-order and --author-date-order do not order by date

Correct. The documentation says:

   --date-order
     Show no parents before all of its children are shown, but otherwise
     show commits in the commit timestamp order.

In your example, one commit is the parent of the other, so it hits the
first part of the sentence, and the dates are never even compared.

There is not a simple way to show commits in arbitrary order without
respect to parentage. I think you'd have to do something like:

  git log --format='%at %H' |
  sort -rn |
  cut -d' ' -f2 |
  git log --stdin --no-walk

-Peff
