Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6AEC64E7C
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3522221FD
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgLCAdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 19:33:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57890 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCAdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 19:33:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD5679A862;
        Wed,  2 Dec 2020 19:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HxMIfzFEQA0egwCY6nPy2l3afBA=; b=lJDiAE
        zved5WkqrO7RZmbVdAHts0eaYQQep7QbDRGY+wHpDkxanRX11gPdHsj0UV0Y+P/b
        p6u1GIl9Qr+wrWMFmFHVyDkgQ/jSu+5+xWqi7+kUAtLIXcvib9OnXbqQF9v+7Tlz
        y6goAU1A+22z0VSdwPmTOMM+hQGvlc3V/f5vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p+CRNlPibiGQbf+gUVui8xz8w2ien+Co
        h5rD+GK//cLKmORlrjHMhLXrGa7WosH0NNgVWRej+Jxaf5pmaBEEQ8TtjV0DpBBl
        WtigolocR2uooWk/4unSx4dZLIcgwjS6ZJZzo2gQFWPtjDbZ7SzK24Nm03b05fzF
        ywLza73BXw0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C32499A861;
        Wed,  2 Dec 2020 19:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11ECB9A85F;
        Wed,  2 Dec 2020 19:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 01/27] revision: factor out parsing of diff-merge
 related options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-2-sorganov@gmail.com>
Date:   Wed, 02 Dec 2020 16:33:00 -0800
In-Reply-To: <20201108213838.4880-2-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Nov 2020 00:38:12 +0300")
Message-ID: <xmqqv9djk9tv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19507726-34FF-11EB-8E85-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Move all the parsing code related to diffing merges into new
> parse_diff_merge_opts() function.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  revision.c | 66 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 27 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index aa6221204081..a09f4872acd7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2153,6 +2153,44 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>  	add_grep(revs, pattern, GREP_PATTERN_BODY);
>  }
>  
> +static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
> +	int argcount;
> +	const char *optarg;
> +	const char *arg = argv[0];
> +
> +	if (!strcmp(arg, "-m")) {
> +		/*
> +		 * To "diff-index", "-m" means "match missing", and to the "log"
> +		 * family of commands, it means "show full diff for merges". Set
> +		 * both fields appropriately.
> +		 */
> +		revs->ignore_merges = 0;
> +		revs->match_missing = 1;
> +	} else if (!strcmp(arg, "-c")) {
> +		revs->diff = 1;
> +		revs->dense_combined_merges = 0;
> +		revs->combine_merges = 1;
> +	} else if (!strcmp(arg, "--cc")) {
> +		revs->diff = 1;
> +		revs->dense_combined_merges = 1;
> +		revs->combine_merges = 1;
> +	} else if (!strcmp(arg, "--no-diff-merges")) {
> +		revs->ignore_merges = 1;
> +	} else if (!strcmp(arg, "--combined-all-paths")) {
> +		revs->diff = 1;
> +		revs->combined_all_paths = 1;
> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {

The reordering of if/else if/ cascade from the original, which
serves no apparent purpose, makes reviewing a tad harder than
necessary, but the conversion at this point seems wrong.

The original allowed parse_long_opt() to potentially return 2
(i.e. "diff-merges" and "off" appear as separate tokens on the
command line), but the return value stored in argcount here is
discarded, without affecting the return value from this function,
which is fed back to the original in handle_revision_opt() below.

> +		if (!strcmp(optarg, "off")) {
> +			revs->ignore_merges = 1;
> +		} else {
> +			die(_("unknown value for --diff-merges: %s"), optarg);
> +		}

To correct the above bug, it probably is sufficient to add

		return argcount;

here.  That will be fed back to ...

> +	} else
> +		return 0;
> +
> +	return 1;
> +}

> @@ -2349,34 +2387,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> ...
> -	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
> -		if (!strcmp(optarg, "off")) {
> -			revs->ignore_merges = 1;
> -		} else {
> -			die(_("unknown value for --diff-merges: %s"), optarg);
> -		}
> +	} else if ((argcount = parse_diff_merge_opts(revs, argv))) {
>  		return argcount;

... this part and cause the number of options and arguments consumed
to the caller of handle_revision_opt().

I wonder if we can cover it with a test to prevent a similar mistake
in the future?

> -	} else if (!strcmp(arg, "--no-diff-merges")) {
> -		revs->ignore_merges = 1;
> -	} else if (!strcmp(arg, "-c")) {
> -		revs->diff = 1;
> -		revs->dense_combined_merges = 0;
> -		revs->combine_merges = 1;
> -	} else if (!strcmp(arg, "--combined-all-paths")) {
> -		revs->diff = 1;
> -		revs->combined_all_paths = 1;
> -	} else if (!strcmp(arg, "--cc")) {
> -		revs->diff = 1;
> -		revs->dense_combined_merges = 1;
> -		revs->combine_merges = 1;
>  	} else if (!strcmp(arg, "-v")) {
>  		revs->verbose_header = 1;
>  	} else if (!strcmp(arg, "--pretty")) {
