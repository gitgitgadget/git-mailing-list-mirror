From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Mon, 27 Apr 2009 18:11:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904271800360.7741@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 18:12:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTR5-00035j-7o
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbZD0QLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZD0QLx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:11:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:50883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751763AbZD0QLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 12:11:53 -0400
Received: (qmail invoked by alias); 27 Apr 2009 16:11:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp035) with SMTP; 27 Apr 2009 18:11:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RUb0cEusRFZFetNBw/NEqGaRJILzLCQtF0cBnb9
	EgeNVeDuN/XVWN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117683>

Hi,

On Mon, 27 Apr 2009, Linus Torvalds wrote:

> On Mon, 27 Apr 2009, Johannes Schindelin wrote:
> > 
> > So, force the use of rename() instead of the link() && unlink() 
> > incantation on Windows, and for good measure, add a 
> > core.unreliableHardlinks option to optionally force it on other 
> > platforms, too.
> 
> Ok, so:
> 
> 	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> but I do think it could be improved. See below..

Sorry, I missed the fact that Junio already applied and pushed it to 
'next'.

> > 	Junio, do you want me to remove the config variable?
> 
> I'd keep it. But I'd suggest that the naming is odd. Why talk about 
> "unreliable hardlinks", when that's just a particular symptom. Why not 
> just talk about whether hardlinks should be used or not?
> 
> And to avoid double negative, make it
> 
> 	[core]
> 		usehardlinks = true/false
> 
> and then default it to 'true' for Unix.

Or maybe core.preferRenameOverLink?  Then we have no negation either.

> The thing is, maybe people would prefer to use 'rename' over the 
> link/unlink games even on some unixes, and not because of 'reliability' 
> issues, but because they may have some filesystems that don't do 
> hardlinks, and they'd just rather speed things up by avoiding the 'link()' 
> system call that will just error out.

We already fall back to renaming when another error than EEXIST is 
returned from link(), so I think this case is covered.

> So naming matters. Calling it 'unreliablehardlinks' in that case would 
> be odd. They're not unreliable - you just don't want to try to use them.
> 
> I also do wonder if we could/should make this one of those options that 
> get set automatically at 'git init' time, rather than silently hardcoded 
> as a compile option. I thought hardlinks at least sometimes worked fine on 
> Windows too, don't they? 

I thought about that long and hard, and I decided against it.  Take my 
NTFS-formatted portable hard drive (for convenience with Windows users 
@work) for example: the ufsd driver is totally broken, but because it is a 
major investment of time to get my EeePC to work with a sane Linux 
distribution, I'd rather keep using the ufsd driver.  Yet, when I use 
ntfs-3g from the other laptop, it works fine.

See?  It is not a file system specific error, but a fs/os combo problem.

> I do detest _hidden_ default values for config options, unless those 
> hidden defaults are "obviously always correct" as a default. This one 
> smells a bit uncertain, and as a result I think it's ok to default to 
> not using hardlinks, but doing it with .gitconfig would be nicer.

I fully agree on hidden default values, albeit in this case, it is 
necessary: the hard links work just fine on Windows XP here, but that 
might just be a matter of not upgrading to a newer service pack.

Ciao,
Dscho
