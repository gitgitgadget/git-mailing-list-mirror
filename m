From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Thu, 6 Apr 2006 01:27:39 +0200
Organization: M38c
Message-ID: <20060405232739.GA18121@nospam.com>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com> <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org> <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org> <fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com> <Pine.LNX.4.63.0604051612200.25304@wbgn013.biozentrum.uni-wuerzburg.de> <20060405210844.GN26780@trixie.casa.cgf.cx>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 06 01:28:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRHPz-0006kf-Le
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 01:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWDEX14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 19:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWDEX14
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 19:27:56 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:6634 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750971AbWDEX14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 19:27:56 -0400
Received: from wingding.demon.nl ([82.161.27.36]:57652)
	by post-25.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FRHPg-0008Zj-VN; Wed, 05 Apr 2006 23:27:49 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FRHPY-00054Z-AN; Thu, 06 Apr 2006 01:27:42 +0200
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060405210844.GN26780@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18460>

On Wed, Apr 05, 2006 at 05:08:44PM -0400, Christopher Faylor wrote:
> On Wed, Apr 05, 2006 at 04:14:20PM +0200, Johannes Schindelin wrote:
> >> Inspired by a patch of Alex Riesen (thanks, Alex), I tried to use the
> >> regular mmap for mapping pack files, only to discover that I compile
> >> without defining "NO_MMAP", so I've been using the stock mmap all
> >> along. So now I'm thinking that the cygwin mmap also does a
> >> malloc-and-read, just like git does with NO_MMAP. So I'll continue to
> >> investigate in that direction.
> >
> >I think cygwin's mmap() is based on the Win32 API equivalent, which could 
> >mean that it *is* memory mapped, but in a special area (which is smaller 
> >than 1.5 gigabyte). In this case, it would make sense to limit the pack 
> >size, thereby having several packs, and mmap() them as they are needed.
> 
> Yes, cygwin's mmap uses CreateFileMapping and MapViewOfFile.  IIRC,
> Windows might have a 2G limitation lurking under the hood somewhere but
> I think that might be tweakable with some registry setting.

Windows places its DLLs criss-cross through the memory space because
every DLL on the system has its own preferred place to be loaded (the
base address). This severely limits the amount of largest contiguous
memory block available, which is needed for one mmap() I think.

Several solutions exist:
  - enlarge the address space with the /3GB boot flag in boot.ini
  - rebase all DLLs with REBASE.EXE (part of platform sdk) .
    Just make them the same and fix them to a low address.
    Problem is rebasing system dlls since those are locked by the system.
  - at start of program before other DLLs are loaded,
    reserve an as large part of the memory as possible with
    VirtualAlloc()

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
