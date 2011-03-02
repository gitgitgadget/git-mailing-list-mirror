From: Jeff King <peff@peff.net>
Subject: Re: Shallow clones vs blame/log
Date: Wed, 2 Mar 2011 16:58:08 -0500
Message-ID: <20110302215808.GI20400@sigill.intra.peff.net>
References: <AANLkTim87tZTN4FGLgwCHdAJH4dum4wBXqA=GcQm-uJ=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:58:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puu3k-0004LA-SZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703Ab1CBV6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:58:11 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48020 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757122Ab1CBV6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:58:10 -0500
Received: (qmail 20951 invoked by uid 111); 2 Mar 2011 21:58:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:58:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:58:08 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim87tZTN4FGLgwCHdAJH4dum4wBXqA=GcQm-uJ=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168355>

On Wed, Mar 02, 2011 at 08:51:27PM +0100, Piotr Krukowiecki wrote:

> I'd like to confirm: when doing shallow clone with --depth=n, and then
> using blame, git does know only about n last revisions. For each
> change that happened before shows "^commit" where "commit" is n+1
> commit ?
> 
> I wonder if this can be more clear. I was bitten by this today. I was
> using blame on a file and it showed a commit and author for a line.
> But the line was not changed in that commit. Took me a while to
> understand that it's caused by shallow copy...

It's not just shallow copy, but any time you have limited the traversal.
So you could do "git blame v1.5.0..v1.6.0 wt-status.c", and lines that
come from v1.5.0 or before are attributed to v1.5.0 with the carat.

The magic name for this is "boundary commits". See the "-b" option for
an alternative way of viewing them.

> I could be blamed for not reading git-blame man, but luckily ^commit is not
> described there ;)

Yes, we seem not to describe the regular output in very much detail at
all (nor mention the "^" syntax in the description of porcelain output),
which we probably should.

We do mention in the "specifying ranges" section that unchanged lines
will be blamed to the boundary commit. Part of the problem is that you
didn't realize you had a range because you were using a shallow clone.
But I wonder if that information would be more appropriate when
introducing shallow clones in git-clone(1).

> Also, git-log puts all not cloned commits into last not cloned commit,
> and there's no information that it's a "fake" commit.

Same issue. The bottom end of a shallow clone has no parents, and log's
diffs show root commits as giant creation events.

Maybe it would be nice if the log output somehow noted that it was not a
real root commit, but rather the endpoint of a shallow clone, regardless
of whether there is a diff being shown. Because it is also potentially
confusing to do "git log", scroll to the bottom, and think that is the
very first commit, when it's not (and you could deepen your repository
if you wanted).

I think all of this is due to the fact that shallow clones were tacked
on after the fact, and are not all that commonly used.

Patches welcome (for docs or for log), of course.

-Peff
