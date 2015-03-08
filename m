From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally
 -t"
Date: Sun, 08 Mar 2015 14:18:14 +0530
Message-ID: <54FC0CCE.70009@gmail.com>
References: <54F89D90.6090505@gmail.com>	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>	<xmqq61af100p.fsf@gitster.dls.corp.google.com>	<54F9E6B6.4070105@gmail.com>	<xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>	<54FACD30.6080005@gmail.com> <xmqqpp8jsyel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUWst-000112-1V
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 09:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbbCHIsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 04:48:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44635 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbbCHIsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 04:48:18 -0400
Received: by padet14 with SMTP id et14so40377565pad.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 00:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Hb8IvhshgJUez2hE14XF+P84WqvcswYj/ewAICdcJC8=;
        b=JTq7kMNsLao5aSkgBCQ8gjVBjNcXNzXSuZiFM8kcArztisuFgnrxbA7+Q9T5/uy/eC
         2UPtwVLaQkXoITf97KESVC/AdabGlmuXODi+lFObatZLtINsJ7d130nk0Enm58puIttf
         710L7sl7H4ltOGbQdsFV0OkviBdVUzqVY6rEF/X2XVPfd88+XKxYJKift+p8XSBglJkG
         2xvH2Vriq3kLqjTeH6cS3gcJQywMedP0jpPL9sgT1rLCZibooM1xtEM6olIzc8pl4L2W
         xcgYDCmnIrId1eZfalyaKIlaifVmmfGuI2zNlXDnyJj4M/TK4xSWcEegbEPJyU9Ps9HK
         MoNg==
X-Received: by 10.70.48.5 with SMTP id h5mr2917101pdn.58.1425804498184;
        Sun, 08 Mar 2015 00:48:18 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id yf6sm14321287pab.26.2015.03.08.00.48.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 00:48:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqpp8jsyel.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265047>



On 03/08/2015 01:39 PM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>> On 03/07/2015 12:58 AM, Junio C Hamano wrote:
>>
>> case 't':
>> 	oi.typep = &type;
>> 	oi.typename = &sb;
>> 	sha1_object_info_extended(sha1, &oi, flags);
>> 	if (sb.len) {
>> 		printf("%s\n", sb.buf);
>> 		strbuf_release(&sb);
>> 		return 0;
>> 	} else if (type) {
>> 		printf("%s\n", typename(type));
>> 		return 0;
>> 	}
>> 	break;
>>
>> This works but I need an else statement to check the type if not
>> getting the type literally, which is because if not called literally
>> the oi.typename is not set,...
>
> Hmph, when I outlined that change to object-info-extended, I meant
> to do it in such a way that when the optional oi->typename is set,
> it is always filled whether "literally" is asked for andr whether
> the object is a kosher one or a bogus one.
>
> Without parsing the header, we wouldn't know how long the object
> would be, so I do not know if not doing some variant of parse_header
> is an option.
>
> Thanks.
>

What parse_sha1_header() does to get the type is just find the first 
occurrence of a " " manually and store everything before it as the type. 
Then it finds the size of the object if needed. And finally returns the 
type by calling type_from_string(). This is where we get the undefined 
type error.
When getting the type "literally" we could just find the first 
occurrence of a " " using strcspn() copy the type to oi->typename and 
avoid calling parse_sha1_header(). Even your code went along these lines.
If "literally" is not set we could call parse_sha1_header() like we 
regularly would.

Thanks
Karthik
