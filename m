From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/19] parse-options-cb: implement parse_opt_pass_strbuf()
Date: Tue, 09 Jun 2015 16:11:39 -0700
Message-ID: <xmqqvbewwk7o.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:11:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2SgS-0000Wd-CS
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbbFIXLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:11:47 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35121 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932466AbbFIXLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 19:11:42 -0400
Received: by iesa3 with SMTP id a3so23453576ies.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dm1FLUbFx8tJzH2EQAiqQsVk6G5GU6ek9+uDnhd8fSI=;
        b=fXgccMITXpiAsis3VZl59A1yqldij3E+ux2FM+TAFxq7AIUYPlxm/k2PBxjQVqCFxE
         UGUGl0HHfmN/mJRSQAnJtQKRZDRlp92VfZH/+remcp+8pywTxAnBf2DHC4SR2HOKqs66
         OX+8d2zJ9rMFB67/9eaX6FlXrZ/a95xONJllR/dvJ1D3NNQptEQZvrnyK0vsQ0PscEIa
         RmssHiuWjxixNA0pnAvSJDT/5PotHngkEuWIQa4FjwLn4aeIbOv0vmrzASarIAfGZ8+w
         Kz/IhSZsYUm8WNl2ko2qVG6qU2/16y34BfOnUxiGAYdzRW/O17E3C2r/RS9flQknEYfC
         yW1w==
X-Received: by 10.50.117.35 with SMTP id kb3mr1758707igb.13.1433891502149;
        Tue, 09 Jun 2015 16:11:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id z195sm4912543iod.33.2015.06.09.16.11.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 16:11:40 -0700 (PDT)
In-Reply-To: <1433314143-4478-2-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 3 Jun 2015 14:48:45 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271238>

Paul Tan <pyokagan@gmail.com> writes:

> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index be8c413..5b1dbcf 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -134,3 +134,32 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
>  {
>  	return 0;
>  }
> +
> +/**
> + * For an option opt, recreates the command-line option in opt->value which
> + * must be an strbuf. This is useful when we need to pass the command-line
> + * option to another command.
> + */

This is to be used to create a single argument, not an entire
command line to be executed via run_command() or a shell, right?
It wasn't very clear from the above command.

If the same option is given more than once, the earlier ones are
discarded and the last one wins.  That may be OK for your expected
callers, and I do not think this needs to have an option to instead
accumulate them, but it needs to be made clear in the comment and
the API documentation for future developers who want to use the
parse-options API.

> +int parse_opt_pass_strbuf(const struct option *opt, const char *arg, int unset)
> +{
> +	struct strbuf *sb = opt->value;
> +
> +	strbuf_reset(sb);
> +
> +	if (opt->long_name) {
> +		strbuf_addstr(sb, unset ? "--no-" : "--");
> +		strbuf_addstr(sb, opt->long_name);
> +		if (arg) {
> +			strbuf_addch(sb, '=');
> +			strbuf_addstr(sb, arg);
> +		}
> +	} else if (opt->short_name && !unset) {
> +		strbuf_addch(sb, '-');
> +		strbuf_addch(sb, opt->short_name);
> +		if (arg)
> +			strbuf_addstr(sb, arg);
> +	} else
> +		return -1;
> +
> +	return 0;
> +}
> diff --git a/parse-options.h b/parse-options.h
> index c71e9da..1d21398 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -224,6 +224,7 @@ extern int parse_opt_with_commit(const struct option *, const char *, int);
>  extern int parse_opt_tertiary(const struct option *, const char *, int);
>  extern int parse_opt_string_list(const struct option *, const char *, int);
>  extern int parse_opt_noop_cb(const struct option *, const char *, int);
> +extern int parse_opt_pass_strbuf(const struct option *, const char *, int);
>  
>  #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
>  #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
