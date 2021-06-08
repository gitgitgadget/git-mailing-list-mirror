Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF6BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 03:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299F361078
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 03:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFHDUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 23:20:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57893 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhFHDUK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 23:20:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27A7D143181;
        Mon,  7 Jun 2021 23:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Mf+0XrEQGDHebk3xultnnBLnM1DGU43EEAZcp
        kHQKA=; b=Rkq7O2x7PRa5nr9axV9tcDGXYsb2yl4M6QGRBpOygXbn+j9DwwI/69
        5KduHtHVSp197I0aUAuAoqmcE8np6hde0JumG/djaKrUn+EqYEpm7Y7h1eyRqgyh
        15Ylg/oo591pbp3Ans3Ttmd+4SLLVgykRM+RydPL70Usc1ZYoiFRU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FD3A143180;
        Mon,  7 Jun 2021 23:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A36414317F;
        Mon,  7 Jun 2021 23:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
References: <cover.1622580781.git.jonathantanmy@google.com>
        <cover.1623111879.git.jonathantanmy@google.com>
        <07290cba86fda73ee329a47db8e524b32dba25af.1623111879.git.jonathantanmy@google.com>
Date:   Tue, 08 Jun 2021 12:18:12 +0900
In-Reply-To: <07290cba86fda73ee329a47db8e524b32dba25af.1623111879.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 7 Jun 2021 17:25:56 -0700")
Message-ID: <xmqq35ttrqmj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29621C0E-C808-11EB-904E-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, the reading of config related to promisor remotes is done in
> two places: once in setup.c (which sets the global variable
> repository_format_partial_clone, to be read by the code in
> promisor-remote.c), and once in promisor-remote.c. This means that care
> must be taken to ensure that repository_format_partial_clone is set
> before any code in promisor-remote.c accesses it.

The above is very true, but I am puzzled by the chosen direction of
the code movement.

Given that the value in the field repository_format.partial_clone
comes from an extension, and an extension that is not understood by
the version of Git that is running MUST abort the execution of Git,
wouldn't it be guaranteed that, in a correctly written program, the
.partial_clone field must already be set up correctly before
anything else, including those in promissor-remote.c, accesses it?

> To simplify the code, move all such config reading to promisor-remote.c.
> By doing this, it will be easier to see when
> repository_format_partial_clone is written and, thus, to reason about
> the code. This will be especially helpful in a subsequent commit, which
> modifies this code.

So, I am not sure if this simplifies the code the way we want to
read our code.  Doing a thing in one place is indeed simpler than
doing it in two places, but it looks like promisor-remote code
should be using the repository-format data more, not the other way
around, at least to me.

Perhaps I am missing some other motivation, though.

Thanks.

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  cache.h           |  1 -
>  promisor-remote.c | 14 +++++++++-----
>  promisor-remote.h |  6 ------
>  setup.c           | 10 +++++++---
>  4 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index ba04ff8bd3..dbdcec8601 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1061,7 +1061,6 @@ extern int repository_format_worktree_config;
>  struct repository_format {
>  	int version;
>  	int precious_objects;
> -	char *partial_clone; /* value of extensions.partialclone */
>  	int worktree_config;
>  	int is_bare;
>  	int hash_algo;
> diff --git a/promisor-remote.c b/promisor-remote.c
> index da3f2ca261..c0e5061dfe 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -7,11 +7,6 @@
>  
>  static char *repository_format_partial_clone;
>  
> -void set_repository_format_partial_clone(char *partial_clone)
> -{
> -	repository_format_partial_clone = xstrdup_or_null(partial_clone);
> -}
> -
>  static int fetch_objects(const char *remote_name,
>  			 const struct object_id *oids,
>  			 int oid_nr)
> @@ -99,6 +94,15 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>  	size_t namelen;
>  	const char *subkey;
>  
> +	if (!strcmp(var, "extensions.partialclone")) {
> +		/*
> +		 * NULL value is handled in handle_extension_v0 in setup.c.
> +		 */
> +		if (value)
> +			repository_format_partial_clone = xstrdup(value);
> +		return 0;
> +	}
> +
>  	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
>  		return 0;
>  
> diff --git a/promisor-remote.h b/promisor-remote.h
> index c7a14063c5..687210ab87 100644
> --- a/promisor-remote.h
> +++ b/promisor-remote.h
> @@ -32,10 +32,4 @@ int promisor_remote_get_direct(struct repository *repo,
>  			       const struct object_id *oids,
>  			       int oid_nr);
>  
> -/*
> - * This should be used only once from setup.c to set the value we got
> - * from the extensions.partialclone config option.
> - */
> -void set_repository_format_partial_clone(char *partial_clone);
> -
>  #endif /* PROMISOR_REMOTE_H */
> diff --git a/setup.c b/setup.c
> index 59e2facd9d..d60b6bc554 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -470,7 +470,13 @@ static enum extension_result handle_extension_v0(const char *var,
>  		} else if (!strcmp(ext, "partialclone")) {
>  			if (!value)
>  				return config_error_nonbool(var);
> -			data->partial_clone = xstrdup(value);
> +			/*
> +			 * This config variable will be read together with the
> +			 * other relevant config variables in
> +			 * promisor_remote_config() in promisor_remote.c, so we
> +			 * do not need to read it here. Just report that this
> +			 * extension is known.
> +			 */
>  			return EXTENSION_OK;
>  		} else if (!strcmp(ext, "worktreeconfig")) {
>  			data->worktree_config = git_config_bool(var, value);
> @@ -566,7 +572,6 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>  	}
>  
>  	repository_format_precious_objects = candidate->precious_objects;
> -	set_repository_format_partial_clone(candidate->partial_clone);
>  	repository_format_worktree_config = candidate->worktree_config;
>  	string_list_clear(&candidate->unknown_extensions, 0);
>  	string_list_clear(&candidate->v1_only_extensions, 0);
> @@ -650,7 +655,6 @@ void clear_repository_format(struct repository_format *format)
>  	string_list_clear(&format->unknown_extensions, 0);
>  	string_list_clear(&format->v1_only_extensions, 0);
>  	free(format->work_tree);
> -	free(format->partial_clone);
>  	init_repository_format(format);
>  }
