Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E162055E
	for <e@80x24.org>; Sun, 29 Oct 2017 01:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbdJ2Bz2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 21:55:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57893 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751216AbdJ2Bz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 21:55:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B9CDAD323;
        Sat, 28 Oct 2017 21:55:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cZD3VuFi4T1wevjluJN87sOwf0c=; b=pIjr2M
        PVVtAZRNuN4QIKb4y5TV6c4kdKYWH1xkou8GUHVwz+oYHgatdwHNCylDFAbJv+tb
        KdLhFz1XO5U+9c1BbGhmlcsAlnwKIET6cs8ckrATpUG9HDLqD1fenvJn/cBUngAP
        7l7/WHNMbxUjtdZrKKSyxBFw8hcI9AnUqmys0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EY52nSjQ0G+DzMxfc6+bnMJaBVSzGrWS
        1D+pdiPf58+qutj21dfXU627/kpC7bGmQsAaVh06x3KNfm936slAX+oUSvmBK6RD
        OxNSl0cNl8Jxcs24Pfp2NtLfPp77eh7j+fNrlAsCjMW/EJJ4Cw3Dt6kJihpz8vC5
        GWeMIXQf+fc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24866AD322;
        Sat, 28 Oct 2017 21:55:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96F11AD321;
        Sat, 28 Oct 2017 21:55:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: convert flags to be stored in bitfields
References: <20171027222853.180981-1-bmwill@google.com>
        <20171027222853.180981-4-bmwill@google.com>
Date:   Sun, 29 Oct 2017 10:55:25 +0900
In-Reply-To: <20171027222853.180981-4-bmwill@google.com> (Brandon Williams's
        message of "Fri, 27 Oct 2017 15:28:53 -0700")
Message-ID: <xmqqk1zeafaq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BE2CDF4-BC4C-11E7-B1BF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> We have have reached the limit of the number of flags that can be stored

s/have have/have/; but bit #9 is unused.  

"We cannot add many more flags even if we wanted to" would be more
flexible and does not take this change hostage to whatever topic
that tries to claim that bit, I would think.

> in a single unsigned int.  In order to allow for more flags to be added
> to the diff machinery in the future this patch converts the flags to be
> stored in bitfields in 'struct diff_flags'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/commit.c |  7 +++--
>  builtin/log.c    |  2 +-
>  diff-lib.c       |  6 ++--
>  diff.c           |  3 +-
>  diff.h           | 96 +++++++++++++++++++++++++++++++++-----------------------
>  sequencer.c      |  5 +--
>  6 files changed, 70 insertions(+), 49 deletions(-)
>

> diff --git a/diff.h b/diff.h
> index aca150ba2..d58f06106 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -60,42 +60,59 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>  
>  #define DIFF_FORMAT_CALLBACK	0x1000
>  
> -#define DIFF_OPT_RECURSIVE           (1 <<  0)
> -#define DIFF_OPT_TREE_IN_RECURSIVE   (1 <<  1)
> -#define DIFF_OPT_BINARY              (1 <<  2)
> -...
> -#define DIFF_OPT_FUNCCONTEXT         (1 << 29)
> -#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
> -#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
> -
> -#define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
> -#define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
> -#define DIFF_OPT_SET(opts, flag)    (((opts)->flags |= DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
> -#define DIFF_OPT_CLR(opts, flag)    (((opts)->flags &= ~DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
> +#define DIFF_FLAGS_INIT { 0 }
> +extern const struct diff_flags diff_flags_cleared;

This thing is curious.  Seeing the scary diff_flags_or(), I would
have expected we'd have diff_flags_clear(&flags).

> +struct diff_flags {
> +	unsigned RECURSIVE:1;
> +	unsigned TREE_IN_RECURSIVE:1;
> +	unsigned BINARY:1;
> +...
> +	unsigned FUNCCONTEXT:1;
> +	unsigned PICKAXE_IGNORE_CASE:1;
> +	unsigned DEFAULT_FOLLOW_RENAMES:1;
> +};
> +
> +static inline struct diff_flags diff_flags_or(struct diff_flags a,
> +					      struct diff_flags b)
> +{
> +	char *tmp_a = (char *)&a;
> +	char *tmp_b = (char *)&b;
> +	int i;
> +
> +	for (i = 0; i < sizeof(struct diff_flags); i++)
> +		tmp_a[i] |= tmp_b[i];
> +
> +	return a;
> +}

