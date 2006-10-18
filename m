From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 09:52:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180938540.3962@g5.osdl.org>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172140270.1971@xanadu.home> <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172242430.17253@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610180752500.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610180845040.18388@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 18:53:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaEeu-0002GB-Eh
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 18:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWJRQwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 12:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWJRQwp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 12:52:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751362AbWJRQwn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 12:52:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IGqOaX000814
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 09:52:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IGqNqt009173;
	Wed, 18 Oct 2006 09:52:23 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610180845040.18388@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29247>



On Wed, 18 Oct 2006, Davide Libenzi wrote:
>
> Speaking in general, seen at the hash function level, of course an interface 
> should not give different result for different word sizes or word endianess. 
> Considering the diff algorithm as interface, as I said, the output was 
> unaffected by the 64 bits word size. It was just very slow.

Well, even the output may actually be affected, in the case of _real_ hash 
collisions (as opposed to just the hash _list_ collision that XDL_HASHLONG 
caused).

So I actually think it would be better to have "uint32_t" as the hash 
value - because that would mean that all diffs (or, in the case of the 
block-algorithm, the deltas) are guaranteed to give the same results 
regardless of architecture.

Right now, we actually generate a 64-bit hash value (BUT: for short lines, 
it's likely only _interesting_ in the low bits, so the high bits tend to 
have a very high likelihood of being zero). So hash collisions are 
different: on a 32-bit architecture, two lines may have the same hash, 
while on a 64-bit one, they are different.

And together with some of the limiters we have (eg XDL_MAX_EQLIMIT) hash 
collisions can sometimes affect the output.

Admittedly, in _practice_ this is really unlikely to affect anything 
(you'd get a valid diff in either case, they'd just possibly be subtly 
different, and the input data must be _really_ strange to even see that 
case), but I do think that the hash algorithm can matter.

NOTE! I'm not talking about XDL_HASHLONG(), I'm talking about the 
xdl_hash_record() hash, which returns differently-sized hash results on 
32-bit and 64-bit. And there are cases where we _only_ compare the hashes, 
and don't actually double-check the contents.

So I think that in _practice_ you can't see differences between a 32-bit 
version and a 64-bit one, but the possibility is there. Using "uint32_t" 
instead of "unsigned long" to keep track of hashes would avoid that 
theoretical problem (and might actually make for better performance on 
64-bit archtiectures, if only because of denser data structures and thus 
better cache behaviour).

			Linus
