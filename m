From: Jeff King <peff@peff.net>
Subject: Re: git smudge filter fails
Date: Wed, 9 Mar 2016 20:59:40 -0500
Message-ID: <20160310015939.GA12709@sigill.intra.peff.net>
References: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 02:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adptE-0001uR-Pq
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 02:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbcCJB7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 20:59:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:57604 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752486AbcCJB7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 20:59:43 -0500
Received: (qmail 11602 invoked by uid 102); 10 Mar 2016 01:59:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Mar 2016 20:59:42 -0500
Received: (qmail 22171 invoked by uid 107); 10 Mar 2016 01:59:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Mar 2016 20:59:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Mar 2016 20:59:40 -0500
Content-Disposition: inline
In-Reply-To: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288594>

On Wed, Mar 09, 2016 at 01:29:31PM -0500, Stephen Morton wrote:

> git config --local filter.dater.smudge 'myDate=`git log
> --pretty=format:"%cd" --date=iso -1 -- %f`; sed -e
> "s/\(\\$\)Date[^\\$]*\\$/\1Date: $myDate \\$/g"'

Your filter is running "git log" without a revision parameter, which
means it is looking at HEAD.

And here....

> git checkout no_foo
> git checkout master
> cat foo.c
> #observe keyword expansion lost

You are expecting this second one to do:

  1. Switch HEAD to "master".

  2. Checkout files which need updating. Looking at HEAD in your filter
     then examines "master", and you see the commit timestamp of the
     destination.

But that isn't how it is implemented. Checkout will handle the file
checkout _first_, as that is the part that is likely to run into
problems (e.g., rejecting a switch because it would lose changes in the
working tree). Only at the very end, after the change to the working
tree has succeeded, do we update HEAD.

I think the order you are expecting is conceptually cleaner, but I don't
think we would want to switch it around (for reasons of efficiency and
robustness). And I don't think we would want to make a promise about the
ordering to callers either way, as it binds our implementation.

So is there a way to reliably know the destination of a checkout? My
first thought was that we could add a placeholder similar to "%f" that
your filter could use. I'm not sure how we would handle the corner cases
there, though (e.g., do we always have a "destination" to report? If
not, what do we give the script?).

I suspect you could also hack something together with a post-checkout
script, though it would probably be a lot less efficient (and might also
have some weird corner cases).

-Peff
