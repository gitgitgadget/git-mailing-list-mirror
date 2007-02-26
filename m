From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problems installing as root
Date: Sun, 25 Feb 2007 21:10:53 -0500
Message-ID: <20070226021053.GB1884@spearce.org>
References: <erpljl$ln9$1@sea.gmane.org> <20070225061258.GA1415@spearce.org> <ersapr$bu5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 03:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLVKW-0001gg-MM
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 03:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXBZCLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 21:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXBZCLF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 21:11:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38727 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbXBZCLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 21:11:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLVKD-0007JB-TD; Sun, 25 Feb 2007 21:10:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1BD9B20FBAE; Sun, 25 Feb 2007 21:10:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <ersapr$bu5$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40604>

walt <wa1ter@myrealbox.com> wrote:
> Shawn O. Pearce wrote:
> > walt <wa1ter@myrealbox.com> wrote:
> >> First, 'make install' as root leaves dozens of files owned by root
> >> in my personal source directory.
> 
> > Which files, specifically? ...
> 
> ~/src/git $find . -user 0
> ./git-fsck-objects
...+100 files...

This is caused by below...

> >> Second, this is a more recent problem with 'make install':
> >> make -C git-gui all
> >> make[1]: Entering directory `/usr/local/mnt/wa1ter/src/git/git-gui'
> >> GITGUI_VERSION = 0.6.GITGUI
> 
> > Hmm.  You can't get the right version number for git-gui.  Do you
> > have tags fetched?
> 
> Oops.  I stupidly forgot to tell you the reason for the failure
> when running the script as root:  /usr/local is not in root's path,
> and thus /usr/local/bin/git-* can't be found.  Since the script
> assumes that git is already installed and working, I would guess
> that it would also fail if I had just fetched Junio's repository
> for the first time and attempted an initial install.

Right.  So what is happening is the toplevel Makefile tries to run
GIT-VERSION-GEN to obtain the version, that calls git-describe,
which does not exist, fails, and falls back on the hardcoded version
number.  That version number differs from what the software was
compiled with, so it gets recompiled.  Instant set of +100 files
owned by root.

Same issue happens down inside of git-gui.

I think the only answer I have for you is the following:

  If you want to run the Makefile without having git in your path
  then make a tarball first (make dist) with Git in your path,
  then unpack the tarball and compile that.

  This works as the tarball embeds version and credits files that
  sidestep the need for git-describe.

-- 
Shawn.
