From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Avoid file descriptor exhaustion in
 ref_transaction_commit()
Date: Fri, 24 Apr 2015 13:26:48 -0400
Message-ID: <20150424172648.GB30592@peff.net>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:27:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlhNe-0000cW-VS
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 19:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945973AbbDXR0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 13:26:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:49715 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031528AbbDXR0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 13:26:51 -0400
Received: (qmail 24935 invoked by uid 102); 24 Apr 2015 17:26:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 12:26:50 -0500
Received: (qmail 17298 invoked by uid 107); 24 Apr 2015 17:27:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 13:27:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2015 13:26:48 -0400
Content-Disposition: inline
In-Reply-To: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267745>

On Fri, Apr 24, 2015 at 01:35:44PM +0200, Michael Haggerty wrote:

> In ref_transaction_commit(), close the reference lockfiles immediately
> to avoid keeping too many file descriptors open at a time. This is
> pretty easy, because in the first loop (where we create the locks) we
> already know what, if anything, has to be written into the lockfile.
> So write it and close the lockfile immediately. In the second loop,
> rename the lockfiles for reference updates into place, and in the
> cleanup loop, unlock any references that are still locked (i.e., those
> that were only being verified or deleted).
> 
> I think this is a cleaner solution than Stefan's approach [1] of
> closing and reopening fds based on an estimate of how many fds we can
> afford to waste--we only need a single file descriptor at a time, and
> we never have to close then reopen a lockfile. But it is a bit more
> intrusive, so it might still be preferable to use Stefan's approach
> for release 2.4.0, if indeed any fix for this problem is still being
> considered for that release.

I like this approach much better. It seems like the best of all worlds
(same performance, and we don't have to worry about whether and when to
close lockfiles).

Stefan's patch is just in pu at this point, right? I do not think there
is any rushing/release concern. It is too late for either to be in
v2.4.0, so the only decision is whether to aim for "master" or "maint".
To me, they both seem to be in the same ballpark as far as risking a
regression.

-Peff
