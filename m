From: Jeff King <peff@peff.net>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 17:21:43 -0400
Message-ID: <20160329212143.GA30116@sigill.intra.peff.net>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <20160329203425.GA24027@sigill.intra.peff.net>
 <20160329205208.GF1578@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elliott Cable <me@ell.io>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:21:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al15E-0001t1-3h
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 23:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbcC2VVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 17:21:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:40280 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754354AbcC2VVr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 17:21:47 -0400
Received: (qmail 10613 invoked by uid 102); 29 Mar 2016 21:21:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 17:21:46 -0400
Received: (qmail 27886 invoked by uid 107); 29 Mar 2016 21:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 17:21:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 17:21:43 -0400
Content-Disposition: inline
In-Reply-To: <20160329205208.GF1578@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290197>

On Tue, Mar 29, 2016 at 09:52:08PM +0100, John Keeping wrote:

> > Yeah, I think this is a bug. Presumably what is happening is that we are
> > too eager to "cd $GIT_WORK_TREE" inside git-rev-parse, and by the time
> > we ask "are we in a work tree", the answer has become yes. But the
> > caller really wants to know "am _I_ inside the work tree".
> 
> I don't think that's what's happening.  Try:
> 
> 	$ cd .git/
> 	$ GIT_WORK_TREE=.. git rev-parse --is-inside-work-tree
> 	true
> 
> so I think it's that we refuse to assume that the directory above a Git
> directory is a working tree (something similar happens when the
> "core.worktree" config variable is set).  I'm not convinced that's
> unreasonable.

Yeah, you're right, but I'm not sure how your example shows that, (isn't
it basically the same as Elliott's original, except using a relative
path?). A more compelling counter-example to my hypothesis is:

  $ cd .git
  $ GIT_WORK_TREE=/tmp git rev-parse --is-inside-work-tree
  false

So it is not that we chdir too early, but just that we blindly check "is
$(pwd) inside $GIT_WORK_TREE". And it does not create a problem for the
normal discovered-path cases, because either:

  - we discovered .git by walking up the directory tree, which means we
    must be in a work-tree

  - we discovered that we are inside a .git directory, and therefore
    take it to be bare (and thus there is no work tree, and we cannot be
    inside it). This is what happens in Elliott's original example that
    behaves differently than the $GIT_WORK_TREE case.

I'd be tempted to say that "inside the work tree" is further clarified
to "not inside the $GIT_DIR". But as you note:

> However, the case above also gives:
> 
> 	$ GIT_WORK_TREE=.. git rev-parse --is-inside-git-dir
> 	false
> 	$ test $(pwd) = $(GIT_WORK_TREE=.. git rev-parse --git-dir); echo $?
> 	0
> 
> so even though $PWD *is* the Git directory, we're not in the Git
> directory!  Setting GIT_DIR=$(pwd) makes no different to that.

We seem to get that wrong. I'm also not sure if it would make sense if
you explicitly set the two to be equal, like:

  # checking in your own refs?
  GIT_WORK_TREE=$(pwd) GIT_DIR=$(pwd) git add refs packed-refs

So the current behavior may just be weird-but-true.

-Peff
