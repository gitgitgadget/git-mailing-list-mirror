From: Jeff King <peff@peff.net>
Subject: Re: Tracking branches and pulling on remote
Date: Wed, 5 Jan 2011 00:01:08 -0500
Message-ID: <20110105050108.GA5884@sigill.intra.peff.net>
References: <loom.20110105T013525-413@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Jan 05 06:06:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaLZU-0002Wc-K8
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 06:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab1AEFBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 00:01:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44892 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab1AEFBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 00:01:15 -0500
Received: (qmail 28706 invoked by uid 111); 5 Jan 2011 05:01:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 05:01:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 00:01:08 -0500
Content-Disposition: inline
In-Reply-To: <loom.20110105T013525-413@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164545>

On Wed, Jan 05, 2011 at 12:58:47AM +0000, Maaartin wrote:

> 1.
> I'm using git for couple of months and still don't get it. In a new repo a have 
> two branches: master and X. I pushed both to the server, everything seems to 
> work. However, there's origin/master but no origin/X in my repo. When I execute
> git fetch --all -v
> only master gets fetched. I've created an entry in the .git/config, no change. 
> I've tried things like
> git branch --track X origin/X
> and all of them ends with an error message. Finally I've found out that
> git config --add remote.origin.fetch refs/heads/X:refs/remotes/origin/X
> seems to do it, was it right?

There should already have been a remote.origin.fetch that looked like:

  $ git config remote.origin.fetch
  +refs/heads/*:refs/remotes/origin/*

which is a superset of what you added. If you run the git config command
I did above, what do you see? If you have a wildcard line like the one
above (which is added during the initial clone), then the config you
added would have done nothing.

Are you absolutely sure that the branch was pushed to the remote side in
the first place? How did you push it?

> 2.
> I'd like to do some (at least for now) private changes on a foreign project. The 
> ideal way I think about would be the following:
> - my local repo is linked to my own server (for backup purposes and for private 
> cooperation with a college)
> - the repo on my server is linked to the github hosting the project
> Now, I'd need to do something like
> ssh myserver git fetch
> and everything would be fine. I can do it this way, but I'd prefer something like
> git remote fetch
> or even
> git fetch --remote-too
> which would first make my server fetch from its origin and then my local repo 
> fetch from my server. Is there such a thing? Would you recommend me doing it in 
> a different way?

There isn't really a shortcut for the two-level thing you're trying to
do. But consider rearranging your topology to always pull to the local
repo, and then push changes up to your backup/collaboration server.

Something like:

  $ git clone http://github.com/whatever/project.git
  $ cd project
  $ git remote add myserver myserver:/path/to/backup repo

and then your workflow is:

  : hmm, I feel like working on project. what happened upstream?
  $ git pull ;# or git fetch origin; gitk origin... ; git merge origin
  $ hack hack hack
  : ok, now I have some work to show to my collaborator
  $ git push myserver

or possibly:

  : ok, now what has my collaborator been up to
  $ git fetch myserver
  $ gitk myserver/topic
  : I like it, let's merge
  $ git merge myserver/topic
  : Now push back my merge
  $ git push myserver

You might also find it convenient to swap which remote is "origin"
(since it is the default for "git push" without arguments). That is, you
primarily consider your local repo to be a clone of what's on
"myserver", but you occasionally fetch and merge changes from upstream,
like:

  : ok, what has my collaborator been working on?
  $ git pull
  : and what has upstream been up to?
  $ git fetch upstream
  : oh, neat stuff. let's merge it
  $ git merge upstream
  : and then let's publish it so our collaborator will also work on top
  : of it
  $ git push ;# implicitly to origin

How you want to set it up really depends on which mental model
represents your workflow best.

-Peff
