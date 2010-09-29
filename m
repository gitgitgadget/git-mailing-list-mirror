From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Re*: [PATCH] t1503: Fix arithmetic expansion syntax error when
 using dash
Date: Wed, 29 Sep 2010 20:57:40 +0100
Message-ID: <4CA39A34.4030909@ramsay1.demon.co.uk>
References: <4C98EF25.4070700@ramsay1.demon.co.uk>	<7viq1xsi7a.fsf@alter.siamese.dyndns.org>	<4C9E2CA6.2070805@ramsay1.demon.co.uk> <AANLkTimdUC++Lq1z4i5E8cw5ej7nQhZ6hcNoffQ1tM9i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jon.seymour@gmail.com
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 19:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1MiJ-0003ad-W2
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 19:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275Ab0I3ROa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 13:14:30 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:64179 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755839Ab0I3RO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 13:14:29 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1P1MiB-0001lP-bJ; Thu, 30 Sep 2010 17:14:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTimdUC++Lq1z4i5E8cw5ej7nQhZ6hcNoffQ1tM9i@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157694>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Sep 25, 2010 at 17:08, Ramsay Jones <ramsay@ramsay1.demon.co.=
uk> wrote:
>> Junio C Hamano wrote:
>>> I just left it vague by saying "e.g. older dash" in below, but we m=
ay want
>>> to be more precise in the documentation.
>> I found a bug report:
>>
>>    http://bugs.launchpad.net/ubuntu/+source/dash/+bug/92189
>>
>> which had a post against it which implied that this was fixed in
>> version 0.5.4-3. I went over to packages.debian.org to read the
>> ChangeLog for this version, but I could not conclude anything
>> from that text. :(
>>
>> Do we need to be more precise?
>=20
> If you want to spend the effort to track it down that would be
> great. There's a dash git repository on kernel.org you can probably
> bisect:
>=20
>     http://git.kernel.org/?p=3Dutils/dash/dash.git;a=3Dsummary

I don't think we need to be more precise here, but just for the
giggle, I cloned the dash repository to take a quick look.

It was actually very easy to spot the commit that adds the missing
capability; I fired up gitk and (starting from v0.5.3) just scanned
the commits "upward" until I found the culprit ;-) Having said that,
I would not have found it just by reading the commit message; I had
to read the "patch" text to discover the "fix", which I suppose
could have been an unintended side effect! :-D

BTW the answer is: commit f6e3b2f8a59922405f42c8bc283e0f5546c25d0e
or, if you prefer:

    $ git describe --tags f6e3b2f8
    v0.5.4-26-gf6e3b2f

[But this does not help too much in identifying the downstream
version(s) from, say, the debian project.]

I decided to actually perform a git-bisect to confirm that I had
actually found the correct commit. I used a script (see below) to
build and test dash, so that I could use "git bisect run ./test.sh"
to find it automatically. (The script may seem to return backward
results, but we need to consider a version that *does* support the
extended syntax to be a *bad* commit for the purposes of bisect! ;-) )

A transcript of the git-bisect run is given below.

ATB,
Ramsay Jones

$ git tag -l
v0.5.2
v0.5.3
v0.5.4
v0.5.5
v0.5.5.1
v0.5.6
v0.5.6.1

$ cat -n test.sh
     1	#!/bin/sh
     2=09
     3	make clean >/dev/null 2>&1
     4	make >make-out 2>&1 || { echo CANNOT BUILD; exit 125; }
     5=09
     6	if src/dash -c 'N=3D20; echo $(( N + 3))'
     7	then
     8		echo "--- works OK =3D> BAD ---"
     9		exit 1;
    10	else
    11		echo "--- syntax error =3D> GOOD ---"
    12		exit 0;
    13	fi

$ git bisect start v0.5.5 v0.5.3
Bisecting: 41 revisions left to test after this (roughly 5 steps)
[aa82f69dea2f2d5fe4337dfb12cea54fabdab175] [BUILTIN] Use intmax_t arith=
metic in test

$ git bisect run ./test.sh
running ./test.sh
src/dash: arith: syntax error: " N + 3"
--- syntax error =3D> GOOD ---
Bisecting: 20 revisions left to test after this (roughly 4 steps)
[f0f930d60cd62f5fe5ba28460b43f333e8062b94] [CD] Restored non-glibc getc=
wd support
running ./test.sh
23
--- works OK =3D> BAD ---
Bisecting: 10 revisions left to test after this (roughly 3 steps)
[d39c8628b8594c29d234427ba07a12538ab36f41] [PARSER] Fix here-doc corrup=
tion
running ./test.sh
23
--- works OK =3D> BAD ---
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[7454c1e3b90f51a49e563323db38bafa50776533] [BUILTIN] Use setvarint to s=
et OPTIND
running ./test.sh
23
--- works OK =3D> BAD ---
Bisecting: 2 revisions left to test after this (roughly 1 step)
[f6e3b2f8a59922405f42c8bc283e0f5546c25d0e] [ARITH] Add assignment and i=
ntmax_t support
running ./test.sh
23
--- works OK =3D> BAD ---
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[3df3edd13389ae768010bfacee5612346b413e38] [PARSER] Report substition e=
rrors at expansion time
running ./test.sh
src/dash: arith: syntax error: " N + 3"
--- syntax error =3D> GOOD ---
f6e3b2f8a59922405f42c8bc283e0f5546c25d0e is the first bad commit
commit f6e3b2f8a59922405f42c8bc283e0f5546c25d0e
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Oct 11 22:36:28 2007 +0800

    [ARITH] Add assignment and intmax_t support
   =20
    This patch adds assignment operator support in arithmetic expansion=
s.  It
    also changes the type used to intmax_t.

:100644 100644 69ba464a3219d6979aa1150c15e279d3adf423ac 895c6072294f13f=
2a434c52752dc839afd412c0b M	ChangeLog
:040000 040000 6640114c4a8d35cbcfaf6fa44b888195270a3ae1 06a80af3e532959=
cddd422f921e66cb679fc8760 M	src
bisect run success

$ git describe --tags f6e3b2f8
v0.5.4-26-gf6e3b2f

$=20
