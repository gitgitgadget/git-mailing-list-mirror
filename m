Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CCC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 05:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80801214AF
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 05:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CEqMK5Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfLKFvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:51:53 -0500
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182]:40284 "EHLO
        mr85p00im-zteg06011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbfLKFvx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Dec 2019 00:51:53 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 00:51:52 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576043008;
        bh=wrwYGVKEMr8YGjYsC6RVl6nuJJrJDfMsU48wPvUOa9U=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=CEqMK5MrWd2WTxlXFRidwTQNPiOi+iNnSvX+yf11/edBwfZVmlnPZyhyBN9008oC2
         rLhWahBUoBiu2xuFLyaOIC/XD5C/JEbVmJYrUmwy0abuS29CmSXrD/EuMUk2AAp30a
         8cygQaLtlAr+/5kqXNyEwOVAsMvRqqOL6ZVz/+wbQmeMJAPZZnAN3yak0vt0aranqJ
         HnRZtFxyASTWVihj+p36b2eEK4Rrm7PMKvSpEFe2eXj63VG8L/a1PeibcdJf/vGlfs
         RkpUQYLA/LybnDT3EirrZrJM1JVWGe88km+OKBr7rn4xZ5edqFZ9KRQBJMtb4n85Mj
         KzhnevOwgEHuQ==
Received: from [10.100.6.188] (unknown [49.255.65.138])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 02A062A00A7;
        Wed, 11 Dec 2019 05:43:26 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
Date:   Wed, 11 Dec 2019 16:43:22 +1100
Cc:     Marc Balmer <marc@msys.ch>,
        "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
 <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
 <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912110049
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Is there a minimal, complete and verifiable example that other =
developers
> could use to analyze the bug?

I ran into this bug today, and while not much closer to a solution, I =
believe I understand why it is happening.=20

The recursive search is required because the original rev-list based =
approach could leave out some relevant commits - ie reversion would =
replace an obvious bug with a hidden one.

The search will stop when it reaches either a root commit or one already =
mapped to a subtree commit.

If you have a small repo or run git subtree add directly on your master =
branch, the search will terminate fairly quickly.

However, if you do everything via pull requests, the search will hit a =
merge commit where one side is just ahead of the subtree mapping, but =
the other side is several thousand commits with no sign of either a root =
or any subtrees.

I=E2=80=99m not sure yet if it is the number of commits or merges =
specifically, but the script seems to be able to handle around 400-500 =
commits before it falls over.

