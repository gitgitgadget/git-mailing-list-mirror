From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Thu, 18 Jul 2013 23:49:48 +0200
Message-ID: <51E862FC.4090607@web.de>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org> <51E4AABD.9010701@web.de> <51E4C400.6000009@gmail.com> <51E82AE0.9050707@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6ger?= =?ISO-8859-1?Q?shausen?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 23:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzw5F-0003S9-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933649Ab3GRVtx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jul 2013 17:49:53 -0400
Received: from mout.web.de ([212.227.15.14]:62574 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759049Ab3GRVtw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:49:52 -0400
Received: from [192.168.1.18] ([99.30.126.110]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LkPrz-1UPVX31YKp-00cQl5 for <git@vger.kernel.org>;
 Thu, 18 Jul 2013 23:49:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51E82AE0.9050707@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:KWcpxmLNK9J/cwHjm2N1qoBbTO0nxW0F3hpGe1uEcRNojtg6gL2
 lTYN4dwSJHdfTeTxZtZP0fDaSW6cLpri3OKlALmMduy7BswZZrwW+1z1q3m3Ka5ojMBY/dH
 0hN4HaD524GXnzyzdi3sw2ksShvPUpsopzg8vSusS/M6FRlaKXkyaK0ESQS5Zo2socq65c8
 RQj9GGkn1RPeth+i7Pb5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230755>

On 2013-07-18 19.50, Ramsay Jones wrote:
> Mark Levedahl wrote:
>> On 07/15/2013 10:06 PM, Torsten B=F6gershausen wrote:
>>> On 2013-07-15 21.49, Junio C Hamano wrote:
>>>> Mark Levedahl <mlevedahl@gmail.com> writes:
>>>>
>>>>>> In order to limit the adverse effects caused by this implementat=
ion,
>>>>>> we provide a new "fast stat" interface, which allows us to use t=
his
>>>>>> only for interactions with the index (i.e. the cached stat data)=
=2E
>>>>>>
>>>>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>>>>> ---
>>>>> I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the re=
sults
>>>>> using your prior patch (removing the Cygwin specific lstat entire=
ly)
>>>>> and get the same results with both, so this seems ok from me.
>>>>>
>>>>> My comparison point was created by reverting your current patch f=
rom
>>>>> pu, then reapplying your earlier patch on top, so the only differ=
ence
>>>>> was which approach was used to address the stat functions.
>>>>>
>>>>> Caveats:
>>>>> 1) I don't find any speed improvement of the current patch over t=
he
>>>>> previous one (the tests actually ran faster with the earlier patc=
h,
>>>>> though the difference was less than 1%).
>>> Hm, measuring the time for the test suite is one thing,
>>> did you measure the time of "git status" with and without the patch=
?
>>>
>>> (I don't have my test system at hand, so I can test in a few days/w=
eeks)
>> Timing for 5 rounds of "git status" in the git project. First, with =
the=20
>> current fast_lstat patches:
>> /usr/local/src/git>for i in {1..5} ; do time git status >& /dev/null=
 ; done
>>
>> real    0m0.218s
>> user    0m0.000s
>> sys     0m0.218s
>>
>> real    0m0.187s
>> user    0m0.077s
>> sys     0m0.109s
>>
>> real    0m0.187s
>> user    0m0.030s
>> sys     0m0.156s
>>
>> real    0m0.203s
>> user    0m0.031s
>> sys     0m0.171s
>>
>> real    0m0.187s
>> user    0m0.062s
>> sys     0m0.124s
>>
>> Now, with Ramsay's original patch just removing the non-Posix stat=20
>> functions:
>> /usr/local/src/git>for i in {1..5} ; do time git status >& /dev/null=
 ; done
>>
>> real    0m0.218s
>> user    0m0.046s
>> sys     0m0.171s
>>
>> real    0m0.187s
>> user    0m0.015s
>> sys     0m0.171s
>>
>> real    0m0.187s
>> user    0m0.015s
>> sys     0m0.171s
>>
>> real    0m0.187s
>> user    0m0.047s
>> sys     0m0.140s
>>
>> real    0m0.187s
>> user    0m0.031s
>> sys     0m0.156s
>>
>>
>> I see no difference in the above. (Yes, I checked multiple times tha=
t I=20
>> was using different executables).
>=20
> Hmm, that looks good. :-D
>=20
> Torsten reported a performance boost using the win32 stat() implement=
ation
> on a linux git repo (2s -> 1s, if I recall correctly) on cygwin 1.7.
> Do you have a larger repo available to test?
(I have a 5 years old Dual Core, 2.5 Ghz, 1 TB hard disk, Win XP, cygwi=
n 1.7)
On that machine I can see the performance boost.
Which kind of computers are you guys using?

SSD/hard disk ?
How much RAM ?
Which OS ?
Is there a difference between Win XP, Win7, Win8?

[snip]
