From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] archive: fix segfault from too long --format parameter
Date: Sun, 07 Feb 2010 11:03:05 +0100
Message-ID: <4B6E8FD9.7060905@lsrfire.ath.cx>
References: <20100207070811.GA26338@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 11:03:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne3zY-0004ij-2d
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 11:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082Ab0BGKD0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 05:03:26 -0500
Received: from india601.server4you.de ([85.25.151.105]:44503 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0BGKDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 05:03:24 -0500
Received: from [10.0.1.100] (p57B7BA5D.dip.t-dialin.net [87.183.186.93])
	by india601.server4you.de (Postfix) with ESMTPSA id 686C52F804E;
	Sun,  7 Feb 2010 11:03:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20100207070811.GA26338@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139228>

Am 07.02.2010 08:10, schrieb Jonathan Nieder:
> =E2=80=98git archive --format=3D<string of 25 characters or more>=E2=80=
=99 overflows a
> local buffer, producing a segfault here.
>=20
> The context: in commit 0f4b377 (git-archive: infer output format from
> filename when unspecified, 2009-09-14), the cmd_archive wrapper
> learned to produce a format argument for the local or remote archive
> machinery in a local buffer, but that code was missing a bounds check=
=2E
>=20
> So add the missing check.  As a belt-and-suspenders measure, also use
> snprintf to make sure the copy afterwards does not overflow.
>=20
> Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> Cc: Dmitry Potapov <dpotapov@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> I noticed this while reading over the archive code.  Thoughts?
>=20
>  builtin-archive.c   |    4 +++-
>  t/t5000-tar-tree.sh |    6 ++++++
>  2 files changed, 9 insertions(+), 1 deletions(-)
>=20
> diff --git a/builtin-archive.c b/builtin-archive.c
> index 3fb4136..94db00d 100644
> --- a/builtin-archive.c
> +++ b/builtin-archive.c
> @@ -107,7 +107,9 @@ int cmd_archive(int argc, const char **argv, cons=
t char *prefix)
>  	}
> =20
>  	if (format) {
> -		sprintf(fmt_opt, "--format=3D%s", format);
> +		if (strlen(format) > sizeof(fmt_opt) - sizeof("--format=3D"))
> +			die("git archive: format is too long: %.50s", format);
> +		snprintf(fmt_opt, sizeof(fmt_opt), "--format=3D%s", format);
>  		/*
>  		 * We have enough room in argv[] to muck it in place,
>  		 * because either --format and/or --output must have

Thanks.  I think this should go into 1.7.0.  I'd use the same format
string for the error message as archive.c, i.e. "Unknown archive format
'%s'".  Later I'd rather do this:


 builtin-archive.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 3fb4136..ffe4f4a 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -70,7 +70,7 @@ static const char *format_from_name(const char *filen=
ame)
 		return NULL;
 	ext++;
 	if (!strcasecmp(ext, "zip"))
-		return "zip";
+		return "--format=3Dzip";
 	return NULL;
 }
=20
@@ -92,33 +92,32 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
 			"retrieve the archive from remote repository <repo>"),
 		OPT_STRING(0, "exec", &exec, "cmd",
 			"path to the remote git-upload-archive command"),
-		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_END()
 	};
-	char fmt_opt[32];
=20
 	argc =3D parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
=20
 	if (output) {
 		create_output_file(output);
-		if (!format)
-			format =3D format_from_name(output);
+		format =3D format_from_name(output);
 	}
=20
 	if (format) {
-		sprintf(fmt_opt, "--format=3D%s", format);
 		/*
 		 * We have enough room in argv[] to muck it in place,
-		 * because either --format and/or --output must have
-		 * been given on the original command line if we get
-		 * to this point, and parse_options() must have eaten
-		 * it, i.e. we can add back one element to the array.
-		 * But argv[] may contain "--"; we should make it the
-		 * first option.
+		 * because --output must have been given on the
+		 * original command line if we get to this point, and
+		 * parse_options() must have eaten it, i.e. we can add
+		 * back one element to the array.  We add a fake
+		 * --format option at the beginning with the hint
+		 * derived from our output filename.  This way explicit
+		 * --format options can override it, and the fake
+		 * option is inserted before any "--" that might have
+		 * been given.
 		 */
 		memmove(argv + 2, argv + 1, sizeof(*argv) * argc);
-		argv[1] =3D fmt_opt;
+		argv[1] =3D format;
 		argv[++argc] =3D NULL;
 	}
=20
