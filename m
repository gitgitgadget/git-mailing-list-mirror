From: Jeff King <peff@peff.net>
Subject: Re: Has anyone written a hook to block fast forward merges to a
 branch?
Date: Wed, 21 Mar 2012 17:22:01 -0400
Message-ID: <20120321212201.GA16734@sigill.intra.peff.net>
References: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com>
 <4F6A3ACA.6050100@gmail.com>
 <20120321204333.GB15021@sigill.intra.peff.net>
 <4F6A44AD.4040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 22:22:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SASz7-0003mi-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 22:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760217Ab2CUVWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 17:22:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55481
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759861Ab2CUVWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 17:22:03 -0400
Received: (qmail 26936 invoked by uid 107); 21 Mar 2012 21:22:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Mar 2012 17:22:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2012 17:22:01 -0400
Content-Disposition: inline
In-Reply-To: <4F6A44AD.4040600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193620>

On Wed, Mar 21, 2012 at 04:14:21PM -0500, Neal Kreitzinger wrote:

> >When I wrote my response, I assumed the intent was that people
> >_should_ be using --no-ff, but that he wanted to enforce it via hook
> >during a push to a central repository.
> >
> Would your script only work at "push time", or would it also work at
> "commit time"?  I'm not sure at what point he thinks he wants to
> enforce it.  I don't think git yet knows the info your script is
> asking for at "commit time" (ie, pre-commit hook and its brethren),
> and by the time it does know it's too late to block the commit
> locally.  Maybe it does know that inof at the point one of those
> "commit time" hooks runs.  I haven't tried it.

Completely untested, but you could probably do something like this in a
pre-commit hook:

  if test "`git symbolic-ref HEAD 2>/dev/null`" = "refs/heads/master" &&
     ! test -e "`git rev-parse --git-dir`/MERGE_HEAD"
  then
    echo >&2 "Don't commit right on master. Go make a topic branch."
    exit 1
  fi

but I'm not sure if that would catch fast-forward merges or not. You
might also have to do an ancestry check against MERGE_HEAD.

Whether such a thing would be useful depends on your workflow and
exactly what you're trying to achieve. Usually people try to enforce
policy like this on pushes, just because that is an easy central point
(e.g., somebody who forgets to use topic branches or --no-ff may also
forget to set up their hooks; but if you have a central publishing
point, it's easy to set up the policies there just once).

-Peff
