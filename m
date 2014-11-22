From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Sat, 22 Nov 2014 22:20:10 +0100
Message-ID: <5470FE0A.1030802@web.de>
References: <546F5CC7.8060904@drmicha.warpmail.net> <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net> <20141121180105.GB26650@peff.net> <5470A4C0.3070501@web.de> <20141122191932.GA13340@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 22 22:20:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsI6s-0004lN-IS
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 22:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbaKVVUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Nov 2014 16:20:47 -0500
Received: from mout.web.de ([212.227.15.3]:55928 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbaKVVUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 16:20:46 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LkPW7-1YUMoD3uaB-00cOgg; Sat, 22 Nov 2014 22:20:28
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141122191932.GA13340@peff.net>
X-Provags-ID: V03:K0:50mZIUle/tH116CaPUmbZKT2AAdzWaUWY0U/SFDFHkchSjDEAsU
 +/MFLfKnbOIFeEtwLuczEmctECprOYAQNqxjdr3a/lrotul+jJusnmBmMb6oqpxmW5Bp7c6
 lGc/QffHytbFJES+MFf2oKM72ZcMo+iuWJoqwG6/etbxY3rGnnVYZOZfRs26xmtxP/bfPjw
 N7uGsPrq7iZF8wie9N3aA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260081>

On 2014-11-22 20.19, Jeff King wrote:
> On Sat, Nov 22, 2014 at 03:59:12PM +0100, Torsten B=C3=B6gershausen w=
rote:
>=20
>>>> +test_expect_success 'error out when attempting to add ignored one=
s but add others' '
>>>> +	touch a.if &&
>>>> +	test_must_fail git add a.?? &&
>>>> +	! (git ls-files | grep "\\.ig") &&
>>>> +	(git ls-files | grep a.if)
>>>> +'
>> [...]
>>
>> 2 small comments:
>> Why the escaped "\\.ig" and the unescaped "a.if"  ?
>=20
> I agree that is inconsistent, and I don't see any reason for it.
>=20
>> The other question, this is a more general one, strikes me every tim=
e I see
>> ! grep
>>
>> Should we avoid it by writing "test_must_fail" instead of "!" ?
>=20
> No. The point of test_must_fail over "!" is to check that not only do=
es
> the command fail, but it fails with a clean exit rather than a signal
> death.  The general philosophy is that this is useful for git (which =
we
> are testing), and not for third-party tools that we are using to chec=
k
> our outputs. In other words, we do not expect grep to segfault, and d=
o
> not need to bother checking it.
>=20
> I do not think there is a real _downside_ to using test_must_fail for
> grep, except that it is a bit more verbose.
We may burn CPU cycles=20
>=20
> And that describes the goal, of course; actual implementation has bee=
n
> less consistent. Possibly because I do not know that those instructio=
ns
> are written down anywhere.=20
There is a hint in test-lib-functions.sh, but a short notice in CodingG=
uidelines
could be useful, once there is an agreement about grep, which I think w=
e have.=20
> We usually catch such things in review these
> days, but there are many inconsistent spots in the existing suite.
>=20
>> The following came into my mind when working on another grepy thing,
>> and it may be unnecessary clumsy:
>>
>> test_expect_success 'error out when attempting to add ignored ones b=
ut add others' '
>> 	touch a.if &&
>> 	test_must_fail git add a.?? &&
>> 	git ls-files >files.txt &&
>> 	test_must_fail grep a.ig files.txt >/dev/null &&
>> 	grep a.if files.txt >/dev/null &&
>> 	rm files.txt
>=20
> Right, my "allergic to pipes" was basically advocating using a tempfi=
le.
> But as noted above, it should remain "! grep" here. And there is no n=
eed
> to redirect the output of grep, as the test suite does it already (in
> fact, it is preferable not to, because somebody debugging the test wi=
th
> "-v" will get more output).
>=20
> -Peff

I counted 19 "test_must_fail grep" under t/*sh, and 201 "! grep".

As a general rule for further review of shell scripts can we say ?
! git                # incorrect, we don't capture e.g. segfaults of si=
gnal=20
test_must_fail grep  # correct, but not preferred for new code
! grep               # preferred for new code
test_must_fail git   # correct
