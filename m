From: Andreas Ericsson <ae@op5.se>
Subject: Re: "malloc failed"
Date: Thu, 29 Jan 2009 14:41:15 +0100
Message-ID: <4981B1FB.6030700@op5.se>
References: <878wow7pth.fsf@mcbain.luannocracy.com>	<20090128050225.GA18546@coredump.intra.peff.net>	<c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141>	<87skn3rn5n.fsf@mcbain.luannocracy.com>	<20090129052041.GB31507@coredump.intra.peff.net>	<20090129055633.GA32609@coredump.intra.peff.net> <87pri6qmvm.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 14:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXAS-0005Rq-5s
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbZA2NlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbZA2NlU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:41:20 -0500
Received: from mail.op5.se ([193.201.96.20]:47784 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbZA2NlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 08:41:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 918991B803E2;
	Thu, 29 Jan 2009 14:42:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-787XkbTiBD; Thu, 29 Jan 2009 14:42:21 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 71D081B800B2;
	Thu, 29 Jan 2009 14:42:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <87pri6qmvm.fsf@mcbain.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107672>

David Abrahams wrote:
> on Thu Jan 29 2009, Jeff King <peff-AT-peff.net> wrote:
> 
>> On Thu, Jan 29, 2009 at 12:20:41AM -0500, Jeff King wrote:
>>
>>> Ok, that _is_ big. ;) I wouldn't be surprised if there is some corner of
>>> the code that barfs on a single object that doesn't fit in a signed
>>> 32-bit integer; I don't think we have any test coverage for stuff that
>>> big.
>> Sure enough, that is the problem. With the patch below I was able to
>> "git add" and commit a 3 gigabyte file of random bytes (so even the
>> deflated object was 3G).
>>
>> I think it might be worth applying as a general cleanup, but I have no
>> idea if other parts of the system might barf on such an object.
>>
>> -- >8 --
>> Subject: [PATCH] avoid 31-bit truncation in write_loose_object
>>
>> The size of the content we are adding may be larger than
>> 2.1G (i.e., "git add gigantic-file"). Most of the code-path
>> to do so uses size_t or unsigned long to record the size,
>> but write_loose_object uses a signed int.
>>
>> On platforms where "int" is 32-bits (which includes x86_64
>> Linux platforms), we end up passing malloc a negative size.
> 
> 
> Good work.  I don't know if this matters to you, but I think on a 32-bit
> platform you'll find that size_t, which is supposed to be able to hold
> the size of the largest representable *memory block*, is only 4 bytes
> large:
> 
>   #include <limits.h>
>   #include <stdio.h>
> 
>   int main()
>   {
>     printf("sizeof(size_t) = %d", sizeof(size_t));
>   }
> 
> Prints "sizeof(size_t) = 4" on my core duo.
> 

It has nothing to do with typesize, and everything to do with
signedness. A size_t cannot be negative, while an int can.
Making sure we use the correct signedness everywhere means
we double the capacity where negative values are clearly bogus,
such as in this case. On 32-bit platforms, the upper limit for
what git can handle is now 4GB, which is expected. To go beyond
that, we'd need to rework the algorithm so we handle chunks of
the data instead of the whole. Some day, that might turn out to
be necessary but today is not that day.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
