From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sun, 24 Dec 2006 02:23:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612240159270.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
 <20061223073428.GL9837@spearce.org> <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org>
 <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612231207400.3671@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Dec 24 02:24:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyI5r-0007Cy-EZ
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 02:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbWLXBX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 20:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbWLXBX7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 20:23:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:51705 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754061AbWLXBX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 20:23:58 -0500
Received: (qmail invoked by alias); 24 Dec 2006 01:23:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 24 Dec 2006 02:23:56 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612231207400.3671@woody.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35335>

Hi,

On Sat, 23 Dec 2006, Linus Torvalds wrote:

> On Sat, 23 Dec 2006, Junio C Hamano wrote:
> > 
> > I have been thinking that we should perhaps change Cygwin
> > default to NO_MMAP.  Safer but slower would be better than not
> > working correctly for people on FAT32.
> 
> The thing is, with a smaller pack access window, it might not even be 
> slower. I don't know just _how_ many hoops cygwin jumps through for mmap, 

AFAIK Windows API _does_ have an equivalent to mmap(), which just is not 
as easy to use.

[/me asks my friend Google]

Yes. The function is called CreateFile(), and it takes a _filename_, not a 
file descriptor. Which does not matter much, since Windows is braindead 
enough not to be able to have files deleted which are still opened. Mind 
you, renaming is no problem...

So, Cygwin has to keep record of the file name (and AFAICT it necessarily 
fails if mmap() is called with a file descriptor of a file which has been 
renamed _externally_ after opening) of the file descriptor.

Cygwin also has to reopen after a fork(), since Windows does not have 
fork(), and it has to be simulated by a CreateProcess() and reestablishing 
existing resources. That is the reason a fork() is really, really 
expensive on Windows.

> and maybe mmap under cygwin is actually perfectly fine, but at the same 
> time I do suspect that UNIX mmap semantics are a lot harder to emulate 
> than just a regular "pread()", so it's quite possible that by avoiding 
> mmap you could avoid a lot of complex cygwin code.

But should we really cater for a braindead API?

At the time, I _hated_ the fact that we had to change HEAD into a regular 
file, just because people feared that Windows could not handle symbolic 
links (and mind you, Cygwin handles them quite gracefully, using .lnk 
files).

Besides, IIRC you said yourself that mmap() is better than pread() when 
seeking a lot. And pack file accesses _are_ the perfect example for such a 
use case, no?

> And yes, making it all work on FAT32 would obviously be a good thing.

If really needed, we could make a hack for Windows, which just adds a new 
config option automagically set by init-db (on Windows only), and which is 
checked in gitfakemmap() and gitfakeunmmap(). (BTW I don't like the naming 
anymore; a good cleanup would be to name them git_mmap() and 
git_unmmap()).

Having said that, if somebody is really dedicated to working on Windows, 
she could overcome the mentioned problems. There's got to be a way to 
avoid the error on FAT32 without using NO_MMAP. Don't look at me, I hate 
Windows, I will not fix it.

Ciao,
Dscho
