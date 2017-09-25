Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A850D2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 03:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbdIYDfV (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 23:35:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53444 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753088AbdIYDfU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 23:35:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8189B2101;
        Sun, 24 Sep 2017 23:35:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EgAUQXWeGRrIbopCSVPZ/CVHJdI=; b=kFMUna
        Nzw6nzGnqi01RkPokGBpkTiD+5DKGhiyPEwfQmYcRz7OlbmcwC3xQm6wzny+7b+r
        QQzZ2QB283Po6Uh3+1b2xlXfHWC0AUcE7jmvtjNMZOkZ+/pQON+3GvGnrd1wM0MC
        7xHwLT+ON1QO7e5uQlHm1qn4c1M+Dj8SEHzDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xZqHWTobKZbU3aqvXcKYsSCRHlCMgOS1
        5HsilN3BzSc1zOqZSrxfn/Dq1fYqSzALYBV+jxILlYixWd4knUBsfkodGAw6hE2f
        jQd+Y242ATTfFhhvHG+ZlodwCOtNMDUIis8SOlPjrosB8y6s6Pks2MMjL+qBRHKV
        lVOkvEQ7OXY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0292B2100;
        Sun, 24 Sep 2017 23:35:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 415C7B20FF;
        Sun, 24 Sep 2017 23:35:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     hanwen@google.com, christian.couder@gmail.com, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v5 1/4] submodule--helper: introduce get_submodule_displaypath()
References: <20170921161059.11750-1-hanwen@google.com>
        <20170924120858.26813-1-pc44800@gmail.com>
        <20170924120858.26813-2-pc44800@gmail.com>
Date:   Mon, 25 Sep 2017 12:35:18 +0900
In-Reply-To: <20170924120858.26813-2-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sun, 24 Sep 2017 17:38:55 +0530")
Message-ID: <xmqqshfbfo21.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DC6DBDE-A1A2-11E7-9271-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Introduce function get_submodule_displaypath() to replace the code
> occurring in submodule_init() for generating displaypath of the
> submodule with a call to it.
>
> This new function will also be used in other parts of the system
> in later patches.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 818fe74f0..d24ac9028 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -220,6 +220,29 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +/* the result should be freed by the caller. */
> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +	const char *super_prefix = get_super_prefix();
> +
> +	if (prefix && super_prefix) {
> +		BUG("cannot have prefix '%s' and superprefix '%s'",
> +		    prefix, super_prefix);
> +	} else if (prefix) {
> +		struct strbuf sb = STRBUF_INIT;
> +		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
> +		strbuf_release(&sb);
> +		return displaypath;
> +	} else if (super_prefix) {
> +		int len = strlen(super_prefix);
> +		const char *format = (len > 0 && is_dir_sep(super_prefix[len - 1])) ? "%s%s" : "%s/%s";
> +
> +		return xstrfmt(format, super_prefix, path);
> +	} else {
> +		return xstrdup(path);
> +	}
> +}

Looks like a fairly faithful rewrite of the original below, with a
reasonable clean-up (e.g. use of xstrfmt() instead of addf()).

One thing I noticed is that future callers of this function, unlike
init_submodule() which is its original caller, are allowed to have
super-prefix that does not end in a slash, because the helper
automatically supplies one when it is missing.

I am not sure the added leniency is desirable [*1*], but in any
case, the added leniency deserves a mention in the log message, I
would think.


[Footnote]

*1* Often it is harder to introduce bugs when the internal rules are
stricter, e.g. "prefix must end with slash", than when they are
looser, e.g. "prefix may or may not end with slash", because
allowing different codepaths to have the same thing in different
representations would hide bugs that is only uncovered when these
codepaths eventually meet (e.g. one codepath has a path with and the
other without trailing slash and they both think that is the
prefix---then they use strcmp() to see if they have the same prefix,
which would be a bug, which may not be noticed for a long time).

>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -335,15 +358,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	struct strbuf sb = STRBUF_INIT;
>  	char *upd = NULL, *url = NULL, *displaypath;
>  
> -	if (prefix && get_super_prefix())
> -		die("BUG: cannot have prefix and superprefix");
> -	else if (prefix)
> -		displaypath = xstrdup(relative_path(path, prefix, &sb));
> -	else if (get_super_prefix()) {
> -		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
> -		displaypath = strbuf_detach(&sb, NULL);
> -	} else
> -		displaypath = xstrdup(path);
> +	displaypath = get_submodule_displaypath(path, prefix);
>  
>  	sub = submodule_from_path(&null_oid, path);
>  
> @@ -358,9 +373,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	 * Set active flag for the submodule being initialized
>  	 */
>  	if (!is_submodule_active(the_repository, path)) {
> -		strbuf_reset(&sb);
>  		strbuf_addf(&sb, "submodule.%s.active", sub->name);
>  		git_config_set_gently(sb.buf, "true");
> +		strbuf_reset(&sb);
>  	}
>  
>  	/*
> @@ -368,7 +383,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	 * To look up the url in .git/config, we must not fall back to
>  	 * .gitmodules, so look it up directly.
>  	 */
> -	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "submodule.%s.url", sub->name);
>  	if (git_config_get_string(sb.buf, &url)) {
>  		if (!sub->url)
> @@ -405,9 +419,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  				_("Submodule '%s' (%s) registered for path '%s'\n"),
>  				sub->name, url, displaypath);
>  	}
> +	strbuf_reset(&sb);
>  
>  	/* Copy "update" setting when it is not set yet */
> -	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "submodule.%s.update", sub->name);
>  	if (git_config_get_string(sb.buf, &upd) &&
>  	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
