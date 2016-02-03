From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Trick to force setup of a specific configured E-Mail per
 repo
Date: Tue, 2 Feb 2016 22:56:48 -0500
Message-ID: <20160203035648.GA20732@sigill.intra.peff.net>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 04:57:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQoYs-00014f-4W
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 04:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbcBCD4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 22:56:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:36514 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755512AbcBCD4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 22:56:51 -0500
Received: (qmail 29730 invoked by uid 102); 3 Feb 2016 03:56:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 22:56:51 -0500
Received: (qmail 20563 invoked by uid 107); 3 Feb 2016 03:56:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 22:56:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2016 22:56:48 -0500
Content-Disposition: inline
In-Reply-To: <1454442861-4879-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285326>

On Tue, Feb 02, 2016 at 09:54:21PM +0200, Dan Aloni wrote:

> Previously, before 5498c57cdd63, many people did the following:
> 
>    git config --global user.email "(none)"
> 
> This was helpful for people with more than one E-Mail address,
> targeting different E-Mail addresses for different clones.
> as it barred git from creating commit unless the user.email
> config was set in the per-clone config to the correct E-Mail
> address.
> 
> Now, since the original 'bug' was fixed, and practically every
> string is acceptable for user.email and user.name, it is best
> to reimplement the feature not as an exploit of a bug, but as
> an actual feature.

Just when I dare to think "somebody cannot possibly be relying on this
arcane behavior", I am proven wrong. :)

The motivating case for your patch makes sense to me. In the
implementation, though:

> +	if (strict && email && !strcmp(email, "(per-repo)")) {
> +		die("email is '(per-repo)', suggesting to set specific email "
> +		    "for the current repo");
> +	}

I find it disappointing that we go back to looking for magic sequences
in the string. Could we perhaps do this more cleanly with a new config
option? Like a "user.guessIdent" which defaults to true, but people can
set to false. And without that, we do not do any automagic at all; we
get the values from the GIT_COMMITTER_* environment or the
user.{name,email} config variables, or we die().

I think that should allow your use case (and extend the same feature to
user.name). It wouldn't work on older versions of git, but nor would
your fix here (the only way to do that is to re-instate "(none)" as
magical).

-Peff
