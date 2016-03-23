From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/GSoC] parse-options: Add a new nousage opt
Date: Wed, 23 Mar 2016 18:31:57 -0400
Message-ID: <20160323223157.GA12531@sigill.intra.peff.net>
References: <1458456405-3519-1-git-send-email-chirayudesai1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 23:32:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1airJu-00052i-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 23:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbcCWWcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 18:32:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:37032 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbcCWWcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 18:32:00 -0400
Received: (qmail 6007 invoked by uid 102); 23 Mar 2016 22:31:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 18:31:59 -0400
Received: (qmail 4368 invoked by uid 107); 23 Mar 2016 22:32:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 18:32:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2016 18:31:57 -0400
Content-Disposition: inline
In-Reply-To: <1458456405-3519-1-git-send-email-chirayudesai1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289687>

On Sun, Mar 20, 2016 at 12:16:45PM +0530, Chirayu Desai wrote:

> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 239898d946..ac2ea4d674 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -85,11 +85,15 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
>  
>  	if (!arg)
>  		return -1;
> -	if (get_sha1(arg, sha1))
> -		return error("malformed object name %s", arg);
> +	if (get_sha1(arg, sha1)) {
> +		error("malformed object name %s", arg);
> +		return -3;
> +	}

Now that we have a few meaningful return values, should we have some
enum that gives them human-readable names?

E.g., why don't we allow "-2" here? I think it is because
parse_options_step internally uses it for "I don't know about that
option". But maybe we should have something like:

  enum PARSE_OPT_ERROR {
          PARSE_OPT_ERR_USAGE = -1,
	  PARSE_OPT_ERR_UNKNOWN_OPTION = -2,
	  PARSE_OPT_ERR_FAIL_QUIETLY = -3,
  }

(I don't quite like the final name, but I couldn't think of anything
better).

> diff --git a/parse-options.c b/parse-options.c
> index 47a9192060..d136c1afd0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -158,6 +158,9 @@ static int get_value(struct parse_opt_ctx_t *p,
>  			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
>  		if (get_arg(p, opt, flags, &arg))
>  			return -1;
> +		if (opt->flags & PARSE_OPT_NOUSAGE) {
> +			return (*opt->callback)(opt, arg, 0);
> +		}
>  		return (*opt->callback)(opt, arg, 0) ? (-1) : 0;

Here you use PARSE_OPT_NOUSAGE to pass the callback's value directly
back to the rest of the option-parsing code. But can't we just intercept
"-3" always? It's possible that another callback is using it to
generically return an error, but it seems like a rather low risk, and
the resulting code is much simpler.

Or we could go the opposite direction. If a callback is annotated with
PARSE_OPT_NOUSAGE, why do we even need to care about its return value?
The callback could continue to return -1, and we would simply suppress
the usage message.

>  	case OPTION_INTEGER:
> @@ -504,6 +507,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  			goto show_usage_error;
>  		case -2:
>  			goto unknown;
> +		case -3:
> +			return PARSE_OPT_DONE;
>  		}
>  		continue;
>  unknown:

If I understand correctly, this is now getting the value from the
callback directly. What happens if a callback returns "-4" or "4"?

Also, this covers the parse_long_opt() call, but there are two
parse_short_opt() calls earlier. Wouldn't they need to learn the same
logic?

-Peff
