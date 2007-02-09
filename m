From: Jeff King <peff@peff.net>
Subject: Re: Question on git fetch to bare repo
Date: Thu, 8 Feb 2007 21:39:41 -0500
Message-ID: <20070209023941.GE10574@coredump.intra.peff.net>
References: <17867.41997.561756.679778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 03:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFLg5-00029X-As
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 03:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbXBICjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 21:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946012AbXBICjo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 21:39:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4757 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945898AbXBICjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 21:39:43 -0500
Received: (qmail 1525 invoked from network); 8 Feb 2007 21:39:46 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Feb 2007 21:39:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2007 21:39:41 -0500
Content-Disposition: inline
In-Reply-To: <17867.41997.561756.679778@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39150>

On Thu, Feb 08, 2007 at 04:28:29PM -0600, Bill Lear wrote:

> % mkdir project && cd project
> % git --bare init-db --shared
> % git --bare fetch git://source/project
> [All seems well]

It's not. You have fetched the objects from git://source/project, and
FETCH_HEAD (an ephemeral pointer to the things you just fetched) points
to them. But look in project/refs/heads; you have no branches!

What you want instead is:
  git --bare fetch git://source/project master:master
which means
  "fetch project's master and store it as my master; if it's not a
  fast-forward, then complain loudly. Don't do any merges."

> I have a private repo:
> 
> % mkdir project && cd project
> % git clone /repos/git/project
> [All is well]

Is it? You shouldn't have any branches in /repos/git/project at this
point.

> A co-worker checks something in to our company repo, so I go to my
> public repo to fetch the changes:
> 
> % cd /repos/git/project
> % git --bare fetch -v git://source/project
> remote: Generating pack...
> remote: Done counting 230 objects.
> remote: Result has 152 objects.
> remote: Deltifying 152 objects.
> remote:  100% (152/152) done
> Unpacking 152 objects
> remote: Total 152, written 152 (delta 109), reused 90 (delta 51)
>  100% (152/152) done
> * fetched git://source/project
>   commit: 5c2d43d

Again, you're not _storing_ those changes in a branch, you're just
putting them in FETCH_HEAD.

> I then go to my private repo to pull from my public one:
> 
> % cd ~/project
> % git branch
>   topic
> * master
> % git pull
> Already up-to-date.

Not surprising, since you didn't actually update any branches in the
previous step.

> % cat .git/remotes/origin
> URL: /repos/git/project
> Pull: refs/heads/master:refs/heads/origin
> Pull: refs/heads/topic:refs/heads/topic
> [All seems well with this repo ??]

I'm confused as to how there are branches in the 'public' repo at this
step, since your initial fetch shouldn't have actually made any,
especially not a 'topic' branch.

> % cd /repos/git/project
> % git --bare show -t 5c2d43d
> 
> the patch comes out exactly as it did in my email notification, so I
> know it's there.

Sure, you have the object, but you don't have any _pointers_ to it.

> I tried then to be more forceful, and did another fetch like this,
> which I sort of expected to fail:
> 
> % git --bare fetch -v git://source/project master:master
> remote: Generating pack...
> remote: Done counting 230 objects.
> remote: Result has 152 objects.
> remote: Deltifying 152 objects.
> remote:  100% (152/152) done
> Unpacking 152 objects
> remote: Total 152, written 152 (delta 109), reused 90 (delta 51)
>  100% (152/152) done
> * refs/heads/master: fast forward to branch 'master' of git://source/project
>   old..new: 37e2298..5c2d43d
> Cannot fetch into the current branch.

You're more on the right track here, but not quite. If you want to save
things in branches, you either need to use a 'remotes' shorthand (which
defines pull lines with refspecs) or you need to specify the refspec on
the command line (like master:master). However, you _don't_ want to
fetch directly into your master branch. fetch is for copying refs and
objects, not for merging (and you've presumably made some commits on
master that the upstream doesn't have).

It seems like you're trying to merge in your "public" repository, which
is a mistake. I think you would be much better served to think of your
public repository as a place where you publish changes (_only_ from your
private repository), and do all of your external fetching and merging in
your private repository. Everyone has a public repo, so you always
"pull" from other people's public repos, and "push" into your public
repo. Thus you don't need --shared at all.

IOW, do this:

# set up public repository; initially empty, but we will push something
# useful into it soon.
mkdir /git/repo/project && cd /git/repo/project
git --bare init

# set up our private repository, which is a clone of the company repo
cd $HOME
git clone git://source/project

# at this point, our .git/remotes/origin file is set up to pull from
# the company repo. But we still want to publish our changes in our
# personal public repo. Let's set that up. We always want the public
# branches to match ours, even if we've reset or rebased, so we use '+'
# to always overwrite. This is safe, because data is never getting into
# the public repo in any way _except_ for us pushing it.
cat >.git/remotes/publish <<'EOF'
URL: /git/repo/project
Push: +master:master
Push: +topic:topic

# now we can make our first publication, which at this point is the same
# as the source repo
git push publish

# and now we make some changes
hack hack hack
git commit

# and we can publish more changes
git push publish

# but now we want to grab some changes from Bob's public repo. Let's set
# up a new remote for him. Again, we use '+' to overwrite, since we are
# just tracking what Bob is doing. Note that we have Bob's branch now,
# but we don't _publish_ it, since it's not in our publish remote.
cat >.git/remotes/bob <<'EOF'
URL: /path/to/bobs/repo
Pull: +master:bob-master
EOF

# and now we can fetch/pull from bob
git fetch bob
# what has bob done that we haven't?
gitk bob-master..master
# ok, let's merge
git pull . bob-master
# or do the fetch/pull in one step
git pull bob master

And Bob can of course do the same to us.

Does that make more sense? Or have I completely missed what you are
trying to accomplish? :)

-Peff
