From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Sun, 27 Aug 2006 15:35:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 00:38:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHTGd-0003Ki-B3
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 00:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWH0WiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 18:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWH0WiG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 18:38:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751231AbWH0WiE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 18:38:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7RMZLnW025076
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Aug 2006 15:35:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7RMZKKZ007505;
	Sun, 27 Aug 2006 15:35:20 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.433 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26125>



On Mon, 28 Aug 2006, Johannes Schindelin wrote:
> > 
> > Modifying git-convert-objects.c to rewrite the regular sha1 into a sha256 
> > should be fairly straightforward. It's never been used since the early 
> > days (and has limits like a maximum of a million objects etc that can need 
> > fixing), but it shouldn't be "fundamentally hard" per se.
> 
> But what about signed tags? (This issue has come up before, but never has 
> been adressed.)

Signed tags fundamentally have to be re-signed. That's by design: if 
somebody could rewrite an archive and signed tags would still be accepted 
to have the right signature, that would be a _serious_ sign of a totally 
broken security model.

The git security model isn't broken.

> I also thought about supporting hybrid hashes, i.e. that older objects 
> still can be hashed with SHA-1. Alas, a simple thought experiment 
> demonstrates how silly that idea is: most of the objects will not change 
> between two revisions, and they'd have to be rehashed with SHA-256 (or 
> whatever we decide upon) anyway, so hybrids would do no good.

Indeed. Hybrids would not only do no good, but they would actually 
_actively_ hurt things, because they'd fundamentally break the notion that 
the hash being identical means that the object (blob, tree, subtree) is 
the same.

So allowing two names for the same object is very fundamentally wrong in 
git-speak. 

> A better idea would be to increment the repository version, and expect 
> SHA-1 for version 1, SHA-256 for version >= 2.

Yes. It would be reasonably painful for users, though (as Krzysztof 
correctly points out). Every client would have to convert when a 
repository they track is converted.

> Even if the breakthrough really comes to full SHA-1, you still have to add 
> _at least_ 20 bytes of gibberish. Which would be harder to spot, but it 
> would be spotted.

Yeah, I don't think this is at all critical, especially since git really 
on a security level doesn't _depend_ on the hashes being cryptographically 
secure. As I explained early on (ie over a year ago, back when the whole 
design of git was being discussed), the _security_ of git actually depends 
on not cryptographic hashes, but simply on everybody being able to secure 
their own _private_ repository.

So the only thing git really _requires_ is a hash that is _unique_ for the 
developer (and there we are talking not of an _attacker_, but a benign 
participant).

That said, the cryptographic security of SHA-1 is obviously a real bonus. 
So I'd be disappointed if SHA-1 can be broken more easily (and I obviously 
already argued against using MD5, exactly because generating duplicates of 
that is fairly easy). But it's not "fundamentally required" in git per se.

[ The one exception: the "signed tags" security does depend on the hashes 
  being cryptographically strong. So again, breaking SHA-1 would not mean 
  that git stops working, but it _would_ potentially mean that if you 
  don't trust your own _private_ repository, the signed tag may no longer 
  protect you entirely ]

> This made me think about the use of hashes in git. Why do we need a hash 
> here (in no particular order):
> 
> 1) integrity checking,
> 2) fast lookup,
> 3) identifying objects (related to (2)),
> 4) trust.
> 
> Except for (4), I do not see why SHA-1 -- even if broken -- should not be 
> adequate. It is not like somebody found out that all JPGs tend to have 
> similar hashes so that collisions are more likely.

Correct. I'm pretty sure we had exactly this discussion around May 2005, 
but I'm too lazy to search ;)

		Linus
