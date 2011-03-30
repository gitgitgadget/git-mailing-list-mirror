From: Jeff King <peff@peff.net>
Subject: Re: checkout new branch tracks wrong remote (bug?)
Date: Wed, 30 Mar 2011 10:59:08 -0400
Message-ID: <20110330145908.GA812@sigill.intra.peff.net>
References: <loom.20110330T040437-823@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 16:59:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4wrd-0005NV-L0
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 16:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470Ab1C3O7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 10:59:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60590
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755127Ab1C3O7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 10:59:11 -0400
Received: (qmail 10882 invoked by uid 107); 30 Mar 2011 14:59:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 10:59:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 10:59:08 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110330T040437-823@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170388>

On Wed, Mar 30, 2011 at 02:27:31AM +0000, chris wrote:

> I have two remotes configured.
> 
> One is "origin" which has a local tracking branch "master" for "origin/master".
> 
> The other is "mirror" which has option mirror = true
> 
> While on the local branch master, I issue the command:
> 
> $ git checkout -b wip
> 
> The branch "wip" is created and oddly configured to track the "mirror" remote.

Right. You are creating a branch from "refs/heads/master" (the currently
checked out branch). So the setup_tracking code will look for any remote
which writes a tracking branch into refs/heads/master according to the
configuration.

Your mirror config looks like this:

> [remote "mirror"]
>         url = ssh://chris@myserver.com/srv/git/mirrors/chris/myproject.git
>         fetch = +refs/*:refs/*
>         mirror = true

meaning that a fetch of the mirror remote will write the mirror's
refs/heads/master into our local refs/heads/master. IOW, your master
branch is actually configured as a remote tracking branch of the mirror
(which is probably not what you want; see below).

> I do not expect this "wip" branch to be tracking the "mirror" remote, but rather
> "origin", according to the documentation.

In the absence of the mirror remote, it would not track anything. You
are branching from a _local_ branch, so there is no remote to track. I
think what you really want is:

  git checkout -b wip origin/master

All of that being said, I'm not sure your config makes sense:

> [remote "origin"]
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         url = ssh://myserver.com/srv/git/myproject.git
> [remote "mirror"]
>         url = ssh://chris@myserver.com/srv/git/mirrors/chris/myproject.git
>         fetch = +refs/*:refs/*
>         mirror = true

Your mirror is configured to overwrite everything in refs/ if you fetch
from it. Meaning it will throw away anything you fetched from "origin",
as well as any local work. So this config is probably not what you want.

I'm guessing what you really wanted is a remote only for pushing to, and
created it with:

  git remote add --mirror mirror ssh://...

The --mirror option has problems with that case. See this thread:

  http://article.gmane.org/gmane.comp.version-control.git/161653

which has some suggestions, but nothing has been implemented yet.
Probably it makes sense to allow --mirror=fetch and --mirror=push, but
there is an open question of what just "--mirror" should do.

-Peff
