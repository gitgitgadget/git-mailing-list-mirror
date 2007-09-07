From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 18:09:07 +0200
Message-ID: <85ejha5ufw.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
	<46E0EEC6.4020004@op5.se>
	<Pine.LNX.4.64.0709071155570.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITgOh-0002W4-Qm
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbXIGQJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbXIGQJS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:09:18 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:38178 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965027AbXIGQJR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 12:09:17 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 743FA27B27F;
	Fri,  7 Sep 2007 18:09:16 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 5C03C13F2C3;
	Fri,  7 Sep 2007 18:09:16 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-212.pools.arcor-ip.net [84.61.39.212])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id EB2331C368A;
	Fri,  7 Sep 2007 18:09:07 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9683E1CAD71B; Fri,  7 Sep 2007 18:09:07 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709071155570.28586@racer.site> (Johannes Schindelin's message of "Fri\, 7 Sep 2007 11\:56\:42 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4178/Fri Sep  7 10:54:58 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58045>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 7 Sep 2007, Andreas Ericsson wrote:
>
>> Wincent Colaiuta wrote:
>> > El 7/9/2007, a las 2:21, Dmitry Kakurin escribi?:
>> > 
>> > > I just wanted to get a sense of how many people share this "Git should
>> > > be in pure C" doctrine.
>> > 
>> > Count me as one of them. Git is all about speed, and C is the best choice
>> > for speed, especially in context of Git's workload.
>> > 
>> 
>> Nono, hand-optimized assembly is the best choice for speed. C is just
>> a little more portable ;-)
>
> I have a buck here that says that you cannot hand-optimise assembly
> (on modern processors at least) as good as even gcc.

That assumes that the original task can even expressed well in C.
Multiple precision arithmetic, for example, requires access to the
carry bit.  You can code around this, for example by writing something
like

unsigned a,b,carry;

[...]

carry = (a+b) < a;

but the problem is that those are ad-hoc idioms with a variety of
possibilities, and thus the compilers are not made to recognize them.
Another thing is mixed-precision multiplications and divisions: those
are _natural_ operations on a normal CPU, but have no representation
in assembly language.

As a consequence, most high performance multiple-precision packages
contain assembly language in some form or other.

gcc's assembly language template are excellent in that they actually
cooperate nicely with the optimizer, so the optimizer can do all the
address calculations and register assignments and opcode reorderings,
and then the actual operations that are not expressible in C can be
done by the programmer.

But anyway, I have worked as a graphics driver programmer for some
amount of time, and bit-stuffing memory-mapped areas with data was
still something where hand assembly was best.

I have also done BIOS terminal emulators, and being able to write
something like

ld b,whatever
myloop:
push bc
push hl
call nextchar
pop hl
pop bc
ld (hl),a
inc hl
djnz myloop

in order to suspend the terminal driver until the application comes up
with the next `whatever' output characters in an escape sequence is
_wagonloads_ more maintainable than using a state machine or whatever
else for distributing material delivered into the driver.

But this requires that nextchar can do something like
nextchar: ld (driverstack),sp
  ld sp,(appstack)
  ret

and the entrypoint, in contrast, does

outchar: ld (appstack),sp
  ld sp,(driverstack)
  ret

Cheap and expedient.  You just need to set up a small stack, and
presto: coroutines, at absolutely negligible cost.  I know that there
are some "portable" coroutine implementations that use setjmp/longjmp
in a rather horrific way, but those are way more unnatural.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
