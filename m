From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Simple UI question...
Date: Sun, 7 Jan 2007 06:13:05 -0500
Message-ID: <20070107111305.GD10351@spearce.org>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 12:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Vxi-0000Ac-Dc
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbXAGLNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbXAGLNL
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:13:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54947 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932498AbXAGLNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:13:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H3Vxu-0007BO-DF; Sun, 07 Jan 2007 06:13:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7657A20FB65; Sun,  7 Jan 2007 06:13:05 -0500 (EST)
To: Chris Lee <clee@kde.org>
Content-Disposition: inline
In-Reply-To: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36154>

Chris Lee <clee@kde.org> wrote:
> So I'm trying to figure out the best way to pull out a checkout of the
> entire tree as of a given revision ID. I have a whole bunch of
> revision IDs, and I'd like to know what the git equivalent of (say)
> the following is:
> 
> svn co -r280600 file:///path/to/svn/repo
> 
> For the sake of argument, let's say that r280600 imported as
> 07058310db903317faa300b93004a5a2e0fc2dcc into my git tree.
> 
> How do I get a pristine checkout in my working copy of the entire tree
> as the repository saw it at 07058310db903317faa300b93004a5a2e0fc2dcc?

One way is:

  git archive \
    --format=tar \
    07058310db903317faa300b93004a5a2e0fc2dcc \
    | (mkdir ../export; cd ../export; tar xf -)

Would give you a new directory tree which is not related to any
Git repository, but which contains the exact set of files in 070583.
But that's probably not what you meant.
 
> Eric Anholt suggested 'git checkout -b temporary-branch-name
> $sha1sum';

Yes, that is usually the way you do this.  Unlike the archive trick
above the result will be in your current working directory and
will be associated with the current Git repository.  Further you
can modify this and commit changes if you need to.

> davej suggested 'git-read-tree $sha1sum &&
> git-checkout-index -a -f'

That's just cruel.  Its only part of the underlying operations that
git checkout is performing, and its trashing your current branch
by making HEAD no longer match the index.  And its very low-level.
And it doesn't really do a 2-way merge to fully update the working
directory.  Not the best way for a user to perform this action.
Forget davej ever suggested this.

> but for some reason, neither of these
> commands seems to do exactly as I expect. davej's method seems to work
> for some revision IDs, but not for others, and the other method seems
> to work just about as well. (The problem I have seen is that, for some
> revisions, the only files I get in the working copy are the files that
> were changed in that commit; the rest of the files in the tree do not
> get checked out.)

The problem is davej's method doesn't take into account what the
current working directory actually has stored in it.  It does not
delete any files which should not appear in $sha1sum.  It also
overwrites more files than it needs to, as it overwrites everything
instead of just those files which actually differ between the
current working directory and $sha1sum.

Eric Anholt's version is the correct way to do it.  It is also very
fast as it only has to modify the files which actually differed.

If Eric's version isn't always working then I'd have to suggest
that you exmaine the output of `git status` for switching to
some temporary branch based on $sha1sum.  Perhaps you have local
modifications which are carrying over in your working directory?

-- 
Shawn.
