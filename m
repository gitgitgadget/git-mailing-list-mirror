From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally
 -t"
Date: Sat, 07 Mar 2015 15:34:32 +0530
Message-ID: <54FACD30.6080005@gmail.com>
References: <54F89D90.6090505@gmail.com>	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>	<xmqq61af100p.fsf@gitster.dls.corp.google.com>	<54F9E6B6.4070105@gmail.com> <xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 11:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUBcG-0001qI-09
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 11:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbbCGKEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 05:04:39 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32844 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbbCGKEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 05:04:36 -0500
Received: by padet14 with SMTP id et14so61766908pad.0
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ht8Xs0I0gkWVomTg3QjOTYi9oQ2RxfGsEt5CdRBsMhg=;
        b=eOTOtI3sANVok6Dzo5U11WVzZ7thmnmM5m+0zxI5/BQ8dz2DkxWGyB/tIF9kMAzC67
         T1dVKQ1SoaKA/aguIQQFsyIOQRIrfR2bKHJPxEEDw2FDv6fP9SnL0gXOobr3bcJlK9/7
         flWvypNOp8avh/cLBalYB5DFtD/X5T9ycX79ir8glbt0XL1nV5ES2SUZh8nZcw7duHQ4
         00TQkS2KkAMIlbA79YRbBBviPbNwz58WzX9Zg/nYGfPoSkYD1xvnyaF8iXqIjhRDvOhX
         zQM3smh0GBwEJF09S5ZfLy9sS8SHTstjO46I1uvCxWyDA12Ie/4LBXkHlu0crQoQvIGG
         japg==
X-Received: by 10.66.156.38 with SMTP id wb6mr34032962pab.68.1425722675650;
        Sat, 07 Mar 2015 02:04:35 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id dr5sm11860647pdb.48.2015.03.07.02.04.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 02:04:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264994>



On 03/07/2015 12:58 AM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>>> ... I suspect that the caller should supply a pointer to struct
>>> object_info, i.e. something along these lines:
>>>
>>>       struct object_info oi = { NULL };
>>>       struct strbuf sb = STRBUF_INIT;
>>>       enum object_type type;
>>>
>>>       ...
>>>
>>>       oi.typename = &sb;
>>>       sha1_object_info_literally(sha1, &oi);
>>>       if (!sb.len)
>>>           that is an error;
>>>       else
>>>           use sb.buf as the name;
>>>
>>>       strbuf_release(&sb);
>> I thought I could get the calling function "cat_one_file()" to send
>> the address to a struct strbuf. Like this ..
>>
>> struct strbuf sb = STRBUF_INIT;
>> length = sha1_object_info_literally(sha1, &sb);
>> if (length < 0)
>> die("git cat-file --literally -t %s: failed",
>>              obj_name);
>> printf("%s\n", sb.buf);
>> strbuf_release(&sb);
>> return 0;
>>
>> What do you think? Is this ok?
>
> When I gave you $gmane/264420, I was actually hoping that we do not
> have to have "object-info-literally" helper at all, and instead the
> caller in cat-file that deals with "-t" option can become something
> like this:
> 	
> 	struct object_info oi = { NULL };
> 	struct strbuf typename = STRBUF_INIT;
> 	unsigned flags = LOOKUP_REPLACE_OBJECT;
>
>          if (doing the --literally stuff)
> 		flags |= LOOKUP_LITERALLY;
>
> 	...
>
> 	switch (...) {
> 	case 't':
>          	oi.typename = &typename;
>                  sha1_object_info_extended(sha1, &oi, flags);
> 		if (typename.len) {
>                  	printf("%s\n", typename.buf);
> 			return 0;
> 		}
>                  break;
> 	...
>
> The change illustrated in $gmane/264420 is probably incomplete and
> some calls from the sha1_object_info_extended() after that change
> may still need to be tweaked to pay attention to LOOKUP_LITERALLY
> bit (e.g. parse_sha1_header() may want to learn not to barf when
> seeing an unexpected typename in the header when the caller asks to
> look up "literally").
>
I got confused with $gmane/264420 thanks for clearing that up, also I
tried implementing it as follows  :

case 't':
	oi.typep = &type;
	oi.typename = &sb;
	sha1_object_info_extended(sha1, &oi, flags);
	if (sb.len) {
		printf("%s\n", sb.buf);
		strbuf_release(&sb);
		return 0;
	} else if (type) {
		printf("%s\n", typename(type));
		return 0;
	}
	break;

This works but I need an else statement to check the type if not getting 
the type literally, which is because if not called literally the 
oi.typename is not set, which I will fix now.
Also when trying to get the type "literally" it does not call 
parse_sha1_header() hence we don't need to worry about it handling 
unexpected typenames.
