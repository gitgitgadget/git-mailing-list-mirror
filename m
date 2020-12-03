Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B71C6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 02:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4169021D91
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 02:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgLCCVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 21:21:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60586 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgLCCVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 21:21:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5905F8CF5F;
        Wed,  2 Dec 2020 21:21:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sHwyp5n2i0WikAv32vq7OKEvSBc=; b=jC5X4f
        vh16FDDzPebXtGdZFFPOxb67Z020K6uu5gxkyySCyseFEbKK9Z0Iz6J9GxwLxghw
        0UEb4xAkQn9X0DKIvDb8jOsz0eicW+Xk07GI4Hv0fJwGwqPlU5e3qjXUN/b6bwp4
        2PH4iIBOTtc53rk+Bw/8Yn7m38o1pMdxB+oFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n2mXtdkg/d8TLrVskVI5tGBK/uv/AXMk
        cZWlGBRlnXkjCaWrPTmKc5wIF1bBWc3kGcLDzx1sY5HNiv6Wi+nH8mKa1ygwFK1D
        75bpCPhcvMCBBReQBvAsicXIIlDXFtaf2kdMlnzMqUkEJPL6bJbjvQjWhNf2tTuP
        Tkdd9aPDBwc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4120D8CF5E;
        Wed,  2 Dec 2020 21:21:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CE918CF58;
        Wed,  2 Dec 2020 21:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, felipe.contreras@gmail.com, ray@ameretat.dev,
        peff@peff.net, vondruch@redhat.com, tytso@mit.edu
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is
 not set either
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
        <20201125020931.248427-2-alexhenrie24@gmail.com>
Date:   Wed, 02 Dec 2020 18:21:01 -0800
In-Reply-To: <20201125020931.248427-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 24 Nov 2020 19:09:31 -0700")
Message-ID: <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3065BA48-350E-11EB-BC34-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index eb0aabd396..1eb79e2939 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -43,10 +43,16 @@ set to `no` at the beginning of them.
>  --no-ff::
>  --ff-only::
>  	Specifies how a merge is handled when the merged-in history is
> -	already a descendant of the current history.  `--ff` is the
> -	default unless merging an annotated (and possibly signed) tag
> -	that is not stored in its natural place in the `refs/tags/`
> -	hierarchy, in which case `--no-ff` is assumed.
> +	already a descendant of the current history.
> +	+
> +	In `git pull`, `--ff-only` is the default unless `--rebase` or
> +	`--no-rebase` is specified, in which case the default is `--ff`.
> +	However, the default changes again to `--no-ff` in the unlikely
> +	scenario where an annotated (and possibly signed) tag that is not
> +	stored in its natural place in the `refs/tags/` hierarchy is being
> +	merged.
> +	+
> +	In `git merge`, `--ff` is always the default.

As we can see one line below, I think these new paragraphs must be
dedented.

