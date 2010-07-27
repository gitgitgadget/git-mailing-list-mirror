From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Allow detached form (e.g. "-S foo" instead of
 "-Sfoo") for diff options
Date: Tue, 27 Jul 2010 16:37:50 -0500
Message-ID: <20100727213750.GB11768@burratino>
References: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
 <1280265719-30968-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:39:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odrrs-00019e-Q0
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0G0VjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:39:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42146 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab0G0VjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:39:00 -0400
Received: by vws3 with SMTP id 3so3790180vws.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K4uIne6J9VWYs42y78lWT7nMW1AzuJwlOQ5LkHaMRbw=;
        b=PGy0KP9w1w4EZKsxi2fC2qsjoxgvY5vrk5YTdt7a8KaMh9TXr4ghigxRw1ZERW7bBR
         HKVpFF8Cco532zSB6KmMVxWOyOeV76i4Hjn7KknkXKHwtE32zQHRVQr9KoloQQIaEA34
         6NrIucV72Hiz7u9ASbQH8H+4UsUJRGMfugvYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bKs7IhvOGQUzBOdYrN5xpyx2A3scdMfO9XX8UaF4pdCMCLsDP1fOPvilpERxG/Rq8P
         W4jt5zSZU1myViolk2tIO5DoUDhni9lTzUg5/uLYT5Ms8YL2OXiM2iGukp2juzl4BFWn
         hXTfttw3Gy38G4kNNO2XcIEZDDxVIzc1caV/M=
Received: by 10.220.60.75 with SMTP id o11mr5455380vch.271.1280266739354;
        Tue, 27 Jul 2010 14:38:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i40sm1625320vcr.32.2010.07.27.14.38.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 14:38:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280265719-30968-2-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152007>

Matthieu Moy wrote:

> +++ b/diff.c
> @@ -2990,9 +2990,23 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
[...]
> +#define IF_SHORT_OPT(optname)			\
> +	((!strcmp(arg, "-" #optname)		\
> +	  && (argv[1] || (die("Option `" #optname "' requires a value"), 1),	\
> +	      optarg   = argv[1],	       		\
> +	      argcount = 2,			\
> +	      1)) ||				\
> +	 (!prefixcmp(arg, "-" #optname)		\
> +	  && (optarg = arg + strlen("-" #optname),	\
> +	      argcount = 1,			\
> +	       1)))
> +

Why not something like this?

	static inline int short_opt(char opt, const char *arg,
					const char *argv, const char **optarg)
	{
		if (arg[0] != '-' || arg[1] != opt)
			return 0;
		if (arg[2] != '\0') {
			*optarg = arg + strlen("-c");
			return 1;
		}
		if (!argv[1])
			die("Option '%c' requires a value", opt);
		*optarg = argv[1];
		return 2;
	}

and then:

	if ((argcount = short_opt('S', arg, argv, &optarg))) {
		...

> +++ b/diff.h
> @@ -214,6 +214,21 @@ extern void diff_unmerge(struct diff_options *,
>  #define DIFF_SETUP_USE_CACHE		2
>  #define DIFF_SETUP_USE_SIZE_CACHE	4
>  
> +/*
> + * Poor man's alternative to parse-option, only meant to be used in
> + * handle_revision_opt and  diff_opt_parse.
> + */
> +#define IF_LONG_OPT(optname)					\
> +	((!strcmp(arg, "--" #optname)				\
> +	  && (argv[1] || (die("Option `" #optname "' requires a value"), 1), \
> +	      optarg   = argv[1],	       			\
> +	      argcount = 2,					\
> +	      1)) ||						\
> +	 (!prefixcmp(arg, "--" #optname "=")			\
> +	  && (optarg = arg + strlen("--" #optname "="),		\
> +	      argcount = 1,					\
> +	      1)))


 static int long_opt(const char *opt, const char *arg,
				const char **argv, const char **optarg)
 {
	if (arg[0] != '-' || arg[1] != '-')
		return 0;
	if (prefixcmp(arg, opt))
		return 0;
	arg += strlen("--") + strlen(opt);
	if (*arg == '=') {
		*optarg = arg + 1;
		return 1;
	}
	if (*arg != '\0')
		return 0;
	if (!argv[1])
		die("Option '--%s' requires a value", opt);
	*optarg = argv[1];
	return 2;
 }

Jonathan
