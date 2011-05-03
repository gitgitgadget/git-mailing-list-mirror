From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Tue, 03 May 2011 10:45:42 +0200
Message-ID: <4DBFC0B6.3080001@drmicha.warpmail.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org> <FB837238-9953-4FD8-BC52-5C0AB061C291@gmail.com> <4DBFA1A2.6050409@drmicha.warpmail.net> <86404CD9-6040-4083-912F-23F4C11F4ED2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 10:45:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHBEz-0006j8-KC
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 10:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab1ECIpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 04:45:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49397 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372Ab1ECIpp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 04:45:45 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7A692202C5;
	Tue,  3 May 2011 04:45:44 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 03 May 2011 04:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6+GpT2HoVauvP3xeYg9IIz315A0=; b=doPEt7oXauOBjnmll0Zdc9od7107lfhrY4U4IsvRt+2ftbIqqzgURopOPKEFgqH4pHrNMYvXIQcF/WAexXF1Xb7EKSp0PeRDiixw6BFBZnFGSeusFJy/VSaSiXRjO6B2rEI8prIzj9tb2JqO6h71cTKbVoSDzFoGesAiN0b4Br4=
X-Sasl-enc: mYy+aQVOTQMH5I/P0d0x8RCzvXWOciil9s0P8sTIkjcb 1304412344
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D4E5E403B76;
	Tue,  3 May 2011 04:45:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <86404CD9-6040-4083-912F-23F4C11F4ED2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172653>

Joshua Juran venit, vidit, dixit 03.05.2011 10:17:
> On May 2, 2011, at 11:33 PM, Michael J Gruber wrote:
> 
>> Joshua Juran venit, vidit, dixit 03.05.2011 03:57:
>>> On May 2, 2011, at 12:15 PM, Junio C Hamano wrote:
>>>
>>>> diff --git a/revision.c b/revision.c
>>>> index f4b8b38..26271d1 100644
>>>> --- a/revision.c
>>>> +++ b/revision.c
>>>> @@ -905,14 +905,26 @@ int handle_revision_arg(const char *arg,
>>>> struct rev_info *revs,
>>>> 		const char *this = arg;
>>>> 		int symmetric = *next == '.';
>>>> 		unsigned int flags_exclude = flags ^ UNINTERESTING;
>>>> +		static const char head_by_default[] = "HEAD";
>>>>
>>>> 		*dotdot = 0;
>>>> 		next += symmetric;
>>>>
>>>> 		if (!*next)
>>>> -			next = "HEAD";
>>>> +			next = head_by_default;
>>>> 		if (dotdot == arg)
>>>> -			this = "HEAD";
>>>> +			this = head_by_default;
>>>> +		if (this == head_by_default && next == head_by_default &&
>>>> +		    !symmetric) {
>>>
>>> Is there a reason not to write
>>>
>>> 	const char *head_by_default = "HEAD";
>>>
>>> or even
>>>
>>> 	const char *const head_by_default = "HEAD";
>>>
>>> instead?  Loading a static array and checking an init flag is a
>>> pessimization versus just pointing into a read-only segment.
>>
>> Because of the comparisons later on: this == "HEAD" is not the same.
> 
> Sorry if I was unclear.  I meant to replace only the 'static const  
> char head_by_default[] = "HEAD";' line and leave the rest of the patch  
> unchanged.
> 
> My recollection is that Metrowerks C will statically allocate read- 
> write storage (duplicating the read-only copy of the string) and copy  
> the string into it at runtime.  It only copies the string once, which  
> is ensured by checking an internally generated flag (also statically  
> allocated) every time the scope containing the declaration is  
> executed.  This is the pessimization I speak of.
> 
> By contrast, my suggestion allocates a single pointer on the stack  
> regardless of compiler optimization.

I see, sorry, I misread your suggestion. Junio will have to answer for
himself then ;)

Michael
