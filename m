From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Errors when diff'ing arbitrary upstream remotes are not
 intuitive if git pull --all hasn't been done
Date: Fri, 25 Oct 2013 03:10:48 -0400
Message-ID: <20131025071048.GA16856@sigill.intra.peff.net>
References: <CAGH67wSf_RQigCmqRZKOpHdV9ELqE=078mkpwA4dfnUr=AvGVQ@mail.gmail.com>
 <CAGH67wRwb1A9CzAfod_XLRVFBRyoEron8tmM+NbMGOeKDVf2Hg@mail.gmail.com>
 <20131025061407.GE11810@sigill.intra.peff.net>
 <20131025061459.GA23524@sigill.intra.peff.net>
 <CALKQrgc0u8TA4mXc+2Hv+Fyo8EYNuiickF_janeCxkzFn+xAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "yaneurabeya ." <yanegomi@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbXu-0001le-1y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab3JYHKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 03:10:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:55381 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182Ab3JYHKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 03:10:51 -0400
Received: (qmail 6764 invoked by uid 102); 25 Oct 2013 07:10:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 02:10:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 03:10:48 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrgc0u8TA4mXc+2Hv+Fyo8EYNuiickF_janeCxkzFn+xAvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236688>

On Fri, Oct 25, 2013 at 09:03:41AM +0200, Johan Herland wrote:

> Actually, I don't think there's much refspec stuff to be done here.
> When running "git diff $remote/$branch", there are 3 possible
> outcomes:
> 
>  - $remote is not a valid remote name, the user probably meant
> something different (like "nested/branch"). The current error message
> is fine.
> 
>  - $remote is a valid remote name, but $branch has not (yet) been
> fetched from there. Suggest the user run "git fetch $remote"
> 
>  - $remote/$branch is a valid remote-tracking branch. The diff works! No errors.

Right, I think it is the second case we are talking about.

> So, AFAICS, the patch should simply:
> 
>  1. Split the input on the first '/' into $remote/$branch, and use the
> preceding part ($remote) as a potential remote name, and the following
> part ($branch) as a potential branch name. (Although it is
> theoretically possible to have remote names containing slashes, I
> don't think anybody uses them, and we have considered disallowing
> them, mainly because of this very issue: it makes "$remote/$branch"
> parsing (even more) ambiguous)

What I specifically meant is that this breaks with a remote like:

  [remote "foo"]
    fetch = +refs/heads/*:refs/remotes/bar/*

The correct advice for "bar/branch" is to recommend "git fetch foo", and
the correct advice for "foo/branch" is nothing at all.

I know such config is unusual, but I thought there was a recent push for
us to be accurate about finding the local side of remote tracking
branches, rather than just assuming they start with "$remote". Maybe I
am misremembering, though; I thought it was related to potentially
shifting the default refspecs.

The procedure along those lines would be:

  for each remote
    for each fetch-refspec in remote
      if refspec.rhs contains "refs/remotes/$failed_branch"
        recommend "git fetch $remote"

I was just wondering if we had something to make that "does this refspec
contain this ref" part easier.

-Peff
