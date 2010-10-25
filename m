From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/4] parse-options: allow git commands to invent new option
 types
Date: Mon, 25 Oct 2010 03:31:03 -0700
Message-ID: <4CC55C67.8080908@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com> <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino> <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino> <20101024081316.GA29630@burratino> <20101024081507.GB29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 12:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAKKr-0004Dm-S1
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 12:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab0JYKbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 06:31:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46095 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0JYKbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 06:31:17 -0400
Received: by gyg4 with SMTP id 4so1882841gyg.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6/ZpL54aaQDloEicS/s3Nyt2wEPM8O3zktD9jVHto8k=;
        b=KsWPlmeiN/HnBzKZvmU22DCIsAUxN5yI+EG+MSpQLTX0t4f8bidwfn+zQ0gqbYfXmR
         50a9q49a0Tjjgi4zko4Hu7VGsY1Y+BfWlx+nh9MRzSISOuiciJNtrq3rB0y6hKrVdsZW
         IxYn7HX4cmzbFn5Os/p7hN12M/H08P7nBGTwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IC1H4i/FStVTDg6nOQuagd6tIy96iOSWZr63P63zN9QusNd+WyQkgb/UytbMXSvWuh
         wn8aXDx7sXr6fDgZfzNSErHkql6hPs4m7QBf+bFD2KL+sVjozvBcsuiWe4D+mbgJ+gRj
         YByapkXlqkWv8RHnA8aqnsd1Bn0Vi/oXFL4eo=
Received: by 10.100.111.10 with SMTP id j10mr2535056anc.222.1288002676789;
        Mon, 25 Oct 2010 03:31:16 -0700 (PDT)
Received: from [192.168.1.105] ([75.85.182.25])
        by mx.google.com with ESMTPS id t23sm8508241ano.27.2010.10.25.03.31.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 03:31:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20101020 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20101024081507.GB29630@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159941>

On 10/24/10 01:15, Jonathan Nieder wrote:
> diff --git a/parse-options.c b/parse-options.c
> index 0fa79bc..7907306 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -8,9 +8,6 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  			       const char * const *usagestr,
>  			       const struct option *opts, int err);
>  
> -#define OPT_SHORT 1
> -#define OPT_UNSET 2
> -
>  static int opterror(const struct option *opt, const char *reason, int flags)
>  {
>  	if (flags & OPT_SHORT)
> @@ -51,6 +48,9 @@ static int get_value(struct parse_opt_ctx_t *p,
>  	const int unset = flags & OPT_UNSET;
>  	int err;
>  
> +	if (opt->type == OPTION_LOWLEVEL_CALLBACK)
> +		return (*(parse_opt_ll_cb *)opt->callback)(p, opt, flags);
> +

(I read patch 4 before this one)

Being able to modify the context within a callback is nice. Having to
know if the option is short or long and and checking for validity seems
like something that should be handled within the parse options library
itself.

Is there an actual use case where someone needs to completely override
get_value()? If you move this into the case statement then we get the
generic error checking of get_value() with the benefits of being able to
modify the context within a callback. We could also probably use the
return value of the low level callback to indicate whether or not to
take some action after parsing the option. Perhaps something like
quiting the option parsing loop when encountering such an option?

This reminds me, we can probably simplify that "takes no value" error
path in get_value() (see below).

> diff --git a/parse-options.h b/parse-options.h
> index d982f0f..fa400da 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -17,6 +17,7 @@ enum parse_opt_type {
>  	OPTION_STRING,
>  	OPTION_INTEGER,
>  	OPTION_CALLBACK,
> +	OPTION_LOWLEVEL_CALLBACK,
>  	OPTION_FILENAME
>  };

Don't forget to document what this option does in the comments of this
file and in api-parse-options.txt

>  
> @@ -40,8 +41,16 @@ enum parse_opt_option_flags {
>  	PARSE_OPT_SHELL_EVAL = 256
>  };
>  
> +enum parse_opt_ll_flags {
> +	OPT_SHORT = 1,
> +	OPT_UNSET = 2
> +};
> +

I hope this isn't necessary.

Hope this pasted ok.
--->8----

diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..7234c11 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -56,22 +56,8 @@ static int get_value(struct parse_opt_ctx_t *p,
        if (unset && (opt->flags & PARSE_OPT_NONEG))
                return opterror(opt, "isn't available", flags);

-       if (!(flags & OPT_SHORT) && p->opt) {
-               switch (opt->type) {
-               case OPTION_CALLBACK:
-                       if (!(opt->flags & PARSE_OPT_NOARG))
-                               break;
-                       /* FALLTHROUGH */
-               case OPTION_BOOLEAN:
-               case OPTION_BIT:
-               case OPTION_NEGBIT:
-               case OPTION_SET_INT:
-               case OPTION_SET_PTR:
+       if (!(flags & OPT_SHORT) && p->opt && (opt->flags &
PARSE_OPT_NOARG))
                        return opterror(opt, "takes no value", flags);
-               default:
-                       break;
-               }
-       }

        switch (opt->type) {
        case OPTION_BIT:
