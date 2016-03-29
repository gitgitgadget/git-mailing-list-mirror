From: John Keeping <john@keeping.me.uk>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 23:14:09 +0100
Message-ID: <20160329221409.GH1578@serenity.lan>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <20160329203425.GA24027@sigill.intra.peff.net>
 <20160329205208.GF1578@serenity.lan>
 <20160329212143.GA30116@sigill.intra.peff.net>
 <20160329220003.GG1578@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elliott Cable <me@ell.io>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:14:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al1uD-0006m2-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269AbcC2WOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:14:25 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:45902 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665AbcC2WOY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:14:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CB866CDA584;
	Tue, 29 Mar 2016 23:14:22 +0100 (BST)
X-Quarantine-ID: <sFWcG9t+OtvW>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sFWcG9t+OtvW; Tue, 29 Mar 2016 23:14:22 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D3581CDA590;
	Tue, 29 Mar 2016 23:14:11 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20160329220003.GG1578@serenity.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290202>

On Tue, Mar 29, 2016 at 11:00:03PM +0100, John Keeping wrote:
> On Tue, Mar 29, 2016 at 05:21:43PM -0400, Jeff King wrote:
> > On Tue, Mar 29, 2016 at 09:52:08PM +0100, John Keeping wrote:
> > 
> > > > Yeah, I think this is a bug. Presumably what is happening is that we are
> > > > too eager to "cd $GIT_WORK_TREE" inside git-rev-parse, and by the time
> > > > we ask "are we in a work tree", the answer has become yes. But the
> > > > caller really wants to know "am _I_ inside the work tree".
> > > 
> > > I don't think that's what's happening.  Try:
> > > 
> > > 	$ cd .git/
> > > 	$ GIT_WORK_TREE=.. git rev-parse --is-inside-work-tree
> > > 	true
> > > 
> > > so I think it's that we refuse to assume that the directory above a Git
> > > directory is a working tree (something similar happens when the
> > > "core.worktree" config variable is set).  I'm not convinced that's
> > > unreasonable.
> > 
> > Yeah, you're right, but I'm not sure how your example shows that, (isn't
> > it basically the same as Elliott's original, except using a relative
> > path?). A more compelling counter-example to my hypothesis is:
> > 
> >   $ cd .git
> >   $ GIT_WORK_TREE=/tmp git rev-parse --is-inside-work-tree
> >   false
> > 
> > So it is not that we chdir too early, but just that we blindly check "is
> > $(pwd) inside $GIT_WORK_TREE". And it does not create a problem for the
> > normal discovered-path cases, because either:
> > 
> >   - we discovered .git by walking up the directory tree, which means we
> >     must be in a work-tree
> > 
> >   - we discovered that we are inside a .git directory, and therefore
> >     take it to be bare (and thus there is no work tree, and we cannot be
> >     inside it). This is what happens in Elliott's original example that
> >     behaves differently than the $GIT_WORK_TREE case.
> > 
> > I'd be tempted to say that "inside the work tree" is further clarified
> > to "not inside the $GIT_DIR".
> 
> Yes, I think that's reasonable.  But...
> 
> > > However, the case above also gives:
> > > 
> > > 	$ GIT_WORK_TREE=.. git rev-parse --is-inside-git-dir
> > > 	false
> > > 	$ test $(pwd) = $(GIT_WORK_TREE=.. git rev-parse --git-dir); echo $?
> > > 	0
> > > 
> > > so even though $PWD *is* the Git directory, we're not in the Git
> > > directory!  Setting GIT_DIR=$(pwd) makes no different to that.
> > 
> > We seem to get that wrong. I'm also not sure if it would make sense if
> > you explicitly set the two to be equal, like:
> > 
> >   # checking in your own refs?
> >   GIT_WORK_TREE=$(pwd) GIT_DIR=$(pwd) git add refs packed-refs
> > 
> > So the current behavior may just be weird-but-true.
> 
> This case definitely feels wrong:
> 
> 	$ GIT_WORK_TREE=$(cd ..; pwd) GIT_DIR=$(pwd) git rev-parse --is-inside-git-dir
> 	false
> 
> Shouldn't that be the same as if GIT_WORK_TREE and GIT_DIR aren't set?
> (It's also potentially surprising since "git rev-parse --git-dir" does
> give the right answer in this case.)
> 
> If GIT_WORK_TREE points somewhere unrelated then it is correct:
> 
> 	$ GIT_WORK_TREE=/tmp GIT_DIR=$(pwd) git rev-parse --is-inside-git-dir
> 	true

It seems that this is a result of changing the working directory to the
root of the working tree if we're inside it.  is_inside_dir() doesn't
take account of startup_info->prefix and changing to:

	real_path(startup_info->prefix)

instead of xgetcwd() means that these tests are less surprising.

But I haven't run the test suite or thought about what else this could
break.
