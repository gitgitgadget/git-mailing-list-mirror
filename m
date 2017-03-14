Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81197201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdCNSmZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 14:42:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59627 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751102AbdCNSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 14:42:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49BAE6A5B8;
        Tue, 14 Mar 2017 14:42:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MnOB+NsV8bG06NEgYN2+nctSKas=; b=ya3i5E
        0/eJrYtNN8wB26R/UOWQCMRMEbBzV65BMB26/BD0hVfD9qHwIEpRkztvj6VRAlQr
        3f7IOVgc21QscZizzGL0oioI28OSrcijipyE47uk2v48bAzCiagTxrtvfegKs94V
        ROARookCl7p4n0c00H2IFWzEMp93BtiJKwd3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ompuauF0X7OuxAlB8HkPu+k/43YjvCN0
        RoJI8kTXX7M/ErWmRswa8HlTLchTlBcdiTMPJ2TwFRKvWhQpgGJ/xGNEKuQd0DUQ
        UbdzGR8lo7OgwT12q4unOMN/7u4Gl0pxX0WPbSH4trfXqlwkG7dHWg+YNowZq1jv
        iHpy/Z8pGng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 439466A5B6;
        Tue, 14 Mar 2017 14:42:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D9A26A5B5;
        Tue, 14 Mar 2017 14:42:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 05/10] submodule: decouple url and submodule existence
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-6-bmwill@google.com>
Date:   Tue, 14 Mar 2017 11:42:20 -0700
In-Reply-To: <20170313214341.172676-6-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:36 -0700")
Message-ID: <xmqqzignittf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F57310FA-08E5-11E7-8434-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Currently the submodule.<name>.url config option is used to determine
> if a given submodule exists and is interesting to the user.  This
> however doesn't work very well because the URL is a config option for
> the scope of a repository, whereas the existence of a submodule is an
> option scoped to the working tree.

A submodule exists if it is exists, whether the user is interested
in it or not.  If it should be checked out in the working tree is a
different matter, but that should be a logical AND between "is it of
interest?" and "is the superproject tree has a gitlink for it in its
working tree?".  

So I do not agree with "This however doesn't work" at all.  I'd
understand it if you said "This is cumbersome if we want to do this
and that, which are different from what we have done traditionally"
and explain what this and that are and how they are different.

> In a future with worktree support for submodules, there will be multiple
> working trees, each of which may only need a subset of the submodules
> checked out.  The URL (which is where the submodule repository can be
> obtained) should not differ between different working trees.

And this makes the motivation a bit clearer.  When the user wants to
have multiple worktrees for the same superproject.  In such a
setting, the same submodule in two worktrees typically want to have
the same URL.  It may be different from what the upstream suggests
in the .gitmodules file, but the difference, i.e. the site specific
customization of the URL, should be the same between the two
worktrees.  But one worktree may be and the other worktree may not be
interested in that submodule, and with shared .git/config file, you
cannot have submodule.<name>.url set to one value and unset at the
same time.

This series does not solve the "two worktrees cannot have private
parts in the configuration namespace" issue, but assuming it will be
solved by some other series, it anticipates that submodule.<name>.URL 
would want to be shared between two worktrees most of time (note that
there will be users who want two separate .URL for the same submodule
while sharing the object database via worktrees mechanism, and you'll
need to prepare for them, too), and another "bit" that tells if the
submodule is of interest would want to be private to each worktree.

That is the motivation, the reason why you want .URL to stop serving
the dual purpose of overriding upstream-suggested URL and indicating
the submodule is interesting to the user.

> It may also be convenient for users to more easily specify groups of
> submodules they are interested in as apposed to running "git submodule
> init <path>" on each submodule they want checked out in their working
> tree.
>
> To this end two config options are introduced, submodule.active and
> submodule.<name>.active.  The submodule.active config holds a pathspec
> that specifies which submodules should exist in the working tree.  The
> submodule.<name>.active config is a boolean flag used to indicate if
> that particular submodule should exist in the working tree.

And because two worktrees always share their .git/config, these new
configuration variables are useless to help workflow with multiple
worktrees with the current system, until "per-worktree configuration"
is invented.  But we prepare for that future in this step.

