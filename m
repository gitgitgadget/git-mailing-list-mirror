From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Thu, 18 Jul 2013 18:50:24 +0100
Message-ID: <51E82AE0.9050707@ramsay1.demon.co.uk>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org> <51E4AABD.9010701@web.de> <51E4C400.6000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzuoV-00047x-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934261Ab3GRU2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jul 2013 16:28:31 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:49977 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933027Ab3GRU2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:28:30 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id DA0391280A8;
	Thu, 18 Jul 2013 21:28:29 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id AC92F1280A6;
	Thu, 18 Jul 2013 21:28:26 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu, 18 Jul 2013 21:28:22 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51E4C400.6000009@gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230733>

Mark Levedahl wrote:
> On 07/15/2013 10:06 PM, Torsten B=F6gershausen wrote:
>> On 2013-07-15 21.49, Junio C Hamano wrote:
>>> Mark Levedahl <mlevedahl@gmail.com> writes:
>>>
>>>>> In order to limit the adverse effects caused by this implementati=
on,
>>>>> we provide a new "fast stat" interface, which allows us to use th=
is
>>>>> only for interactions with the index (i.e. the cached stat data).
>>>>>
>>>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>>>> ---
>>>> I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the res=
ults
>>>> using your prior patch (removing the Cygwin specific lstat entirel=
y)
>>>> and get the same results with both, so this seems ok from me.
>>>>
>>>> My comparison point was created by reverting your current patch fr=
om
>>>> pu, then reapplying your earlier patch on top, so the only differe=
nce
>>>> was which approach was used to address the stat functions.
>>>>
>>>> Caveats:
>>>> 1) I don't find any speed improvement of the current patch over th=
e
>>>> previous one (the tests actually ran faster with the earlier patch=
,
>>>> though the difference was less than 1%).
>> Hm, measuring the time for the test suite is one thing,
>> did you measure the time of "git status" with and without the patch?
>>
>> (I don't have my test system at hand, so I can test in a few days/we=
eks)
> Timing for 5 rounds of "git status" in the git project. First, with t=
he=20
> current fast_lstat patches:
> /usr/local/src/git>for i in {1..5} ; do time git status >& /dev/null =
; done
>=20
> real    0m0.218s
> user    0m0.000s
> sys     0m0.218s
>=20
> real    0m0.187s
> user    0m0.077s
> sys     0m0.109s
>=20
> real    0m0.187s
> user    0m0.030s
> sys     0m0.156s
>=20
> real    0m0.203s
> user    0m0.031s
> sys     0m0.171s
>=20
> real    0m0.187s
> user    0m0.062s
> sys     0m0.124s
>=20
> Now, with Ramsay's original patch just removing the non-Posix stat=20
> functions:
> /usr/local/src/git>for i in {1..5} ; do time git status >& /dev/null =
; done
>=20
> real    0m0.218s
> user    0m0.046s
> sys     0m0.171s
>=20
> real    0m0.187s
> user    0m0.015s
> sys     0m0.171s
>=20
> real    0m0.187s
> user    0m0.015s
> sys     0m0.171s
>=20
> real    0m0.187s
> user    0m0.047s
> sys     0m0.140s
>=20
> real    0m0.187s
> user    0m0.031s
> sys     0m0.156s
>=20
>=20
> I see no difference in the above. (Yes, I checked multiple times that=
 I=20
> was using different executables).

Hmm, that looks good. :-D

Torsten reported a performance boost using the win32 stat() implementat=
ion
on a linux git repo (2s -> 1s, if I recall correctly) on cygwin 1.7.
Do you have a larger repo available to test?

If performance isn't an issue (it isn't for _me_), then I will happily
re-submit my original patch (removing the win32 stat implementation).

[Hmm, I may do anyway!]

ATB,
Ramsay Jones