>>=20
>>=20
>>> Am 09.12.2019 um 17:20 schrieb Johannes Schindelin =
<Johannes.Schindelin@gmx.de>:
>>>=20
>>> =EF=BB=BFHi,
>>>=20
>>>> On Mon, 9 Dec 2019, Marc Balmer wrote:
>>>>=20
>>>> I am not familiar with the source code, so I can not send in that
>>>> revert.  I can, however, say that I am grateful to whomever does it =
;)
>>>=20
>>> I am against reverting the change without knowing the root cause.
>>>=20
>>> The recent reporter only compared Git for Windows v2.19.0 vs =
v2.20.1,
>>> which is _quite_ a big difference.
>>>=20
>>> For what I know, the problem might be a change in the MSYS2 runtime =
that
>>> is mistaken by some malware for malicious code (we did introduce =
some code
>>> to emulate Ctrl+C in MinTTY which injects a remote thread and =
executes
>>> ExitProcess() there, which might very well be construed as an =
attack, even
>>> if it is actually very much desired behavior).
>>>=20
>>> These segmentation faults in `git subtree` on Windows have =
traditionally
>>> been _all_ because of overzealous anti-malware.
>>>=20
>>> So first, a much more fine-grained analysis would be required, e.g.
>>> comparing v2.20.1 against v2.20.0, then copying _just_ the =
`git-subtree`
>>> file from a working into a non-working version (or vice versa; I =
would
>>> highly recommend using the portable versions for such side-by side
>>> comparison).
>>>=20
>>> Ciao,
>>> Johannes
>>>=20
>>>>=20
>>>> - Marc
>>>>=20
>>>>=20
>>>>>> Am 09.12.2019 um 15:18 schrieb Strain, Roger L. =
<roger.strain@swri.org>:
>>>>>=20
>>>>> As I said, I'm using a custom script here. I don't know if anybody =
else
>>>>> benefited from the change and hasn't said anything, but I won't =
object
>>>>> to someone submitting that revert.
>>>>>=20
>>>>> --
>>>>> Roger
>>>>>=20
>>>>> -----Original Message-----
>>>>> From: Marc Balmer <marc@msys.ch>
>>>>> To: "Strain, Roger L." <roger.strain@swri.org>
>>>>> Cc: ns@nadavsinai.com <ns@nadavsinai.com>, git@vger.kernel.org <
>>>>> git@vger.kernel.org>, Johannes.Schindelin@gmx.de <
>>>>> Johannes.Schindelin@gmx.de>, gitster@pobox.com =
<gitster@pobox.com>,
>>>>> pclouds@gmail.com <pclouds@gmail.com>
>>>>> Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, =
after
>>>>> 315a84f9aa0e2e629b0680068646b0032518ebed
>>>>> Date: Mon, 09 Dec 2019 15:13:47 +0100
>>>>>=20
>>>>> Roger,
>>>>>=20
>>>>> I am all for reverting it. if that does not cause any other =
regressions
>>>>> or headaches (or both...)
>>>>>=20
>>>>> - Marc
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> Am 09.12.2019 um 15:11 schrieb Strain, Roger L. =
<roger.strain@swri.org>
>>>>> :
>>>>>=20
>>>>> I haven't been able to find anything relating to the issue, but I =
also
>>>>> haven't had a repo that exposes the problem to test more =
thoroughly
>>>>> against. If this happens to be a public repo somewhere, I'd be =
more
>>>>> than happy to take a second look.
>>>>>=20
>>>>> That being said, if the community feels it would be better to =
revert
>>>>> the changes that were introduced, I won't object. I've had to =
further
>>>>> customize the script for our internal use, and those changes =
aren't
>>>>> something that would be useful for the public at large. (A few =
changes
>>>>> relate to the presence/absence of a specific file, which I =
certainly
>>>>> wouldn't expect anyone else to have.) Short story is we're going =
to
>>>>> have to use a custom script going forward, so keeping or reverting =
the
>>>>> changes here make no difference to us. I still feel that the =
changes
>>>>> which were made make the script more correct, but clearly there's =
some
>>>>> undiagnosed logic error somewhere.
>>>>>=20
>>>>> Honestly, I'm surprised we didn't see this particular issue show =
up on
>>>>> our own repo; it's ridiculously large and complex. At least if it =
had,
>>>>> I'd be able to troubleshoot it more reliably.
>>>>>=20
>>>>> --
>>>>> Roger Strain
>>>>>=20
>>>>> -----Original Message-----
>>>>> From: Nadav SInai <ns@nadavsinai.com>
>>>>> To: roger.strain@swri.org
>>>>> Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, =
gitster@pobox.com,
>>>>> marc@msys.ch, pclouds@gmail.com
>>>>> Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, =
after
>>>>> 315a84f9aa0e2e629b0680068646b0032518ebed
>>>>> Date: Sun, 08 Dec 2019 12:30:48 +0200
>>>>>=20
>>>>> [EXTERNAL EMAIL]
>>>>>=20
>>>>> Hi, I'm curious if any of you had any luck in preventing that
>>>>> seg-fault in git-subtree script
>>>>> I'm encountering it myself using git 2.24.0.windows.2., seg-fault =
is
>>>>> in the same while loop (currently on line 757)
>>>>> When I tried your suggestion of adding the ($parents) ($rev) to =
the
>>>>> progress print I see that the last commit have only one revision
>>>>> printed
>>>>> like this:
>>>>>=20
>>>>> 259/290 (523) [271] (843dd34090d36dfabd6a2e3e8459a4887427313b)
>>>>> (a69ee056f66acf66c63f89f55d26c0cc17036623)
>>>>> 259/290 (525) [273] (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
>>>>> (843dd34090d36dfabd6a2e3e8459a4887427313b)
>>>>> 259/290 (527) [275] (82303752a428cf1d789ac9f156008adb2798b7b5)
>>>>> (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
>>>>> 259/290 (528) [276]
>>>>> (7187897883c9fb4d33d4c87a02b876f8603728ff05f0945ae2ce9f98a35135)
>>>>> 259/290 (529) [277]
>>>>> (a00a3665343439a426671958dd90ed0407a22cad9ac9f156008adb2798b7b5)
>>>>> 259/290 (530) [278]
>>>>> (90beb94ebd331c457d79d05341453f5829a50bfcd4c87a02b876f8603728ff)
>>>>> 259/290 (531) [279]
>>>>> (9582e0acbed1910173564e250f350b5cc4291a7f671958dd90ed0407a22cad)
>>>>> 259/290 (532) [280]
>>>>> (f183930d6fabd3dccdddc5ec35d754ad28caf3b879d05341453f5829a50bfc)
>>>>> 259/290 (533) [281]
>>>>> (c9309f3a38c41f7991d9e78ddb47f7e85b8521eb564e250f350b5cc4291a7f)
>>>>> 259/290 (534) [282]
>>>>> (3bcf08f63a0e2b93ecc376bd679a16c80e99e7b1ddc5ec35d754ad28caf3b8)
>>>>> 259/290 (535) [283]
>>>>> (134621bb55a0470cdf6519ce08d6909af43ce0e5d9e78ddb47f7e85b8521eb)
>>>>> 259/290 (536) [284]
>>>>> (edb3471fbba29748f9784d29b3cee1dee2df4b37c376bd679a16c80e99e7b1)
>>>>> 259/290 (537) [285]
>>>>> (dd947a095df07a32dfd56666a395a7c42b25ca116519ce08d6909af43ce0e5)
>>>>> 259/290 (538) [286]
>>>>> (a639e09d2cbe1ea1149c080c1c95b8b018340ae2784d29b3cee1dee2df4b37)
>>>>> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line =
757:
>>>>> 8853 Done                    eval "$grl"
>>>>>   8854 Segmentation fault      (core dumped) | while read rev
>>>>> parents; do
>>>>> process_split_commit "$rev" "$parents" 0;
>>>>> done
>>>>>=20
>>>>> I downgraded git to 2.19.0-windows.1 and it works now.
>>>>>=20
>>>>>=20
>>>>> I'm thankful for your insights
>>>>> Nadav Sinai
>>>>> Web Tech lead
>>>>> Philips-Algotec
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>=20
>>>>=20
>>=20
>>=20

