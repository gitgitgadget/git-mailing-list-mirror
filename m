From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 09:52:30 -0400
Message-ID: <20130820135230.GA32370@sigill.intra.peff.net>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
 <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 20 15:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmMQ-0002Ap-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 15:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab3HTNwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 09:52:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:37493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab3HTNwe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 09:52:34 -0400
Received: (qmail 19608 invoked by uid 102); 20 Aug 2013 13:52:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 08:52:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 09:52:30 -0400
Content-Disposition: inline
In-Reply-To: <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232596>

On Tue, Aug 20, 2013 at 03:40:02PM +0200, Thomas Rast wrote:

> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
> > The condition as it is written in that line was most likely intended to
> > check for the pointer passed to free(), rather than checking for the
> > 'repo_abbrev', which is already checked against being non null at the
> > beginning of the function.
> [...]
> > -			if (repo_abbrev)
> > +			if (*repo_abbrev)
> >  				free(*repo_abbrev);
> 
> But now the test is useless, because free(NULL) is defined to be a
> no-op.

Yeah, I think we should just drop the conditional completely.

I am not sure of the complete back-story. The earlier check for
repo_abbrev to be non-NULL was added by 8503ee4, after this check on
free() already existed. So that was when this conditional became
redundant.

But the line right after this one unconditionally assigns to
"*repo_abbrev", so we would always segfault in such a case anyway (which
is what 8503ee4 was fixing).

So I think it was either a misguided "don't pass NULL to free" check
that was simply wrong, or it was an incomplete "make sure repo_abbrev is
not NULL" check. And the first is useless, and the second is now
redundant due to 8503ee4. So it should simply be free().

-Peff
