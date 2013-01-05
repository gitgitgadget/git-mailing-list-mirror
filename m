From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [LHF] making t5000 "tar xf" tests more lenient
Date: Sat, 05 Jan 2013 19:34:19 +0100
Message-ID: <50E8722B.8010408@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 19:42:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrYht-00026c-O2
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 19:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab3AESmi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 13:42:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:36961 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab3AESmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 13:42:37 -0500
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2013 13:42:37 EST
Received: from [192.168.2.105] (p579BE462.dip.t-dialin.net [87.155.228.98])
	by india601.server4you.de (Postfix) with ESMTPSA id 0E45D81;
	Sat,  5 Jan 2013 19:34:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212705>

Am 24.12.2012 21:49, schrieb Junio C Hamano:
> I've been running testsuite on a few platforms that are unfamiliar
> to me, and was bitten by BSD implementation of tar that do not grok
> the extended pax headers.  I've already fixed one in t9502 [*1*]
> where we produce a tarball with "git archive" and then try to
> validate it with the platform implementation of "tar" so that the
> test won't barf when it sees the extended pax header.
>=20
> t5000 is littered with similar tests that break unnecessarily with
> BSD implementations.  I think what it wants to test are:
>=20
>   - "archive" produces tarball, and "tar" can extract from it.  If
>     your "tar" does not understand pax header, you may get it as an
>     extra file that shouldn't be there, but that should not cause the
>     test to fail---in real life, people without a pax-aware "tar"
>     will just ignore and remove the header and can go on.
>=20
>   - "get-tar-commmit-id" can inspect a tarball produced by "archive"
>     to recover the object name of the commit even on a platform
>     without a pax-aware "tar".
>=20
> Perhaps t5000 can be restructured like so:
>=20
>   - create a tarball with the commit-id and test with
>     "get-tar-commit-id" to validate it; also create a tarball out of
>     a tree to make sure it does not have commit-id and check with
>     "get-tar-commit-id".  Do this on any and all platform, even on
>     the ones without a pax-aware "tar".
>=20
>   - check platform implementation of "tar" early to see if extracting
>     a simple output from "git archive" results in an extra pax header
>     file.  If so, remember this fact and produce any and all tarballs
>     used in the remainder of the test by forcing ^{tree}.
>=20
> so that people on platforms without pax-aware "tar" do not have to
> install GNU tar only to pass this test.
>=20
> It would be a good exercise during the holiday week for somebody on
> BSD (it seems NetBSD is more troublesome than OpenBSD) to come up
> with a patch to help users on these platforms.

I got around to building a virtual machine with NetBSD 6.0.1, which
involved a bit of cursing because networking only seems to work when I
turn off ACPI and SMP -- and running tests is a lot more pleasant with
more than one CPU.

Anyway, I don't think the pax headers are to blame here.  The patch bel=
ow
fixes the tar failures for me, but I'm not sure why.  There must be
something special about some (not all!) directory entries with trailing
slashes after directory names.

Several ZIP tests still fail, however, because NetBSD's unzip doesn't
seem to support (our flavour of) symlinks and streamed files.

I'll take a deeper look into it over the weekend.

Ren=E9


---
 archive-tar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index 0ba3f25..fd2d3e8 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -215,6 +215,8 @@ static int write_tar_entry(struct archiver_args *ar=
gs,
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		*header.typeflag =3D TYPEFLAG_DIR;
 		mode =3D (mode | 0777) & ~tar_umask;
+		if (pathlen && path[pathlen - 1] =3D=3D '/')
+			pathlen--;
 	} else if (S_ISLNK(mode)) {
 		*header.typeflag =3D TYPEFLAG_LNK;
 		mode |=3D 0777;
--=20
1.7.12
