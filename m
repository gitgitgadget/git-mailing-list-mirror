From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: recent cygwin breakage
Date: Sat, 22 Nov 2014 16:29:45 +0000
Message-ID: <5470B9F9.2060008@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 22 17:31:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsDbJ-0004UY-Gy
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 17:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbaKVQ3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Nov 2014 11:29:51 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:47110 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729AbaKVQ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 11:29:51 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 01A50401640;
	Sat, 22 Nov 2014 16:29:58 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id D60614015E4;
	Sat, 22 Nov 2014 16:29:57 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sat, 22 Nov 2014 16:29:57 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260071>

Hi Junio,

Just a quick heads-up on a recent cygwin breakage.

I updated my (64-bit) cygwin installation yesterday and (along
with many other packages) I noticed a new version of gcc (and
presumably libc) was installed (gcc v4.8.3-5 x86-64).

Unfortunately, this caused new warning to be issued when compiling
git. In particular, warnings about the implicit declaration of the
memmem(), strlcpy() and strcasestr() functions. As an example:

    CC archive.o
archive.c: In function =E2=80=98format_subst=E2=80=99:
archive.c:44:3: warning: implicit declaration of function =E2=80=98memm=
em=E2=80=99 [-Wimplicit-function-declaration]
   b =3D memmem(src, len, "$Format:", 8);
   ^
archive.c:44:5: warning: assignment makes pointer from integer without =
a cast [enabled by default]
   b =3D memmem(src, len, "$Format:", 8);
     ^

I haven't spent too long on this, but it appears that the _XOPEN_SOURCE
setting now trumps _GNU_SOURCE and _BSD_SOURCE settings. (I am guessing
that /usr/lib/gcc/x86_64-pc-cygwin/4.8.3/include-fixed/sys/cdefs.h was
changed recently to reflect the new priority).

Anyway, based on that quick squint, I changed git-compat-util.h, thus:

    diff --git a/git-compat-util.h b/git-compat-util.h
    index 400e921..cef2691 100644
    --- a/git-compat-util.h
    +++ b/git-compat-util.h
    @@ -75,7 +75,8 @@
     # endif
     #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__U=
SLC__) && \
           !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly=
__) && \
    -      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD=
__)
    +      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD=
__) && \
    +      !defined(__CYGWIN__)
     #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD=
 needs 600 for S_ISLNK() */
     #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
     #endif

=2E.. which fixed up the build for me.

However, I haven't run any tests yet. Also, I would need to check
this out on 32-bit cygwin (I haven't booted that laptop into Win XP
for quite some time!).

Hmm, I don't really know if this is an unintended side-effect of a
recent change to cygwin (or a bug), but I couldn't see any mention
of this on the cygwin mailing list. (I don't intend to report this
to that mailing list; I don't want to subscribe to (yet another)
busy list). :(

ATB,
Ramsay Jones
