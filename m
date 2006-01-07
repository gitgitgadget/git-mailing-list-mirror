From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Does git belong in root's $PATH?
Date: Sun, 8 Jan 2006 00:01:30 +0100
Message-ID: <20060107230130.GA8335@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg> <Pine.LNX.4.64.0601071023250.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 00:01:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvN4K-00067E-Md
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 00:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWAGXBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 18:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWAGXBt
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 18:01:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25873 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161046AbWAGXBs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 18:01:48 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id B93391EC316;
	Sun,  8 Jan 2006 00:01:44 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 11ADA43C054; Sun,  8 Jan 2006 00:01:31 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601071023250.3169@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14284>

On Sat, Jan 07, 2006 at 10:31:52AM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 7 Jan 2006, walt wrote:
> >
> > When updated my kernel this morning, the same way I've been doing
> > it for many months, I noticed that the -gxxxxxxx localversion
> > string was missing from the new kernel's name.
> > 
> > I finally figured out that this happened because /usr/local/bin
> > is not in my root's $PATH, and the setlocalversion script depends
> > on git.  (The only thing I do as root is 'make install').
> 
> Ok, sounds like a build buglet to me. If you've done a "make" as a regular 
> user, and just do a "make install" as root, I'd argue that the "make 
> install" should do as little as humanly possible, and literally just 
> install the kernel. If it starts changing the version, that sounds a bit 
> fishy.
> 
> Sam, anything we can do?
Today kbuild uses same method to build KERNELRELEASE no matter what
target is used, and I recently committed a change that used git tools as
replacement for direct manipulation with .git/*
What I did not realise was that we now require git during make install
time - which is obviously plain wrong.

I will try to look into a cleaner solution tomorrow where KERNELRELEASE
is fetched somewhere else during make install time.

> 
> That said:
> 
> > I suppose I'm asking a philosophical question here:  do you
> > guys install git where root can find it (as a system tool)?
> 
> I don't, but I don't use "make install" anyway, I just do "make 
> modules_install". I install the kernel by hand, I always have.
> 
> Of course, that's partly because I've always felt that "make install" does 
> too much (I think "make modules_install" is better - it really only 
> installs the already-built modules).
The big difference here is that "make modules_install" is part of
kbuild, whereas "make install" almost just call installkernel which is
distribution specific - and the distributions does all sort of stuff in
installkernel :-(

> 
> Maybe it would be best to remove the "vmlinux" dependency from "make 
> install" (so that "make install" will do exactly that: just install).  I 
> think all the documentation already tells you to do a "make" and then a 
> "make install".

I had a short chat with David Miller about something similar.
What I really liked to do was to tell user if vmlinux needed an update.
But the implmentation of kbuild does make this almost impossible - I
have at least not seen how to do it.

When I during early 2.6.12 removed the dependency on vmlinux from
the install target people were complaining that there scripts broke and
the solution that was implmented was a new target:
"make kernel_install" and "make install" got back the vmlinux
dependency.

Only difference between the two are that "make kernel_install" does NOT
have vmlinux as prerequisite. This was btw only done for i386 and
the only other architecture that have kernel_install is parisc with a
vmlinux dependency.


So no, I'm very unlikely to remove the vmlinux dependency from the
"make install" target - it results in too many suprises.

> 
> The other make targets really _are_ different: "make fdimage" depends on 
> vmlinux, but that's because it literally just builds the image. "make 
> install" is special.
> 
> Sam, what say you? I forget what the kbuild mailing list is, but maybe 
> you can forward this suggestion there..

These days it is named linux-kernel@vger.kernel.org ;-)
kbuild-devel@lists.sourceforge.net is seldom used though I still monitor
it. Talked with mec about discontinue it but he liked to keep it
araound. He is btw still moderator on that list filtering away all spam.

	Sam
