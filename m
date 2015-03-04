From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: correct help string for --exclude-standard
Date: Wed, 4 Mar 2015 05:16:06 -0500
Message-ID: <20150304101606.GB15788@peff.net>
References: <1425045718-30696-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:16:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT6Li-0001gW-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 11:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921AbbCDKQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 05:16:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:56174 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753917AbbCDKQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 05:16:09 -0500
Received: (qmail 1103 invoked by uid 102); 4 Mar 2015 10:16:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 04:16:09 -0600
Received: (qmail 29154 invoked by uid 107); 4 Mar 2015 10:16:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 05:16:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 05:16:06 -0500
Content-Disposition: inline
In-Reply-To: <1425045718-30696-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264747>

On Fri, Feb 27, 2015 at 09:01:58PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> The current help string is about --no-exclude-standard. But "git grep=
 -h"
> would show --exclude-standard instead. Flip the string. See 0a93fb8
> (grep: teach --untracked and --exclude-standard options - 2011-09-27)
> for more info about these options.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4063882..e77f7cf 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -641,7 +641,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  		OPT_BOOL(0, "untracked", &untracked,
>  			N_("search in both tracked and untracked files")),
>  		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
> -			    N_("search also in ignored files"), 1),
> +			    N_("ignore files specified via '.gitignore'"), 1),

Hmm. If the default is "--exclude-standard", then what expect people to
use is "--no-exclude-standard". Would it make more sense to list that i=
n
the "-h" output? Sadly I think to do that you have to manually specify
"--no-exclude-standard" with OPT_NONEG, and then manually specify
"--exclude-standard" in addition with OPT_HIDDEN.

It might be nice if parseopt had a PARSE_OPT_NEGHELP option or somethin=
g
to show the "--no-" form. Something like:

diff --git a/builtin/grep.c b/builtin/grep.c
index 9262b73..c03c3e7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -640,8 +640,10 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			 N_("find in contents not managed by git"), 1),
 		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
-		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
-			    N_("search also in ignored files"), 1),
+		{ OPTION_SET_INT, 0, "exclude-standard", &opt_exclude,
+		  NULL, N_("search also in ignored files"),
+		  PARSE_OPT_NOARG | PARSE_OPT_NEGHELP,
+		  NULL, 1 },
 		OPT_GROUP(""),
 		OPT_BOOL('v', "invert-match", &opt.invert,
 			N_("show non-matching lines")),
diff --git a/parse-options.c b/parse-options.c
index 80106c0..0ba7dc4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -599,8 +599,12 @@ static int usage_with_options_internal(struct pars=
e_opt_ctx_t *ctx,
 		}
 		if (opts->long_name && opts->short_name)
 			pos +=3D fprintf(outfile, ", ");
-		if (opts->long_name)
-			pos +=3D fprintf(outfile, "--%s", opts->long_name);
+		if (opts->long_name) {
+			int neg =3D opts->flags & PARSE_OPT_NEGHELP;
+			pos +=3D fprintf(outfile, "--%s%s",
+				       neg ? "no-" : "",
+				       opts->long_name);
+		}
 		if (opts->type =3D=3D OPTION_NUMBER)
 			pos +=3D utf8_fprintf(outfile, _("-NUM"));
=20
diff --git a/parse-options.h b/parse-options.h
index 7940bc7..e688c32 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -37,6 +37,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT =3D 16,
 	PARSE_OPT_NODASH =3D 32,
 	PARSE_OPT_LITERAL_ARGHELP =3D 64,
+	PARSE_OPT_NEGHELP =3D 128,
 	PARSE_OPT_SHELL_EVAL =3D 256
 };
=20

Though it is annoying that we have to give up the nice OPT_SET_INT macr=
o
to specify an extra flag.

-Peff
