Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A37C47094
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 03:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392436108D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 03:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFHDce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 23:32:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54750 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFHDcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 23:32:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7C90143272;
        Mon,  7 Jun 2021 23:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G7rY7PfFahWrovpyJiWrCLQIe48rX3v/hHq+2w
        5pZgY=; b=KoLxg9o32aceceOww0FGMR7cchVyviIebVP8W/df1cFcDDJzc34s4Q
        MN0g5mjkDRLxf1gC37EOT4fKZ0TtIAhPEuVPgFDB8CzR6+y7L2NSjA69b2bOkbdj
        MFq97S3Tr03Ld9GWbF9l3ymH5X7URyzWl4t2VV98Vk4RS6b2W5u8E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFB8D143271;
        Mon,  7 Jun 2021 23:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8EC0143270;
        Mon,  7 Jun 2021 23:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 2/4] promisor-remote: support per-repository config
References: <cover.1622580781.git.jonathantanmy@google.com>
        <cover.1623111879.git.jonathantanmy@google.com>
        <c462927ff222501ade111003d9e063bf06d3a0b0.1623111879.git.jonathantanmy@google.com>
Date:   Tue, 08 Jun 2021 12:30:34 +0900
In-Reply-To: <c462927ff222501ade111003d9e063bf06d3a0b0.1623111879.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 7 Jun 2021 17:25:57 -0700")
Message-ID: <xmqqy2blqbhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E33EBE7E-C809-11EB-B795-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Instead of using global variables to store promisor remote information,
> store this config in struct repository instead, and add
> repository-agnostic non-static functions corresponding to the existing
> non-static functions that only work on the_repository.

This does make sense.  In general, repository extensions are per
repository, so anything read from "extensions.*" should be stored
per in-core repository structure.

But doesn't that mean the thing that should be fixed is on the
setup.c side, where not just extensions.partialClone but other data
is read into "struct repository_format *format"?  Shouldn't we have
a pointer to that struct in the in-core repository object?

Special casing the "partialClone" field alone feels somewhat strange
to me.

Thanks.


