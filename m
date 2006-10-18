From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 14:21:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181407040.18885@alien.or.mcafeemobile.com>
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
 <Pine.LNX.4.64.0610180938540.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:22:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaIrY-0006gF-CN
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422981AbWJRVWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422986AbWJRVWE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:22:04 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:20098 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422981AbWJRVWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:22:01 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F5CF5> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 18 Oct 2006 14:21:58 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610180938540.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29269>

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> On Wed, 18 Oct 2006, Davide Libenzi wrote:
> >
> > Speaking in general, seen at the hash function level, of course an interface 
> > should not give different result for different word sizes or word endianess. 
> > Considering the diff algorithm as interface, as I said, the output was 
> > unaffected by the 64 bits word size. It was just very slow.
> 
> Well, even the output may actually be affected, in the case of _real_ hash 
> collisions (as opposed to just the hash _list_ collision that XDL_HASHLONG 
> caused).
> 
> So I actually think it would be better to have "uint32_t" as the hash 
> value - because that would mean that all diffs (or, in the case of the 
> block-algorithm, the deltas) are guaranteed to give the same results 
> regardless of architecture.
> 
> Right now, we actually generate a 64-bit hash value (BUT: for short lines, 
> it's likely only _interesting_ in the low bits, so the high bits tend to 
> have a very high likelihood of being zero). So hash collisions are 
> different: on a 32-bit architecture, two lines may have the same hash, 
> while on a 64-bit one, they are different.
> 
> And together with some of the limiters we have (eg XDL_MAX_EQLIMIT) hash 
> collisions can sometimes affect the output.
> 
> Admittedly, in _practice_ this is really unlikely to affect anything 
> (you'd get a valid diff in either case, they'd just possibly be subtly 
> different, and the input data must be _really_ strange to even see that 
> case), but I do think that the hash algorithm can matter.
> 
> NOTE! I'm not talking about XDL_HASHLONG(), I'm talking about the 
> xdl_hash_record() hash, which returns differently-sized hash results on 
> 32-bit and 64-bit. And there are cases where we _only_ compare the hashes, 
> and don't actually double-check the contents.

The hash value (hence the hash bucket index) simply directs you to the 
bucket where a real record-compare loop is performed. Collisions here 
means only performance loss (you don't spread buckets enough), nothing 
more. So the different behaviour does not apply to the diff algo.
But, it would apply if the knowledge of the hash indexing would be 
"exported", for example inside an external file. Think about a trivial DB 
file where you store hash buckets on file an you want to lookup records 
based on the store hash layout. In that case, of course, if the hash 
function that generated the DB bucket layout is different from the one 
that you use to get the bucket index at lookup time, you're in trouble.
IOW if the hash function result is not "exported" is some way, it doesn't 
really matter if it's an 'unsigned long' or a 'uint32_t'. In the same way 
you cannot export binary structures using 'int' or 'long', and expect to 
be compatible over different architectures.



- Davide
