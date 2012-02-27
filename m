From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] parse-options: remove PARSE_OPT_NEGHELP
Date: Mon, 27 Feb 2012 13:25:04 -0500
Message-ID: <20120227182504.GA1600@sigill.intra.peff.net>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49336C.3000303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:25:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25G7-00082x-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab2B0SZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 13:25:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58877
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab2B0SZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:25:07 -0500
Received: (qmail 28580 invoked by uid 107); 27 Feb 2012 18:25:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 13:25:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 13:25:04 -0500
Content-Disposition: inline
In-Reply-To: <4F49336C.3000303@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191643>

On Sat, Feb 25, 2012 at 08:15:56PM +0100, Ren=C3=A9 Scharfe wrote:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index e4ea900..b151467 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -671,7 +671,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
>  	int i;
>  	int dummy;
> -	int use_index =3D 1;
> +	int no_index =3D 0;
>  	enum {
>  		pattern_type_unspecified =3D 0,
>  		pattern_type_bre,
> @@ -684,9 +684,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  	struct option options[] =3D {
>  		OPT_BOOLEAN(0, "cached", &cached,
>  			"search in index instead of in the work tree"),
> -		{ OPTION_BOOLEAN, 0, "index", &use_index, NULL,
> -			"finds in contents not managed by git",
> -			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP },
> +		OPT_BOOL(0, "no-index", &no_index,
> +			 "finds in contents not managed by git"),
>  		OPT_BOOLEAN(0, "untracked", &untracked,
>  			"search in both tracked and untracked files"),
>  		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
> @@ -851,7 +850,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  		break; /* nothing */
>  	}
> =20
> -	if (use_index && !startup_info->have_repository)
> +	if (!no_index && !startup_info->have_repository)

Hmm. We usually try to avoid these sorts of double negations in the
code, as they can often make the logic hard to read. In this case, it i=
s
not _so_ bad, because out of the 4 uses of use_index/no_index, only one
is "!no_index", and it is in a relatively simple conditional.

But I do feel like the original was slightly easier to read, and that
getting rid of NEGHELP is restricting how the developer can express the
options.

I think your original motivation was that NEGHELP lead to confusion
where the name of the option does not match its description. Would it b=
e
better to simply be explicit that an option is a reversed boolean (i.e.=
,
what the user specifies on the command line and what is in the code are
naturally opposites). Like:

 OPT_REVERSE_BOOL(0, "no-index", &use_index,
             "finds in contents not managed by git"),

Using NEGHELP, the "reverse" is between the option name and the
description, which is very subtle. Here it is between the option name
and the variable, which is hopefully a little more explicit (especially
with the big REVERSE in the macro name).

I dunno. Given that there are only two uses of NEGHELP, and that they
don't come out too badly, I don't care _too_ much. But I have seen some
really tortured logic with double-negations like this, and I'm concerne=
d
that a few months down the road somebody is going to want NEGHELP (or
something similar) in a case where it actually does really impact
readability.

-Peff
