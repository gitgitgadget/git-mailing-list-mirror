From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: clarify git clone --local --shared --reference
Date: Fri, 8 Jun 2007 01:37:50 -0400
Message-ID: <20070608053750.GB18521@spearce.org>
References: <4664A5FE.30208@nrlssc.navy.mil> <20070605045008.GC9513@spearce.org> <46658F98.6020001@nrlssc.navy.mil> <20070606051111.GF9513@spearce.org> <466701E0.4000108@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 08 07:38:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwXAh-0000qy-1S
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 07:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936336AbXFHFhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 01:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936396AbXFHFhz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 01:37:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37359 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936336AbXFHFhz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 01:37:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1HwXAW-0001Mq-BB; Fri, 08 Jun 2007 01:37:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1A13920FBAE; Fri,  8 Jun 2007 01:37:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <466701E0.4000108@nrlssc.navy.mil>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49436>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> ok. I just want to make sure this is not really about prune'ing.
> 
> In the following, source and --shared repos are identical except...
> 1) Source repo contains loose objects which are new commits.
>    --shared repo does git-pull.
>    we fast-forward, copying very little.
>    success.

Copying nothing actually.  All of the objects required are in the
source repository, so --shared needs nothing additional.

> 2) Source repo contains loose objects which are new commits.
>    Source repo does git-gc, which repacks but doesn't prune.
>    --shared repo does git-pull.
>    success?

Yes, same as above.  Except: If --shared has a branch that points
at a commit that used to be in source (hence its data isn't in
--shared) and that data used to be packed, but source no longer
has a reference to it.  When you repack source we won't include
that commit in the new pack, but we will delete the old pack.
That means the commit goes away.

> 3) Source repo deletes a branch that --shared repo also has.
>    This deletion creates dangling unreferenced objects.

Yes... see above about the repack problem.

> ** --shared repo still ok here, right?
>    Source repo does git-gc, which repacks but doesn't prune.

Broken.  The repack didn't include the dangling objects.

> ** Is --shared screwed at this point? (This is what I understand
>      you to say above) Or do the dangling objects still exist,
>      so --shared is still ok?

--shared is fubar, on the deleted branch.

>    git gc --prune
>    --shared is fubar, at least on the deleted branch.

also fubar, on the deleted branch.

> The docs (git-repack.txt) seem to suggest that git-repack (without -d) 
> does not delete any objects. And if -d is used, then at most objects 
> already referenced in other packs will be deleted. This makes me think 
> that repack is safe on the source repository.

You are correct that leaving off the '-d' won't delete objects.
But a pack is created by listing the objects we need, and if we don't
need the object in source, we don't include it into the new pack.

-a -d implies delete all packs that existed when we started the
repack.  So if an object was in the old packfile, and we didn't
copy it to the new packfile, it gets deleted.  ;-)

Packfiles are immutable.  We cannot delete something from it without
deleting the entire packfile.
 
> If the above is wrong, then I'm missing a clue about git-rebase. And 
> don't feel like you have to explain it to me. Do feel free to give a 
> short *NO!! REPACK IS DANGEROUS ON SHARED REPOS YOU IDIOT!!* or other 
> such beating. But if you see what I'm misunderstanding please let me know.

;-)

NO!! REPACK IS DANGEROUS ON SHARED REPOS YOU IDIOT!!

Exactly because of what I'm saying above, and what you mention about
source deleting a branch and repacking or pruning, and --shared
then being corrupt because its now missing at least one object it
wants to have.
 
> If the above is right, then it seems like the source repo developer 
> should be able to go about his developing, and git-gc'ing without
> regard for other developers who may be --share'ing. And only when the
> source developer wants to do a prune of dangling objects must something 
> special be done. git-prune.txt suggests:
> 
>     git prune $(cd ../another && $(git-rev-parse --all))

Right; but the thing that is shocking to some people (me in my
early days with Git) is that a repack is *also* doing a prune if
you add -d.  Its not quite the same type of prune as it prunes only
previously packed objects, but its still a prune.
 
> >In my day-job repositories I have about 150 MiB of blobs that
> >are very common across a number of Git repositories.  I've made a
> >single repo that has all of those packed, and then setup that as an
> >alternate for everything else.  It saves a huge chunk of disk for us.
> >But that common-blob.git thing that I created never gets changed,
> >and never gets repacked.  Its sort of a "historical archive" for us.
> >Works very nicely.  Alternates have their uses...
> 
> Ahh, now that's interesting.
> 
> Could I create something like that by doing something like this:
> 
> (in a cloned repository with only a master branch)
> git reset --hard HEAD^     # I know, HEAD is still in the history
> git gc --prune             # log so it doesn't get pruned, but
>                            # it's just an example
> 
> (now back in my devel repo)
> <add archive repo to alternates>
> git prune-packed

Actually you want `git gc` in your --shared repo now.  That way it
minimizes the current packfiles.  prune-packed only applies to loose
objects; not already packed stuff.  Since you added a repo with a
large packfile to your alternates list you probably want to shrink
your own packfile down as much as possible.  That works because
`git gc` is actually running `git repack -a -d -l`.  The -l means
"only things that are local to this --shared repository.
 
> Now most everything is likely referenced in the archive repo except the 
> last commit. Well, maybe even the HEAD commit due to the history log.

Right.
 
> Depending on how you reply above, a periodic pull into the archive repo 
> (and a repack?), then a 'git prune-packed' from the sharers could allow 
> good sharing? <waiting for a "NO, YOU IDIOT!"> If not, then I guess the 
> archive creation steps could be repeated periodically.

Yes, exactly.  The trick here is that once something enters the
shared repo IT MUST STAY THERE.  You cannot allow a branch to be
deleted from the shared repo, unless it is fully merged into another
branch (or tag) that is staying.  You also cannot rewind a branch
(e.g. push with --force).

But I do exactly what you are suggesting.  I pull every so often
into a the shared common repo and repack it.  And then everyone
else can repack and their repack deletes things that are in the
shared common repo.

Just make sure you have a good backup of the shared common repo.  :)

-- 
Shawn.
