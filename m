From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] rev-parse: correctly diagnose revision errors
 before "--"
Date: Fri, 6 Dec 2013 15:34:10 -0800
Message-ID: <20131206233410.GO29959@google.com>
References: <20131206220520.GA30652@sigill.intra.peff.net>
 <20131206220547.GA25620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 00:34:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp4ub-0006e3-PF
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 00:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878Ab3LFXeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 18:34:16 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:51517 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289Ab3LFXeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 18:34:13 -0500
Received: by mail-yh0-f48.google.com with SMTP id f73so1031377yha.7
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IASRP1jBs/UIM7GqQS0TnnYKC/HQQE6SOK+bGiQ2jQU=;
        b=suWglW0l7ymCjyijKC8rPYVrrRwugKzmId515ZXj8LzvhPFzSHQQj9INkJcfo+eNqH
         K/t9hvV6ZLISiCSSuPWYF3XTpKTpiN4/0QCqQ8+latOK98db6ogt7l22TSAlaXCUhcRz
         sXh+rIWmDJiBr2akOavQcprvbMJ1gufjYr72szO05UFheZGmzx4lOAbINmo34rBD7Aiw
         dU9G50CUL054pWYAA7Y3+G3Il9002lM55b536c+kAZqqCw2A2n5MzFhI3VEl2adCg1aa
         2Asf9is7ipViA0QQrOdgeDj/5I3lGOKvv6SIgvp7AHWIzpBG+BIMrUM7cIjMEV/+YW2g
         c+CA==
X-Received: by 10.236.157.35 with SMTP id n23mr4832477yhk.0.1386372853107;
        Fri, 06 Dec 2013 15:34:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d32sm242313yhq.27.2013.12.06.15.34.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 15:34:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131206220547.GA25620@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238965>

Jeff King wrote:

> Since rev-parse prefers revisions to files when parsing
> before the "--", we end up with the correct result (if such
> an argument is a revision, we parse it as one, and if it is
> not, it is an error either way).  However, we misdiagnose
> the errors:
>
>   $ git rev-parse foobar -- >/dev/null
>   fatal: ambiguous argument 'foobar': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>
>   $ >foobar
>   $ git rev-parse foobar -- >/dev/null
>   fatal: bad flag '--' used after filename
>
> In both cases, we should know that the real error is that
> "foobar" is meant to be a revision, but could not be
> resolved.

Neat.

[...]
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -488,6 +488,7 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
>  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  {
>  	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
> +	int has_dashdash = 0;
>  	int output_prefix = 0;
>  	unsigned char sha1[20];
>  	const char *name = NULL;
> @@ -501,6 +502,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  	if (argc > 1 && !strcmp("-h", argv[1]))
>  		usage(builtin_rev_parse_usage);
>  
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--")) {
> +			has_dashdash = 1;
> +			break;
> +		}
> +	}
> +
>  	prefix = setup_git_directory();
>  	git_config(git_default_config, NULL);
>  	for (i = 1; i < argc; i++) {
> @@ -788,6 +796,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  		}
>  		if (verify)
>  			die_no_single_rev(quiet);
> +		if (has_dashdash)
> +			die("bad revision '%s'", arg);
>  		as_is = 1;

Yep, this is the "fall back to looking for a file" part of rev-parse,
so erroring out if there as a dashdash coming is the right thing to
do.  And a quick code search for "rev-parse.*\ --\ " reveals that
most callers would simply not be affected by this.

Thanks for a pleasant patch.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
