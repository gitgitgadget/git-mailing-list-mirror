From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH/RFC] grep: optionally show only the match
Date: Mon, 10 Sep 2012 18:43:32 +0200
Message-ID: <504E18B4.5050000@lsrfire.ath.cx>
References: <1347227905-2398-1-git-send-email-mk@acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:43:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB75U-0002zy-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2IJQno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Sep 2012 12:43:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:42358 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab2IJQnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:43:41 -0400
Received: from [192.168.2.105] (p4FFD9777.dip.t-dialin.net [79.253.151.119])
	by india601.server4you.de (Postfix) with ESMTPSA id D129513E;
	Mon, 10 Sep 2012 18:43:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <1347227905-2398-1-git-send-email-mk@acc.umu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205144>

Am 09.09.2012 23:58, schrieb Marcus Karlsson:
> Make git-grep optionally omit the parts of the line before and after =
the
> match.
>
> Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
> ---
>   Documentation/git-grep.txt | 8 +++++++-
>   builtin/grep.c             | 2 ++
>   grep.c                     | 7 +++++--
>   grep.h                     | 1 +
>   4 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index cfecf84..6ef22cb 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -20,7 +20,8 @@ SYNOPSIS
>   	   [-c | --count] [--all-match] [-q | --quiet]
>   	   [--max-depth <depth>]
>   	   [--color[=3D<when>] | --no-color]
> -	   [--break] [--heading] [-p | --show-function]
> +	   [--break] [--heading] [-o | --only-matching]
> +	   [-p | --show-function]
>   	   [-A <post-context>] [-B <pre-context>] [-C <context>]
>   	   [-W | --function-context]
>   	   [-f <file>] [-e] <pattern>
> @@ -183,6 +184,11 @@ OPTIONS
>   	Show the filename above the matches in that file instead of
>   	at the start of each shown line.
>
> +-o::
> +--only-matching::
> +	Show only the part of the matching line that matched the
> +	pattern.
> +
>   -p::
>   --show-function::
>   	Show the preceding line that contains the function name of
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 09ca4c9..56aba7b 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -782,6 +782,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>   			N_("print empty line between matches from different files")),
>   		OPT_BOOLEAN(0, "heading", &opt.heading,
>   			N_("show filename only once above matches from same file")),
> +		OPT_BOOLEAN('o', "only-matching", &opt.only_matching,
> +			N_("show only the matching part of a matched line")),
>   		OPT_GROUP(""),
>   		OPT_CALLBACK('C', "context", &opt, N_("n"),
>   			N_("show <n> context lines before and after matches"),
> diff --git a/grep.c b/grep.c
> index 04e3ec6..9fc888e 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -827,7 +827,9 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
>   			if (match.rm_so =3D=3D match.rm_eo)
>   				break;
>
> -			output_color(opt, bol, match.rm_so, line_color);
> +			if (opt->only_matching =3D=3D 0)
> +				output_color(opt, bol, match.rm_so,
> +					     line_color);
>   			output_color(opt, bol + match.rm_so,
>   				     match.rm_eo - match.rm_so,
>   				     opt->color_match);
> @@ -837,7 +839,8 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
>   		}
>   		*eol =3D ch;
>   	}
> -	output_color(opt, bol, rest, line_color);
> +	if (opt->only_matching =3D=3D 0)
> +		output_color(opt, bol, rest, line_color);
>   	opt->output(opt, "\n", 1);
>   }

The implementation keeps only the coloured parts.  However, they are no=
t=20
necessarily the same as the matching parts.  This is more complicated=20
with git grep than with regular grep because the former has the=20
additional options --and and --not.  Consider this:

	$ git grep --not -e bla --or --not -e blub

Lines with only either "bla" or "blub" (or none of them) will be shown,=
=20
lines with both not.  Both "bla" and "blub" will be highlighted.  The=20
matching part is always the whole shown line.

Ren=E9
