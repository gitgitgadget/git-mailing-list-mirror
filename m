From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 14:35:45 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801251417380.5056@hp.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>  <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>  <4797095F.9020602@op5.se>  <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>  <4797518A.3040704@op5.se>
  <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>  <4798B633.8040606@op5.se>  <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>  <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org> <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>
 <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:36:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIXAE-00050L-VV
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 23:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbYAYWgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 17:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbYAYWgO
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 17:36:14 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57496 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754886AbYAYWgM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 17:36:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PMZkC8016043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2008 14:35:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PMZjNj004071;
	Fri, 25 Jan 2008 14:35:46 -0800
In-Reply-To: <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71746>



On Fri, 25 Jan 2008, Linus Torvalds wrote:
> 
> I can write a hash function that reliably does 8 bytes at a time for the 
> common case on a 64-bit architecture, exactly because it's easy to do 
> "test high bits in parallel" with a simple bitwise 'and', and we can do 
> the same with "approximate lower-to-uppercase 8 bytes at a time" for a 
> hash by just clearing bit 5.

Side note: you *can* get better approximations fairly cheaply if you care.

If you want to distinguish the characters 0-31 from the characters 31-63 
in your hash (pointless for filenames, but it can be worthwhile for some 
other string cases), you can decide to clear bit#5 only if bit#6 in that 
byte was also set, with just a few bitwise operations.

Eg, imagine that you have "unsigned long x" containing eight bytes of 
ascii data (ie you already did the test by 0x8080808080808080), you can do 
things like

	unsigned long bit6 = x & 0x4040404040404040;
	x &= ~(bit6 >> 1);

which will only clear bit5 if bit6 in the same byte was set..

So you can do tricks like that, and it will still be plenty fast. And 
nobody will ever care that while it collides 'A' with 'a' (by design), it 
also causes '{' and '[' to be considered "case collisions".

[ Amusing side note: '{' and '[' *are* case collisions in legacy 7-bit 
  "Finnish ASCII". The editor I use still "upper-cases" '{' to '['. I'm 
  not kidding, and yes, it really does it on purpose!

  It used to be that before everybody turned to Latin1, the {|} characters 
  were re-used in Finland (and Sweden, for that matter) for the 
  extra characters needed in Finnish. Because obviously nobody ever
  needed them for any real work.

  I (and probably every Finnish C UNIX programmer) used to be very good at 
  reading C source code even when it was full of odd finnish characters 
  with dots on top, instead of curly braces! ]

And yes, from a performance standpoint, things liek this probably do realy 
matter. For the kernel tree, the average pathname length is ~28 
characters. If you can do it with three iterations that do the first 24 
characters eight characters at a time, and then four iterations over the 
four last ones, rather than 28 iterations with byte->longword and 
multiplications in each, I bet it's quite visible.

Of course, it's going to be visible only if everything else is fast too, 
but git has been pretty good at that in general.

			Linus
