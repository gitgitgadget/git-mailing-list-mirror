Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE5C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 23:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhLQXfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 18:35:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57598 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLQXfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 18:35:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81D1FF8CE7;
        Fri, 17 Dec 2021 18:35:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0n4MDeHPKaSSB0QaGnPho4ToVqvL3v0ARz8iO2
        vrgJc=; b=EbwRkdqFJPTOAQn40embRhxnXyISEqoiPt1zvoLFIhbd8oXAQ+r8MN
        P+cfWO4MiJ/cq+gKy2C1vuShBYZiKtEpUQBOD4I5ibz3FxJ1bO6M+TPoI8Uq3VBi
        iRqbANFytU4tNyVc3nMuD3yokHRNaigTYZpPGfGcncvSXWYoV6WII=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23DC6F8CE1;
        Fri, 17 Dec 2021 18:35:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8086BF8CDD;
        Fri, 17 Dec 2021 18:35:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] builtin/fetch: skip unnecessary tasks when using
 --negotiate-only
References: <20211207192925.67680-1-chooglen@google.com>
        <20211217000235.68996-1-chooglen@google.com>
Date:   Fri, 17 Dec 2021 15:35:04 -0800
In-Reply-To: <20211217000235.68996-1-chooglen@google.com> (Glen Choo's message
        of "Thu, 16 Dec 2021 16:02:35 -0800")
Message-ID: <xmqqilvm24bb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F74BE232-5F91-11EC-B122-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> cmd_fetch() performs certain tasks with the assumption that objects are
> fetched, but `git fetch --negotiate-only` does not fetch objects, as its
> name implies. This is results in behavior that is unnecessary at best,
> and incorrect at worst:
>
> * Submodules are updated if enabled by recurse.submodules=true, but
>   negotiation fetch doesn't actually update the repo, so this doesn't
>   make sense (introduced in [1]).

Hmph.

> * Commit graphs will be written if enabled by
>   fetch.writeCommitGraph=true. But according to
>   Documentation/config/fetch.txt [2], this should only be done if a
>   pack-file is downloaded.

Makes sense, as we haven't changed any reachability, and we have no
need to rewrite the graph file.

> * gc is run, but according to [3], we only do this because we expect
>   `git fetch` to introduce objects.

Makes sense.  As we haven't added any new objects, there is nothing
(other than the passage of time) that adds to the need to collect
garbage.

It makes me wonder if we need to do anything upon "fetch --dry-run".
I know we add to the object store without making anything reachable,
so that the user can do pre-flight checks with the real objects.  We
do not change the reachability so there is no reason to rewrite the
graph file, but we do add cruft to the object store.

Doing something about "--dry-run" is obviously outside the scope of
this topic, but it may make sense to think about it while we are
thinking about "fetch".

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f7abbc31ff..85091af99b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1996,6 +1996,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
> +
> +	if (negotiate_only) {
> +		/*
> +		 * --negotiate-only should never recurse into
> +		 * submodules, so there is no need to read .gitmodules.
> +		 */
> +		recurse_submodules = RECURSE_SUBMODULES_OFF;
> +		if (!negotiation_tip.nr)
> +			die(_("--negotiate-only needs one or more --negotiate-tip=*"));
> +	}
> +

This means "fetch --negotiate-only --recurse-submodules" silently
ignores an explicit wish by the user.

I suspect that this part should be more like this.

	if (negitiate_only &&
	    recurse_submodules != RECURSE_SUBMODULES_OFF) {
		if (recurse_submodules came from the parse_options)
			die(_("'--%s' cannot be used with '--%s'",
			      "recurse-submodules", "negotiate-only"));
		recurse_submodules = RECURSE_SUBMODULES_OFF;
	}

That is, we complain if user gives us a combination we do not
support, but we are OK if the configuration is set to do so and
silently ignore (because we declare that the combination does not
make sense).

By the way, do not move the check about the number of negotiation
tips from the original location.  That check, or its location, have
nothing to do with what you want to do in this patch, which is "do
not gc or update the graph file if we are not fetching".  It is
better to leave unrelated changes out of the patch.

In order to tell if recurse_submodules that is not OFF came from the
call to parse_options(), you may need to capture the value of the
variable before calling parse_options() and compare it with the
current value in the above illustration code snippet I gave.

Having said all that, is it true that recurse-submodules should not
be combined with negotiate-only?  I naively think it would not be
surprising if users expect negotiate-only fetches are done also in
the submodules.  Whatever we decide the right behaviour should be,
we should document it.  With your patch without any of my above
input, I would expect at least something like

    diff --git i/Documentation/fetch-options.txt w/Documentation/fetch-options.txt
    index e967ff1874..baf2e9c50d 100644
    --- i/Documentation/fetch-options.txt
    +++ w/Documentation/fetch-options.txt
    @@ -73,6 +73,9 @@ configuration variables documented in linkgit:git-config[1], and the
     +
     Internally this is used to implement the `push.negotiate` option, see
     linkgit:git-config[1].
    ++
    +Note that this option silently makes various options that do not make
    +sense to be used together with it (e.g. `--recurse-submodules`) ignored.
     
     --dry-run::
            Show what would be done, without making any changes.

to leave wiggling room for us to silently ignore more.  We may know
about --recurse-submodules today, but I would not be surprised if we
find more.

> @@ -2112,6 +2120,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		result = fetch_multiple(&list, max_children);
>  	}
>  
> +	string_list_clear(&list, 0);
> +
> +	/*
> +	 * Skip irrelevant tasks because we know objects were not
> +	 * fetched.
> +	 *
> +	 * NEEDSWORK: as a future optimization, we can return early
> +	 * whenever objects were not fetched e.g. if we already have all
> +	 * of them.
> +	 */
> +	if (negotiate_only)
> +		return result;
> +

I find it somewhat misleading to have the early return before the
block for recurse_submodules, as we _are_ already forcing it to not
to recurse.  It would be more readable if it went before the place
where we start doing the post-action clean-ups like reachability
graphs and garbage collection.

>  	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
>  		struct strvec options = STRVEC_INIT;
>  		int max_children = max_jobs;
> @@ -2132,8 +2153,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		strvec_clear(&options);
>  	}
>  
> -	string_list_clear(&list, 0);
> -

Namely, here.

>  	prepare_repo_settings(the_repository);

This is existing code, but I wonder why it can be done _SO_ late in
the sequence.  We've already called the transport API for the
negotiate-only communication at this point, but a call to this
function is the only thing that gives fetch_negotiation_algorithm
member in the_repository its default value, isn't it?

Thanks.
