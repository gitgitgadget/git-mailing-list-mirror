From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 00:02:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 00:03:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSiY-0006UK-D8
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 00:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWH0WCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 18:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWH0WCm
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 18:02:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:4296 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751212AbWH0WCl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 18:02:41 -0400
Received: (qmail invoked by alias); 27 Aug 2006 22:02:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 28 Aug 2006 00:02:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26121>

Hi,

On Sun, 27 Aug 2006, Linus Torvalds wrote:

> On Sun, 27 Aug 2006, Krzysztof Halasa wrote:
> > 
> > > Maybe sha-256 could be considered for the next major-rev of git?
> > 
> > Not sure, but _if_ we want it we should do it sooner rather than
> > later.
> 
> Modifying git-convert-objects.c to rewrite the regular sha1 into a sha256 
> should be fairly straightforward. It's never been used since the early 
> days (and has limits like a maximum of a million objects etc that can need 
> fixing), but it shouldn't be "fundamentally hard" per se.

But what about signed tags? (This issue has come up before, but never has 
been adressed.)

I also thought about supporting hybrid hashes, i.e. that older objects 
still can be hashed with SHA-1. Alas, a simple thought experiment 
demonstrates how silly that idea is: most of the objects will not change 
between two revisions, and they'd have to be rehashed with SHA-256 (or 
whatever we decide upon) anyway, so hybrids would do no good.

A better idea would be to increment the repository version, and expect 
SHA-1 for version 1, SHA-256 for version >= 2.

However, I could imagine that we do not need this huge change (it would 
break _many_ setups). The breakthrough was announced last Tuesday, and it 
involved 75% payload, i.e. to fake a new -- say -- git.c, one would need 
to enlarge git.c by a factor 4, and you would see a lot of gibberish 
inside some comment. (Note that I did not listen to the talk myself, this 
is all deducted from the scarce information which is available via the 
'net.)

Even if the breakthrough really comes to full SHA-1, you still have to add 
_at least_ 20 bytes of gibberish. Which would be harder to spot, but it 
would be spotted.

This made me think about the use of hashes in git. Why do we need a hash 
here (in no particular order):

1) integrity checking,
2) fast lookup,
3) identifying objects (related to (2)),
4) trust.

Except for (4), I do not see why SHA-1 -- even if broken -- should not be 
adequate. It is not like somebody found out that all JPGs tend to have 
similar hashes so that collisions are more likely.

And thinking about trust: The hash is augmented by thinking persons. It is 
not like you blindly trust a person forever. You build up trust, and once 
you were failed, the trust is lost, and very hard to build up again. So, 
you just would try to get all objects again from somebody you still trust, 
and never pull from the loser^H^H^H^H^Huntrusted person again. Ever.

Besides, as has been pointed out several times, a dishonest person could 
try to sneak bad code into your repository _regardless_ of a secure hash.

So: Do we really need a secure hash, or do we need an adequate hash, and 
just happen to use one which was intended as a secure hash, but no longer 
is?

Ciao,
Dscho
