From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn init from Avogadro SVN repo - deleted files showing
Date: Thu, 13 Dec 2007 08:41:34 -0800
Message-ID: <20071213164134.GD18433@soma>
References: <475C8748.6000005@cryos.net> <20071210104235.GA7521@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Marcus D. Hanwell" <marcus@cryos.net>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2r8I-0000zW-Cm
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbXLMQlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 11:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbXLMQlg
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:41:36 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59040 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391AbXLMQlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:41:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CB90C7DC025;
	Thu, 13 Dec 2007 08:41:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071210104235.GA7521@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68176>

Peter Baumann <waste.manager@gmx.de> wrote:
> On Sun, Dec 09, 2007 at 07:24:40PM -0500, Marcus D. Hanwell wrote:
> > Hi,
> >
> > I am quite new to git and git-svn but have been using both for my 
> > development work recently. I imported the Avogadro subversion repository 
> > (hosted on Sourceforge) using the following commands,
> >
> > git svn init -t tags -b branches -T trunk 
> > https://avogadro.svn.sourceforge.net/svnroot/avogadro
> >
> > git svn fetch
> >
> >
> > The files avogadro.pro and README in the trunk/ directory appear in my 
> > imported git repository but not in Avogadro subversion trunk. We also had 
> > trunk/src/ and all its files/subdirectories appearing in the git checkout 
> > but not in subversion trunk. We deleted this using git and git svn which 
> > removed it from the git checkouts too after r858.
> >
> > I have been talking to Peter who confirmed this and pointed out that the 
> > repo was reorganised several times in the past. Please CC me on replies as 
> > I am not on the list. There is a copy of my git repo at 
> > http://platinum.cryos.net/avogadro.git/ if you would rather skip the 
> > import. Other than that everything has been working great. It would be good 
> > to get rid of this bug if possible. Let me know if there is anything else I 
> > can do to help.
> >
> 
> [ Eric Cc'ed, as the author of git-svn ]
> 
> I can confirm that this looks like an import problem.
> (e.g see svn log -v -r33:78 https://avogadro.svn.sourceforge.net/svnroot/avogadro)
> 
> I did my analysis on the file /trunk/avogadro.pro, because the error
> happens really early in the history so could just import up to revision 76
> to see what goes wrong. (The file gets never deleted in the import, as it
> should be!)
> 
> 
> 
> trunk/avogadro.pro is added here:
> 
>     ------------------------------------------------------------------------
>     r33 | dcurtis3 | 2006-08-21 07:34:10 +0200 (Mon, 21 Aug 2006) | 3 lines
>     Changed paths:
>        A /trunk/avogadro.pro
> 
>     Does a recursive build.
> 
> 
> Here the refactoring starts (a new directory not tracked by git is added):
>     ------------------------------------------------------------------------
>     r66 | dcurtis3 | 2007-01-03 06:42:45 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro
> 
>     Making room for libavogadro.
> 
> 
> /branches is moved to /avogadro/branches
>     ------------------------------------------------------------------------
>     r67 | dcurtis3 | 2007-01-03 06:47:11 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro/branches (from /branches:66)
>        D /branches
> 
>     Making room for libavogadro
> 
> 
> 
> 
> ERROR HAPPENS HERE:
> ====================
> 
> /trunk and /tags are moved, too.
> (/trunk/avogadro.pro becomes /avogadro/trunk/avogadro.pro):
>     ------------------------------------------------------------------------
>     r68 | dcurtis3 | 2007-01-03 06:47:34 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro/tags (from /tags:66)
>        A /avogadro/trunk (from /trunk:66)
>        D /tags
>        D /trunk
> 
>     Making room for libavogadro.
> 
> The above delete/move of trunk isn't recorded anywhere in the git svn import.
> 'git-svn find-rev r66' doesn't produce any output!
> And later git-svn thinks that /trunk and all its files are still there, so
> e.g. /trunk/avogadro.pro stays in the repo forever.

Hi,

Thanks for the analysis, Peter.

git-svn ignores deletions to the directory we're tracking in order to
represent renames when the follow-parent case is hit.

Unfortunately, this never took into account the directory we're tracking
reappearing later in history.  I'll try to have a fix later tonight or
over the weekend.

> mv /avogadro/trunk/avogadro.pro /trunk/avogadro/avogadro.pro
>    ------------------------------------------------------------------------
>     r75 | dcurtis3 | 2007-01-03 20:49:35 +0100 (Wed, 03 Jan 2007) | 2 lines
>     Changed paths:
>        D /avogadro
>        D /avogadro-lib
>        A /branches
>        A /tags
>        A /trunk
>        A /trunk/avogadro (from /avogadro/trunk:74)
>        A /trunk/libavogadro (from /avogadro-lib/trunk:74)
> 
>     Moving things around.  Conforming to a more KDE-like layout in SVN.
>     I'm going nuts.  SOrry

Instead of handling the full delete of everything in r68, I think I'll
make it so importing r75 will clobber all the stuff in trunk/ we ignored
deleting in r68 before adding the contents of trunk/ in r75.

-- 
Eric Wong
