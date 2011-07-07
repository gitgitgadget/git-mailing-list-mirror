From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH v2 2/4] xdiff/xprepare: refactor abort cleanups
Date: Wed, 06 Jul 2011 23:55:29 -0400
Message-ID: <4E152E31.4020105@cisco.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com> <1309970337-6016-2-git-send-email-rctay89@gmail.com> <1309970337-6016-3-git-send-email-rctay89@gmail.com> <7vliwbmgv0.fsf@alter.siamese.dyndns.org> <CALUzUxqPf0nReHHhQ3zJoVbPAN7GNuzWeunWoxbzLuoYtuEbUw@mail.gmail.com> <7vaacrhtp3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 06:05:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qefpu-0002uI-EE
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 06:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794Ab1GGEFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 00:05:04 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:11095 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1GGEFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 00:05:03 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jul 2011 00:05:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2001; q=dns/txt;
  s=iport; t=1310011503; x=1311221103;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=uIhD1/RTz7SAq2K9jGDXu/xJeXeKCTRqD0dANz7N2UQ=;
  b=FqDQWrXCkrMi5ME46w9hlFv6cjrSksXOQH3pZkF6RLYASAfthqDUh1gL
   lUHEacwNrPfq4LRmSANDZlDZsaJqiMe223uuEs/0wjQZgPMdJ9QrBJ4ol
   EA5sm4JIvAQkrRbWrSGsGcQlgOBsrxWVv2G/YbSRfYR9Qa6ikQAaxFKcg
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAJAsFU6rRDoG/2dsb2JhbABTqBd3rg2df4Y3BJJGhH2EVIcM
X-IronPort-AV: E=Sophos;i="4.65,491,1304294400"; 
   d="scan'208";a="519310"
Received: from mtv-core-1.cisco.com ([171.68.58.6])
  by rcdn-iport-8.cisco.com with ESMTP; 07 Jul 2011 03:55:31 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id p673tUXH007936;
	Thu, 7 Jul 2011 03:55:30 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vaacrhtp3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110706235529830
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176740>



On 07/06/2011 07:31 PM, Junio C Hamano wrote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> On Thu, Jul 7, 2011 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>>
>>>> Group free()'s that are called when a malloc() fails in
>>>> xdl_prepare_ctx(), making for more readable code.
>>> Nicer, but I wonder if we can get away with a single label that lets us
>>> abort with freeing whatever we have allocated by making sure that the
>>> various pointer fields and variables are initialized to NULL, which may
>>> lead to even more readable code.
>> Pardon my dullness. Do you mean to check if the various fields are set
>> to NULL upon allocation, and free()'ing them if so?
> What I meant was that, instead of doing this:
>
>     func() {
> 	if (somefunc(&A, ...) < 0)
> 		goto failA;
>         ... do something ...
> 	B = someotheralloc();
>         if (!B)
>         	goto failB;
>         ... do something ...
> 	C = yetanotheralloc();
>         if (!C)
>         	goto failC;
> 	... do things using A, B, C ...
>
> 	return 0;
>     failC:
>     	free(B);
>     failB:
> 	free(A);
>     failA:
>         return -1;
>     }
>
> it would be easier to follow if you did:
>
>     func() {
> 	A = B = C = NULL;
> 	if (somefunc(&A, ...) < 0)
> 		goto fail;
>         ... do something ...
> 	B = someotheralloc();
>         if (!B)
>         	goto fail;
>         ... do something ...
> 	C = yetanotheralloc();
>         if (!C)
>         	goto fail;
> 	... do things using A, B, C ...
>
>     fail:
>         free(B);
>     	free(A);
>         return -1;
>     }
>
> Especially when you have more than 2 such fail labels.


Because 'free(NULL)' is handled sanely (as a no-op).
http://pubs.opengroup.org/onlinepubs/009695399/functions/free.html

I haven't looked, but I assume xdl_cha_free does the same thing.  I only
assume this because Junio seems to imply it, though.

Phil
