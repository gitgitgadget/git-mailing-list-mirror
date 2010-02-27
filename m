From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sat, 27 Feb 2010 12:43:46 +0100
Message-ID: <4B890572.5040604@lsrfire.ath.cx>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> <1267246670-19118-5-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 12:44:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlL5q-000671-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 12:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966305Ab0B0LoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 06:44:19 -0500
Received: from india601.server4you.de ([85.25.151.105]:53115 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966278Ab0B0LoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 06:44:10 -0500
Received: from [10.0.1.100] (p57B7EFC1.dip.t-dialin.net [87.183.239.193])
	by india601.server4you.de (Postfix) with ESMTPSA id C7FCB2F80BF;
	Sat, 27 Feb 2010 12:44:08 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100216 Thunderbird/3.0.2
In-Reply-To: <1267246670-19118-5-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141194>

Am 27.02.2010 05:57, schrieb Mark Lodato:
> Colorize the filename, line number, and separator in git grep output, as
> GNU grep does.  The colors are customizable through color.grep.<slot>.
> The default is to only color the separator (in cyan), since this gives
> the biggest legibility increase without overwhelming the user with
> colors.  GNU grep also defaults cyan for the separator, but defaults to
> magenta for the filename and to green for the line number, as well.
> 
> There are a few differences from GNU grep:
> 
> 1. With --name-only, GNU grep colors the filenames, but we do not.  I do
>    not see any point to making everything the same color.

I guess they did it for consistency, so when you see "magenta" you think
"filename", and because it can be turned off with a switch.  With your
patch all filenames are coloured the same, too, by the way: using the
default foreground colour. :)

> diff --git a/builtin-grep.c b/builtin-grep.c
> index dcc3d48..43b952b 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -289,6 +289,7 @@ static int wait_all(void)
>  static int grep_config(const char *var, const char *value, void *cb)
>  {
>  	struct grep_opt *opt = cb;
> +	char *color = NULL;
>  
>  	switch (userdiff_config(var, value)) {
>  	case 0: break;
> @@ -296,17 +297,24 @@ static int grep_config(const char *var, const char *value, void *cb)
>  	default: return 0;
>  	}
>  
> -	if (!strcmp(var, "color.grep")) {
> +	if (!strcmp(var, "color.grep"))
>  		opt->color = git_config_colorbool(var, value, -1);
> -		return 0;
> -	}
> -	if (!strcmp(var, "color.grep.match")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		color_parse(value, var, opt->color_match);
> -		return 0;
> -	}
> -	return git_color_default_config(var, value, cb);
> +	else if (!strcmp(var, "color.grep.filename"))
> +		color = opt->color_filename;
> +	else if (!strcmp(var, "color.grep.linenumber"))
> +		color = opt->color_lineno;
> +	else if (!strcmp(var, "color.grep.match"))
> +		color = opt->color_match;
> +	else if (!strcmp(var, "color.grep.separator"))
> +		color = opt->color_sep;
> +	else
> +		return git_color_default_config(var, value, cb);
> +	if (!value)
> +		return config_error_nonbool(var);

color.grep without a value used to turn on colourization, now it seems
to error out.

> +	color_parse(value, var, color);
> +	if (!strcmp(color, GIT_COLOR_RESET))
> +		color[0] = '\0';

This turns off colouring if the user specified "reset" as the colour,
right?  Interesting optimization, but is it really needed?  Perhaps it's
just me, but I'd give the user the requested "<reset>text<reset>"
sequence if she asked for it, even if it's longer than and looks the
same as "text" alone.

> diff --git a/grep.c b/grep.c
> index a0864f1..132798d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -506,35 +506,52 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
>  	return hit;
>  }
>  
> +static void output_color(struct grep_opt *opt, const void *data, size_t size,
> +			 const char *color)
> +{
> +	if (opt->color && color && color[0]) {
> +		opt->output(opt, color, strlen(color));
> +		opt->output(opt, data, size);
> +		opt->output(opt, GIT_COLOR_RESET, strlen(GIT_COLOR_RESET));
> +	}
> +	else

	} else

> +		opt->output(opt, data, size);
> +}
> +
> +static void output_sep(struct grep_opt *opt, char sign)
> +{
> +	if (opt->null_following_name) {
> +		sign = '\0';
> +		opt->output(opt, &sign, 1);
> +	} else

	if (opt->null_following_name)
		opt->output(opt, "", 1);
	else

> +		output_color(opt, &sign, 1, opt->color_sep);
> +}
