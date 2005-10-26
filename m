From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 12:15:52 -0400
Message-ID: <20051026161552.GA11483@delft.aura.cs.cmu.edu>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de> <86mzkwfh54.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de> <86irvkfg80.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 26 18:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUnwT-0002Rr-2W
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 18:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVJZQPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 12:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJZQPx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 12:15:53 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:20381 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S964805AbVJZQPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 12:15:53 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1EUnwP-0003zx-00
	for <git@vger.kernel.org>; Wed, 26 Oct 2005 12:15:53 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86irvkfg80.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10676>

On Wed, Oct 26, 2005 at 08:30:39AM -0700, Randal L. Schwartz wrote:
> >> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Johannes> What does your man page for link() say? If it is not 
> Johannes> supported, what value will be in errno?
> >> 
> >> EOPNOTSUPP
> 
> Interesting... google for "ENOTSUPP EOPNOTSUPP".  Apparently
> hits like this:
> 
> <http://sources.redhat.com/ml/bug-glibc/2002-08/msg00013.html>
> 
> shows that on some platforms, they may have both.  This is not as
> easy as it looks.  Maybe define an extra || condition to handle either
> or both?

It looks like glibc assumes that the kernel doesn't have ENOTSUP and
defines it as EOPNOTSUPP in <bits/errno.h>. So even if the kernel does
return different values, any glibc linked application probably wouldn't
be able to test for the ENOTSUP error.

Checking the SuSv2 manpage for link(2), it doesn't mention either of
these error codes. But does mention EPERM as a valid error when the
filesystem doesn't support hardlinks.
    http://www.opengroup.org/onlinepubs/007908799/xsh/link.html

My local manual page for link(2) agrees with that definition,

	EPERM  oldpath is a directory.

	EPERM  The  filesystem  containing oldpath and newpath does not support
	       the creation of hard links.

I also took a look at the Linux 2.4/2.6 kernel sources, and msdos, fat
and vfat all do not set a function for 'dir->i_op->link'. In that case,
vfs_link() will return EPERM.

So I don't know where ENOTSUP/EOPNOTSUPP would be coming from. From the
few places I looked, I don't think the original patch can be right. Not
sure yet if I want to change Coda's return value to EPERM as well, the
thing is that we do support hardlinks, just not between different
directories, but I guess EXDEV isn't really accurate either.

Jan
