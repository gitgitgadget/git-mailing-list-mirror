Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238A1C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED48C60FDA
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJSWUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:20:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:42054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJSWUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:20:53 -0400
Received: (qmail 7725 invoked by uid 109); 19 Oct 2021 22:18:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Oct 2021 22:18:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15993 invoked by uid 111); 19 Oct 2021 22:18:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Oct 2021 18:18:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Oct 2021 18:18:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
Message-ID: <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
References: <xmqqv91uw5dl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv91uw5dl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 11:32:38AM -0700, Junio C Hamano wrote:

> The for-each-ref family of commands invoke parsers immediately when
> it sees each --sort=<atom> option, and die before even seeing the
> other options on the command line when the <atom> is unrecognised.
> 
> Instead, accumulate them in a string list, and have them parsed into
> a ref_sorting structure after the command line parsing is done.  As
> a consequence, "git branch --sort=bogus -h" used to fail to give the
> brief help, which arguably may have been a feature, now does so,
> which is more consistent with how other options work.
> [...]

Very nicely explained. As you often say, I wish all patches came with a
commit message like this. :)

> As side effects, this change also cleans up a few issues:
> 
>  - 95be717c (parse_opt_ref_sorting: always use with NONEG flag,
>    2019-03-20) muses that "git for-each-ref --no-sort" should simply
>    clear the sort keys accumulated so far; it now does.

Neat. Is it worth adding a test here?

>  - The implementation detail of "struct ref_sorting" and the helper
>    function parse_ref_sorting() can now be private to the ref-filter
>    API implementation.

Yes, I think this makes the API overall cleaner. Including the fact that
ref_sorting_default() is now handled internally.

>  - If you set branch.sort to a bogus value, the any "git branch"
>    invocation, not only the listing mode, would abort with the
>    original code; now it doesn't

And the new tests nicely cover these cases.

>  builtin/branch.c        | 13 ++++++-------
>  builtin/for-each-ref.c  |  8 ++++----
>  builtin/ls-remote.c     | 13 ++++++++-----
>  builtin/tag.c           | 13 ++++++-------
>  ref-filter.c            | 34 ++++++++++++++++++++++++----------
>  ref-filter.h            | 28 ++++++++++------------------
>  t/t3200-branch.sh       | 12 +++++++++++-
>  t/t6300-for-each-ref.sh |  5 +++++
>  8 files changed, 74 insertions(+), 52 deletions(-)

The patch overall looks good to me. Just a few observations:

> @@ -86,8 +86,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  
>  	packet_trace_identity("ls-remote");
>  
> -	UNLEAK(sorting);
> -
>  	if (argc > 1) {
>  		int i;
>  		CALLOC_ARRAY(pattern, argc);
> @@ -139,8 +137,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  		item->symref = xstrdup_or_null(ref->symref);
>  	}
>  
> -	if (sorting)
> +	if (sorting_options.nr) {
> +		struct ref_sorting *sorting;
> +		UNLEAK(sorting);
> +
> +		sorting = ref_sorting_options(&sorting_options);
>  		ref_array_sort(sorting, &ref_array);
> +	}

I wondered at first about pulling this UNLEAK() down, but it's because
you move the "sorting" variable itself into the smaller scope. So this
makes sense (and calling UNLEAK() before the pointer is set is perfectly
fine, since it takes the address of the auto variable). It is a shame
you can't just ref_sorting_free() afterwards, but we don't have that
function yet. And adding it is way out of scope here. :)

I do find it interesting that this case checks sorting_options.nr
itself, rather than relying on ref_sorting_options() to give us the
default. But that's because the existing code avoids sorting at all in
that case, so this is staying faithful to the original.

