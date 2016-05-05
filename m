From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: unary minus operator applied to unsigned type, result still unsigned?
Date: Thu, 5 May 2016 22:39:23 +0100
Organization: OPDS
Message-ID: <D165B5E4FA8947DD8A5F18B7A15B02BC@PhilipOakley>
References: <74B59A4DF45C45AF9CDCF6662DDAEF1E@PhilipOakley> <xmqqoa8lcswz.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:39:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQzd-00023G-QI
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757691AbcEEVjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:39:25 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:4328 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbcEEVjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:39:24 -0400
Received: from PhilipOakley ([92.22.61.226])
	by smtp.talktalk.net with SMTP
	id yQzSaUdB0eSy4yQzSagcJN; Thu, 05 May 2016 22:39:23 +0100
X-Originating-IP: [92.22.61.226]
X-Spam: 0
X-OAuthority: v=2.2 cv=bsEOPwSi c=1 sm=1 tr=0 a=PhzTUH1fCcwppfJjoMy/AA==:117
 a=PhzTUH1fCcwppfJjoMy/AA==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=uPZiAMpXAAAA:8 a=yMhMjlubAAAA:8 a=pIiNZIo2QrxxUPUvUv0A:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=svzibyHiZmA4t4YY0eFS:22
 a=BKKCjISod1eDJeS0ORpz:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfLT74uh8DjYfpf8Zwa6BWnAEdg3rqWWRhWrAsK98/cQ3tbsyYR9QI2YaXB2DHsNnGpTZLUcWgjXOBPTWj1B4diTTnPCQlBmqyiNIi/abbXkmkk7OgdNh
 kcQRXqUyLhNUnZLYnJYlvnlOGdP3PJzdQSpakD/Cny13faWkmyTSy8MJZsNW0PoBa4YvCibHySZdlg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293684>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I'm working on building Git on Visual Studio as part of the Git for 
>> Windows
>> capability.
>>
>> The MSVC compiler is reporting:
>>
>> 1>..\sha1-lookup.c(100) : warning C4146: unary minus operator applied to
>> unsigned type, result still unsigned
>
>> 1>..\sha1-lookup.c(316) : warning C4146: unary minus operator applied to
>> unsigned type, result still unsigned
>>
>> the two lines of code are the same, and the message suggests a bad
>> return value:
>>
>> #100: return -lo-1;
>>
>> #316: return -lo-1;
>>
>>
>> Should these be protected by an appropriate brackets/calculation
>> (-1-lo) ? Or does
>> gcc use an alternate assumption about unary minus conversion for 
>> functions
>> returning int?
>
> I think -lo-1 (which is carried out as unsigned) is further casted
> back to signed int as part of the return from the function whose
> type is signed int.  This may be portable in practice, but changing
> type of lo to signed int may be prudent.
>
> sha1_pos() uses size_t, but returns "int", which is inconsistent
> (size_t could be much larger).  Either using int for hi/lo/mi, or
> using ssize_t and returning ssize_t would make sense.
>

I'm going to hold off on patching this at the moment, as there are a few 
more signed/unsigned mismatches that are reported but I've been ignoring 
(mainly comparisons), so I'll try and catch them all at the same time, 
especially as I now understand the standards issues.

This thread has a summary of the standards 
http://stackoverflow.com/questions/8026694/c-unary-minus-operator-behavior-with-unsigned-operands 
(includes C++ >> C) while 
https://msdn.microsoft.com/en-us/library/4kh09110(v=vs.90).aspx explains 
what is being reported.

i.e. unary minus on unsigned ints produces the 2's complement + 1 value, 
except for 0x8000h, where that would be out of range. It's an oddball of 
partially defined behaviours.
--
Philip
