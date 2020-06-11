Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A996C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58331206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZEiSdHXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFKBaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:30:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58984 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKBaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 21:30:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2589378CE9;
        Wed, 10 Jun 2020 21:30:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TfDiREpelbWWvzVU0aci6/Bgno4=; b=ZEiSdH
        XlIG7erd0+dPPrFjCsZpSFIAqpLUU7FiCctM9xtezBZ7LjSmHI8CPfnmNvdDrhcn
        jH5nJUm8hfg2/e+Zdbf6DV7t2JsjwgKa1QbADJTutZkTo7uNGrK0kV6uwGZud9vK
        W90zxo5LKrLEI21GIkBKAGXYQiBGSQqbi6jHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aCbX+u/pg8ZvGigtZNSwWXtzdSHdZdwU
        Vv7TDBGpyQdygb3Gl7FOCCDwmpFMVZm4ldVEegagWVXIEcsvkgYuRE154h2893gs
        N5y4qglm4+AvLEAMpCxTENpN7RVgcqoVt0/ZOmdabTgIgxRGf1JBabCOwIFRt65z
        N8v0gE1NjZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13A3C78CE7;
        Wed, 10 Jun 2020 21:30:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E52378CE5;
        Wed, 10 Jun 2020 21:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/9] http-fetch: support fetching packfiles by URL
References: <cover.1590789428.git.jonathantanmy@google.com>
        <cover.1591821067.git.jonathantanmy@google.com>
        <a4a7ed512b251fb16f0b2400fac8c0c5cc14aa75.1591821067.git.jonathantanmy@google.com>
Date:   Wed, 10 Jun 2020 18:30:09 -0700
In-Reply-To: <a4a7ed512b251fb16f0b2400fac8c0c5cc14aa75.1591821067.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 10 Jun 2020 13:57:18 -0700")
Message-ID: <xmqqo8pqcrtq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 172BF322-AB83-11EA-A86A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach http-fetch the ability to download packfiles directly, given a
> URL, and to verify them.
>
> The http_pack_request suite has been augmented with a function that
> takes a URL directly. With this function, the hash is only used to
> determine the name of the temporary file.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/git-http-fetch.txt |  9 ++++-
>  http-fetch.c                     | 63 +++++++++++++++++++++++++++-----
>  http.c                           | 28 ++++++++++----
>  http.h                           | 11 ++++++
>  t/t5550-http-fetch-dumb.sh       | 30 +++++++++++++++
>  5 files changed, 123 insertions(+), 18 deletions(-)

This step certainly got easier to read thanks to the introduction of 3/9
but ...

> @@ -68,25 +103,33 @@ int cmd_main(int argc, const char **argv)
>  			get_recover = 1;
>  		} else if (!strcmp(argv[arg], "--stdin")) {
>  			commits_on_stdin = 1;
> +		} else if (skip_prefix(argv[arg], "--packfile=", &p)) {
> +			const char *end;
> +
> +			packfile = 1;
> +			if (parse_oid_hex(p, &packfile_hash, &end) || *end)
> +				die(_("argument to --packfile must be a valid hash (got '%s')"), p);
>  		}
>  		arg++;
>  	}
> -	if (argc != arg + 2 - commits_on_stdin)
> +	if (argc != arg + 2 - (commits_on_stdin || packfile))
>  		usage(http_fetch_usage);
> -	if (commits_on_stdin) {
> -		commits = walker_targets_stdin(&commit_id, &write_ref);
> -	} else {
> -		commit_id = (char **) &argv[arg++];
> -		commits = 1;
> -	}
>  
>  	setup_git_directory();
>  
>  	git_config(git_default_config, NULL);
>  
> -	if (!argv[arg])
> -		BUG("must have one arg remaining");
> +	if (packfile) {
> +		fetch_single_packfile(&packfile_hash, argv[arg]);
> +		return 0;
> +	}
>  
> +	if (commits_on_stdin) {
> +		commits = walker_targets_stdin(&commit_id, &write_ref);
> +	} else {
> +		commit_id = (char **) &argv[arg++];
> +		commits = 1;
> +	}

... it would have been even less taxing to the readers' minds if the
code movement to run setup-git-directory and git-config before the
computation of the walker target done here is *not* part of this
step.  Perhaps that can be done between 2/9 and 3/9, or as part of
3/9?  The point is to reduce the mental load required to understand
the step that does *new* things, like this step.

> diff --git a/http.h b/http.h
> index bbc6b070f1..dc49c60165 100644
> --- a/http.h
> +++ b/http.h
> @@ -216,6 +216,15 @@ int http_get_info_packs(const char *base_url,
>  
>  struct http_pack_request {
>  	char *url;
> +
> +	/*
> +	 * If this is true, finish_http_pack_request() will pass "--keep" to
> +	 * index-pack, resulting in the creation of a keep file, and will not
> +	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
> +	 * printed to stdout).
> +	 */
> +	unsigned generate_keep : 1;

OK.

