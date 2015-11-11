From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Wed, 11 Nov 2015 17:47:43 +0000
Message-ID: <56437F3F.7050305@ramsayjones.plus.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
 <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:48:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwZV1-0006OK-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 18:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbbKKRrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 12:47:52 -0500
Received: from avasout01.plus.net ([84.93.230.227]:54706 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbKKRru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 12:47:50 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout01 with smtp
	id gHnk1r0072GQ2gJ01HnlZT; Wed, 11 Nov 2015 17:47:49 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MbeRwMLf c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=vPAaMmz6WfBFfUcQtJ0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281173>



On 11/11/15 01:22, Eric Sunshine wrote:
> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> Commit f8117f55 ("http: use off_t to store partial file size",
>> 02-11-2015) changed the type of some variables from long to off_t.
>> The 32-bit build, which enables the large filesystem interface
>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>> integer, whereas long is a 32-bit integer. This results in a couple
>> of printf format warnings.
>>
>> In order to suppress the warnings, change the format specifier to use
>> the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
>> the http_opt_request_remainder() function, which uses the same
>> solution).
> 
> I just ran across the problem when building 'next' on my Mac and was
> about to investigate, so am happy to find that the work has already
> been done. Thanks.

Hmm, interesting. I've never used a Mac, so please forgive my ignorance ...

> My machine is 64-bit, though, so perhaps it's misleading to
> characterize this as a fix for 32-bit builds. In particular, off_t is
> 'long long' on this machine, so it complains about the "long" format
> specifier.

... but this seems to imply that sizeof(long) is 4 on your machine, right?
(on x86_64 linux it's 8, which is why I hadn't noticed before).

Jeff, do you need me to re-word the commit message?

ATB,
Ramsay Jones

> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>> diff --git a/http.c b/http.c
>> index 42f29ce..2532976 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1617,8 +1617,8 @@ struct http_pack_request *new_http_pack_request(
>>         if (prev_posn>0) {
>>                 if (http_is_verbose)
>>                         fprintf(stderr,
>> -                               "Resuming fetch of pack %s at byte %ld\n",
>> -                               sha1_to_hex(target->sha1), prev_posn);
>> +                               "Resuming fetch of pack %s at byte %"PRIuMAX"\n",
>> +                               sha1_to_hex(target->sha1), (uintmax_t)prev_posn);
>>                 http_opt_request_remainder(preq->slot->curl, prev_posn);
>>         }
>>
>> @@ -1772,8 +1772,8 @@ struct http_object_request *new_http_object_request(const char *base_url,
>>         if (prev_posn>0) {
>>                 if (http_is_verbose)
>>                         fprintf(stderr,
>> -                               "Resuming fetch of object %s at byte %ld\n",
>> -                               hex, prev_posn);
>> +                               "Resuming fetch of object %s at byte %"PRIuMAX"\n",
>> +                               hex, (uintmax_t)prev_posn);
>>                 http_opt_request_remainder(freq->slot->curl, prev_posn);
>>         }
>>
>> --
>> 2.6.0
> 
