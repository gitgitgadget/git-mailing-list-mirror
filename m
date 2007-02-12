From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 18:34:54 -0500
Message-ID: <20070212233453.GA30967@spearce.org>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net> <20070211224158.GA31488@spearce.org> <7v64a782ht.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkhM-0003Mu-Jy
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbXBLXfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbXBLXfB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:35:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45496 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030478AbXBLXfA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:35:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGkh6-0006yl-Ta; Mon, 12 Feb 2007 18:34:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B4B420FBAE; Mon, 12 Feb 2007 18:34:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v64a782ht.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39456>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > It may be saner for all involved if that development happens in
> > the git-gui.git repository, with drops made to git.git by way of
> > merging the "subproject" every so often.
> 
> Ok, so here is what I did last night.
> 
> $ git remote show git-gui
> * remote git-gui
>   URL: git://repo.or.cz/git-gui.git/
>   Tracked remote branches
>     master
> $ git fetch git-gui
> $ git read-tree --prefix=git-gui/ git-gui/master
> $ git checkout git-gui
> $ git rev-parse git-gui/master >.git/MERGE_HEAD
> $ git commit

I just sent you a patch for Makefile in git.git to build git-gui.
I've also setup things so git-gui's versions track independently of
git, yet the correct versions are embedded into the release tarball
and executable in both the standalone and embedded-in-git cases.
A true subproject!

For this to work the gitgui-* tags need to be fetched into your
repository.  I also took the assumption that the git-gui subdirectory
is never modified in git.git, but only through merging git-gui's
commit history.

To play nice I'm prefixing the git-gui tags with 'gitgui-', rather
than 'v', so that they don't conflict with git's own version numbers
within the refs/tags namespace.

I am signing gitgui tags with a GPG key. For ease of distribution
my public key was tagged under spearce-gpg-pub.  The hash for
spearce-gpg-pub is 8bb563fb25a372a9cb14f0a9b9015d409fd82c16.

I'm not sure if it makes sense to push the gitgui-* tags (or
spearce-gpg-pub) to the public git.git repository.  If these tags
aren't present then git-gui will fail to get its version number
and fallback on the hardcoded value in git-gui/GIT-VERSION-GEN.
Anyone who really cares that this is correct could just fetch
the tags on their own from repo.or.cz.

Here's the script I was working with to merge git-gui into git.git:

-->8--
#!/bin/sh

remote=git-gui
branch=master

git-fetch $remote &&
ggh=$(git-rev-parse $remote/$branch) &&
ggt=$(git-rev-parse $ggh^{tree}) &&
tree=$(git ls-tree HEAD \
	| sed "/	git-gui/s/tree .*	/tree $ggt	/" \
	| git mktree) &&
git-read-tree -m -u --exclude-per-directory=.gitignore HEAD $tree &&
git-update-ref ORIG_HEAD HEAD &&
git-update-ref MERGE_HEAD $ggh &&
msg="Merge branch '$branch' of $(git-config remote.$remote.url)

Update to version $(git describe --abbrev=4 $ggh).
" &&
echo "$msg" >.git/MERGE_MSG &&
echo "Merge complete.  Please commit the result." ||
exit
-->8--

-- 
Shawn.
