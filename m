From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 11:18:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 20:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZX2m-0005jx-Q8
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWJPSS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWJPSS1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:18:27 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:21219 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422778AbWJPSS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 14:18:26 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F52DF> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 11:18:23 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28979>

On Mon, 16 Oct 2006, Linus Torvalds wrote:

> On Mon, 16 Oct 2006, Jim Meyering wrote:
> > 
> > That helps a little.
> > Now, instead of taking 63s, my test takes ~30s.
> > (32 for XDL_MAX_EQLIMIT = 16, 30 for XDL_MAX_EQLIMIT = 8)
> 
> Btw, what architecture is this on?
> 
> I'm testing those two files, and I get much more reasonable numbers with 
> both ppc32 and x86. Both 32-bit:
> 
> 	[torvalds@macmini test-perf]$ time git show | wc -l
> 	25221
> 
> 	real    0m1.437s
> 	user    0m1.436s
> 	sys     0m0.012s
> 
> ie it generated the diff in less than a second and a half. Not wonderful, 
> but certainly not your 63s either.
> 
> HOWEVER. On x86-64, it takes forever (still not 63 seconds, but it takes 
> 17 seconds on my 2GHz merom machine).
> 
> So I think there's something seriously broken with hashing on 64-bit. 
> 
> And I think I know what it is.
> 
> Try this patch. And make sure to do a "make clean" first, since I think 
> the dependencies on xdiff may be broken.
> 
> Davide: there's two things wrong with your old XDL_HASHLONG():
> 
>  - the GR_PRIME was just 32-bit, so it wouldn't shift low bits up far 
>    enough on a 64-bit architecture, so then shifting things down caused 
>    pretty much everything to be very small.
> 
>  - The whole idea of shifting up by multiplying and then shifting down to 
>    get the high bits is _broken_. Even on 32-bit architectures. Think 
>    about what happens when "hashbits" is 16 on a 32-bit architecture: the 
>    multiply moves the low bits _up_, but it doesn't move the high bits 
>    _down_. And with hashbits being a large fraction of the whole word, you 
>    need to shift things down, not up.
> 
> So just making GR_PRIME be a bigger value on a 64-bit architecture would 
> not have fixed it. The whole hash was simply broken. Do it the sane and 
> obvious way instead: always pick the low bits, but mix in upper bits there 
> too..

Yeah, using an appropriate golden ratio prime for 64 bits fixes it. I 
think it's the best/minimal fix (use 0x9e37fffffffc0001UL, like the 
kernel does).
I'm also looking into optimizing the multi-match discard loop, that 
actually loses the classifier informations collected in the context 
prepare phase.




- Davide
