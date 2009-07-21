From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: encrypted repositories?
Date: Tue, 21 Jul 2009 10:25:50 +0200
Message-ID: <op.uxesdcu41e62zd@merlin.emma.line.org>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
 <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
 <op.uxc712eh1e62zd@balu.cs.uni-paderborn.de>
 <20090720153024.GD5347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 21 10:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTAfj-000502-CS
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 10:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbZGUIZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 04:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZGUIZz
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 04:25:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:52933 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750807AbZGUIZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 04:25:54 -0400
Received: (qmail invoked by alias); 21 Jul 2009 08:25:52 -0000
Received: from g227137121.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.227.137.121]
  by mail.gmx.net (mp048) with SMTP; 21 Jul 2009 10:25:52 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/SwLMjr0TSHLvR2d/z2eZv9YnXrekD0Pj5NYv5am
	AgmQdCZFTYto8I
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id A246C94BB0;
	Tue, 21 Jul 2009 10:25:50 +0200 (CEST)
In-Reply-To: <20090720153024.GD5347@coredump.intra.peff.net>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123651>

Am 20.07.2009, 17:30 Uhr, schrieb Jeff King <peff@peff.net>:

> On Mon, Jul 20, 2009 at 02:09:28PM +0200, Matthias Andree wrote:
>
>> No, the server can't be allowed access to the keys or decrypted data.
>>
>> I'm not sure about the graph, and if I should be concerned. Exposing
>> the DAG might be in order.
>>
>> It would be ok if the disk storage and the over-the-wire format
>> cannot use delta compression then. It would suffice to just send a
>> set of objects efficiently - and perhaps smaller revisions can be
>> delta-compressed by the clients when pushing.
>
> The problem is that you need to expose not just the DAG, but also the
> hashes of trees and blobs. Because if I know you have master^, and I want
> to send you master, then I need to know which objects are referenced by
> master that are not referenced by master^.

Yes, you need to know that.  Not all of the push logic needs to be  
implemented on the server though.

In my scenario, the server degenerates into sort of a general object store  
- I really don't expect much smartness there. What is easily available  
(clients providing deltas rather than full objects) could be exploited,  
and that's it.

We can always have two local repositories, one reference and one checkout.  
The reference is a decrypted (unencrypted) copy of the set of objects on  
the server, and I could use that for tracking the server-side view (for  
instance, what are master^ and master pointing at so I can derive git  
rev-list master^...master, what do I need to send to the server).

I'm well aware that crypto requires more efforts on the client side if we  
don't trust the server, that's just natural.

The question is: which VCS can serve my scenario?

> So now you have security implications, because I can do an offline
> guessing attack against your files (i.e., calculate git blob hashes for
> likely candidates and see if you have them). Whether that is a problem
> really depends on your data.

Or look at commit frequency and push sources. There's always a leak of  
information even if I just upload a series of  
blah-2009MMDD-NNN.tar.lzma.gpg files... The data is going to be obsolete,  
say, 3 months; students then write the exam and then it's sort of public  
anyways. Even if your model does not entail not publishing exams (as  
opposed to embargoed press releases under development), but you can't  
prevent someone from writing their recollection of the problems from  
memory afterwards and sharing it with other students.

> Not to mention that it makes the protocol a lot more complex, as you
> would be encrypting _parts_ of objects, like the filenames of a tree,
> and the commit message of a commit object.
>
> I suppose in theory you could obfuscate the sha1's in a way that
> preserved the object relationships but revealed no information. That is,
> the server would have one "fake" set of sha1's, and the client would map
> its real sha1's to the fake ones when talking with the server. But that
> is again potentially getting complex.

Is your concern that the object name (SHA1) is derived from the  
unencrypted version?

-- 
Matthias Andree
