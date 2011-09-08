From: wanghui <Hui.Wang@windriver.com>
Subject: Re: [PATCH v3 1/1] sha1_file: normalize alt_odb path before comparing
 and storing
Date: Thu, 8 Sep 2011 10:01:06 +0800
Message-ID: <4E6821E2.3060900@windriver.com>
References: <1315391867-31277-1-git-send-email-Hui.Wang@windriver.com> <1315391867-31277-2-git-send-email-Hui.Wang@windriver.com> <7vk49k2nsz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <tali@admingilde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 04:01:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Tve-0001LH-Ik
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 04:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858Ab1IHCBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 22:01:05 -0400
Received: from mail.windriver.com ([147.11.1.11]:55119 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757835Ab1IHCBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 22:01:04 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p8820q7j029598
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 7 Sep 2011 19:00:52 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 7 Sep
 2011 19:00:51 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vk49k2nsz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180933>

Junio C Hamano wrote:
> Wang Hui <Hui.Wang@windriver.com> writes:
>
>   
>> From: Hui Wang <Hui.Wang@windriver.com>
>>
>> When it needs to compare and add an alt object path to the
>> alt_odb_list, we normalize this path first since comparing normalized
>> path is easy to get correct result.
>>
>> Use strbuf to replace some string operations, since it is cleaner and
>> safer.
>>     
>
> Thanks, will queue.
>
>   
>> diff --git a/sha1_file.c b/sha1_file.c
>> index f7c3408..fa2484b 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -248,27 +248,27 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
>> ...
>> +	/* Drop the last '/' from path can make memcmp more accurate */
>> +	if (pathbuf.buf[pfxlen-1] == '/')
>> +		pfxlen -= 1;
>>     
>
> By the way, I do not necessarily agree with the above comment. As long as
> you consistently strip the trailing slashes from all directory paths, or
> you consistently leave a single trailing slash after all directory paths,
> you can get accurate comparison either way.
>
> 	Side note: I tend to prefer keeping a single trailing slash when I
> 	know what we are talking about is a directory in general, because
> 	you do not have to worry about the corner case near the root.
> 	Compare ('/' and '/bin/') vs ('/' and '/bin').
>
> In this particular case, the real reason you want to remove the trailing
> slash is that the invariants of ent->base[] demands it (after all, it
> places another slash immediately after it), and making pathbuf.buf[] an
> empty string (i.e. pfxlen == 0) would still be OK to represent an
> alternate object store at the root level (this function assigns '/' at
> ent->base[pfxlen] immediately before returning, and that '/' names the
> root directory).
>
>   
Yes, your concern is right, I didn't even think about root directory 
situation. If the pathbuf.buf is really '/', stripping last slash will 
make pathbuf.buf a empty string, this will make is_directory() return 
false, this is a bug, how about replace those three line codes to:

/* Except root dir, all paths are stripped the last slash if they have */
if (pathbuf.buf[pfxlen-1] == '/' && pxflen != 1)
pxflen -= 1;

>> +	entlen = pfxlen + 43; /* '/' + 2 hex + '/' + 38 hex + NUL */
>> +	ent = xmalloc(sizeof(*ent) + entlen);
>> +	memcpy(ent->base, pathbuf.buf, pfxlen);
>> +	strbuf_release(&pathbuf);
>>  
>>  	ent->name = ent->base + pfxlen + 1;
>>  	ent->base[pfxlen + 3] = '/';
>>     
>
>   
