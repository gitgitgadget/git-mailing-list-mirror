From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Thu, 27 Mar 2014 18:34:06 -0400
Message-ID: <20140327223406.GA32434@sigill.intra.peff.net>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
 <20140326221531.11352.86408.chriscool@tuxfamily.org>
 <xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
 <20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
 <xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
 <xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	mhagger@alum.mit.edu, dan.carpenter@oracle.com, greg@kroah.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:34:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTIsY-0007Ws-JC
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 23:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbaC0WeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 18:34:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:48769 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755086AbaC0WeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 18:34:09 -0400
Received: (qmail 3546 invoked by uid 102); 27 Mar 2014 22:34:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Mar 2014 17:34:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2014 18:34:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245330>

On Thu, Mar 27, 2014 at 03:16:48PM -0700, Junio C Hamano wrote:

> > I wasn't looking at the caller (and I haven't).  I agree that, if
> > you have to compare case-insensitive user input against known set of
> > tokens, using strcasecmp() would be saner than making a downcased
> > copy and the set of known tokens.  I do not know however you want to
> > compare in a case-insensitive way in your application, though.
> 
> It appears that one place this "lowercase" is used is to allow
> rAnDOm casing in the configuration file, e.g.
> 
> 	[trailer "Signed-off-by"]
> 		where = AfTEr
> 
> which I find is totally unnecessary.  Do we churn code to accept
> such a nonsense input in other places?

I think we are very inconsistent.

All bool config values allow "tRuE". Ones that take "auto" often use
strcasecmp (e.g., diff.*.binary). "blame.date" and "help.format" choose
from a fixed set of tokens, but use strcmp.

Command line parameters are of course case-sensitive, and tokens used by
them usually are, too (e.g., the date formats for "blame.date" or also
the same ones taken by "--date=").

In general I do not see any reason _not_ to use strcasecmp for config
values that are matching a fixed set. It's friendlier to the user, the
extra CPU time is negligible, and the code is no harder to read than a
strcmp. Just looking at the callers in patch 04/12, I think it would be
better just used strcasecmp instead of making a lowercase copy. Not
because the copy is wasteful (it is, but it almost certainly doesn't
matter here), but because avoiding the copy is shorter and easier to
follow (you don't have to wonder about memory ownership).

-Peff
