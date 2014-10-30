From: Jeff King <peff@peff.net>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Thu, 30 Oct 2014 17:48:52 -0400
Message-ID: <20141030214852.GB21017@peff.net>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
 <xmqqh9ymy8np.fsf@gitster.dls.corp.google.com>
 <CAPBPrnuxAPmKe_aRb9USh=cOu4jMZaYzOorXC_RJa8b8ROq+iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Vojtek <peter.vojtek@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxaV-0003Ih-JU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbaJ3Vsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:48:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:35297 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161336AbaJ3Vsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 17:48:55 -0400
Received: (qmail 3360 invoked by uid 102); 30 Oct 2014 21:48:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 16:48:54 -0500
Received: (qmail 9226 invoked by uid 107); 30 Oct 2014 21:48:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 17:48:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Oct 2014 17:48:52 -0400
Content-Disposition: inline
In-Reply-To: <CAPBPrnuxAPmKe_aRb9USh=cOu4jMZaYzOorXC_RJa8b8ROq+iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 30, 2014 at 05:08:56PM -0400, Dan Johnson wrote:

> > The underlying data representation records time as number of seconds
> > since epoch (1970-01-01).  Theoretically the codepaths that read
> > data could consider negative timestamps to represent times before
> > the epoch, but in the context of source code control, negative
> > values are more likely to be an indication of a bug or a user
> > mistake, and I do not think any existing code in Git is prepared to
> > pass such a timestamp as a sane value---instead they diagnose a
> > failure and die.
> 
> I remember a pretty old thread found some success storing timestamps this way:
> http://comments.gmane.org/gmane.comp.version-control.git/152433

A few things have changed since then. Most notably, git is more careful
about overflow of "unsigned long" when reading in timestamp values. Of
course, we can't do much in the overflow case except assign a sentinel
value. But it at least means that overflowing values all end up as "Jan
1 1970" and not whatever random 32-bit wraparound you happen to get.

But what _hasn't_ changed is that we still use "unsigned long"
internally. The fact that the 1787 date in that thread worked at all is
somewhat accidental and due to implicit casts between "unsigned long"
and "time_t" working. As noted here (and downthread):

  http://permalink.gmane.org/gmane.comp.version-control.git/152508

I think it would be a nice project to convert git to consistently use
signed 64-bit times internally, and then everything would Just Work
going back to the beginning of history. But the demand for such a
feature has been low enough that nobody has really dug in and tried the
conversion.

We do also gain some small amount of efficiency by storing commit
timestamps as 32-bit values. However, those should always be "current"
times anyway. I think we are really talking about author timestamps
here (and of course the underlying time-manipulation functions).

-Peff
