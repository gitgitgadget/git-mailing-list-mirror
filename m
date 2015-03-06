From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally
 -t"
Date: Fri, 06 Mar 2015 23:11:10 +0530
Message-ID: <54F9E6B6.4070105@gmail.com>
References: <54F89D90.6090505@gmail.com>	<1425579560-18898-1-git-send-email-karthik.188@gmail.com> <xmqq61af100p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:41:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTwFT-00056Q-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 18:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbbCFRlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 12:41:15 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44711 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbbCFRlO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 12:41:14 -0500
Received: by padet14 with SMTP id et14so29232502pad.11
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jgszx5ttdoPrcxHnOZIfBSm946Uy6/hHJbJdnzBZ2vk=;
        b=bsunHDbuhXNrrJGRleWpW7n5JrCRcBYnnHxJxqyaXaGU9eIdhhKj6Br7czlADbSsbv
         /HahLbYHZoQ3/3pcPwrsUuUiH7UBQmgHaByd7PSu2wymxsbMY+Af5vt6gGSoqdny94Ms
         +Ia3byI+zKl4whk+QecyYz0gr8kTb/T+hM1O18JMfuA0IeiAQJpEGh9KPivmLMAEFHt3
         5YIhgm1yTNIBAcs0f77mWPNqVle95QK13hYKwROOAvgwWAtLKAgj1l4DMcq7dMWFn5l5
         Eg7begzhHTkT9KfNZFhxjYva52MsgchyJ3mz4+6lvdsmqkPrMsEVLLWyTnbw0Fy6JRFw
         4Ssw==
X-Received: by 10.68.212.6 with SMTP id ng6mr28195138pbc.38.1425663674072;
        Fri, 06 Mar 2015 09:41:14 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id dq4sm10003810pdb.96.2015.03.06.09.41.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 09:41:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq61af100p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264944>



On 03/06/2015 05:15 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +const char *sha1_object_info_literally(const unsigned char *sha1)
>> +{
>> +	enum object_type type;
>> +	struct strbuf sb = STRBUF_INIT;
>> +	struct object_info oi = {NULL};
>> +
>> +	oi.typename = &sb;
>> +	oi.typep = &type;
>> +	if (sha1_object_info_extended(sha1, &oi, LOOKUP_LITERALLY) < 0)
>> +		return NULL;
>> +	if (*oi.typep > 0) {
>> +		strbuf_release(oi.typename);
>> +		return typename(*oi.typep);
>> +	}
>> +	return oi.typename->buf;
>> +}
>
> After calling this function to ask the textual type of an object,
> should the caller free the result it obtains from this function?
>
> oi.typename points at the strbuf on stack and its buf member points
> at an allocated piece of memory.  That must be freed.
>
> On the other hand, typename(*oi.typep) is a pointer into static
> piece of memory, which must never be freed.
>
> This patch introduces this function without introducing any caller,
> which makes it unnecessarily harder to judge if this problem is
> caused by choosing a wrong calling convention, and/or if so what
> better calling convention can be used to correct the problem, but
> without looking at the caller that (presumably) will be introduced
> in a later patch, I suspect that the caller should supply a pointer
> to struct object_info, i.e. something along these lines:
>
>      struct object_info oi = { NULL };
>      struct strbuf sb = STRBUF_INIT;
>      enum object_type type;
>
>      ...
>
>      oi.typename = &sb;
>      sha1_object_info_literally(sha1, &oi);
>      if (!sb.len)
>          that is an error;
>      else
>          use sb.buf as the name;
>
>      strbuf_release(&sb);
I thought I could get the calling function "cat_one_file()" to send
the address to a struct strbuf. Like this ..

struct strbuf sb = STRBUF_INIT;
length = sha1_object_info_literally(sha1, &sb);
if (length < 0)
die("git cat-file --literally -t %s: failed",
             obj_name);
printf("%s\n", sb.buf);
strbuf_release(&sb);
return 0;

What do you think? Is this ok?
>
> As sha1_object_info_extended() takes oi and fills oi.typename when
> it is supplied for _all_ types, not just the bogus ones, a caller of
> that function, including sha1_object_info_literally() and its
> caller, shouldn't have to worry about "is that a known one?  then
> use typename() to convert the enum type to a string.  Otherwise use
> the oi.typename->buf" at all, I would think.
>
>
>
 >
I also missed a part where the object given was a packed object.
eg : git cat-file -t --literally HEAD~2
And since I missed that out, it wasnt copying the type to oi.typename,
and oi.typename would end up being empty, I found this while i was
using gdb.

Didn't CC the mailing list the first time, sorry.
