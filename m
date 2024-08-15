Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCF5A7AA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751264; cv=none; b=ma2CuE+sM8oFl2yI65tn3gRai+iNtyQNhTR+nQHhWAtudRGWEMgOK7yATUaKA31ZyDpsstjhXTWeP57aELv+aosPGDIY/sowQ+K3oEwbvI5RP3ePLK0+u5vQSGAafTSGj047OeoviOIlEw70EDaGpgD5OHzjmP+9mvv98/lY4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751264; c=relaxed/simple;
	bh=RTYveiU6RWJuhAN1x8sTwEfjPSh8auQhKA0PBuWdhaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQUnUBuc1kpBSTSS2UXGv3Uhe795KXHen8StMpR7yy83lCwpVTnxXnMJbSeGjDuonYdptf3Krq2hidH5W6tTYUnCQvQiVUQGloSYxDapfialUq+ztIz5PatU2IHwiRVCr4GHBZDi0Hvc6xDv2IVoV/3lWlEvX/hWT3Z5U2RG9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B72ISBar; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B72ISBar"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 392F324CE9;
	Thu, 15 Aug 2024 15:47:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RTYveiU6RWJuhAN1x8sTwEfjPSh8auQhKA0PBu
	WdhaE=; b=B72ISBarqGJtKpxb5JtbuEZ5OIXzgvSqfGNRv8+wpiHiblNqSclOJI
	+oSwt85XDEibEGwklFDbdNVKS9FBPePlxSrVXDj4p94frCYcKLWVsvwH4A4TntPx
	V7yGXF4dvqN9ov5wO/rLEaHAxW2Gkw4YtrknVAw37DA1gKuiSFA4w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31BBF24CE8;
	Thu, 15 Aug 2024 15:47:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92C6824CE7;
	Thu, 15 Aug 2024 15:47:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch: add top-level trace2 regions
In-Reply-To: <c0481f85f8166e520c387f9e9157b142b93d933c.1723747832.git.steadmon@google.com>
	(Josh Steadmon's message of "Thu, 15 Aug 2024 11:51:12 -0700")
References: <cover.1723747832.git.steadmon@google.com>
	<c0481f85f8166e520c387f9e9157b142b93d933c.1723747832.git.steadmon@google.com>
Date: Thu, 15 Aug 2024 12:47:40 -0700
Message-ID: <xmqqh6blsh43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3BCDE58A-5B3F-11EF-8EEF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> -	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
> -	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
> -		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
> +	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
> +		int result = 0;

This needs no initialization.

> +		trace2_region_enter("fetch", "fetch-bundle-uri", the_repository);
> +		result = fetch_bundle_uri(the_repository, bundle_uri, NULL);
> +		trace2_region_leave("fetch", "fetch-bundle-uri", the_repository);
> +		if (result)
> +			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
> +	}

It is a bit sad that the concise original with straight-forward
control flow had to be butchered like this to sprinkle tracing code
in it, but I guess that cannot be helped?  I wonder if it becomes
much less invasive and more future proof to define the trace region
in the fetch_bundle_uri() function itself.  Has it been considered?

> @@ -2407,6 +2412,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		struct oidset_iter iter;
>  		const struct object_id *oid;
>  
> +		trace2_region_enter("fetch", "negotiate-only", the_repository);
>  		if (!remote)
>  			die(_("must supply remote when using --negotiate-only"));
>  		gtransport = prepare_transport(remote, 1);
> @@ -2415,6 +2421,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		} else {
>  			warning(_("protocol does not support --negotiate-only, exiting"));
>  			result = 1;
> +			trace2_region_leave("fetch", "negotiate-only", the_repository);
>  			goto cleanup;
>  		}
>  		if (server_options.nr)
> @@ -2425,11 +2432,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		while ((oid = oidset_iter_next(&iter)))
>  			printf("%s\n", oid_to_hex(oid));
>  		oidset_clear(&acked_commits);
> +		trace2_region_leave("fetch", "negotiate-only", the_repository);

OK.  Both error path and normal path we leave the region we entered.

A complete tangent, but do we have an automated test or code
analysis that catches us if we forget to leave an entered region
(i.e., imagine we didn't leave in the else clause after issuing the
warning---we remain in the region in such an error case, even though
normally we leave the region correctly)?

>  	} else if (remote) {
> -		if (filter_options.choice || repo_has_promisor_remote(the_repository))
> +		if (filter_options.choice || repo_has_promisor_remote(the_repository)) {
> +			trace2_region_enter("fetch", "setup-partial", the_repository);
>  			fetch_one_setup_partial(remote);
> +			trace2_region_leave("fetch", "setup-partial", the_repository);
> +		}

OK.  That's nice and straight-forward.

> +		trace2_region_enter("fetch", "fetch-one", the_repository);
>  		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
>  				   &config);
> +		trace2_region_leave("fetch", "fetch-one", the_repository);

This one, too.
> @@ -2449,7 +2462,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			max_children = config.parallel;
>  
>  		/* TODO should this also die if we have a previous partial-clone? */
> +		trace2_region_enter("fetch", "fetch-multiple", the_repository);
>  		result = fetch_multiple(&list, max_children, &config);
> +		trace2_region_leave("fetch", "fetch-multiple", the_repository);

So is this.

> @@ -2471,6 +2486,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			max_children = config.parallel;
>  
>  		add_options_to_argv(&options, &config);
> +		trace2_region_enter_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
>  		result = fetch_submodules(the_repository,
>  					  &options,
>  					  submodule_prefix,
> @@ -2478,6 +2494,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  					  recurse_submodules_default,
>  					  verbosity < 0,
>  					  max_children);
> +		trace2_region_leave_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
>  		strvec_clear(&options);
>  	}

Ditto.

> @@ -2501,9 +2518,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		if (progress)
>  			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
>  
> +		trace2_region_enter("fetch", "write-commit-graph", the_repository);
>  		write_commit_graph_reachable(the_repository->objects->odb,
>  					     commit_graph_flags,
>  					     NULL);
> +		trace2_region_leave("fetch", "write-commit-graph", the_repository);

OK.
