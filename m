Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiBKTCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:02:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbiBKTCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 14:02:17 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C5CE9
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:02:15 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F253C16AD38;
        Fri, 11 Feb 2022 14:02:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q2xp+48sFSQPqH4K2ennn9JVmjZoteJbQv74B/
        yCZ5s=; b=ggdJ2l7SDHy3IecpuA4+gBvlAyq3sj68dGEQ5wP5Ld0i55AklxSbsi
        tvYQA6ayyeB26VJH/C+6lRzqE2sQ4JzgyxAMsp1ktJMM8Y588xA1dCoDXPE4WH63
        Lo8wvJIgD9c2/Y/7cuPARjrHBvTlAhglmI8lANSBNekIsK8oDxBO8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC24216AD36;
        Fri, 11 Feb 2022 14:02:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57A4F16AD34;
        Fri, 11 Feb 2022 14:02:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Subject: Re: [PATCH v3 2/4] log: add a --no-graph option
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
        <20220211163627.598166-2-alexhenrie24@gmail.com>
Date:   Fri, 11 Feb 2022 11:02:11 -0800
In-Reply-To: <20220211163627.598166-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Fri, 11 Feb 2022 09:36:25 -0700")
Message-ID: <xmqqa6exb51o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EA88842-8B6D-11EC-A542-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> It's useful to be able to countermand a previous --graph option, for
> example if `git log --graph` is run via an alias.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v3: don't pass a regular expression with parentheses to grep, so that
> the tests pass in all configurations on GitHub
> ---
>  builtin/blame.c    |  1 +
>  builtin/shortlog.c |  1 +
>  revision.c         | 19 ++++++++++---
>  revision.h         |  1 +
>  t/t4202-log.sh     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 87 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 7fafeac408..ef831de5ac 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -934,6 +934,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
>  	}
>  parse_done:
> +	revision_opts_finish(&revs);

This ...

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index e7f7af5de3..228d782754 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -388,6 +388,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
>  		parse_revision_opt(&rev, &ctx, options, shortlog_usage);
>  	}
>  parse_done:
> +	revision_opts_finish(&rev);
>  	argc = parse_options_end(&ctx);
>  
>  	if (nongit && argc > 1) {

... and this.  It is a bit scary that we have to make sure all the
users of parse_revision_opt() users need to call this new helper.
Didn't we recently gain new documentation to help novices write
their first revision-traversal-API-using program?  Does it need to
be updated for this change (I didn't check)?

> diff --git a/revision.c b/revision.c
> index 816061f3d9..a39fd1c278 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2424,10 +2424,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->pretty_given = 1;
>  		revs->abbrev_commit = 1;
>  	} else if (!strcmp(arg, "--graph")) {
> -		revs->topo_order = 1;
> -		revs->rewrite_parents = 1;
>  		graph_clear(revs->graph);
>  		revs->graph = graph_init(revs);
> +	} else if (!strcmp(arg, "--no-graph")) {
> +		graph_clear(revs->graph);
> +		revs->graph = NULL;
>  	} else if (!strcmp(arg, "--encode-email-headers")) {
>  		revs->encode_email_headers = 1;
>  	} else if (!strcmp(arg, "--no-encode-email-headers")) {
> @@ -2524,8 +2525,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  			unkv[(*unkc)++] = arg;
>  		return opts;
>  	}
> -	if (revs->graph && revs->track_linear)
> -		die(_("options '%s' and '%s' cannot be used together"), "--show-linear-break", "--graph");
>  
>  	return 1;
>  }

As a later "--no" can clear an earlier "--graph", we cannot
incrementally check if options are compatible, until the end, at
which time we can be sure that "--graph" is being asked.

> +void revision_opts_finish(struct rev_info *revs)
> +{
> +	if (revs->graph && revs->track_linear)
> +		die(_("options '%s' and '%s' cannot be used together"), "--show-linear-break", "--graph");

Inherited from the original, but we may want to wrap this line.

> +	if (revs->graph) {
> +		revs->topo_order = 1;
> +		revs->rewrite_parents = 1;
> +	}
> +}
> +

OK.

> @@ -2786,6 +2796,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			break;
>  		}
>  	}
> +	revision_opts_finish(revs);

OK.

Will queue.  Thanks.
