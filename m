From: Andreas Ericsson <ae@op5.se>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 15:39:06 +0100
Message-ID: <4797518A.3040704@op5.se>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>	 <4797095F.9020602@op5.se> <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 07:18:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHvPx-0006GX-OJ
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 07:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYAXGR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 01:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYAXGR7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 01:17:59 -0500
Received: from mail.op5.se ([193.201.96.20]:43595 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbYAXGR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 01:17:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 717E91F08004;
	Thu, 24 Jan 2008 07:17:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.379
X-Spam-Level: 
X-Spam-Status: No, score=-2.379 tagged_above=-10 required=6.6
	tests=[AWL=-0.872, BAYES_00=-2.599, DATE_IN_PAST_12_24=0.992,
	RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ruSiV2aIR7I3; Thu, 24 Jan 2008 07:17:52 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 1843D1F08003;
	Thu, 24 Jan 2008 07:17:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71591>

Marko Kreen wrote:
> On 1/23/08, Andreas Ericsson <ae@op5.se> wrote:
>> Dmitry Potapov wrote:
>>> On Wed, Jan 23, 2008 at 09:32:54AM +0100, Andreas Ericsson wrote:
>>>> The FNV hash would be better (pasted below), but I doubt
>>>> anyone will ever care, and there will be larger differences
>>>> between architectures with this one than the lt_git hash (well,
>>>> a function's gotta have a name).
>>> Actually, Bob Jenkins' lookup3 hash is twice faster in my tests
>>> than FNV, and also it is much less likely to have any collision.
>>>
>> >From http://burtleburtle.net/bob/hash/doobs.html
>> ---
>> FNV Hash
>>
>> I need to fill this in. Search the web for FNV hash. It's faster than my hash on Intel (because Intel has fast multiplication), but slower on most other platforms. Preliminary tests suggested it has decent distributions.
> 
> I suspect that this paragraph was about comparison with lookup2


It might be. It's from the link Dmitry posted in his reply to my original
message. (something/something/doobs.html).

> (not lookup3) because lookup3 beat easily all the "simple" hashes

By how much? FNV beat Linus' hash by 0.01 microseconds / insertion,
and 0.1 microsecons / lookup. We're talking about a case here where
there will never be more lookups than insertions (unless I'm much
mistaken).

> 
> If you don't mind few percent speed penalty compared to Jenkings
> own optimized version, you can use my simplified version:
> 
>   http://repo.or.cz/w/pgbouncer.git?a=blob;f=src/hash.c;h=5c9a73639ad098c296c0be562c34573189f3e083;hb=HEAD
> 

I don't, but I don't care that deeply either. On the one hand,
it would be nifty to have an excellent hash-function in git.
On the other hand, it would look stupid with something that's
quite clearly over-kill.

> It works always with "native" endianess, unlike Jenkins fixed-endian
> hashlittle() / hashbig().  It may or may not matter if you plan
> to write values on disk.
> 
> Speed-wise it may be 10-30% slower worst case (in my case sparc-classic
> with unaligned data), but on x86, lucky gcc version and maybe
> also memcpy() hack seen in system.h, it tends to be ~10% faster,
> especially as it does always 4byte read in main loop.
> 

It would have to be a significant improvement in wall-clock time
on a test-case of hashing 30k strings to warrant going from 6 to 80
lines of code, imo. I still believe the original dumb hash Linus
wrote is "good enough".

On a side-note, it was very interesting reading, and I shall have
to add jenkins3_mkreen() to my test-suite (although the "keep
copyright note" license thing bugs me a bit).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
