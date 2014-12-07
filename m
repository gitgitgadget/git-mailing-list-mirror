From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Accept-language test fails on Mac OS
Date: Sun, 07 Dec 2014 11:03:14 +0100
Message-ID: <548425E2.5080503@web.de>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com> <xmqqppbxogli.fsf@gitster.dls.corp.google.com> <CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com> <5482D180.9010002@web.de> <CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com> <54836F46.9080009@web.de> <20141207071827.GA31014@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: semtlenori@gmail.com, Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 11:03:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxYgX-0001vA-2M
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 11:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbaLGKDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 05:03:21 -0500
Received: from mout.web.de ([212.227.15.3]:54589 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbaLGKDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 05:03:19 -0500
Received: from birne.local ([78.72.72.190]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0Mef0K-1YLqpv2WzY-00OHuX; Sun, 07 Dec 2014 11:03:15
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141207071827.GA31014@peff.net>
X-Provags-ID: V03:K0:s9oehANVbgSs4f32g0z5K/QZ/oC6MfCA2xz4st4AFHuYWIIknwg
 yTTJHtY8Z5945KFSdbbrr38KB+PcCLQDMZZRfnbumrXIVJXzQXZXVxW62a0/zQxwG89Yx/O
 4WekAx/CdkxnUri1D0+6YnyUhwFbtUJ7keibkdzMrxbizIXlQhDQr2/eY/bVDBryDnnMLZS
 KdcjKpVSERLguYIEXSDvw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260982>

On 07.12.14 08:18, Jeff King wrote:
> On Sat, Dec 06, 2014 at 10:04:06PM +0100, Torsten B=C3=B6gershausen w=
rote:
>=20
>> I get this:
>>
>>
>> expecting success:=20
>>         check_language "ko-KR, *;q=3D0.1" ko_KR.UTF-8 de_DE.UTF-8 ja=
_JP.UTF-8 en_US.UTF-8 &&
>>         check_language "de-DE, *;q=3D0.1" ""          de_DE.UTF-8 ja=
_JP.UTF-8 en_US.UTF-8 &&
>>         check_language "ja-JP, *;q=3D0.1" ""          ""          ja=
_JP.UTF-8 en_US.UTF-8 &&
>>         check_language "en-US, *;q=3D0.1" ""          ""          ""=
          en_US.UTF-8
>>
>> --- expect      2014-12-06 21:00:59.000000000 +0000
>> +++ actual      2014-12-06 21:00:59.000000000 +0000
>> @@ -1 +0,0 @@
>> -Accept-Language: de-DE, *;q=3D0.1
>> not ok 25 - git client sends Accept-Language based on LANGUAGE, LC_A=
LL, LC_MESSAGES and LANG
>=20
> I can reproduce the same problem here (Debian unstable). I actually r=
an
> into three issues (aside from needing to use Junio's SQUASH commit, t=
o
> avoid the "\r" bash-ism):
>=20
>   1. I couldn't build without including locale.h, for the
>      definition of setlocale() and the LC_MESSAGES constant (both use=
d
>      in get_preferred_languages).
>=20
>      I'm not sure what portability issues there are with including it
>      unconditionally. Should this possibly be tied into gettext.c, wh=
ich
>      already uses setlocale?
>=20
>   2. The call to setlocale(LC_MESSAGES, NULL) in get_preferred_langua=
ges
>      always returns "C" for me. This seems related to building with
>      NO_GETTEXT (which I typically do), as we never init setlocale
>      if NO_GETTEXT is set. This program demonstrates it:
>=20
> 	#include <stdio.h>
> 	#include <string.h>
> 	#include <locale.h>
> =09
> 	int main(int argc, char **argv)
> 	{
> 		if (argv[1] && !strcmp(argv[1], "init"))
> 			setlocale(LC_MESSAGES, "");
> 		printf("%s", setlocale(LC_MESSAGES, NULL));
> 		return 0;
> 	}
>=20
>      If I run it as "LANG=3Den_US.UTF-8 ./a.out", it prints "C". If I=
 run
>      it as "LANG=3Den_US.UTF-8 ./a.out init", it prints "en_US.UTF-8"=
=2E I
>      think we either need to start unconditionally calling setlocale(=
)
>      as we do in git_setup_gettext, or we need to tie your feature to
>      using gettext.
>=20
>      This is what causes the failure of the de-DE test for me; buildi=
ng
>      without NO_GETTEXT makes it work. Note that this doesn't affect =
the
>      first test for ko-KR, because that test sets LANGUAGE, which we
>      read ourselves (so we never make a setlocale() call).
>=20
>   3. Even building with NO_GETTEXT, setlocale() does not want to
>      report ja_JP.UTF-8 for me, making the third test fail.
>=20
>      I think the issue is that I do not build the ja_JP locale on my
>      system. Running "dpkg-reconfigure locales" and asking it to buil=
d
>      ja_JP.UTF-8 makes the test pass. This is somewhat of a Debian-is=
m.
>      From "man locale-gen":
>=20
>        By default, the locale package which provides the base support
>        for localisation of libc-based programs does not contain usabl=
e
>        localisation files for every supported language. This limitati=
on
>        has became necessary because of the substantial size of such
>        files and the large number of languages supported by libc. As =
a
>        result, Debian uses a special mechanism where we prepare the
>        actual localisation files on the target host and distribute on=
ly
>        the templates for them.
>=20
>      I suspect it is inherited by Debian derivatives like Ubuntu. But=
 I
>      also don't know that we can count on other platforms having all =
of
>      the locales either (e.g., they may ship them as separate package=
s,
>      not all of which are installed).
>=20
>      So I'm not sure of an easy way around this. You want 4 separate
>      locales to thoroughly test, but you cannot rely on any particula=
r
>      locale being present on the user's system.
>=20
>      Note that this is just a problem with the tests, probably not wi=
th
>      the feature itself. Presumably people setting LANG=3Dja_JP actua=
lly
>      have that locale on their system (though technically this featur=
e
>      is about asking the _server_ to use that language, it seems like
>      you would do so because you were using that language locally, to=
o).
>=20
> -Peff
> --
(I remember debugging t0204 some time ago)

We may get inspiration from this, either how to adjust the locale to be=
 used,
or if the test should be skipped.

 grep -l is_IS *
lib-gettext.sh
t0200-gettext-basic.sh
t0203-gettext-setlocale-sanity.sh
t0204-gettext-reencode-sanity.sh
