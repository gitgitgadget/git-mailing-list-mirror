Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28F8207DF
	for <e@80x24.org>; Sat, 17 Sep 2016 03:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755696AbcIQDqk (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 23:46:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50850 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754701AbcIQDqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 23:46:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0758B3F89C;
        Fri, 16 Sep 2016 23:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HYrmvUvRIOlpsbhlqmuA4E2NsWg=; b=Piytiq
        0X7dF26sYlOCNZ+QYMwwYJallID3ux7nVLr4Qib6JKCp468MvotcNhjNrbsBTwZa
        7cvJjsXRgsvSyyaY4jVTXHdQ61N7/riPCDgr2rbVewrhIGxwgBdzUryrA/8qHyv5
        t5UPMOjiTy+GA+LeXxoULjfXda4SKyTmVcVjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hnE1BliSbKWD/Dzs1yGZ3StsJh9KByCg
        IVFJUHHEexTlahkbtzmdZkhEDG/jpEp7LX9BvsQ4TdANROnqGQwZBe9zBQPfHGXg
        yB++iioKnckCzcVWhDKyXad9WvFpmUvK1fMsBoyb7FMeRlRYmr8gCikz6mQYtNfo
        0N6Fa6Ww1R8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1A493F89A;
        Fri, 16 Sep 2016 23:46:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DFAF3F899;
        Fri, 16 Sep 2016 23:46:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
        <1474073981-96620-1-git-send-email-bmwill@google.com>
Date:   Fri, 16 Sep 2016 20:46:35 -0700
In-Reply-To: <1474073981-96620-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 16 Sep 2016 17:59:41 -0700")
Message-ID: <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55E21C9A-7C89-11E6-B516-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> ...
>  		[--full-name] [--recurse-submodules]
> -		[--output-path-prefix=<path>]
> +		[--submodule-prefix=<path>]
>  		[--abbrev] [--] [<file>...]
>  
> ---output-path-prefix=<path>::
> +--submodule-prefix=<path>::
>  	Prepend the provided path to the output of each file
> ...
>  static int show_eol;
> -static const char *output_path_prefix;
> +static const char *submodule_prefix;
>  static int recurse_submodules;
> ...
>  	static struct strbuf full_name = STRBUF_INIT;
> -	if (output_path_prefix && *output_path_prefix) {
> +	if (submodule_prefix && *submodule_prefix) {
>  		strbuf_reset(&full_name);
> -		strbuf_addstr(&full_name, output_path_prefix);
> +		strbuf_addstr(&full_name, submodule_prefix);
>  		strbuf_addstr(&full_name, name);

As the previous one that used a wrong (sorry) argument is not even
in 'next' yet, let's pretend that it never happened.  It is OK to
still keep it and this patch as two separate steps, i.e. a topic
with two patches in it.

> +	/* Add pathspec args */
> +	argv_array_push(&cp.args, "--");
> +	for (i = 0; i < pathspec.nr; ++i)
> +		argv_array_push(&cp.args, pathspec.items[i].original);

OK, so as discussed previously with Heiko and Stefan, the idea is to

 - pass the original pathspec as-is,

 - when --submodule-prefix is given, a path discovered in a
   submodule repository is first prefixed with that string before
   getting checked to see if it matches the original pathspec.

And this loop is about relaying the original pathspec.

> @@ -192,57 +210,63 @@ static void show_gitlink(const struct cache_entry *ce)
>  
>  static void show_ce_entry(const char *tag, const struct cache_entry *ce)
>  {
> +	struct strbuf name = STRBUF_INIT;
>  	int len = max_prefix_len;
> +	if (submodule_prefix)
> +		strbuf_addstr(&name, submodule_prefix);
> +	strbuf_addstr(&name, ce->name);
>  
>  	if (len >= ce_namelen(ce))
> -		die("git ls-files: internal error - cache entry not superset of prefix");
> +		die("git ls-files: internal error - cache entry not "
> +		    "superset of prefix");

This is not such a great thing to do.  Upon a bug report, we can no
longer do

	git grep 'cache entry not superset'

to see where the error message is coming from.

> -	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
> -			    len, ps_matched,
> -			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
> -		return;
> -	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
> +	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> +	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
>  		show_gitlink(ce);
> -		return;
> -	}
> +	} else if (match_pathspec(&pathspec, name.buf, name.len,
> +				  len, ps_matched,
> +				  S_ISDIR(ce->ce_mode) ||
> +				  S_ISGITLINK(ce->ce_mode))) {
> +		if (tag && *tag && show_valid_bit &&
> + ...

Argh.  If we had a preparatory clean-up step, would it have helped
to avoid this big re-indentation that makes the patch harder to read
than necessary, I wonder?

Another way would have been to "goto" from the end of this block

> +	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> +	    submodule_path_match(&pathspec, name.buf, ps_matched)) {

where we used to "return" out to the central clean-up location, i.e.
here.

> +	strbuf_release(&name);
>  }


>  	parse_pathspec(&pathspec, 0,
>  		       PATHSPEC_PREFER_CWD |
>  		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>  		       prefix, argv);
>  
> -	/* Find common prefix for all pathspec's */
> -	max_prefix = common_prefix(&pathspec);
> +	/*
> +	 * Find common prefix for all pathspec's
> +	 * This is used as a performance optimization which violates correctness
> +	 * in the recurse_submodules mode
> +	 */

The two new lines phrase it overly negatively and also misleading.
I thought you were saying "We do this as optimization anyway; damn
the correctness in the submodule case!" in my first reading before
reading the statements the comment talks about.  "This optimization
unfortunately cannot be done when recursing into submodules" would
have been better.

> +	if (recurse_submodules)
> +		max_prefix = NULL;
> +	else
> +		max_prefix = common_prefix(&pathspec);
>  	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;

> diff --git a/dir.c b/dir.c
> index 0ea235f..630dc7a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -63,6 +63,30 @@ int fspathncmp(const char *a, const char *b, size_t count)
>  	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
>  }
>  
> +static int prefix_fnmatch(const struct pathspec_item *item,
> +		   const char *pattern, const char *string,
> +		   int prefix)
> +{

Is this meant to be free of false positives, free of false
negatives, or exact?  I think you use it to decide, without knowing
what kind of paths the submodule contains, if it is worth descending
into it, so as long as you definitively say "The pathspec can never
match anything in the submodule" with WM_NOMATCH, it is OK if you
returned WM_MATCH when it actually couldn't match anything.  I.e. it
is OK to give false positive but it is a bug to give false negative.

The answer to the above question should be a good explanation to
prepend as /* comment */ before the function.

> +	if (prefix > 0) {
> +		if (ps_strncmp(item, pattern, string, prefix))
> +			return WM_NOMATCH;

This says: when we have a set prefix that must literally match, and
that part does not match what we have, it cannot possibly match.

Is that correct?  What do we have in "name" and "item" at this
point?  We disable the common-prefix optimization, so we do not have
to worry about a pathspec with two elements "sub/dir1/*" and "sub/dir2/*"
giving you "sub/dir" as the common prefix, when you are wondering if
it is worth descending into "sub/" without knowing what it contains.
Is that what guarantees why this part is correct?

> +		pattern += prefix;
> +		string += prefix;
> +	}
> +
> +	if (item->flags & PATHSPEC_ONESTAR) {
> +		return WM_MATCH;

We have a pathspec that has a segment without wildcard letters,
followed by a '*', and there is no wildcard letters after that
asterisk.  We punt and assume it might match, which is OK for the
purpose of not giving a false negative.

> +	} else if (item->magic & PATHSPEC_GLOB) {
> +		return wildmatch(pattern, string,
> +				 WM_PATHNAME |
> +				 (item->magic & PATHSPEC_ICASE ?
> +				  WM_CASEFOLD : 0),
> +				 NULL);

What does this say?  If we are using the :(glob) semantics, which is
the default, we'll ask wildmatch() to see the remainder of the
pattern (after stripping the fixed prefix part if necessary) matches
the string (which also may have lost the prefix that we already know
matches).

Is that correct?  I think it depends on what "string" is being fed,
but I am assuing that you are working in the top-level project here
to decide if it is worth descending into a submodule.  If the item
is sub/dir?/*.c and we are considering "sub/" submodule, wildmatch
would not say "It could match" if "string" is "sub/".  Perhaps I am
reading the patch incorrectly.  Let me read on to see what the caller
does later.
