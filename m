From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui not working in a non-default Cygwin installation.
Date: Sun, 17 Feb 2008 03:02:55 -0500
Message-ID: <20080217080255.GQ24004@spearce.org>
References: <fp5fdj$5fi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jurko =?utf-8?Q?Gospodneti=C4=87?= <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Sun Feb 17 09:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQeUq-0008M4-En
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 09:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYBQIDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 03:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753143AbYBQIDA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 03:03:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51067 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbYBQIC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 03:02:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JQeUB-0007z2-95; Sun, 17 Feb 2008 03:02:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4690420FBAE; Sun, 17 Feb 2008 03:02:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <fp5fdj$5fi$1@ger.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74102>

Jurko Gospodneti <jurko.gospodnetic@docte.hr> wrote:
>   I am unsure whether this is the right group for asking this question 
> and if it is not please excuse me and/or redirect me to a more suitable one.

This is a pretty good place to start for all things Git related.  :)
 
>   One of these is that it seems that with the latest git release the 
> git-gui script changed and started hardcoding some absolute paths in it 
> during its build (git-gui/Makefile replaces @@GITGUI_SCRIPT@@ with a 
> hardcoded path). However, this causes the prebuilt Cygwin package to not 
> work in case Cygwin is not installed in its default location at 
> C:\Cygwin (e.g. D:\Cygwin or C:\Program Files\Cygwin).
> 
>   Everything works fine if you manually edit the git-gui script and 
> change the hard-coded path defined there.
> 
>   Is there something I'm missing here? E.g. is there any way for the 
> Cygwin installation to set the correct path here? Or is the user 
> supposed to modify this by hand on every installation? If this is so, 
> then what other such files are expected to be modified?

Gaaaaah.

This is not what I had intended to have happen.  Users should not
need to edit binary package files post installation to make things
work correctly.

There's a lot of people I could try to point fingers at for this,
but I think its all mine.  :-\

First, let me point out that Cygwin's Tcl/Tk is stuck on 8.4.1 and
will probably never get updated again.  I have had some bugs with
git-gui on 8.4.1 on Windows where git-fetch/git-push processes
get hung and don't function correctly.  Upgrading Tcl/Tk to the
native Windows binaries of version 8.4.15 resolves the problem,
but that binary cannot handle Cygwin paths and Cygwin mount points.

Cygwin gets around needing to embed absolute paths into binary
files at build time by using the mount point feature to relocate
those paths onto the user's system.  Thus '/' can be D:\Cygwin on
your system and C:\Program Files\Cygwin on mine.  Executables linked
against the Cygwin library can still function just fine, but native
Win32 programs (like Tcl/Tk 8.4.15) can't.

git-gui assumes its going to be running on a newer (and more stable)
Tcl/Tk so its build process embeds the Windows path into the script.
*sigh*

I'll have to figure out on Cygwin if the $TCL_PATH I'm using is
able to resolve Cygwin absolute paths or not, and then build the
script accordingly.  Fun.

I'll try to work up a Makefile patch in the next few days and get
it into a gitgui-0.9.3 maint release, which will probably roll up
into git 1.5.4.3.

-- 
Shawn.
