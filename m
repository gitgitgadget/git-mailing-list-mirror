From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v4] git-archive: Add new option "--output" to write archive
   to a file instead of stdout.
Date: Sat, 21 Feb 2009 21:38:04 +0100
Message-ID: <49A0662C.4010606@lsrfire.ath.cx>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1DC@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: carlos.duclos@nokia.com
X-From: git-owner@vger.kernel.org Sat Feb 21 21:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Layf4-0002gu-Mj
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 21:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbZBUUiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2009 15:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZBUUiR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 15:38:17 -0500
Received: from india601.server4you.de ([85.25.151.105]:39478 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZBUUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 15:38:16 -0500
Received: from [10.0.1.101] (p57B7E971.dip.t-dialin.net [87.183.233.113])
	by india601.server4you.de (Postfix) with ESMTPSA id 5D9FE2F8027;
	Sat, 21 Feb 2009 21:38:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <599636D7828020419E3AB2DE5CCC8130036BF8B1DC@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110980>

carlos.duclos@nokia.com schrieb:
> Hi,
>=20
> Patch attached as MIME.
>=20
> Patch highlights:
> 1. Remove duplicated tests
> 1.1 Tests are present on t0024.
> 1.2 Introduced some comments in t5000 to make it easy to read.
> 2. Removed close(2) and comments from archive.c
> 3. Rewrote commit message.
> 4. Signed off.
>=20
> Cheers!
>=20
> From 3a143244b84d80adba91f37307e30ec8fb3a6701 Mon Sep 17 00:00:00 200=
1
> From: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
> Date: Mon, 16 Feb 2009 18:20:25 +0100
> Subject: [PATCH] git-archive: add --output=3D<file> to send output to=
 a file instead of stdout.
>  When archiving a repository there is no way to specify a file as out=
put.
>  This patch adds a new option "--output" that redirects the output to=
 a file
>  instead of stdout.
>=20
> Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
> ---
>  Documentation/git-archive.txt |    3 +++
>  archive.c                     |   16 ++++++++++++++++
>  t/t0024-crlf-archive.sh       |   19 +++++++++++++++++++
>  t/t5000-tar-tree.sh           |    8 ++++++++
>  4 files changed, 46 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archiv=
e.txt
> index 41cbf9c..5bde197 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -47,6 +47,9 @@ OPTIONS
>  --prefix=3D<prefix>/::
>  	Prepend <prefix>/ to each filename in the archive.
> =20
> +--output=3D<file>::
> +	Write the archive to <file> instead of stdout.
> +
>  <extra>::
>  	This can be any options that the archiver backend understand.
>  	See next section.
> diff --git a/archive.c b/archive.c
> index e6de039..3a646e5 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -239,6 +239,16 @@ static void parse_treeish_arg(const char **argv,
>  	ar_args->time =3D archive_time;
>  }
> =20
> +static void create_output_file(const char *output_file)
> +{
> +	int output_fd =3D open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0=
666);
> +	if (output_fd < 0)
> +		die("could not create archive file: %s ", output_file);
> +	if (output_fd !=3D 1)
> +		if (dup2(output_fd, 1) < 0)
> +			die("could not redirect output");
> +}
> +

output_fd is leaked.  Sure, it points to the same file as stdout, but I
don't see why we would want to keep two handles open.  (Leaking when we
die() is OK, though.)

> diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
> index e533039..237a8f6 100755
> --- a/t/t0024-crlf-archive.sh
> +++ b/t/t0024-crlf-archive.sh
> @@ -26,6 +26,15 @@ test_expect_success 'tar archive' '
> =20
>  '
> =20
> +test_expect_success 'tar archive output redirected' '
> +
> +	git archive --format=3Dtar --output=3Dtest.tar HEAD &&
> +	( mkdir untarred2 && cd untarred2 && "$TAR" -xf ../test.tar )
> +
> +	test_cmp sample untarred2/sample
> +
> +'
> +
>  "$UNZIP" -v >/dev/null 2>&1
>  if [ $? -eq 127 ]; then
>  	echo "Skipping ZIP test, because unzip was not found"
> @@ -43,4 +52,14 @@ test_expect_success 'zip archive' '
> =20
>  '
> =20
> +test_expect_success 'zip archive output redirected' '
> +
> +	git archive --format=3Dzip --output=3Dtest.zip HEAD &&
> +
> +	( mkdir unzipped2 && cd unzipped2 && unzip ../test.zip ) &&
> +
> +	test_cmp sample unzipped2/sample

I had something even more simple in mind.  In t5000 there are these tes=
ts:

	test_expect_success \
	    'git archive' \
	    'git archive HEAD >b.tar'

	test_expect_success \
	    'git tar-tree' \
	    'git tar-tree HEAD >b2.tar'

	test_expect_success \
	    'git archive vs. git tar-tree' \
	    'diff b.tar b2.tar'

Could you add another one for archive with --output?  (The "vs." test
could be switched to test_cmp and merged with the second one, but this
should be done in a separate patch.)  The same can be done for zip.  No
untarring or unzipping needed.

t5000 is the right file for these tests, by the way, as they are not
about CR/LF issues, but basic archive functionality.

> +
> +'
> +
>  test_done
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index c942c8b..a74dd4a 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -66,6 +66,11 @@ test_expect_success \
>      'remove ignored file' \
>      'rm a/ignored'
> =20
> +
> +#
> +# Tar tests
> +#
> +
>  test_expect_success \
>      'git archive' \
>      'git archive HEAD >b.tar'
> @@ -159,6 +164,9 @@ test_expect_success \
>        diff g/prefix/a/substfile1.expected g/prefix/a/substfile1 &&
>        diff a/substfile2 g/prefix/a/substfile2
>  '
> +#
> +# Zip tests
> +#
> =20
>  test_expect_success \
>      'git archive --format=3Dzip' \
> --=20
> 1.6.2.rc0.63.g7cbd0.dirty
>=20

These comments are nice additions, but they don't belong in this patch.
Even better would be to move the zip tests into their own file (also in
a separate patch).

We're getting there. :)

Thanks,
Ren=E9
