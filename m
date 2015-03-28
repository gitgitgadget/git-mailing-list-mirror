From: Kevin D <me@ikke.info>
Subject: Re: how to make "full" copy of a repo
Date: Sat, 28 Mar 2015 15:31:52 +0100
Message-ID: <20150328143152.GB9387@vps892.directvps.nl>
References: <1427511397.19633.52.camel@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Anton Mitterer <calestyo@scientia.net>
X-From: git-owner@vger.kernel.org Sat Mar 28 15:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbrmI-0005uT-T1
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 15:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbC1Oby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 10:31:54 -0400
Received: from ikke.info ([178.21.113.177]:60817 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbbC1Obx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 10:31:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 803511DCF6D; Sat, 28 Mar 2015 15:31:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1427511397.19633.52.camel@scientia.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266417>

On Sat, Mar 28, 2015 at 03:56:37AM +0100, Christoph Anton Mitterer wrote:
> Hey.
> 
> I was looking for an ideally simple way to make a "full" copy of a git
> repo. Many howtos are floating around on this on the web, with also lots
> of voodoo.
> 
> 
> First, it shouldn't be just a clone, i.o.w.
> - I want to have all refs (local/remote branches/tags) and of course all
> objects from the source repo copied as is.
> So it's local branches should become my local branches and not remote
> branches as well - and so on.
> Basically I want to be able to delete the source afterwards (and all
> backups ;) ) and not having anything lost.
> 
> - It shouldn't set the source repo as origin or it's branches as remote
> tracking branches, as said it should be identical the source repo, just
> "freshly copied" via the "Git aware transport mechanisms".
> 
> - Whether GC or repacking happens, I don't care, as long as nothing that
> is still reachable in the source repo wouldn't get lost (or get lost
> once I run a GC in the copied repo).
> 
> - Whether anything that other tools have added to .git (e.g. git-svn
> stuff) get's lost, I don't care.
> 
> - It should work for both, bare and non-bare repos, but it's okay when
> it doesn't copy anything that is not committed or stashed.
> 
> 
> 
> I'd have said that either:
> $ git clone --mirror URl-to-source-repo copy
> for the direction from "outside" the source to a copy,
> or alternatively:
> $ cd source-repo
> $ git push --mirror URl-to-copy
> for the direction from "within" the source to a copy with copy being an
> empty bare or non-bare repo,
> would do the job.
> 
> But:
> 
> a) but the git-clone(1) part for --mirror:
>    >and sets up a refspec configuration such that all these refs are
>    >overwritten by a git remote update in the target repository.
>    kinda confuses me since I wanted to get independent of the source
>    repo and this ssems to set up a remote to it?
> 
> b) do I need --all --tags for the push as well?
> 
> c) When following
>    https://help.github.com/articles/duplicating-a-repository/
>    it doesn't seem as if --mirror is what I want because they seem to
>    advertise it rather as having the copy tracking the source repo.
>    Of course I read about just using git-clone --bare, but that seems to
>    not copy everything that --mirror does (remote-tracking branches,
>    notes).
> 
>    So I'm a bit confused...
> 
> 
> 1) Is it working like I assumed above?
> 2) Does that also copy things like git-config, hooks, etc.?
> 3) Does it copy the configured remotes from the source?
> 4) What else is not copied by that? I'd assume anything that is not
>    tracked by git and the stash of the source?
> 
> 
> 
> Thanks a lot,
> Chris.

Git clone is never going to get you a copy where nothing is lost.

What you are losing on clone is:

* config settings (this includes the configures remotes)
* hooks
* reflog (history of refs, though, by default disabled for bare
  repositories)
* Stashes, because the reference to them is stored in the reflog
* unreferenced objects (though you said those are not a requirement, it
  is still something that is lost)

git clone --mirror is used for repositories that regularly get updates
from the repositories they were cloned from. Though this is not what you
want, it's not difficult to reset the refspecs to the default refspecs.
Because it fetches all refs, it's not necessary to add --all --tags
(because tags are also refs).

git clone --mirror is the closest you are going to get by only using
git.

I guess you are aware of this, but if you want to retain more
information, you have to rely on other means, like scp to get the other
things

So to summarize, git clone is only used for cloning history, which means
objects and refs, the rest is not part of cloning. To get more, you have
to go outside git.

Hope this helps to clear some confussion.

Kevin
