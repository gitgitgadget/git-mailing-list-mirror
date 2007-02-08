From: Jeff King <peff@peff.net>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 18:24:04 -0500
Message-ID: <20070208232404.GA9493@coredump.intra.peff.net>
References: <17866.27739.701406.722074@lisa.zopyra.com> <7vr6t13251.fsf@assigned-by-dhcp.cox.net> <17867.16740.875694.789664@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIcg-00073P-6h
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965593AbXBHXYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbXBHXYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:24:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3660 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965593AbXBHXYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:24:07 -0500
Received: (qmail 25975 invoked from network); 8 Feb 2007 18:24:08 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Feb 2007 18:24:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2007 18:24:04 -0500
Content-Disposition: inline
In-Reply-To: <17867.16740.875694.789664@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39120>

On Thu, Feb 08, 2007 at 09:27:32AM -0600, Bill Lear wrote:

> > - never build on a branch that appears on the RHS of ':'.
> 
> This I don't quite understand.  So, if it is on the LHS, it is ok?
> But, if it is ALSO on the RHS it is not?

If it is on the LHS, it's talking about the branch in the _remote_ repo.

> So, this:
> 
>       Pull: refs/heads/topic:refs/heads/topic
> 
> really means don't don't work on a branch named topic in this
> repository?

It means to fetch the remote's branch "refs/heads/topic" and store the
current head in _your_ "refs/heads/topic" as a tracking branch, but only
if it's a fast-forward. Yes, I know it says "Pull:", but it's really
about fetching.

You can then merge the result of that fetch into your current branch. So
what you want is something like:

Pull: refs/heads/topics:refs/heads/remote-topic

which will use 'remote-topic' as a tracking branch, always updating it
at fetch time to reflect the remote's version of topic. You can then
merge remote-topic into your local topic branch by fetching+merging, or
by doing 'git-pull remote refs/heads/topic:refs/heads/remote-topic'.

> I assume by "build on" you mean "work, compile, check stuff in,
> etc."?.  Did you have something else in mind when you said "build on"?

I believe he means 'store commits in'. That is, the RHS of the refspec
should be used solely for tracking fetches from the remote. If you make
a commit on top of it (either directly, or by doing a merge), then the
fetch must either throw away your commits, or fail to fast-forward to
the remote's new position for that branch.

> I don't currently have any 'refs/remotes' of any sort, so I guess you
> mean that the new principle, using git clone --use-separate-remote
> will effect this.

Yes. It will basically give you a RHS of "refs/remotes/$REMOTE/$BRANCH"
to track a branch $BRANCH coming from $REMOTE (generally "origin"); it's
a more organized way of doing what I mentioned above (RHS of
refs/heads/remote-topic).

> >(git-clone from 1.5.0 does not actually make remotes/origin file
> >in .git/ that has the above -- it creates the moral equivalent
> >in .git/config).
> 
> So, using 1.4.4 series, or 1.5, the "sane" way to work in git
> is to use clone --use-separate-remotes.

Most people think so (though I think Junio actually still uses the
traditional layout, because he finds it more convenient). Note that in
1.5, --use-separate-remote is the default (the option is still
accepted, but has no effect; note also that the option is singular).

> I assume by this you mean that if I do the separate remote trick, I
> will not shoot myself by doing a 'git pull' while on my topic branch,
> as the setup will cause git to refuse to do it.

No, you will not shoot yourself because the fetch part of the pull will
store the remote's position of 'refs/heads/topic' at
'refs/remotes/origin/topic' instead of trying to overwrite the branch
you've been working on.

As an additional bonus, you can put this in your .git/config:

[branch "topic"]
remote = origin
merge = refs/heads/topic

which means "When I'm on my refs/heads/topic branch and I issue a
git-pull without any arguments, do a git-fetch on origin. Then, merge
what the remote end calls refs/heads/topic into my current branch."
Without this, git-pull in v1.4.* will attempt to merge the remote's
'master' branch. In v1.5, I believe it will refuse to make a merge.

> Ok, so if I am on master, I do this:
> 
> [master] % git pull
> 
> and this will fetch the remote master and merge it to my master, and
> fetch the remote topic and merge it to my local topic.
> 
> While, if I am on my topic branch, if I do this:
> 
> [topic] % git pull
> 
> it sill fetches from the remote master and the remote topic, but will
> not merge at all.
> 
> Could you verify if I have stated your position correctly?

That is correct. If you add the config I mentioned above, you can get
the "automatically merge from remote topic into my topic" behavior that
you get for master.

> If I am, this still seems bizarre.  I really just want a way to sync
> two repos that works consistently, and is invoked consistently, no
> matter what branch I am currently on.  And, again, by "sync", I just
> mean no cross-branch merging --- no "crossing of the streams".  Even
> if it were limited to syncing the current branch only, that would be
> ok, but this variable behavior seems rather odd and confusing.  In
> other words, I just want to type the equivalent of 'git sync' and have
> it work, and not have to give a branch name, or be in the "right
> place" for it to work as I expect.

Syncing repositories doesn't involve pulling. It just involves fetching.
So in either case, you can simply do a 'git-fetch origin'. In v1.5,
the repositories won't be exactly identical; your remote branches will
be stored in refs/remotes/origin instead of refs/heads.

However, your original setup is still broken for syncing. You are doing
local work on refs/heads/topic, but you also are claiming you want to
store the sync of the remote in refs/heads/topic. You obviously can't do
both.

> Thus, I don't want to have to think "oh, I'm on my topic branch, and
> if I really want to sync from my remote repo, I need to get on my
> master branch".  It seems that the only difference in the "insane" way

Maybe I don't understand what you mean by sync here, but I don't see the
mental leap. Whenever you fetch, from whatever branch, using the
'origin' remote, it will update all tracking branches in your local
repository. You can then selectively do merges to any local branches
you're working on. You _can't_ do an operation that is "for every local
branch I have, merge the matching remote branch into my local branch".
And I don't think you'd want to: a merge may or may not be a trivial
thing, since it might have conflicts.

The workflows I suspect you want are:

1. I'm working on my topic, and somebody else is working on topic. Pull
   their work from the remote 'origin':

     git checkout topic
     hack hack hack
     git commit
     git pull origin

  Using separate remotes, you'll get a copy of the remote topic branch
  in your refs/remotes/origin/topic. If you have the config magic I
  mentioned above, it will automagically pull from his topic branch. If
  not, it will either pull from his master (v1.4) or complain (v1.5).

2. I'm working on my topic, and now I want to pull from the remote
   master to do some testing.

     git checkout topic
     hack hack hack
     git commit
     git fetch origin
     git merge origin/master

   This will only work in v1.5.  Using separate remotes, the
   'origin/master' branch refers to the 'refs/remotes/origin/master'
   tracking branch. You could do it in v1.4 like this (without using a
   tracking branch at all):

     git pull origin master

3. I'm interested in what's happening on the topic branch, but I don't
   care about making local commits. I just want to build it.

     git checkout origin/topic
     build build build

   It assumes you are tracking using separate remotes (hence the
   origin/topic branch). This will _only_ work in v1.5, since you're
   not allowed to checkout any non-branch refs in v1.4 (including tags
   or remote tracking branches). The moral equivalent in v1.4 using
   separate remotes is:

     git checkout -b topic origin/topic
     build build build

   which leaves you with your own local 'topic' branch, which you can
   then merge into if you want.

Hope that makes sense.

-Peff