> +
> With `--ff`, when possible resolve the merge as a fast-forward (only
> update the branch pointer to match the merged branch; do not create a
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 4d80efe5b7..c703560a77 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -292,17 +292,21 @@ static void set_reflog_message(int argc, const char **argv)
>  }
>  
>  /**
> - * If pull.ff is unset, returns NULL. If pull.ff is "true", returns "--ff". If
> - * pull.ff is "false", returns "--no-ff". If pull.ff is "only", returns
> - * "--ff-only". Otherwise, if pull.ff is set to an invalid value, die with an
> - * error.
> + * If pull.ff is unset, returns NULL if pull.rebase is set or "--ff-only" if
> + * pull.rebase is not set. If pull.ff is "true", returns "--ff". If pull.ff is
> + * "false", returns "--no-ff". If pull.ff is "only", returns "--ff-only".
> + * Otherwise, if pull.ff is set to an invalid value, die with an error.
>   */
>  static const char *config_get_ff(void)
>  {
>  	const char *value;
>  
> -	if (git_config_get_value("pull.ff", &value))
> -		return NULL;
> +	if (git_config_get_value("pull.ff", &value)) {
> +		if (opt_rebase < 0)
> +			return "--ff-only";
> +		else
> +			return NULL;
> +	}

So, the idea is that we currently return NULL when pull.ff is set,
but now we also check "pull.rebase" etc. and give "--ff-only" when
we did not choose --[no-]rebase and lack the configuration.  So the
default (i.e. when pull.ff and pull.rebase are not set) would be as
if the user said

	git pull --ff-only --no-rebase

I am not seeing what problem this tries to solve, exactly, though.

I would have expected that for those who did not choose between
merge and rebase (either with the pull.rebase configuration or from
the command line --[no-]rebase option) the command would behave as
if --ff-only is given, regardless of how pull.ff configuration is
set.  That way, those who are unconfigured will just follow along
what happens at the upstream, until they have their own development,
at which point "--ff-only" can no longer be satisfied and their
"pull" would fail until they choose how to consolidate their work
with the upstream.

And once they choose between merge and rebase, we no longer have to
force "--ff-only" and things will start working as specified by the
user.  In other words, what I would have expected in the previous
paragraph is a minimum and natural extension of the current "you
must pick between merge and rebase or you'll get an advice message
until you do so"---we do not warn for those who haven't chosen as
long as they are only riding along with the upstream without having
their own development.

Having said that, back to what you did in your patch (read: the
following comments are not about achieving what I would have
expected; it is about what this patch from you seems to be trying to
do).

The above code in config_get_ff() obviously depends on the order in
the caller to make this call and determine opt_rebase's value and I
see you tweaked the caller to call config_get_rebase() before it
makes a call to this helper.

It feels a bit brittle now because of this subtle dependency.

Perhaps it is a good idea to introduce another helper that
cmd_pull() calls, and make that helper call these two helpers that
determine the value of opt_rebase and opt_ff, to hide the
dependency.

> @@ -322,7 +326,7 @@ static const char *config_get_ff(void)
>   * value of "branch.$curr_branch.rebase", where $curr_branch is the current
>   * branch, and if HEAD is detached or the configuration key does not exist,
>   * looks for the value of "pull.rebase". If both configuration keys do not
> - * exist, returns REBASE_FALSE.
> + * exist, returns REBASE_INVALID.
>   */
>  static enum rebase_type config_get_rebase(void)
>  {
> @@ -344,23 +348,7 @@ static enum rebase_type config_get_rebase(void)
>  	if (!git_config_get_value("pull.rebase", &value))
>  		return parse_config_rebase("pull.rebase", value, 1);
>  
> -	if (opt_verbosity >= 0 && !opt_ff) {
> -		warning(_("Starting in Git 3.0, the default behavior of `git pull` will change\n"
> -			"when it is not specified how to reconcile divergent branches. You can\n"
> -			"squelch this message by running one of the following commands sometime\n"
> -			"before your next pull:\n"
> -			"\n"
> -			"  git config pull.rebase false  # merge (the current default)\n"
> -			"  git config pull.rebase true   # rebase\n"
> -			"  git config pull.ff only       # fast-forward only (the future default)\n"
> -			"\n"
> -			"You can replace \"git config\" with \"git config --global\" to set a default\n"
> -			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -			"or --ff-only on the command line to override the configured default per\n"
> -			"invocation.\n"));
> -	}
> -
> -	return REBASE_FALSE;
> +	return REBASE_INVALID;
>  }

Hmph, and who reacts to this REBASE_INVALID value?  Shouldn't there
be something that catches this INVALID value and stop/complain?

>  
>  /**
> @@ -931,11 +919,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	parse_repo_refspecs(argc, argv, &repo, &refspecs);
>  
> +	if (opt_rebase < 0)
> +		opt_rebase = config_get_rebase();
> +
>  	if (!opt_ff)
>  		opt_ff = xstrdup_or_null(config_get_ff());
>  
>  	if (opt_rebase < 0)
> -		opt_rebase = config_get_rebase();
> +		opt_rebase = REBASE_FALSE;
>  
>  	if (read_cache_unmerged())
>  		die_resolve_conflict("pull");

Another thing.  Does "git pull --rebase --ff-only" behave sensibly?
"rebase our history on top of theirs only if we are truly ahead" is
a bit strange way to say "we only ride along without having our own
development, and once we discover we have our own stuff, stop us".
IIRC, "git pull --rebase" ignored the "--ff-only" request and
rebased our own stuff on top of their history anyway, which we would
want to fix.
