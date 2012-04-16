From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH i18n 03/11] i18n: parseopt: lookup help and argument
 translations when showing usage
Date: Mon, 16 Apr 2012 12:54:02 -0500
Message-ID: <20120416175402.GV5813@burratino>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
 <1334580603-11577-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:54:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJq84-00022Z-H2
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab2DPRyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 13:54:15 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40027 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2DPRyO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 13:54:14 -0400
Received: by obbta14 with SMTP id ta14so3920685obb.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I/kmix/a97sc+N2PcHgw+qWYHgd+MkdrnE3hAoHemZg=;
        b=yiIWiOSxGU4CZjkPYwi1q4wRMnaLl4pZjBbZefiqAlQ0y9GBYYejqZj/rci/TaKpSN
         L9c+X2HGdSOwvNo71t0hVInbzy3eBpaQZE/7S3EUaVqM10CudLpQlBCY/HKYI0tivDZI
         r4DYWPJQyDLuYcvUI2QAZckdaMvlt7WEf1vnhsXBaeRx81A2sRgqy+skjKx+7MFks0ik
         0olI5c+9SYCsFKPFQxFH3AxD4AUlmS1x9OSWbXThmsjkB46ZLCPM3xAI/5C8+l+yWor7
         afex6Ck1ORLE2WXhAm9Jw/ZoeG2nP3tcEynB8KwDMuuPrgmZSr7y+41lXBhhboJUwAT6
         aZaQ==
Received: by 10.182.13.8 with SMTP id d8mr17255272obc.36.1334598854232;
        Mon, 16 Apr 2012 10:54:14 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h5sm20120719oba.17.2012.04.16.10.54.10
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 10:54:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334580603-11577-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195673>

Hi again,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -490,7 +490,7 @@ static int usage_argh(const struct option *opts, =
=46ILE *outfile)

The interesting parts in this patch are strings not marked for
translation:

>  			s =3D literal ? "[%s]" : "[<%s>]";
>  	else
>  		s =3D literal ? " %s" : " <%s>";

That means the usage message will have one of the formats

	--foo[=3D<bar>]
	-f[<bar>]
	--foo <bar>
	-f <bar>

in all languages.  Makes sense.

> -	return fprintf(outfile, s, opts->argh ? opts->argh : "...");
> +	return fprintf(outfile, s, opts->argh ? _(opts->argh) : "...");

"bar" becomes "..." in all languages when the caller was too lazy to
fill it in.  I wonder if we should not just require argh to be
non-NULL for options that can take an argument and catch mistakes in
parse_options_check().

> @@ -508,13 +508,12 @@ static int usage_with_options_internal(struct p=
arse_opt_ctx_t *ctx,
>  	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
>  		fprintf(outfile, "cat <<\\EOF\n");
> =20
> -	fprintf(outfile, "usage: %s\n",
> +	fprintf_ln(outfile, _("usage: %s"),

It's too bad this doesn't share code with usage.c. :)  The prompt will
be translated in some contexts and not in others, which seems fine.

> -                                   *usagestr++);
> +                                   _(*usagestr++));

Maybe this change belongs in a separate patch that would mark the
usage strings with N_ at the same time. (*)

>  	while (*usagestr && **usagestr)
> -		fprintf(outfile, "   or: %s\n", *usagestr++);
> +		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));

Maybe worth a translators note to explain how these line up.

>  	while (*usagestr) {
> -		fprintf(outfile, "%s%s\n",
> -				**usagestr ? "    " : "",
> -				*usagestr);
> +		fprintf(outfile, "%s%s\n", **usagestr ? "    " : "",
> +			_(*usagestr));

Mph, the space is going to look wrong in other languages.

>  		usagestr++;
>  	}
> =20
> @@ -528,7 +527,7 @@ static int usage_with_options_internal(struct par=
se_opt_ctx_t *ctx,
>  		if (opts->type =3D=3D OPTION_GROUP) {
>  			fputc('\n', outfile);
>  			if (*opts->help)
> -				fprintf(outfile, "%s\n", opts->help);
> +				fprintf(outfile, "%s\n", _(opts->help));
[...]
> @@ -558,7 +557,7 @@ static int usage_with_options_internal(struct par=
se_opt_ctx_t *ctx,
>  			fputc('\n', outfile);
>  			pad =3D USAGE_OPTS_WIDTH;
>  		}
> -		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
> +		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
[...]
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -66,12 +66,14 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_=
t *ctx,
>   *
>   * `argh`::
>   *   token to explain the kind of argument this option wants. Keep i=
t
> - *   homogeneous across the repository.
> + *   homogeneous across the repository. Should be wrapped by N_() fo=
r
> + *   translation.
>   *
>   * `help`::
>   *   the short help associated to what the option does.
>   *   Must never be NULL (except for OPTION_END).
>   *   OPTION_GROUP uses this pointer to store the group header.
> + *   Should be wrapped by N_() for translation.
[...]
> @@ -158,7 +160,8 @@ struct option {
>  #define OPT_BOOLEAN OPT_COUNTUP
> =20
>  /* parse_options() will filter out the processed options and leave t=
he
> - * non-option arguments in argv[].
> + * non-option arguments in argv[]. usagestr strings should be marked
> + * for translation with N_().

Also might be worth splitting into a separate patch that adjusts
callers to use N_ at the same time.  Is there some easy way to catch
strings not in the po template that are passed to gettext() using a
variable (at runtime)?

Thanks for some food for thought.
Jonathan
