Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDB2C191
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n/eYoXcI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C94CF33481;
	Thu,  4 Jan 2024 13:23:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LRN4YgaO3RLW6qJ5ajPZxWcPxb0eXyKt9dG9aL
	vHR/Q=; b=n/eYoXcI8rfSw2ZTapfJBSm7R55OL9I24Lg+lqQNhHhJMuF9t7BYKz
	zqo0fYLtVT562rYzpXyln/nEsphv4vaf8BQtmuxEj09F+LxTfB7PckcNU8VsmSPS
	HyybrfA9+3CvW24GNs8FGxWP4PKjAXigbT/Ops4ccSXmfjT8vc75g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA91633480;
	Thu,  4 Jan 2024 13:23:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55CB13347F;
	Thu,  4 Jan 2024 13:23:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fetch: add new config option fetch.all
In-Reply-To: <20240104143656.615117-1-dev@tb6.eu> (Tamino Bauknecht's message
	of "Thu, 4 Jan 2024 15:33:55 +0100")
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
	<20240104143656.615117-1-dev@tb6.eu>
Date: Thu, 04 Jan 2024 10:23:11 -0800
Message-ID: <xmqqv8896jqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 525C461E-AB2E-11EE-A22B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Tamino Bauknecht <dev@tb6.eu> writes:

> This commit introduces the new boolean configuration option fetch.all
> which allows to fetch all available remotes by default. The config
> option can be overridden by explicitly specifying a remote.
> The behavior for --all is unchanged and calling git-fetch with --all and
> a remote will still result in an error.

This sounds like a usability annoyance for forks that use --all some
of the time and not always, as they now have to remember not just to
pass something to countermand the configured fetch.all but what that
something exactly is (i.e., the name of the remote they fetch from
by default), which makes fetch.all less appealing.  I wonder if we
can instead take "--no-all" from the command line to make configured
fetch.all ignored (hence, giving an explicit remote will fetch from
there, and not giving any remote will fetch from whereever the
command will fetch from with "git -c fetch.all=false fetch")?

> The option was also added to the config documentation and new tests
> cover the expected behavior.
> ---

Missing sign-off.

>  Documentation/config/fetch.txt |  4 ++
>  builtin/fetch.c                | 18 +++++--
>  t/t5514-fetch-multiple.sh      | 88 ++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index aea5b97477..4f12433874 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -50,6 +50,10 @@ fetch.pruneTags::
>  	refs. See also `remote.<name>.pruneTags` and the PRUNING
>  	section of linkgit:git-fetch[1].
>  
> +fetch.all::
> +	If true, fetch will attempt to update all available remotes.
> +	This behavior can be overridden by explicitly specifying a remote.

And we should say that this configuration variable defaults to false.

> @@ -2337,11 +2344,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
>  		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
>  
> -	if (all) {
> -		if (argc == 1)
> -			die(_("fetch --all does not take a repository argument"));
> -		else if (argc > 1)
> -			die(_("fetch --all does not make sense with refspecs"));
> +	if (all && argc == 1) {
> +		die(_("fetch --all does not take a repository argument"));
> +	} else if (all && argc > 1) {
> +		die(_("fetch --all does not make sense with refspecs"));
> +	} else if (all || (config.all > 0 && argc == 0)) {
> +		/* Only use fetch.all config option if no remotes were explicitly given */
>  		(void) for_each_remote(get_one_remote_for_fetch, &list);

This conditional cascade will probably need to change when we allow
"--no-all" to countermand the configured fetch.all anyway, so I
won't worry about it now, but it looks somewhat convoluted that we
have to re-check "all" many times, which was the point of the
original that implemented this as a nested conditional.

Thanks.