> -int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
> +struct ref_sorting *ref_sorting_options(struct string_list *options)
>  {
> +	struct string_list_item *item;
> +	struct ref_sorting *sorting = NULL, **tail = &sorting;
> +
> +	if (!options->nr) {
> +		sorting = ref_default_sorting();
> +	} else {
> +		for_each_string_list_item(item, options)
> +			parse_ref_sorting(tail, item->string);
> +	}
> +
>  	/*
> -	 * NEEDSWORK: We should probably clear the list in this case, but we've
> -	 * already munged the global used_atoms list, which would need to be
> -	 * undone.
> +	 * From here on, the ref_sorting list should be used to talk
> +	 * about the sort order used for the output.  The caller
> +	 * should not touch the string form anymore.
>  	 */
> -	BUG_ON_OPT_NEG(unset);
> -
> -	parse_ref_sorting(opt->value, arg);
> -	return 0;
> +	string_list_clear(options, 0);
> +	return sorting;
>  }

This interface seems pretty sensible overall. A few idle thoughts:

  - I'd probably have kept the word "parse" somewhere in the name, since
    it really is turning the user-provided text into our internal form

  - using a string_list is probably reasonable. We don't care about the
    util field here. Taking a "const char **" with NULL-termination or a
    number would be more general (and the callers could use a strvec to
    collect it). But I doubt any of the callers would ever be care about
    the distinction.

  - clearing the list at the end feels a little funny to me, just
    because this is conceptually a read-only operation (parse the user's
    text into our internal format). Your comment tells me what you're
    trying to protect against, but I find it unlikely anybody would
    mis-use the string_list afterwards (it doesn't do anything itself
    unless you parse it into the ref_sorting struct).

    All of the current callers are happy with this (and it even saves
    them clearing it themselves), but it just feels like an unusual
    interface.

> -struct ref_sorting {
> -	struct ref_sorting *next;
> -	int atom; /* index into used_atom array (internal) */
> -	enum {
> -		REF_SORTING_REVERSE = 1<<0,
> -		REF_SORTING_ICASE = 1<<1,
> -		REF_SORTING_VERSION = 1<<2,
> -		REF_SORTING_DETACHED_HEAD_FIRST = 1<<3,
> -	} sort_flags;
> +enum ref_sorting_order {
> +	REF_SORTING_REVERSE = 1<<0,
> +	REF_SORTING_ICASE = 1<<1,
> +	REF_SORTING_VERSION = 1<<2,
> +	REF_SORTING_DETACHED_HEAD_FIRST = 1<<3,
>  };

OK, so we have to leave this order enum public because some of the
callers use it with ref_sorting_set_sort_flags_all(). I was confused
that it never had a name before, but it looks like we just passed it as
an "unsigned int".

We could change that now that it has a name, but it's not a big deal
either way (and certainly a separate patch if we do).

> @@ -97,9 +94,8 @@ struct ref_format {
>  #define OPT_NO_MERGED(f, h) _OPT_MERGED_NO_MERGED("no-merged", f, h)
>  
>  #define OPT_REF_SORT(var) \
> -	OPT_CALLBACK_F(0, "sort", (var), \
> -		       N_("key"), N_("field name to sort on"), \
> -		       PARSE_OPT_NONEG, parse_opt_ref_sorting)
> +	OPT_STRING_LIST(0, "sort", (var), \
> +			N_("key"), N_("field name to sort on"))

Oh, this part makes using a string_list more appealing. ;)

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e575ffb4ff..0e23d18807 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1418,7 +1418,17 @@ test_expect_success 'invalid sort parameter in configuration' '
>  	(
>  		cd sort &&
>  		git config branch.sort "v:notvalid" &&
> -		test_must_fail git branch
> +
> +		# this works in the "listing" mode, so bad sort key
> +		# is a dying offence.
> +		test_must_fail git branch &&
> +
> +		# these do not need to use sorting, and should all
> +		# succeed
> +		git branch newone main &&
> +		git branch -c newone newerone &&
> +		git branch -m newone newestone &&
> +		git branch -d newerone newestone
>  	)
>  '

And this test looks very nice.

-Peff
