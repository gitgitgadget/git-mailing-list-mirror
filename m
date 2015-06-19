From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of pack-objects.c
Date: Fri, 19 Jun 2015 10:58:51 -0700
Message-ID: <xmqq7fqza8bo.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434705059-2793-3-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:59:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z60ZJ-0008Bx-HY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbbFSR7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:59:00 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34952 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbbFSR6x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:58:53 -0400
Received: by igbzc4 with SMTP id zc4so19636355igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9FqhXupsy9bNuGqjWaP/2lzzhgkUlzYwn+mPpJFKkTc=;
        b=qay06COqTdUpcue+Upg9Pa6c/WpAbPf4OpT64vaLq3bDmLnL7c0cw9dLD8TuxECcUE
         83oYDtK27wMSjrO5k+uy4L/A1ulb2bux8z26YJi16a/ennk3Ex5xuf1dQ9OCdkj9s35p
         7P1M2J+IAaxsjsdi63BtmHMrWmvBwkzqFTVPszQGGJqo1yPoru0iaeYjopwYRBw+RCKa
         ZUyoMnH7hBetuq53XdedyOYknYwgk0ujFzPRoy4CywO5LFoj9mzlOI+IaC4Hrql9Stzl
         Eb1XaeUOJZ70XBwEq9ylHBWOh09mklU7YBeFj0/DfuTofMd6SDyy1/ObJAB7FT4Bk6Qw
         MMSA==
X-Received: by 10.43.162.136 with SMTP id mk8mr13022821icc.28.1434736732756;
        Fri, 19 Jun 2015 10:58:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id o200sm7493422ioo.43.2015.06.19.10.58.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 10:58:52 -0700 (PDT)
In-Reply-To: <1434705059-2793-3-git-send-email-charles@hashpling.org> (Charles
	Bailey's message of "Fri, 19 Jun 2015 10:10:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272174>

Charles Bailey <charles@hashpling.org> writes:

> diff --git a/parse-options.h b/parse-options.h
> index c71e9da..2ddb26f 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -18,7 +18,8 @@ enum parse_opt_type {
>  	OPTION_INTEGER,
>  	OPTION_CALLBACK,
>  	OPTION_LOWLEVEL_CALLBACK,
> -	OPTION_FILENAME
> +	OPTION_FILENAME,
> +	OPTION_ULONG
>  };

Please place it immediately after INTEGER, as they are conceptually
siblings---group similar things together.

>  			return opterror(opt, "expects a numerical value", flags);
>  		return 0;
>  
> +	case OPTION_ULONG:

This one is placed right from that point of view ;-)

> +		if (unset) {
> +			*(unsigned long *)opt->value = 0;
> +			return 0;
> +		}
> +		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> +			*(unsigned long *)opt->value = opt->defval;
> +			return 0;
> +		}
> +		if (get_arg(p, opt, flags, &arg))
> +			return -1;
> +		if (!git_parse_ulong(arg, opt->value))
> +			return opterror(opt, "expects a numerical value", flags);

This used to be:

> -		die(_("unable to parse value '%s' for option %s"),
> -		    arg, opt->long_name);

but opterror() talks about which option, so there is no information
loss by losing "for option %s" from here.  That means there is only
one difference for pack-objects:

    $ git pack-objects --max-pack-size=1T
    fatal: unable to parse value '1T' for option max-pack-size
    $ ./git pack-objects --max-pack-size=1T
    error: option `max-pack-size' expects a numerical value
    usage: git pack-objects --stdout [options...
    ... 30 more lines omitted ...

Eh, make that two:

 * We no longer say what value we did not like.  The user presumably
   knows what he typed, so this is only a minor loss.

 * We used to stop without giving "usage", as the error message was
   specific enough.  We now spew descriptions on other options
   unrelated to the specific error the user may want to concentrate
   on.  Perhaps this is a minor regression.

I wonder if "expects a numerical value" is the best way to say this.

Ponder:

 - we do not take "4.8"
 - we do not take "-4".
 - people may not realize, from "numerical", that we take "5M".

Except for the minor nits above, I think this is a good change.

This is a totally unrelated tangent that does not have to be part of
your series, but we probably should take "4.8M"; I do not think we
currently do.

Oh, and perhaps 1T, too.
