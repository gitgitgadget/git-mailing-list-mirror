From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Wed, 9 Apr 2008 16:34:54 -0400
Message-ID: <20080409203453.GA10370@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 22:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjh1B-0001iy-9p
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYDIUe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbYDIUe5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:34:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4857 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbYDIUe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:34:56 -0400
Received: (qmail 10438 invoked by uid 111); 9 Apr 2008 20:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 16:34:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 16:34:54 -0400
Content-Disposition: inline
In-Reply-To: <20080409200836.GA19248@mithlond>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79133>

On Wed, Apr 09, 2008 at 11:08:36PM +0300, Teemu Likonen wrote:

> seem quite unnecessary hackerish. Pull and push work pretty nicely
> without knowing about any refs/* stuff; they can be operated with simple
> branch names. Fetch is another story. Some ideas:
> 
>   $ git fetch <URL>
> 
> would be equivalent to
> 
>   $ git fetch <URL> +refs/heads/*:refs/remotes/<name>/*
> 
> In other words, fetch all the branches from remote repo and store them
> locally as remote tracking branches to <name>/ hieararchy. The <name> is
> the last component taken from the <URL> (maybe "origin" if it can't be
> detected).

This has been discussed before and rejected, because the point of doing
a fetch of a URL (rather than a remote name) is to do a "one-off" thing.
IOW, you don't _want_ the tracking branches, as they will just clutter
your branch space (plus choosing the last component is a bad heuristic;
lots of people must ask Linus to pull from their .../linux-2.6
repository).

Almost nobody says "git fetch <URL>"; it is just a subpart of "git
pull <URL>" which is intended for one-off merges (i.e., you are not
tracking somebody over the long term, you just want to grab their work
and merge it).

> Currently "git fetch <URL>" does not seem to do anything useful for
> non-git-hackers. It seems to fetch objects but not create any branches
> referring to them. As a comparison, let's configure a remote and run

It does; it puts the refs into FETCH_HEAD. Maybe a status table like the
usual one would be more informative, like:

  From git://host/path/to/repo
   * [new branch]      foo -> FETCH_HEAD

though again, it would help if we could see a workflow that uses "git
fetch <URL>" for something. I think the simplest answer in your case is
"don't use git fetch <URL>".

> similar fetch command without any refspecs explicitly named:
> 
>   $ git remote add <name> <URL>
>   $ git fetch <name>
> 
> Now this fetch really creates all the branches (as defined in
> remote.<name>.fetch) which is nice and the way Git currently works.

Sure. There is an explicit design decision that "because you gave this
thing a nickname, you are probably interested in keeping its tracking
branches around."

> Some more ideas for simple refspecs:
> 
>   $ git fetch <URL|name> <branch>
> 
> would be equivalent to
> 
>   $ git fetch <URL|name> +refs/heads/<branch>:refs/remotes/<name>/<branch>

It would probably be nice if "git fetch name foo" saved the remote
tracking branch remotes/name/foo, which it doesn't currently. But
whether to do it with a URL is orthogonal; it depends on whether we use
tracking branches for URLs in general, as you suggested above.

>   $ git fetch <URL|name> <Rbranch>:<Lbranch>
> 
> would be equivalent to
> 
>   $ git fetch <URL|name> +refs/heads/<Rbranch>:refs/remotes/<Lbranch>

We almost have that. It's actually spelled:

  git fetch <URL|name> <Rbranch>:remotes/<Lbranch>

But again, what is the workflow? There are generally two ways of
fetching:

  1. I am tracking some remote with multiple branches. I give it a
     remote name (either by editing the config file or by using
     git-remote). When i want to get updates, I do "git fetch <name>",
     and then I can work with the <name>/* branches as I want (diffing,
     merging, etc).

  2. "Somehow" I found out about something interesting in a particular
     branch of a particular repo. I want to pull that in to see the
     work, so I use "git pull <repo> <branch>". Alternatively, if I
     prefer to fetch and examine before pulling (even though the merge
     can of course be cancelled easily), I can "git fetch <repo>
     <branch>", followed by "git diff HEAD FETCH_HEAD", followed by "git
     merge FETCH_HEAD".

It seems like you are getting caught up on using "git fetch" in
different ways that don't really make sense to its original use. So the
problem is not so much one of "fetch doesn't do what I want it to do" as
much as "it is easy to be confused about what it is I want to do."

-Peff