Also submodule.active that takes pathspec and not name is an oddball
(use of "name" not "path" is to prepare for a submodule whose
location in the superproject changes depending on the commit in the
superproject), and we need to justify with an explanation.  I think
you envision two cases.  1. we encourage projects to adopt a
convention that submodules are grouped with leading directory, so
that pathspec e.g. lib/, would cover _all_ library-ish modules to
allow those who are interested in library-ish modules to set
".active = lib/" just once to say any and all modules in lib/ are
interesting.  2. another convention the projects can adopt, when
pathspec-attribute feature is invented, is to label submodules with
attribute to group them, so that a broad pathspec with attribute
requirement, e.g. .:(attr:lib), can be used to say any and all
modules with 'lib' attribute are interesting.

The above two points (justifications, intended uses and future
plans) need to be clarified around here (and possibly in the
documentation), I would think.

> diff --git a/submodule.c b/submodule.c
> index 0a2831d84..2b33bd70f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -217,13 +217,41 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
>  int is_submodule_initialized(const char *path)
>  {
>  	int ret = 0;
> -	const struct submodule *module = NULL;
> +	char *key;
> +	const struct string_list *sl;
> +	const struct submodule *module = submodule_from_path(null_sha1, path);
>  
> -	module = submodule_from_path(null_sha1, path);
> +	/* early return if there isn't a path->module mapping */
> +	if (!module)
> +		return 0;
> +
> +	/* submodule.<name>.active is set */
> +	key = xstrfmt("submodule.%s.active", module->name);
> +	if (!git_config_get_bool(key, &ret)) {
> +		free(key);
> +		return ret;
> +	}
> +	free(key);
> +
> +	sl = git_config_get_value_multi("submodule.active");
>  
> -	if (module) {
> -		char *key = xstrfmt("submodule.%s.url", module->name);
> +	if (sl) {
> +		struct pathspec ps;
> +		struct argv_array args = ARGV_ARRAY_INIT;
> +		const struct string_list_item *item;
> +
> +		for_each_string_list_item(item, sl) {
> +			argv_array_push(&args, item->string);
> +		}
> +
> +		parse_pathspec(&ps, 0, 0, 0, args.argv);
> +		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
> +
> +		argv_array_clear(&args);
> +		clear_pathspec(&ps);
> +	} else {
>  		char *value = NULL;
> +		key = xstrfmt("submodule.%s.url", module->name);
>  
>  		ret = !git_config_get_string(key, &value);

It probably is easier to read if you had a final "return ret" in the
"if (sl) {...}" part, just like you have one for the codepath that
deals with "submodule.<name>.active", and flatten the else clause.
That would make it clear that we have three ways with decreasing
precedence.

At this point, the answer from function is even less about "is it
initialized?"  but about "is it of interest?" (or "is it to be
initialized?").  We'd probably want a /* NEEDSWORK */ comment before
the function to remind us to come up with a better name after the
dust settles.

> diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
> index f18e0c925..c41b899ab 100755
> --- a/t/t7413-submodule-is-active.sh
> +++ b/t/t7413-submodule-is-active.sh
> @@ -28,4 +28,59 @@ test_expect_success 'is-active works with urls' '
>  	git -C super submodule--helper is-active sub1
>  '
>  
> +test_expect_success 'is-active works with submodule.<name>.active config' '
> +	git -C super config --bool submodule.sub1.active "false" &&
> +	test_must_fail git -C super submodule--helper is-active sub1 &&
> +
> +	git -C super config --bool submodule.sub1.active "true" &&
> +	git -C super config --unset submodule.sub1.URL &&
> +	git -C super submodule--helper is-active sub1 &&
> +
> +	git -C super config submodule.sub1.URL ../sub &&
> +	git -C super config --unset submodule.sub1.active
> +'

The last "unset" is done to clean the customization this test did,
in order to give a predictable beginning state to the next test?  If
so, use test_when_finished instead of &&-cascading it at the end.

> + ...
> +test_expect_success 'is-active with submodule.active and submodule.<name>.active' '
> +	git -C super config --add submodule.active "sub1" &&
> +	git -C super config --bool submodule.sub1.active "false" &&
> +	git -C super config --bool submodule.sub2.active "true" &&
> +
> +	test_must_fail git -C super submodule--helper is-active sub1 &&
> +	git -C super submodule--helper is-active sub2 &&
> +
> +	git -C super config --unset-all submodule.active &&
> +	git -C super config --unset submodule.sub1.active &&
> +	git -C super config --unset submodule.sub2.active
> +'

Likewise for all the new tests in this patch.

Thanks.
