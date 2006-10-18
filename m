From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 15:34:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181527350.18885@alien.or.mcafeemobile.com>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172140270.1971@xanadu.home> <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172242430.17253@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610180752500.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610180845040.18388@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610180938540.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181407040.18885@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610181434510.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:35:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaK03-0003MD-32
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945897AbWJRWez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945895AbWJRWez
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:34:55 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:22658 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1945898AbWJRWey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 18:34:54 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F5D35> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 18 Oct 2006 15:34:36 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610181434510.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29293>

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> 
> 
> On Wed, 18 Oct 2006, Davide Libenzi wrote:
> > 
> > The hash value (hence the hash bucket index) simply directs you to the 
> > bucket where a real record-compare loop is performed.
> 
> As far as I can tell not all loops do a real "record-compare" thing.
> 
> Some of the hash loops _only_ look at the hash, and as such a bad hash 
> will do more than just cause bad performance, it will actually degrade the 
> diff itself. Isn't that what XDL_MAX_EQLIMIT effectively does?

The XDL_MAX_EQLIMIT is used to limit the search for equal records, in the 
record-discard phase. Note though, that at that point that "ha" value is a 
record-class ID (every different record/line in the input has a unique ID).
Look at what xdl_classify_record() does. So in that case, XDL_HASHLONG can 
really simply be a bitmask. So comparing "ha" in the loop in there, does 
actually the right thing in any case (equal "ha" means really equal 
record).



> Btw, the binary delta generator doesn't seem to have this issue at all: it 
> uses "unsigned int" for the hash values, so the xdiff delta generation 
> will give the same exact results on 32-bit and 64-bit architectures.
> 
> Or was that one of the changes by Nico? (I only looked at the git version 
> of that code)

The binary diff in libxdiff uses a chaining hash, so even in that case it 
wouldn't have made a difference. I think Nico changed the hash to be a 
coalesced hash, and in that case it does change the output.




- Davide
