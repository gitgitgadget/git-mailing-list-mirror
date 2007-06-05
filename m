From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: clarify git clone --local --shared --reference
Date: Tue, 5 Jun 2007 00:50:08 -0400
Message-ID: <20070605045008.GC9513@spearce.org>
References: <4664A5FE.30208@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 05 06:50:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQzz-0005YM-U9
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 06:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXFEEuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 00:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbXFEEuO
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 00:50:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55562 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXFEEuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 00:50:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HvQzi-00079n-3m; Tue, 05 Jun 2007 00:50:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0350F20FBAE; Tue,  5 Jun 2007 00:50:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4664A5FE.30208@nrlssc.navy.mil>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49159>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> 
> I think the goal of these three objects is space savings (and speed),
> but I don't understand when I should prefer one option over another, or
> when/whether to use a combination of them. And I am unsure (SCARED)
> about any side effects they may have.

Yes, they are mainly about saving time setting up the new clone,
and about disk space required by the new clone.
 
> 1) What does local mean?
>   --local says repository must be on the "local" machine and claims it
>   attempts to make hardlinks when possible. Of course hard links cannot
>   be created across filesystems, so are there other speedups/space
>   savings when repository is on local machine but not on the same
>   filesystem? Is this option still valid then?

Basically --local means instead of using the native Git transport to
copy object data from one repository to another we shortcut and use
`find . | cpio -lpumd` or somesuch, so that cpio can use hardlinks if
possible (same filesystem) but fallback to whole copy if it cannot.
This is usually faster than the native Git transport as we copy
every file, without first trying to compute if the file would be
needed by the new clone or not.

So --local may copy garbage that git-prune would have removed,
or that git-repack/git-gc might have eliminated from a packfile.
But generally that's such a small amount of data that the faster
cpio path (and even better, the hardlinks) saves disk.

Note we only hardlink the immutable data under .git/objects; the
mutable data and the working directory files that are checked out
are *not* hardlinked.
 
> 2) Does --shared imply shared write access? Does --local?
>    I'll point out that git-init has an option with the same name.

No.  --shared means something entirely different in git-clone
than it does in git-init.

The --shared here implies adds the source repository to the new
repository's .git/objects/info/alternates.  This means that the
new clone doesn't copy the object database; instead it just accesses
the source repository when it needs data.

This exposes two risks:

  a) Don't delete the source repository.  If you delete the source
  repository then the clone repository is "corrupt" as it won't be
  able to access object data.

  b) Don't repack the source repository without accounting for the
  refs and reflogs of all --shared repositories that came from it.
  Otherwise you may delete objects that the source repository no
  longer needs, but that one or more of the --shared repositories
  still needs.

Objects that are newly created in a --shared repository are written
in the --shared area, not in the source repository.  Hence the
source repository can be read-only to the current user.
 
> 3) --shared seems like a special case of --reference? Are there
>    differences?

--reference is actually a special case of --shared.  --reference is
meant for cloning a remote repository over the network, where you
already have an existing local repository that has most of the
objects you need to successfully clone the remote repository.

With --reference we setup a temporary copy of refs from the
--reference repository in the new repository, so that during the
network transfer from the remote system we don't download things
the --reference repository already has.

But --reference implies --shared, and has the same issues as above.
 
> 4) what happens if the source repository dissappears? Is --local ok
>    but --shared screwed?

Correct.

> 4) is space savings obtained only at initial clone? or is it on going?
>    does a future git pull from the source repository create new hard
>    links where possible?

Only on initial clone.  Later pulls will copy.  You can try using
git-relink to redo the hardlinks after the pull.

> Can --shared be used with --reference. Can --reference be used multiple 
> times (and would I want to). Does -l with -s get you anything? (the
> examples use this)

--reference can only be given once in a git-clone; we only setup
one set of temporary references during the network transfer.
And as I said above, --reference implies --shared.

-- 
Shawn.
