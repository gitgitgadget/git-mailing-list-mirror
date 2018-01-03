Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC01A1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 22:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeACWBz (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 17:01:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750979AbeACWBy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 17:01:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C0D8CD3B4;
        Wed,  3 Jan 2018 17:01:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9vz0VyBNdSnGjjJTyb2fFAdmW7s=; b=S0ZxYp
        mi/FTud22tcT20FEGrn7zZu7AHnfXthgz5WTKxv11e5AqNimHaVENXiV+QSyMQfK
        w4P7w1YaEyaCLjXpLzXneqiHxdRC4PWPxCVz6APi6JMdCqIt85sOv7lSYi1zaPNJ
        A6wvX7aWSd+cKY0ps1bStvUTqTzjM5L4F43uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q7h25ocpMlBYWGNlfPns0swXkhhtrVI9
        kH5DVHo5RuBx9fcy73zD/wQLEZWbmtSdxLi5itTQ7VUjqbw8b7IlEqzfmoF6PEfd
        5jNEtx7t1ANSqFyCcuBbg8S8xOIYBwic5mPoWdbhKUKWasstmJKa4SLhyycMwANC
        wHI3cK0ZIyI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23C71CD3B3;
        Wed,  3 Jan 2018 17:01:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CD18CD3B1;
        Wed,  3 Jan 2018 17:01:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff: introduce DIFF_PICKAXE_KINDS_MASK
References: <20180103004624.222528-1-sbeller@google.com>
        <20180103004624.222528-4-sbeller@google.com>
Date:   Wed, 03 Jan 2018 14:01:52 -0800
In-Reply-To: <20180103004624.222528-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 2 Jan 2018 16:46:22 -0800")
Message-ID: <xmqqbmiaha9b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B52335BE-F0D1-11E7-9461-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently the check whether to perform pickaxing is done via checking
> `diffopt->pickaxe`, which contains the command line argument that we
> want to pickaxe for. Soon we'll introduce a new type of pickaxing, that
> will not store anything in the `.pickaxe` field, so let's migrate the
> check to be dependent on pickaxe_opts.
>
> It is not enough to just replace the check for pickaxe by pickaxe_opts,
> because flags might be set, but pickaxing was not requested ('-i').
> To cope with that, introduce a mask to check only for the bits indicating
> the modes of operation.

The resulting code after this series would leave a few "huh?" if it
were new code, but the series is not making anything worse, so take
this as just something noticed, not as something needs further work.

Because we do not allow "log -S<something> -G<something>", there is
no legitimate reason why they have to be a bit in the pickaxe_opts
flag word.  A single enum that says "We are doing pickaxe search and
_this_ is the kind of pickaxe search we are doing" would suffice,
i.e. the NULL-ness check of rev->diffopt.pickaxe string can be
replaced with a check of that enum field against PICKAXE_NONE or
something that signals us that no pickaxe is in effect.

On the other hand, if somebody comes up with a sensible way to
combine more than one pickaxe queries in a single traversal
(e.g. "log -S<something> -S<somethingelse>" might mean "find a
change that loses or gains <something> and <somethingelse> in the
same commit", or it may mean the same with "...<something> or
<somethingelse>"), then a more sensible data structure to represent
the pickaxe request may have been a list of struct, each of which
records the kind and the parameter (e.g. "-S" and "<something>"
would be in a single struct, and "-S" and "<somethingelse>" would be
in another, and these two are in the list that is diffopt->pickaxe).
The NULL-ness check of rev->diffopt.pickaxe string would be replaced
with a check of the length of that list.

In any case, this step looks sensible.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/log.c  | 4 ++--
>  combine-diff.c | 2 +-
>  diff.c         | 4 ++--
>  diff.h         | 2 ++
>  revision.c     | 2 +-
>  5 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 6c1fa896ad..bd6f2d1efb 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -180,8 +180,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	if (rev->show_notes)
>  		init_display_notes(&rev->notes_opt);
>  
> -	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
> -	    rev->diffopt.flags.follow_renames)
> +	if ((rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
> +	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
>  		rev->always_show_header = 0;
>  
>  	if (source)
> diff --git a/combine-diff.c b/combine-diff.c
> index 2505de119a..bc08c4c5b1 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1438,7 +1438,7 @@ void diff_tree_combined(const struct object_id *oid,
>  			opt->flags.follow_renames	||
>  			opt->break_opt != -1	||
>  			opt->detect_rename	||
> -			opt->pickaxe		||
> +			(opt->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)	||
>  			opt->filter;
>  
>  
> diff --git a/diff.c b/diff.c
> index 0763e89263..5508745dc8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4173,7 +4173,7 @@ void diff_setup_done(struct diff_options *options)
>  	/*
>  	 * Also pickaxe would not work very well if you do not say recursive
>  	 */
> -	if (options->pickaxe)
> +	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
>  		options->flags.recursive = 1;
>  	/*
>  	 * When patches are generated, submodules diffed against the work tree
> @@ -5777,7 +5777,7 @@ void diffcore_std(struct diff_options *options)
>  		if (options->break_opt != -1)
>  			diffcore_merge_broken();
>  	}
> -	if (options->pickaxe)
> +	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
>  		diffcore_pickaxe(options);
>  	if (options->orderfile)
>  		diffcore_order(options->orderfile);
> diff --git a/diff.h b/diff.h
> index 8af1213684..9ec4f824fe 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -326,6 +326,8 @@ extern void diff_setup_done(struct diff_options *);
>  #define DIFF_PICKAXE_KIND_S	4 /* traditional plumbing counter */
>  #define DIFF_PICKAXE_KIND_G	8 /* grep in the patch */
>  
> +#define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | DIFF_PICKAXE_KIND_G)
> +
>  #define DIFF_PICKAXE_IGNORE_CASE	32
>  
>  extern void diffcore_std(struct diff_options *);
> diff --git a/revision.c b/revision.c
> index ccf1d212ce..5d11ecaf27 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2407,7 +2407,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		revs->diff = 1;
>  
>  	/* Pickaxe, diff-filter and rename following need diffs */
> -	if (revs->diffopt.pickaxe ||
> +	if ((revs->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
>  	    revs->diffopt.filter ||
>  	    revs->diffopt.flags.follow_renames)
>  		revs->diff = 1;
