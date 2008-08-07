From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: git filter-branch --subdirectory-filter, still a mistery
Date: Thu, 7 Aug 2008 12:14:25 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200808071214.25399.J.Wielemaker@uva.nl>
References: <200808061539.50268.J.Wielemaker@uva.nl> <200808070950.23754.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BssmIdokK6psaZ4"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR4sY-0006Ca-MW
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbYHGMor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 08:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYHGMor
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:44:47 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:41903 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbYHGMoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 08:44:46 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Aug 2008 12:15:12 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200808070950.23754.trast@student.ethz.ch>
X-OriginalArrivalTime: 07 Aug 2008 10:15:12.0814 (UTC) FILETIME=[7AAE6CE0:01C8F876]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91576>

--Boundary-00=_BssmIdokK6psaZ4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Thomas,

On Thursday 07 August 2008 09:50:03 am Thomas Rast wrote:
> Jan Wielemaker wrote:
> [...]
>
> > 	% git filter-branch --subdirectory-filter packages/chr HEAD
> >
> > This indeed creates a nice directory holding only the contents of
> > packages/chr.  But, starting qgit I see that all commits, also those
> > that had absolutely nothing to do with this dir are still there.
>
> The trick is to rewrite all refs, not just HEAD.  I usually proceed as
> follows:
>
>   cp -a repo repo.old  # just to keep a backup
>   cd repo
>   git filter-branch --subdirectory-filter somedir -- --all
>
> The --all tells it to rewrite as many refs as possible.  Note that the
> -- is required.  Also note that refs/original/* will still point to
> the old commits, so they won't "just vanish".  You may want to clone
> the repository or delete them manually once you are sure the
> filter-branch did the right thing.

Thanks. That is moving in the right direction! There are some, possibly
related, problems left (using 1.5.6.GIT).  According to git fsck,
my repo is clean.  I got:

  Ref 'refs/tags/V5.6.50' was rewritten
  error: Ref refs/tags/V5.6.50 is at 8678b32f71178019c06aefa40e2d3fb9a2e8ef25 
but
	expected 2e8aef64e2fed088720a19ac2ffa2481e5bc7806
  fatal: Cannot lock the ref 'refs/tags/V5.6.50'.
  Could not rewrite refs/tags/V5.6.50

Now, if I look in .git/packed-refs, I see this (i.e. a second line with
a ^) for all refs that cause problems:

274ec8ac671542206ba3567ff5d72b3e54c5603c refs/tags/V5.6.59
^28920c3c0a184698d9cd15a65cd643367200bbf5
faf203f9d9e350d84b6b38b7746e710b6232fc97 refs/tags/V5.6.58
^1edb1adedcc47ec15c3242234cc6b7ede94bbfba
48488c871227beabcb3ba167b737d6e33ced65bc refs/tags/V5.6.57
^766587b09e3d2f09c87b03ad0d7faf3529c9dcff

After a bit of puzzling I discovered the the SHA1 after the ^ refers to
the actual commit and I changed all these to `lightweight' tags by
putting the SHA1 behind ^ before the tag itself.  I wrote a little
sh/awk script to automate this (attached).

Now it runs to the end.  Unfortunagtely the history is completely
screwed up :-(:

	* There are a lot of commits that are not related to the dir
	* Commits start long before the directory came into existence,
	Looks like it just shows the whole project at this place.

I think the problem is related to the fact that the directory I want to
filter didn't exists at the start of the project. Looking at
git-rev-list, I found --remove-empty, so I added that after the --all,
but that doesn't appear to help.  I must admit I don't really know what
I'm doing (though I still think the result I want it well defined and
its hard to imagine I'm the only person who wants this).

If someone wants to help: clone git://gollem.science.uva.nl/home/git/pl.git
and try to filter the dir packages/chr.  You can browse the git at
http://gollem.science.uva.nl/git/pl.git

	Thanks --- Jan


--Boundary-00=_BssmIdokK6psaZ4
Content-Type: application/x-shellscript;
  name="git-lightweight-tags"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-lightweight-tags"

#!/bin/bash -f

if [ -f .git/packed-refs ]; then
    cp -p .git/packed-refs .git/packed-refs.orig;
    if awk -- '
BEGIN	{ saved="";
	}
/^#/	{ if ( saved != "" )
	  { print saved; saved="";
	  };
	  print;
	  next;
	}
/^\^/	{ commit=substr($0, 2);
	  split(saved, a);
	  print commit, a[2];
	  saved="";
	  next;
	}
	{ if ( saved != "" ) { print saved };
	  saved=$0;
	  next;
	}
END	{ if ( saved != "" )
	  { print saved;
	  }
	}' .git/packed-refs > .git/packed-refs.light; then
	mv .git/packed-refs .git/packed-refs.orig
	mv .git/packed-refs.light .git/packed-refs
    else
	rm .git/packed-refs.light
	exit 1
    fi
else
    echo "Cannot find .git/packed-refs"
    exit 1
fi

--Boundary-00=_BssmIdokK6psaZ4--
