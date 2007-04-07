From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git pull and importers
Date: Sat, 7 Apr 2007 19:12:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704071808580.27922@iabervon.org>
References: <Pine.LNX.4.64.0704062239420.27922@iabervon.org>
 <20070407202409.GA5107@muzzle>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 01:12:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaK5R-00021i-C2
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 01:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXDGXMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbXDGXMq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 19:12:46 -0400
Received: from iabervon.org ([66.92.72.58]:4763 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbXDGXMp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 19:12:45 -0400
Received: (qmail 28280 invoked by uid 1000); 7 Apr 2007 23:12:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Apr 2007 23:12:44 -0000
In-Reply-To: <20070407202409.GA5107@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43991>

On Sat, 7 Apr 2007, Eric Wong wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > There's an SVN project I'm trying to track with git-svn. "git svn fetch" 
> > fetches and imports the commits perfectly, but I can't figure out a way to 
> > merge upstream commits into my branch automatically.
> 
> I don't suggest using merge with git-svn since it can generate
> non-linear history.  Non-linear history does not map well to SVN.

That depends entirely on your merge strategy. In this case, I'm only 
really interested in fast-forwards, which can't create, well, anything. If 
I did any development on this particular project, I'd be emailing patch 
series, at least for now, so mapping back into SVN isn't a concern for me.

> "git svn rebase" (in 1.5.1) is handy for getting upstream commits into
> your branch (it's a wrapper around "git rebase")

Possibly "pull" should be able to invoke rebase instead of merge, also
(or merge should be able to actually use rebase). Handwaving, it would be 
good if a branch config could say that the history has to remain linear 
for some policy reason.

> > It seems like the right solution should be:
> > 
> > [remote "origin"]
> > 	importer = svn
> > 	url = svn://ixion.tartarus.org/main
> > 	fetch = puzzles:refs/remotes/puzzles
> > [branch "master"]
> > 	remote = origin
> > 	merge = puzzles
> 
> git-svn in 1.5.1 already allows you to define:
> 
> [svn-remote "svn"]
> 	url = svn://ixion.tartarus.org/main
> 	fetch = puzzles:refs/remotes/puzzles
> 
> And then "git svn rebase" should automatically be able to figure out to
> rebase against refs/remotes/puzzles without needing a [branch "master"]
> section.

That's what I've got right now.

> I don't think having the "importer = svn" in [remote "..."] is a good
> idea since it would be incompatible with older versions of git and the
> documentation would confuse users who don't track the latest version.

The current version of git just ignores it, which means that a regular 
"git fetch" fails, but actually somewhat less confusingly than if you 
don't have the section at all. (See below)

> > Which would mean that it would use "git svn fetch" instead of "git fetch" 
> > for that remote, and "git svn fetch" would use that config section instead 
> > of its current config section.
> 
> Here's what I'd like git-fetch to do someday[1]:
> 
> When git-fetch is called without any remote arguments, it would look for
> [remote "origin"] as it does now.  However, if no [remote "..."]
> sections are found (as is common with importer-created repos), it would
> try other importers: [svn-remote "svn"], (and hopefully one day
> [cvs-remote "cvs"], [arch-remote "arch"], ...).
> 
> Of course, git-fetch would also be able to handle --svn (and later
> --cvs/--arch/...) flags if the [*remote "..."] section names are
> ambiguous.
> 
> I intentionally named the default svn-remote section "svn" instead of
> "origin" for this reason, too; I didn't want to confuse git-fetch.

git-fetch is confused worse by getting invoked without any remotes than by 
getting a URL that doesn't work. I think it's trying to fetch from 
"./origin/.git" effectively. At least if you've got a section with a URL 
that doesn't have a git repository at it, it tells you it couldn't find a 
git repository at the svn URL (or it tells you it doesn't understand 
svn://...), at which point you know what's wrong.

For future versions, it would be just as easy to have a setting to tell it 
what interfacing thing it needs in order to handle a particular remote.

But I could see it being helpful to be able to have a ton of different 
remotes, some of which are through importers, where you don't much care 
how you get the content. E.g., Linus could just do "git pull alsa", to 
import from ALSA's repository, ignoring the fact that it's hg (and used 
to be cvs). It would definitely be helpful for cases where changes only 
come from the foriegn SCM (or go back as patches). So, at the very least, 
you should be able to use:

[hg-remote "alsa"]

Also, subprojects in the "vast superproject" model would often have 
import-only links to upstream repositories in other systems, as a backbone 
for non-linear local development.

> [1] - patches would be very much welcome (*nudge*nudge*wink*wink),
>       I have a lot on my plate and this isn't a high priority.

I've been poking at the git-fetch stuff some. Certainly doing better than 
looking at git-svn, since I don't know perl...

	-Daniel
*This .sig left intentionally blank*