> The actual lazy-fetching of missing objects currently does not work on
> repositories other than the_repository, and will still not work after
> this commit, so add a BUG message explaining this. A subsequent commit
> will remove this limitation.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  promisor-remote.c | 103 ++++++++++++++++++++++++++--------------------
>  promisor-remote.h |  22 ++++++++--
>  repository.c      |   6 +++
>  repository.h      |   4 ++
>  4 files changed, 87 insertions(+), 48 deletions(-)
>
> diff --git a/promisor-remote.c b/promisor-remote.c
> index c0e5061dfe..e1e1f7e93a 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -5,7 +5,11 @@
>  #include "transport.h"
>  #include "strvec.h"
>  
> -static char *repository_format_partial_clone;
> +struct promisor_remote_config {
> +	char *repository_format_partial_clone;
> +	struct promisor_remote *promisors;
> +	struct promisor_remote **promisors_tail;
> +};
>  
>  static int fetch_objects(const char *remote_name,
>  			 const struct object_id *oids,
> @@ -37,10 +41,8 @@ static int fetch_objects(const char *remote_name,
>  	return finish_command(&child) ? -1 : 0;
>  }
>  
> -static struct promisor_remote *promisors;
> -static struct promisor_remote **promisors_tail = &promisors;
> -
> -static struct promisor_remote *promisor_remote_new(const char *remote_name)
> +static struct promisor_remote *promisor_remote_new(struct promisor_remote_config *config,
> +						   const char *remote_name)
>  {
>  	struct promisor_remote *r;
>  
> @@ -52,18 +54,19 @@ static struct promisor_remote *promisor_remote_new(const char *remote_name)
>  
>  	FLEX_ALLOC_STR(r, name, remote_name);
>  
> -	*promisors_tail = r;
> -	promisors_tail = &r->next;
> +	*config->promisors_tail = r;
> +	config->promisors_tail = &r->next;
>  
>  	return r;
>  }
>  
> -static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
> +static struct promisor_remote *promisor_remote_lookup(struct promisor_remote_config *config,
> +						      const char *remote_name,
>  						      struct promisor_remote **previous)
>  {
>  	struct promisor_remote *r, *p;
>  
> -	for (p = NULL, r = promisors; r; p = r, r = r->next)
> +	for (p = NULL, r = config->promisors; r; p = r, r = r->next)
>  		if (!strcmp(r->name, remote_name)) {
>  			if (previous)
>  				*previous = p;
> @@ -73,7 +76,8 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
>  	return NULL;
>  }
>  
> -static void promisor_remote_move_to_tail(struct promisor_remote *r,
> +static void promisor_remote_move_to_tail(struct promisor_remote_config *config,
> +					 struct promisor_remote *r,
>  					 struct promisor_remote *previous)
>  {
>  	if (r->next == NULL)
> @@ -82,14 +86,15 @@ static void promisor_remote_move_to_tail(struct promisor_remote *r,
>  	if (previous)
>  		previous->next = r->next;
>  	else
> -		promisors = r->next ? r->next : r;
> +		config->promisors = r->next ? r->next : r;
>  	r->next = NULL;
> -	*promisors_tail = r;
> -	promisors_tail = &r->next;
> +	*config->promisors_tail = r;
> +	config->promisors_tail = &r->next;
>  }
>  
>  static int promisor_remote_config(const char *var, const char *value, void *data)
>  {
> +	struct promisor_remote_config *config = data;
>  	const char *name;
>  	size_t namelen;
>  	const char *subkey;
> @@ -99,7 +104,7 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>  		 * NULL value is handled in handle_extension_v0 in setup.c.
>  		 */
>  		if (value)
> -			repository_format_partial_clone = xstrdup(value);
> +			config->repository_format_partial_clone = xstrdup(value);
>  		return 0;
>  	}
>  
> @@ -114,8 +119,8 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>  
>  		remote_name = xmemdupz(name, namelen);
>  
> -		if (!promisor_remote_lookup(remote_name, NULL))
> -			promisor_remote_new(remote_name);
> +		if (!promisor_remote_lookup(config, remote_name, NULL))
> +			promisor_remote_new(config, remote_name);
>  
>  		free(remote_name);
>  		return 0;
> @@ -124,9 +129,9 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>  		struct promisor_remote *r;
>  		char *remote_name = xmemdupz(name, namelen);
>  
> -		r = promisor_remote_lookup(remote_name, NULL);
> +		r = promisor_remote_lookup(config, remote_name, NULL);
>  		if (!r)
> -			r = promisor_remote_new(remote_name);
> +			r = promisor_remote_new(config, remote_name);
>  
>  		free(remote_name);
>  
> @@ -139,59 +144,65 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>  	return 0;
>  }
>  
> -static int initialized;
> -
> -static void promisor_remote_init(void)
> +static void promisor_remote_init(struct repository *r)
>  {
> -	if (initialized)
> +	struct promisor_remote_config *config;
> +
> +	if (r->promisor_remote_config)
>  		return;
> -	initialized = 1;
> +	config = r->promisor_remote_config =
> +		xcalloc(sizeof(*r->promisor_remote_config), 1);
> +	config->promisors_tail = &config->promisors;
>  
> -	git_config(promisor_remote_config, NULL);
> +	git_config(promisor_remote_config, config);
>  
> -	if (repository_format_partial_clone) {
> +	if (config->repository_format_partial_clone) {
>  		struct promisor_remote *o, *previous;
>  
> -		o = promisor_remote_lookup(repository_format_partial_clone,
> +		o = promisor_remote_lookup(config,
> +					   config->repository_format_partial_clone,
>  					   &previous);
>  		if (o)
> -			promisor_remote_move_to_tail(o, previous);
> +			promisor_remote_move_to_tail(config, o, previous);
>  		else
> -			promisor_remote_new(repository_format_partial_clone);
> +			promisor_remote_new(config, config->repository_format_partial_clone);
>  	}
>  }
>  
> -static void promisor_remote_clear(void)
> +void promisor_remote_clear(struct promisor_remote_config *config)
>  {
> -	while (promisors) {
> -		struct promisor_remote *r = promisors;
> -		promisors = promisors->next;
> +	FREE_AND_NULL(config->repository_format_partial_clone);
> +
> +	while (config->promisors) {
> +		struct promisor_remote *r = config->promisors;
> +		config->promisors = config->promisors->next;
>  		free(r);
>  	}
>  
> -	promisors_tail = &promisors;
> +	config->promisors_tail = &config->promisors;
>  }
>  
> -void promisor_remote_reinit(void)
> +void repo_promisor_remote_reinit(struct repository *r)
>  {
> -	initialized = 0;
> -	promisor_remote_clear();
> -	promisor_remote_init();
> +	promisor_remote_clear(r->promisor_remote_config);
> +	FREE_AND_NULL(r->promisor_remote_config);
> +	promisor_remote_init(r);
>  }
>  
> -struct promisor_remote *promisor_remote_find(const char *remote_name)
> +struct promisor_remote *repo_promisor_remote_find(struct repository *r,
> +						  const char *remote_name)
>  {
> -	promisor_remote_init();
> +	promisor_remote_init(r);
>  
>  	if (!remote_name)
> -		return promisors;
> +		return r->promisor_remote_config->promisors;
>  
> -	return promisor_remote_lookup(remote_name, NULL);
> +	return promisor_remote_lookup(r->promisor_remote_config, remote_name, NULL);
>  }
>  
> -int has_promisor_remote(void)
> +int repo_has_promisor_remote(struct repository *r)
>  {
> -	return !!promisor_remote_find(NULL);
> +	return !!repo_promisor_remote_find(r, NULL);
>  }
>  
>  static int remove_fetched_oids(struct repository *repo,
> @@ -239,9 +250,11 @@ int promisor_remote_get_direct(struct repository *repo,
>  	if (oid_nr == 0)
>  		return 0;
>  
> -	promisor_remote_init();
> +	promisor_remote_init(repo);
>  
> -	for (r = promisors; r; r = r->next) {
> +	if (repo != the_repository)
> +		BUG("only the_repository is supported for now");
> +	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
>  		if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
>  			if (remaining_nr == 1)
>  				continue;
> diff --git a/promisor-remote.h b/promisor-remote.h
> index 687210ab87..edc45ab0f5 100644
> --- a/promisor-remote.h
> +++ b/promisor-remote.h
> @@ -17,9 +17,25 @@ struct promisor_remote {
>  	const char name[FLEX_ARRAY];
>  };
>  
> -void promisor_remote_reinit(void);
> -struct promisor_remote *promisor_remote_find(const char *remote_name);
> -int has_promisor_remote(void);
> +void repo_promisor_remote_reinit(struct repository *r);
> +static inline void promisor_remote_reinit(void)
> +{
> +	repo_promisor_remote_reinit(the_repository);
> +}
> +
> +void promisor_remote_clear(struct promisor_remote_config *config);
> +
> +struct promisor_remote *repo_promisor_remote_find(struct repository *r, const char *remote_name);
> +static inline struct promisor_remote *promisor_remote_find(const char *remote_name)
> +{
> +	return repo_promisor_remote_find(the_repository, remote_name);
> +}
> +
> +int repo_has_promisor_remote(struct repository *r);
> +static inline int has_promisor_remote(void)
> +{
> +	return repo_has_promisor_remote(the_repository);
> +}
>  
>  /*
>   * Fetches all requested objects from all promisor remotes, trying them one at
> diff --git a/repository.c b/repository.c
> index 448cd557d4..dca0a11ab6 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -11,6 +11,7 @@
>  #include "lockfile.h"
>  #include "submodule-config.h"
>  #include "sparse-index.h"
> +#include "promisor-remote.h"
>  
>  /* The main repository */
>  static struct repository the_repo;
> @@ -258,6 +259,11 @@ void repo_clear(struct repository *repo)
>  		if (repo->index != &the_index)
>  			FREE_AND_NULL(repo->index);
>  	}
> +
> +	if (repo->promisor_remote_config) {
> +		promisor_remote_clear(repo->promisor_remote_config);
> +		FREE_AND_NULL(repo->promisor_remote_config);
> +	}
>  }
>  
>  int repo_read_index(struct repository *repo)
> diff --git a/repository.h b/repository.h
> index a45f7520fd..fc06c154e2 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -10,6 +10,7 @@ struct lock_file;
>  struct pathspec;
>  struct raw_object_store;
>  struct submodule_cache;
> +struct promisor_remote_config;
>  
>  enum untracked_cache_setting {
>  	UNTRACKED_CACHE_UNSET = -1,
> @@ -139,6 +140,9 @@ struct repository {
>  	/* True if commit-graph has been disabled within this process. */
>  	int commit_graph_disabled;
>  
> +	/* Configurations related to promisor remotes. */
> +	struct promisor_remote_config *promisor_remote_config;
> +
>  	/* Configurations */
>  
>  	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
