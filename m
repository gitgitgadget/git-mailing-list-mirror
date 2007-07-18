From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 21:48:06 -0400
Message-ID: <20070718014806.GQ32566@spearce.org>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk> <20070717212103.11950.10363.julian@quantumfyre.co.uk> <20070717214011.GU19073@lavos.net> <20070717214510.GV19073@lavos.net> <31e9dd080707171449r26c430f1vacfb58eb00f578e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Downing <bdowning@lavos.net>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 03:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAyeJ-0005K2-Qk
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 03:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190AbXGRBsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 21:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbXGRBsQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 21:48:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48071 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbXGRBsP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 21:48:15 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAydx-0004OG-Bl; Tue, 17 Jul 2007 21:47:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BA3AD20FBAE; Tue, 17 Jul 2007 21:48:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <31e9dd080707171449r26c430f1vacfb58eb00f578e5@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52816>

Jason Sewall <jasonsewall@gmail.com> wrote:
> On 7/17/07, Brian Downing <bdowning@lavos.net> wrote:
> >I take it this means that keeping your home directory under git
> >/directly/ as I have chosen to do is a bad idea...
> 
> Interesting, because this is something I've wanted to do - I use
> several machines (work, work laptop, home, home laptop) and I'm always
> tweaking my various dotfiles... I could really use a way to keep them
> all synchronized.
> 
> Just out of curiosity, what do you people do?

I have a regular git directory in ~/cgwork/HomeDir, with its
associated .git directory in ~/cgwork/HomeDir/.git.  In other
words standard Git repository setup in a location that isn't my
actual home directory.

My dotfiles in ~/ are actually symlinks back to that Git repository.
To update the symlinks I run the script below.  Its pretty simple,
it just merges to directories from the Git repository into my ~/
as dotfiles (the dot-* items) and into my ~/bin (the bin/* items).
So my Git repository looks like this:

  $ git ls-tree --abbrev=4 HEAD
  040000 tree 0d35        common
  040000 tree e033        host-asimov
  040000 tree 21c4        host-spearce-pb15.local
  100755 blob 0f2d        relink.sh

  $ git ls-tree --abbrev=4 HEAD:common/
  040000 tree cc76        bin
  100644 blob 371e        dot-bash_profile
  100644 blob e675        dot-bashrc
  100644 blob 1f0a        dot-gitconfig
  100644 blob 3d02        dot-ldaprc
  100644 blob 1d42        dot-vilerc

  $ git ls-tree --abbrev=4 HEAD:common/bin/
  100755 blob 7322        cherry-kill
  100755 blob 9ed5        fp
  100755 blob 89f2        genbibtex
  100755 blob 68be        newrepo
  100755 blob 3759        tkbibtex

  $ ls -l ~/.bashrc ~/bin/fp
  lrwxr-xr-x   1 spearce  spearce  41 Feb  3 23:05 /Users/spearce/.bashrc -> cgwork/HomeDir-DotFiles/common/dot-bashrc
  lrwxr-xr-x   1 spearce  spearce  40 Feb  3 23:05 /Users/spearce/bin/fp -> ../cgwork/HomeDir-DotFiles/common/bin/fp

Yea, it relies on the fact that I never use `git config --global`,
which apparently I've done recently as the damn thing isn't a symlink
like its supposed to be.  Uggh.  Its the *only* program on my system
that doesn't resolve the symlink and edit the file it points at.

-->--
#!/bin/sh

root=`dirname "$0"`
[ -d "$root" ] || {
	echo "error: Can't locate $0 in filesystem." >&2
	exit 1
}

cd "$root"
root=$(pwd)
root=$(echo "$root" | sed s:^$HOME/::)

if [ "X$HOSTTYPE" = Xpowerpc ]
then
	HOSTNAME=spearce-pb15.local
fi

dot_sources="common/dot-* host-$HOSTNAME/dot-*"
bin_sources="common/bin/* host-$HOSTNAME/bin/*"

echo "Linking from $dot_sources"
for src in $dot_sources
do
	if [ -e "$src" ]
	then
		dot_file=$(basename "$src" | sed s/^dot-/./)

		targ="$root/$src"
		dest="$HOME/$dot_file"

		if [ -L "$dest" ]
		then
			echo " U $dest -> $targ"
			rm -f "$dest"
			ln -s "$targ" "$dest"
			continue
		fi

		if [ ! -e "$dest" ]
		then
			echo " N $dest -> $targ"
			ln -s "$targ" "$dest"
			continue
		fi

		if [ -e "$dest" -a ! -e "$dest.bak" ]
		then
			echo " O $dest -> $targ"
			mv "$dest" "$dest.bak"
			ln -s "$targ" "$dest"
			continue
		fi

		echo " ! $dest -> $targ"
	fi
done
echo "done."

echo
echo "Linking from $bin_sources"
for src in $bin_sources
do
	if [ -e "$src" ]
	then
		bin_file=$(basename "$src")

		case "$root" in
		/*) targ="$root/$src";;
		*)  targ="../$root/$src"
		esac
		dest="$HOME/bin/$bin_file"

		mkdir -p "$HOME/bin"

		if [ -L "$dest" ]
		then
			echo " U $dest -> $targ"
			rm -f "$dest"
			ln -s "$targ" "$dest"
			continue
		fi

		if [ ! -e "$dest" ]
		then
			echo " N $dest -> $targ"
			ln -s "$targ" "$dest"
			continue
		fi

		if [ -e "$dest" -a ! -e "$dest.bak" ]
		then
			echo " O $dest -> $targ"
			mv "$dest" "$dest.bak"
			chmod a-x "$dest.bak"
			ln -s "$targ" "$dest"
			continue
		fi

		echo " ! $dest -> $targ"
	fi
done
echo "done."
-->--

-- 
Shawn.
