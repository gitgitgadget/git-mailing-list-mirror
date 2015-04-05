From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Sun, 05 Apr 2015 13:22:50 +0530
Message-ID: <5520E9D2.4010603@gmail.com>
References: <551F7984.5070902@gmail.com>	<1428126162-18987-1-git-send-email-karthik.188@gmail.com>	<xmqq7ftrg02b.fsf@gitster.dls.corp.google.com>	<55204141.9070100@gmail.com> <xmqqiodbdnkn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 09:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YefMa-0002Md-Nv
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 09:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbbDEHw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 03:52:56 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34469 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbDEHwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 03:52:55 -0400
Received: by pacyx8 with SMTP id yx8so11298214pac.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FIrNwLTPENAdq+tePp+7g/q2ejSMX9zmZZ4DWBNSVHc=;
        b=vLmI8yScFFdRllo9SuTWf9oWdW3gCrt9RQVtfr+eiDqbLQBtyAuON/rzvQz6eznVJm
         5P63vqV6j1I/G9K14l2ikvafJlATWJylKDWG62tHorEK+casNgzyuRs9wxAvLO+TLPGZ
         7SZoQuvSriiwdjYCkXXmRVdVqMyzM9R5TrRWPlAaivhtqtjnUvTSaoX2IdpRS9t9f9oF
         YUsp4z1QasV2UEJRCzc8DQ7dFtGgk58CEt2xkdlPcDU71DjprlMKtM0SjGH0eWIYINQ/
         WqnGGNWf1v3vUCn6ERg+bIXriT50CCL8q3AfLOfHyDZW25HEGgYP0WrsqTIatiVQPhaW
         dDJQ==
X-Received: by 10.68.221.226 with SMTP id qh2mr18153934pbc.1.1428220374833;
        Sun, 05 Apr 2015 00:52:54 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id zp2sm875971pbb.79.2015.04.05.00.52.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2015 00:52:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqiodbdnkn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266800>



On 04/05/2015 01:16 PM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>>> So, it makes me wonder what guarantee we have that this does not
>>> dereference a NULL here.
>>>
>> As per my code, oi->typename is only pointing to something when oi->typep
>> is ( As oi->typename is currently only used in cat-file.c).
>> But what you're saying also is true, there is no other guarantee, as a user may
>> set oi->typename to point to a struct strbuf and leave out oi->typep.
>>
>>   if (oi->typename && oi->typep)
>>           strbuf_addstr(oi->typename, typename(*oi->typep));
>>
>> This should suffice. Do you want me to re-roll this?
>
> I'd rather avoid the thinking along the lines of "at this moment,
> there happens to be only one caller that asks for typename and the
> caller also sets typep, so we will be safe as long as we make sure
> the caller passed typep before giving him typename back".
>
> Somebody else may write new code that wants to learn the typename,
> forgets to set typep, calls into this codepath, and ends up
> scratching his head wondering why the typename string is returned to
> him.  Surely the code may not crash at the new code you wrote, but
> you are not helping him.


Yes! I do agree with you, If you read my previous reply, I did mention 
what you said about not having a guarantee that typep and typename are 
both set and another user might have a bug with this.

>
> If it semantically does not make sense to ask for the typename
> without asking for the type code, then we can and should make that
> as a new calling convention _all_ callers must follow.
>
> In other words, I think it is better to have
>
> 	if (oi->typename && !oi->typep)
> 		die("BUG");
>
> somewhere near the beginning of the callchain that takes oi; that
> will ensure all callers understand the rule.
>

Yes! this is a better approach as it will enforce that typep must be set 
when typename is set.
