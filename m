From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Fri, 13 Nov 2015 20:02:23 +0000
Message-ID: <564641CF.5050008@ramsayjones.plus.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
 <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
 <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
 <56437F96.2070209@ramsayjones.plus.com>
 <71B4BDE3-153C-4918-A23A-F45F0228A988@gmail.com>
 <CAPig+cRjDVPHH3VH-Mv_KJTeOVyxV-6agHDk+bXqZ4kjJoaLJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 21:02:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxKYS-0006n7-K4
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 21:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbbKMUCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 15:02:36 -0500
Received: from avasout04.plus.net ([212.159.14.19]:44093 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbbKMUCe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 15:02:34 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout04 with smtp
	id h82R1r0042GQ2gJ0182SLS; Fri, 13 Nov 2015 20:02:31 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=BCjA09oAAAAA:8
 a=extA4yZ_AAAA:8 a=v7MLz4EJ5Y4oeCqJLJEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAPig+cRjDVPHH3VH-Mv_KJTeOVyxV-6agHDk+bXqZ4kjJoaLJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281261>



On 13/11/15 08:57, Eric Sunshine wrote:
> On Fri, Nov 13, 2015 at 3:46 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> On 11 Nov 2015, at 18:49, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>>> On 11/11/15 02:00, Stefan Beller wrote:
>>>> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>>>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>>>>> 02-11-2015) changed the type of some variables from long to off_t.
>>>>>> The 32-bit build, which enables the large filesystem interface
>>>>>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>>>>>> integer, whereas long is a 32-bit integer. This results in a couple
>>>>>> of printf format warnings.
>>>>>
>>>>> My machine is 64-bit, though, so perhaps it's misleading to
>>>>> characterize this as a fix for 32-bit builds. In particular, off_t is
>>>>> 'long long' on this machine, so it complains about the "long" format
>>>>> specifier.
>>>>
>>>> I wonder if 32 bit compilation can be part of travis.
>>>
>>> Did this warning show up on the OS X build?
>>
>> Yes, I added CFLAGS="-Werror=format" to the my experimental TravisCI
>> build and it breaks the build on OS X.
>> See here (you need to scroll all the way down):
>> https://travis-ci.org/larsxschneider/git/jobs/90899656
>>
>> BTW: I tried to set "-Werror" but then I got a bunch of macro redefined errors like this:
>> ./git-compat-util.h:614:9: error: 'strlcpy' macro redefined [-Werror]
>>
>> Is this a known issue? Is this an issue at all?
> 
> Odd. I don't experience anything like that on my Mac.
> 

Hmm, from the output, it looks like the configure script is
not detecting that 'strlcpy' is available (so setting
NO_STRLCPY=YesPlease in the config.mak.autogen file).
However, it seems to be a 'macro redirect' set in the
/usr/include/secure/_string.h header file (presumably it
redirects between a more or less secure version ;-)

Unfortunately, I don't have access to a mac - so I can't
help you with the debugging. :(

ATB,
Ramsay Jones
