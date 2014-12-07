From: Jeff King <peff@peff.net>
Subject: Re: Accept-language test fails on Mac OS
Date: Sun, 7 Dec 2014 02:18:28 -0500
Message-ID: <20141207071827.GA31014@peff.net>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
 <xmqqppbxogli.fsf@gitster.dls.corp.google.com>
 <CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>
 <5482D180.9010002@web.de>
 <CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com>
 <54836F46.9080009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: semtlenori@gmail.com, Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 08:37:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxWOq-0006vZ-Rf
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 08:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbaLGHSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 02:18:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:49551 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752347AbaLGHSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 02:18:30 -0500
Received: (qmail 4792 invoked by uid 102); 7 Dec 2014 07:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 01:18:30 -0600
Received: (qmail 15406 invoked by uid 107); 7 Dec 2014 07:18:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 02:18:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Dec 2014 02:18:28 -0500
Content-Disposition: inline
In-Reply-To: <54836F46.9080009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260974>

On Sat, Dec 06, 2014 at 10:04:06PM +0100, Torsten B=C3=B6gershausen wro=
te:

> I get this:
>=20
>=20
> expecting success:=20
>         check_language "ko-KR, *;q=3D0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_=
JP.UTF-8 en_US.UTF-8 &&
>         check_language "de-DE, *;q=3D0.1" ""          de_DE.UTF-8 ja_=
JP.UTF-8 en_US.UTF-8 &&
>         check_language "ja-JP, *;q=3D0.1" ""          ""          ja_=
JP.UTF-8 en_US.UTF-8 &&
>         check_language "en-US, *;q=3D0.1" ""          ""          "" =
         en_US.UTF-8
>=20
> --- expect      2014-12-06 21:00:59.000000000 +0000
> +++ actual      2014-12-06 21:00:59.000000000 +0000
> @@ -1 +0,0 @@
> -Accept-Language: de-DE, *;q=3D0.1
> not ok 25 - git client sends Accept-Language based on LANGUAGE, LC_AL=
L, LC_MESSAGES and LANG

I can reproduce the same problem here (Debian unstable). I actually ran
into three issues (aside from needing to use Junio's SQUASH commit, to
avoid the "\r" bash-ism):

  1. I couldn't build without including locale.h, for the
     definition of setlocale() and the LC_MESSAGES constant (both used
     in get_preferred_languages).

     I'm not sure what portability issues there are with including it
     unconditionally. Should this possibly be tied into gettext.c, whic=
h
     already uses setlocale?

  2. The call to setlocale(LC_MESSAGES, NULL) in get_preferred_language=
s
     always returns "C" for me. This seems related to building with
     NO_GETTEXT (which I typically do), as we never init setlocale
     if NO_GETTEXT is set. This program demonstrates it:

	#include <stdio.h>
	#include <string.h>
	#include <locale.h>
=09
	int main(int argc, char **argv)
	{
		if (argv[1] && !strcmp(argv[1], "init"))
			setlocale(LC_MESSAGES, "");
		printf("%s", setlocale(LC_MESSAGES, NULL));
		return 0;
	}

     If I run it as "LANG=3Den_US.UTF-8 ./a.out", it prints "C". If I r=
un
     it as "LANG=3Den_US.UTF-8 ./a.out init", it prints "en_US.UTF-8". =
I
     think we either need to start unconditionally calling setlocale()
     as we do in git_setup_gettext, or we need to tie your feature to
     using gettext.

     This is what causes the failure of the de-DE test for me; building
     without NO_GETTEXT makes it work. Note that this doesn't affect th=
e
     first test for ko-KR, because that test sets LANGUAGE, which we
     read ourselves (so we never make a setlocale() call).

  3. Even building with NO_GETTEXT, setlocale() does not want to
     report ja_JP.UTF-8 for me, making the third test fail.

     I think the issue is that I do not build the ja_JP locale on my
     system. Running "dpkg-reconfigure locales" and asking it to build
     ja_JP.UTF-8 makes the test pass. This is somewhat of a Debian-ism.
     From "man locale-gen":

       By default, the locale package which provides the base support
       for localisation of libc-based programs does not contain usable
       localisation files for every supported language. This limitation
       has became necessary because of the substantial size of such
       files and the large number of languages supported by libc. As a
       result, Debian uses a special mechanism where we prepare the
       actual localisation files on the target host and distribute only
       the templates for them.

     I suspect it is inherited by Debian derivatives like Ubuntu. But I
     also don't know that we can count on other platforms having all of
     the locales either (e.g., they may ship them as separate packages,
     not all of which are installed).

     So I'm not sure of an easy way around this. You want 4 separate
     locales to thoroughly test, but you cannot rely on any particular
     locale being present on the user's system.

     Note that this is just a problem with the tests, probably not with
     the feature itself. Presumably people setting LANG=3Dja_JP actuall=
y
     have that locale on their system (though technically this feature
     is about asking the _server_ to use that language, it seems like
     you would do so because you were using that language locally, too)=
=2E

-Peff
