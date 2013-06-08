From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 08 Jun 2013 19:22:17 +0200
Message-ID: <51B36849.3030608@lsrfire.ath.cx>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com> <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com> <51B31651.6020307@lsrfire.ath.cx> <CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com> <51B32FFD.5070302@lsrfire.ath.cx> <CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com> <51B35414.1090101@lsrfire.ath.cx> <CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:22:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMqe-0005sQ-E2
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab3FHRWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 13:22:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:58976 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3FHRWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:22:22 -0400
Received: from [192.168.2.105] (p579BE82C.dip0.t-ipconnect.de [87.155.232.44])
	by india601.server4you.de (Postfix) with ESMTPSA id 3D45417D;
	Sat,  8 Jun 2013 19:22:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226843>

Am 08.06.2013 18:53, schrieb Felipe Contreras:
> On Sat, Jun 8, 2013 at 10:56 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Am 08.06.2013 16:04, schrieb Felipe Contreras:
>>
>>> On Sat, Jun 8, 2013 at 8:22 AM, Ren=C3=A9 Scharfe
>>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>>
>>>> Am 08.06.2013 14:15, schrieb Felipe Contreras:
>>>
>>>
>>>>> Why leave it out? If somebody makes the mistake of doing the abov=
e
>>>>> sequence, would you prefer that we leak?
>>>>
>>>>
>>>> Leaking is better than silently cleaning up after a buggy caller b=
ecause
>>>> it
>>>> still allows the underlying bug to be found.
>>>
>>>
>>> No, it doesn't. The pointer is replaced and forever lost. How is
>>> leaking memory helping anyone to find the bug?
>>
>> Valgrind can tell you where leaked memory was allocated, but not if =
you free
>> it in the "wrong" place.
>
> It is the correct place to free it. And nobody will ever find it with
> valgrind, just like nobody has ever tracked down the hundreds of leak=
s
> in Git that happen reliably 100% of the time, much less the ones that
> happen rarely.

We could argue about freeing it here or adding a discard_index call=20
somewhere else (which seems more natural to me) once we had a call=20
sequence that actually causes such a leak.  The test suite contains=20
none, so I'd say we need more tests first.

Lots of the existing leaks were not worth plugging because the process=20
would end right after freeing the memory.  Leaving clean-up to the OS=20
was a conscious design choice, simplifying the code.

When such code is reused in a library or run multiple times while it wa=
s=20
originally meant to be run only a single time (like with cherry-pick=20
--stdin) the original assumption doesn't hold any more and we have a=20
problem.

Let's find and fix those leaks by freeing memory in the right places.=20
=46reeing memory just in case in places where we can show that no leak =
is=20
triggered by our test suite doesn't help.

Ren=C3=A9
