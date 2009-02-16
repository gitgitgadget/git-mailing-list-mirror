From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2] git-archive: Add new option "--output" to write archive
   to a file instead of stdout.
Date: Mon, 16 Feb 2009 21:11:48 +0100
Message-ID: <4999C884.5050209@lsrfire.ath.cx>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D5@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: carlos.duclos@nokia.com
X-From: git-owner@vger.kernel.org Mon Feb 16 21:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ9qK-0008LQ-AS
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 21:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbZBPUL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 15:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZBPUL6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 15:11:58 -0500
Received: from india601.server4you.de ([85.25.151.105]:43202 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZBPUL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 15:11:57 -0500
Received: from [10.0.1.101] (p57B7D33D.dip.t-dialin.net [87.183.211.61])
	by india601.server4you.de (Postfix) with ESMTPSA id 720092F8057;
	Mon, 16 Feb 2009 21:11:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <599636D7828020419E3AB2DE5CCC8130036BF8B1D5@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110232>

carlos.duclos@nokia.com schrieb:
> NOTE: I can only use a webmail client, so some of the tabs might have
> overwritten by it. If  that's the case I'll resend the patch as MIME
> attachment.

Please do, as applying the patch as-is would be difficult, painful even=
=2E

> When archiving a repository there is no way to specify a file as outp=
ut.
> This patch adds a new option "--output" that redirects the output to =
a
> file instead of stdout.
>=20
> Signed-off by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
> ---
>  Documentation/git-archive.txt |    3 +
>  archive-zip.c                 |    1 -
>  archive.c                     |   17 +++++
>  t/t0024-crlf-archive.sh       |   19 +++++
>  t/t5000-tar-tree.sh           |  148 +++++++++++++++++++++++++++++++=
++++++++++
>  5 files changed, 187 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archiv=
e.txt
> index 41cbf9c..04b05f3 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -47,6 +47,9 @@ OPTIONS
>  --prefix=3D<prefix>/::
>         Prepend <prefix>/ to each filename in the archive.
>=20
> +--output=3D<file>::
> +       Writes the archive to <file> instead of stdout.

Please use imperative ("Write") instead of present tense to match the
style used to describe other options.

> +
>  <extra>::
>         This can be any options that the archiver backend understand.
>         See next section.
> diff --git a/archive-zip.c b/archive-zip.c
> index cf28504..de5e540 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -266,7 +266,6 @@ int write_zip_archive(struct archiver_args *args)
>         int err;
>=20
>         dos_time(&args->time, &zip_date, &zip_time);
> -
>         zip_dir =3D xmalloc(ZIP_DIRECTORY_MIN_SIZE);
>         zip_dir_size =3D ZIP_DIRECTORY_MIN_SIZE;
>=20

This hunk doesn't seem to belong in here.

> diff --git a/archive.c b/archive.c
> index e6de039..fde8602 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -239,6 +239,18 @@ static void parse_treeish_arg(const char **argv,
>         ar_args->time =3D archive_time;
>  }
>=20
> +static void create_output_file(const char *output_file)
> +{
> +       int output_fd =3D creat(output_file, 0666);
> +       if (output_fd < 0)
> +               die("could not create archive file");

Reporting the file name here could help the user to spot typos.

> +       if (dup2(output_fd, 1) !=3D 1)
> +       {
> +               close(output_fd);
> +               die("could not redirect output");
> +       }
> +}

Style:
	if (condition) {
		do(something);
		...
	}

output_fd can be closed after dup2()ing.

A successful dup2() call can return 0 on some systems (mingw here).

> +
>  #define OPT__COMPR(s, v, h, p) \
>         { OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
>           PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
> @@ -253,6 +265,7 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>         const char *base =3D NULL;
>         const char *remote =3D NULL;
>         const char *exec =3D NULL;
> +    const char *output =3D NULL;

One tab indent, please.

>         int compression_level =3D -1;
>         int verbose =3D 0;
>         int i;
> @@ -262,6 +275,7 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>                 OPT_STRING(0, "format", &format, "fmt", "archive form=
at"),
>                 OPT_STRING(0, "prefix", &base, "prefix",
>                         "prepend prefix to each pathname in the archi=
ve"),
> +               OPT_STRING(0, "output", &output, "file", "write the r=
esults to this file"),

Please wrap lines to fit into 80 columns, like it was done for the
preceding option.  And perhaps replace "results" with "archive"?

>                 OPT__VERBOSE(&verbose),
>                 OPT__COMPR('0', &compression_level, "store only", 0),
>                 OPT__COMPR('1', &compression_level, "compress faster"=
, 1),
> @@ -294,6 +308,9 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>         if (!base)
>                 base =3D "";
>=20
> +       if(output)
> +               create_output_file(output);
> +

Ah, you make it possible to write the list of formats into a file,
too, as Junio mentioned.  So the "results" above is correct after
all.  But is this intended?

>         if (list) {
>                 for (i =3D 0; i < ARRAY_SIZE(archivers); i++)
>                         printf("%s\n", archivers[i].name);
> diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
> index e533039..237a8f6 100755
> --- a/t/t0024-crlf-archive.sh
> +++ b/t/t0024-crlf-archive.sh
> @@ -26,6 +26,15 @@ test_expect_success 'tar archive' '
>=20
>  '
>=20
> +test_expect_success 'tar archive output redirected' '
> +
> +       git archive --format=3Dtar --output=3Dtest.tar HEAD &&
> +       ( mkdir untarred2 && cd untarred2 && "$TAR" -xf ../test.tar )
> +
> +       test_cmp sample untarred2/sample
> +
> +'
> +
>  "$UNZIP" -v >/dev/null 2>&1
>  if [ $? -eq 127 ]; then
>         echo "Skipping ZIP test, because unzip was not found"
> @@ -43,4 +52,14 @@ test_expect_success 'zip archive' '
>=20
>  '
>=20
> +test_expect_success 'zip archive output redirected' '
> +
> +       git archive --format=3Dzip --output=3Dtest.zip HEAD &&
> +
> +       ( mkdir unzipped2 && cd unzipped2 && unzip ../test.zip ) &&
> +
> +       test_cmp sample unzipped2/sample
> +
> +'
> +
>  test_done
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index c942c8b..b11e504 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -66,6 +66,11 @@ test_expect_success \
>      'remove ignored file' \
>      'rm a/ignored'
>=20
> +
> +#
> +# Tar tests
> +#
> +
>  test_expect_success \
>      'git archive' \
>      'git archive HEAD >b.tar'
> @@ -160,6 +165,91 @@ test_expect_success \
>        diff a/substfile2 g/prefix/a/substfile2
>  '
>=20
> +#
> +# Same tests as above but now using redirection
> +#
> +
> +test_expect_success \
> +    'git archive' \
> +    'git archive --output=3Db20.tar HEAD'
> +
> +test_expect_success \
> +    'git tar-tree' \
> +    'git tar-tree HEAD >b21.tar'
> +
> +test_expect_success \
> +    'git archive vs. git tar-tree' \
> +    'diff b20.tar b21.tar'
> +
> +test_expect_success \
> +    'git archive in a bare repo' \
> +    '(cd bare.git && git archive --output=3D../b22.tar HEAD)'
> +
> +test_expect_success \
> +    'git archive vs. the same in a bare repo' \
> +    'test_cmp b20.tar b22.tar'
> +
> +test_expect_success \
> +    'validate file modification time' \
> +    'mkdir extract2 &&
> +     "$TAR" xf b20.tar -C extract2 a/a &&
> +     test-chmtime -v +0 extract2/a/a |cut -f 1 >b20.mtime &&
> +     echo "1117231200" >expected.mtime &&
> +     diff expected.mtime b20.mtime'
> +
> +test_expect_success \
> +    'git get-tar-commit-id' \
> +    'git get-tar-commit-id <b20.tar >b20.commitid &&
> +     diff .git/$(git symbolic-ref HEAD) b20.commitid'
> +
> +test_expect_success \
> +    'extract tar archive' \
> +    '(mkdir b20 && cd b20 && "$TAR" xf -) <b20.tar'
> +
> +test_expect_success \
> +    'validate filenames' \
> +    '(cd b20/a && find .) | sort >b20.lst &&
> +     diff a.lst b20.lst'
> +
> +test_expect_success \
> +    'validate file contents' \
> +    'diff -r a b20/a'
> +
> +test_expect_success \
> +    'create archives with substfiles' \
> +    'echo "substfile?" export-subst >a/.gitattributes &&
> +     git archive --output=3Df20.tar HEAD &&
> +     git archive --prefix=3Dprefix/ --output=3Dg20.tar HEAD &&
> +     rm a/.gitattributes'
> +
> +test_expect_success \
> +    'extract substfiles' \
> +    '(mkdir f20 && cd f20 && "$TAR" xf -) <f20.tar'
> +
> +test_expect_success \
> +     'validate substfile contents' \
> +     'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" H=
EAD \
> +      >f20/a/substfile1.expected &&
> +      diff f20/a/substfile1.expected f20/a/substfile1 &&
> +      diff a/substfile2 f20/a/substfile2
> +'
> +
> +test_expect_success \
> +    'extract substfiles from archive with prefix' \
> +    '(mkdir g20 && cd g20 && "$TAR" xf -) <g20.tar'
> +
> +test_expect_success \
> +     'validate substfile contents from archive with prefix' \
> +     'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" H=
EAD \
> +      >g20/prefix/a/substfile1.expected &&
> +      diff g20/prefix/a/substfile1.expected g20/prefix/a/substfile1 =
&&
> +      diff a/substfile2 g20/prefix/a/substfile2
> +'
> +
> +#
> +# Zip tests
> +#
> +
>  test_expect_success \
>      'git archive --format=3Dzip' \
>      'git archive --format=3Dzip HEAD >d.zip'
> @@ -172,6 +262,26 @@ test_expect_success \
>      'git archive --format=3Dzip vs. the same in a bare repo' \
>      'test_cmp d.zip d1.zip'
>=20
> +#
> +# Same tests as above but now using redirection
> +#
> +
> +test_expect_success \
> +    'git archive --format=3Dzip --output=3Dd10.zip' \
> +    'git archive --format=3Dzip --output=3Dd10.zip HEAD'
> +
> +test_expect_success \
> +    'git archive --format=3Dzip --output=3Dd11.zip in a bare repo' \
> +    '(cd bare.git && git archive --format=3Dzip --output=3D../d11.zi=
p HEAD)'
> +
> +test_expect_success \
> +    'git archive --format=3Dzip redirected output vs. the same in a =
bare repo' \
> +    'test_cmp d10.zip d11.zip'
> +
> +#
> +# Zip tests
> +#
> +
>  $UNZIP -v >/dev/null 2>&1
>  if [ $? -eq 127 ]; then
>         echo "Skipping ZIP tests, because unzip was not found"
> @@ -213,4 +323,42 @@ test_expect_success \
>      'git archive --list outside of a git repo' \
>      'GIT_DIR=3Dsome/non-existing/directory git archive --list'
>=20
> +#
> +# Same tests as above but now with redirected output
> +#
> +
> +test_expect_success \
> +    'extract ZIP archive from redirected output  archive' \
> +    '(mkdir d10 && cd d10 && $UNZIP ../d10.zip)'
> +
> +test_expect_success \
> +    'validate filenames from redirected output  archive' \
> +    '(cd d10/a && find .) | sort >d10.lst &&
> +     diff a.lst d10.lst'
> +
> +test_expect_success \
> +    'validate file contents from redirected output  archive' \
> +    'diff -r a d10/a'
> +
> +test_expect_success \
> +    'git archive --format=3Dzip with prefix from redirected output  =
archive' \
> +    'git archive --format=3Dzip --prefix=3Dprefix/ --output=3De10.zi=
p HEAD'
> +
> +test_expect_success \
> +    'extract ZIP archive with prefix from redirected output  archive=
' \
> +    '(mkdir e10 && cd e10 && $UNZIP ../e10.zip)'
> +
> +test_expect_success \
> +    'validate filenames with prefix from redirected output  archive'=
 \
> +    '(cd e10/prefix/a && find .) | sort >e10.lst &&
> +     diff a.lst e10.lst'
> +
> +test_expect_success \
> +    'validate file contents with prefix from redirected output  arch=
ive' \
> +    'diff -r a e10/prefix/a'
> +
> +test_expect_success \
> +    'git archive --list outside of a git repo' \
> +    'GIT_DIR=3Dsome/non-existing/directory git archive --list'
> +
>  test_done
> --
> 1.6.2.rc0.63.g7cbd0.dirty
>=20

Lot's of tests, nice!  But I think comparing the created archive to
the one written to stdout using the same parameters is sufficient.
There's no need to untar, unzip or otherwise look at the archives
again if they are the the same.

Ren=E9