This is doubly scary, but let's see why we need it by looking at the
callers.

> +#define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
> +#define DIFF_OPT_TOUCHED(opts, flag)	((opts)->touched_flags.flag)
> +#define DIFF_OPT_SET(opts, flag)	(((opts)->flags.flag = 1),((opts)->touched_flags.flag = 1))
> +#define DIFF_OPT_CLR(opts, flag)	(((opts)->flags.flag = 0),((opts)->touched_flags.flag = 1))

These are trivial and straight-forward.

> +
>  #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
>  #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
>  #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
> @@ -122,8 +139,8 @@ struct diff_options {
>  	const char *a_prefix, *b_prefix;
>  	const char *line_prefix;
>  	size_t line_prefix_length;
> -	unsigned flags;
> -	unsigned touched_flags;
> +	struct diff_flags flags;
> +	struct diff_flags touched_flags;
>  
>  	/* diff-filter bits */
>  	unsigned int filter;
> @@ -388,7 +405,8 @@ extern int diff_result_code(struct diff_options *, int);
>  
>  extern void diff_no_index(struct rev_info *, int, const char **);
>  
> -extern int index_differs_from(const char *def, int diff_flags, int ita_invisible_in_index);
> +extern int index_differs_from(const char *def, struct diff_flags flags,
> +			      int ita_invisible_in_index);

OK.  I tend to think twice before passing any struct by value (even
something that starts its life as a small/single-word struct), but
let's see how much simpler this allows callers to become.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index d75b3805e..de08c2594 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -912,11 +912,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			 * submodules which were manually staged, which would
>  			 * be really confusing.
>  			 */
> -			int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> +			struct diff_flags flags = DIFF_FLAGS_INIT;
> +			flags.OVERRIDE_SUBMODULE_CONFIG = 1;
>  			if (ignore_submodule_arg &&
>  			    !strcmp(ignore_submodule_arg, "all"))
> -				diff_flags |= DIFF_OPT_IGNORE_SUBMODULES;

This couldn't have been done in patches 1+2/3 because DIFF_OPT_SET()
does not take a bare 'flags' but diffopt itself, which was a bit
unfortunate, but the end result after this step becomes a lot more
sensible.

> -			commitable = index_differs_from(parent, diff_flags, 1);
> +				flags.IGNORE_SUBMODULES = 1;
> +			commitable = index_differs_from(parent, flags, 1);

OK.

> diff --git a/builtin/log.c b/builtin/log.c
> index d81a09051..780975ed4 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -134,7 +134,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
>  
>  	if (default_date_mode)
>  		parse_date_format(default_date_mode, &rev->date_mode);
> -	rev->diffopt.touched_flags = 0;
> +	rev->diffopt.touched_flags = diff_flags_cleared;

So this structure assignment is a more kosher way to clear
everything than memset(&touched_flags, '\0', sizeof(...));
I'd still prefer

	diff_flags_clear(&rev->diffopt.touched_flags);

tough, as it is easy to forget diff_flags_cleared is a singleton
constant specifically created to be assigned for clearing another
flags struct.

> @@ -546,7 +546,7 @@ int index_differs_from(const char *def, int diff_flags,
>  	setup_revisions(0, NULL, &rev, &opt);
>  	DIFF_OPT_SET(&rev.diffopt, QUICK);
>  	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
> -	rev.diffopt.flags |= diff_flags;
> +	rev.diffopt.flags = diff_flags_or(rev.diffopt.flags, flags);

In a more general case, we cannot know what flags setup_revisions()
gave to rev.diffopt, and because of that we cannot do

	rev.diffopt.flags = diff_flags;
	DIFF_OPT_SET(&rev.diffopt, QUICK);
	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);

without using the flags_or() thing.  In this codepath, that
currently is not a problem (because we give ac/av = 0/NULL), but it
probably is a good idea to avoid depending on that.

I still haven't brought myself to like the structure being passed by
value and the singleton diff_flags_cleared thing, but I suspect that
we may get used to them once we start using these.  I dunno.

Thanks.
