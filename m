Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79026C83F2E
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbjHaQO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjHaQO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 12:14:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5281E4C
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 09:14:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EE44207FA;
        Thu, 31 Aug 2023 12:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=3Rkl0U2nFFLJgIotEUdhMfU60kOQZGRi/vjvUq
        RLy9M=; b=H/xzTdltU6YueD01gQMgwvPf91s1AUsOAJxDPa+Oc3hLHswLeRfZQx
        jd09kNICxyTYpr/ECPjhHEaSlZ48Nf0y4T+MLvE0+txYyj0ADk0pcYsmwY9AnLm8
        KMD1GdmAwq0OmXWfFd11VGXkwuOnl0QwU7Nf9ZTbElY3BNsBICQDI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67224207F9;
        Thu, 31 Aug 2023 12:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ECDEF207F7;
        Thu, 31 Aug 2023 12:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 3/8] parse-options: prefer opt->value to globals in
 callbacks
In-Reply-To: <20230831071743.GA3197751@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:17:43 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831071743.GA3197751@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 09:14:49 -0700
Message-ID: <xmqqr0njxk7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83553532-4819-11EE-8BEC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... have the
> caller pass in the appropriate variable via opt->value, and use it. That
> has the benefit of making the callbacks reusable (in theory at least),
> and makes it clear from the OPT_CALLBACK declaration which variables
> will be affected (doubly so for the cases in builtin/fast-export.c,
> where we do set opt->value, but it is completely ignored!).

Thanks for doing this.  I vaguely recall in my recent reviews I said
that I prefer the style for exactly the second reason above.

> I went with the "just use them" approach here. The loss of type safety
> is unfortunate, but that is already an issue with most of the other
> callbacks. If we want to try to address that, we should do so more
> consistently (and this patch would prepare these callbacks for whatever
> we choose to do there).
>
> Note that in the cases in builtin/fast-export.c, we are passing
> anonymous enums. We'll have to give them names so that we can declare
> the appropriate pointer type within the callbacks.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I was tempted to push some of these globals into the cmd_foo()
> functions, to make sure we don't make the same mistake again. But there
> are lots of ripple effects from other functions which want to access the
> globals (and passing them makes the code longer for little benefit).
> Plus it would make things inconsistent, with some options globals and
> some not. So that can be a cleanup for another day if somebody is
> interested (and this takes us one tiny step closer).

Yup, as long as these globals are file-scope static that these
cmd_foo() use to decide and prepare arguments to pass to the more
library-ish part of the code, I do not mind them not being on stack.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index b28a4a1f82..718b5c3073 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -561,9 +561,11 @@ static void describe(const char *arg, int last_one)
>  static int option_parse_exact_match(const struct option *opt, const char *arg,
>  				    int unset)
>  {
> +	int *val = opt->value;
> +
>  	BUG_ON_OPT_ARG(arg);
>  
> -	max_candidates = unset ? DEFAULT_CANDIDATES : 0;
> +	*val = unset ? DEFAULT_CANDIDATES : 0;
>  	return 0;
>  }
>  
> @@ -578,7 +580,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
>  		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
>  		OPT__ABBREV(&abbrev),
> -		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
> +		OPT_CALLBACK_F(0, "exact-match", &max_candidates, NULL,
>  			       N_("only output exact matches"),
>  			       PARSE_OPT_NOARG, option_parse_exact_match),
>  		OPT_INTEGER(0, "candidates", &max_candidates,

If we ever choose to libify builtin/describe.c::describe_commit(),
max_candidates may want to become a parameter to it, which would
allow cmd_describe() to have it on its stack, but until that
happens, I agree that it is not a very useful churn.

> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index c5e8345265..6aadce6a1e 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -26,19 +26,19 @@ static enum trailer_if_missing if_missing;
>  static int option_parse_where(const struct option *opt,
>  			      const char *arg, int unset)
>  {
> -	return trailer_set_where(&where, arg);
> +	return trailer_set_where(opt->value, arg);
>  }
>  
>  static int option_parse_if_exists(const struct option *opt,
>  				  const char *arg, int unset)
>  {
> -	return trailer_set_if_exists(&if_exists, arg);
> +	return trailer_set_if_exists(opt->value, arg);
>  }
>  
>  static int option_parse_if_missing(const struct option *opt,
>  				   const char *arg, int unset)
>  {
> -	return trailer_set_if_missing(&if_missing, arg);
> +	return trailer_set_if_missing(opt->value, arg);
>  }
>  
>  static void new_trailers_clear(struct list_head *trailers)
> @@ -97,11 +97,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
>  		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
>  
> -		OPT_CALLBACK(0, "where", NULL, N_("action"),
> +		OPT_CALLBACK(0, "where", &where, N_("action"),
>  			     N_("where to place the new trailer"), option_parse_where),
> -		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
> +		OPT_CALLBACK(0, "if-exists", &if_exists, N_("action"),
>  			     N_("action if trailer already exists"), option_parse_if_exists),
> -		OPT_CALLBACK(0, "if-missing", NULL, N_("action"),
> +		OPT_CALLBACK(0, "if-missing", &if_missing, N_("action"),
>  			     N_("action if trailer is missing"), option_parse_if_missing),
>  
>  		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),

OK.  These three variables should be fun (but not too difficult) to
convert to on-stack variables.  option_parse_trailer() needs to
learn to take a struct that holds "trailers", in addition to these
three variables as its members to lose its dependency on the
globals, and then these three callbacks can learn to take the same
struct and fill their own members in it.

Of course that is outside the scope of this series.
