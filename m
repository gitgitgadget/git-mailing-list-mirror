From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Tue, 3 May 2011 01:17:17 -0700
Message-ID: <86404CD9-6040-4083-912F-23F4C11F4ED2@gmail.com>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org> <FB837238-9953-4FD8-BC52-5C0AB061C291@gmail.com> <4DBFA1A2.6050409@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 03 10:17:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHAnZ-0007o4-Bn
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 10:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab1ECIRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 04:17:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56935 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab1ECIRW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 04:17:22 -0400
Received: by pwi15 with SMTP id 15so3025059pwi.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=ZIgzOU/zdSMjfCgnVZfTCdH94Ud/mhc4ppcoLEsJHkA=;
        b=rsf5R8Rp37h5P9ncU+V53k/LHLlloPKnRGgOFgRKGtnkjk+KzghUA8NKRuZrO9u6Ue
         P8Ai7lXkSyNZfAAmGKwXn9k+Ft73GqXm9rHBlKLF6hbDtK59cTV6c48MHZhqvXZx8/hb
         03mleKOk3L6HHP7u5i4ftMtb0o8GkcVoaezHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=aO3Q61rSW+2oFXMiGyRjYm8K4uPh/ThwbdmfQ5+roKnB07VUgUXB7Zvfs5XZ3Softn
         4Cr2+MDSLLMfF0YdjkfyKsHilI3MwzXfyecq4Q0g6yqMFsFxMqECwWiOyT0mTiav6Y1V
         3+TD67XW4WMfuMnmRg5DaUoN0XDJkJwZgHrmA=
Received: by 10.68.57.33 with SMTP id f1mr10067536pbq.428.1304410641693;
        Tue, 03 May 2011 01:17:21 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id l7sm4356743pbo.44.2011.05.03.01.17.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 01:17:20 -0700 (PDT)
In-Reply-To: <4DBFA1A2.6050409@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172651>

On May 2, 2011, at 11:33 PM, Michael J Gruber wrote:

> Joshua Juran venit, vidit, dixit 03.05.2011 03:57:
>> On May 2, 2011, at 12:15 PM, Junio C Hamano wrote:
>>
>>> diff --git a/revision.c b/revision.c
>>> index f4b8b38..26271d1 100644
>>> --- a/revision.c
>>> +++ b/revision.c
>>> @@ -905,14 +905,26 @@ int handle_revision_arg(const char *arg,
>>> struct rev_info *revs,
>>> 		const char *this = arg;
>>> 		int symmetric = *next == '.';
>>> 		unsigned int flags_exclude = flags ^ UNINTERESTING;
>>> +		static const char head_by_default[] = "HEAD";
>>>
>>> 		*dotdot = 0;
>>> 		next += symmetric;
>>>
>>> 		if (!*next)
>>> -			next = "HEAD";
>>> +			next = head_by_default;
>>> 		if (dotdot == arg)
>>> -			this = "HEAD";
>>> +			this = head_by_default;
>>> +		if (this == head_by_default && next == head_by_default &&
>>> +		    !symmetric) {
>>
>> Is there a reason not to write
>>
>> 	const char *head_by_default = "HEAD";
>>
>> or even
>>
>> 	const char *const head_by_default = "HEAD";
>>
>> instead?  Loading a static array and checking an init flag is a
>> pessimization versus just pointing into a read-only segment.
>
> Because of the comparisons later on: this == "HEAD" is not the same.

Sorry if I was unclear.  I meant to replace only the 'static const  
char head_by_default[] = "HEAD";' line and leave the rest of the patch  
unchanged.

My recollection is that Metrowerks C will statically allocate read- 
write storage (duplicating the read-only copy of the string) and copy  
the string into it at runtime.  It only copies the string once, which  
is ensured by checking an internally generated flag (also statically  
allocated) every time the scope containing the declaration is  
executed.  This is the pessimization I speak of.

By contrast, my suggestion allocates a single pointer on the stack  
regardless of compiler optimization.

Josh
