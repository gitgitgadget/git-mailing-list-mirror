Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60511770E6
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673660; cv=none; b=XZzRCsezEKcsJXOeYun/0s/vWHnqN95Tjyf9ZZeV/C+tiVtOZlTMZJCcKEM7PZtVY6chOl421dGzjsjvdhpS9cuGxItkQa84fJ+P2JvJVlS+z/LujGu4q4tJW/s99vCh8ne0xPI5/7k2SD4MaRGOzNlWBRKyTkFm4Ciz17liFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673660; c=relaxed/simple;
	bh=UdeydNtzHn04E71QtCjGMtP26ZfHvTu4obXw0vtPiqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BH7UHtTI+1IeG5Pzxg8wMuFGYL/jKJItuxOvXstGf4ZGkRjrGpjupdBEEvclQJMdys1SCCM66I0HfPgP5YTnI23u0ly0qePKhUU4bzf+LeRAiYZuLdt6q9sOvPGKaGnESHAXUQ1AWP36lTFmaB/Vol3oswzJTz5AHU18o3e0T3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n4tePljH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n4tePljH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D85A52422B;
	Mon, 22 Jul 2024 14:40:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UdeydNtzHn04E71QtCjGMtP26ZfHvTu4obXw0v
	tPiqk=; b=n4tePljHViWxnKuvgLQc5P/SGMOkDJIBPSP7SIEoxpQ5TG8i0CbC1n
	2iY2Y9HILDwTcVKXMex+LRUCpq81+DYZLsd7AuQDjPwH946w6JFDHXkvNS67bZJ1
	CwjdBAtGBqGcXSX5ltFBfyx129nGm3/irB+P8zqx6N37BpRfMZoFA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D01BC2422A;
	Mon, 22 Jul 2024 14:40:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CE97241E5;
	Mon, 22 Jul 2024 14:40:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fetch: use bundle URIs when having creationToken heuristic
In-Reply-To: <20240722080705.2614195-1-toon@iotcl.com> (Toon Claes's message
	of "Mon, 22 Jul 2024 10:07:05 +0200")
References: <20240722080705.2614195-1-toon@iotcl.com>
Date: Mon, 22 Jul 2024 11:40:52 -0700
Message-ID: <xmqqmsm9b77v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ED660168-4859-11EF-B44E-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Toon Claes <toon@iotcl.com> writes:

> At the moment, bundle URIs are only used on git-clone(1). For a clone
> the use of bundle URI is trivial, because repository is empty so
> downloading bundles will never result in downloading objects that are in
> the repository already.
>
> For git-fetch(1), this more complicated to use bundle URI. We want to
> avoid downloading bundles that only contains objects that are in the
> local repository already.
>
> One way to achieve this is possible when the "creationToken" heuristic
> is used for bundle URIs. With this heuristic, the server sends along a
> creationToken for each bundle. When a client downloads bundles with such
> creationToken, the highest known value is written to
> `fetch.bundleCreationToken` in the git-config. The next time bundles are
> advertised by the server, bundles with a lower creationToken value are
> ignored. This was already implemented by 7903efb717 (bundle-uri:
> download in creationToken order, 2023-01-31) in
> fetch_bundles_by_token().
>
> Using the creationToken heuristic is optional, but without it the
> client has no idea which bundles are new and which only have objects the
> client already has.

The above explains that you can see which bundle is newer than which
other ones, but ...

> With this knowledge, make git-fetch(1) get bundle URI information from
> the server, but only use bundle URIs if the creationToken heuristic is
> used.

... it does not explain how it helps for the repository that runs
"fetch" to tell which bundles do not give any new objects it does
not have.  "clone" starts from an emptyness, so for it it is enough
if it can figure out among N bundles the other end has, which ones
are sufficient to cover the entire set of objects the other end has,
but "fetch" needs to be able to exclude a lot more---the objects
this end has need to be excluded".  The logic to do so may need to
be explained a bit better than the above to make it more convincing.

On the other hand...

> The code added in builtin/fetch.c is very similar to the code in
> builtin/clone.c, so while at it make sure we always clean up the bundles
> list advertised by the server.

... I do understand that clean-up code.  Please make it a separate
preliminary clean-up patch before the main thing.

If the "clone" and "fetch" codepath uses very similar logic, can the
code in "clone" the preliminary clean-up patch would fix be
refactored in another separate patch on top of the clean-up patch to
a helper function that can be called from outside?  And then can
"fetch" be taught, on top of those two preliminary patches, to call
that helper function to implement what this single patch wanted to
do?

Thanks.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/clone.c             | 13 +++++-----
>  builtin/fetch.c             | 17 +++++++++++++
>  t/t5584-fetch-bundle-uri.sh | 49 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 6 deletions(-)
>  create mode 100755 t/t5584-fetch-bundle-uri.sh
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index af6017d41a..29f0470aea 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1406,9 +1406,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			git_config_set_gently("fetch.bundleuri", bundle_uri);
>  	} else {
>  		/*
> -		* Populate transport->got_remote_bundle_uri and
> -		* transport->bundle_uri. We might get nothing.
> -		*/
> +		 * Populate transport->bundles. We might get nothing or fail
> +		 * trying, but clone can continue without bundles as well.
> +		 */
>  		transport_get_remote_bundle_uri(transport);
>
>  		if (transport->bundles &&
> @@ -1419,10 +1419,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			else if (fetch_bundle_list(the_repository,
>  						   transport->bundles))
>  				warning(_("failed to fetch advertised bundles"));
> -		} else {
> -			clear_bundle_list(transport->bundles);
> -			FREE_AND_NULL(transport->bundles);
>  		}
> +
> +		clear_bundle_list(transport->bundles);
> +		if (transport->bundles)
> +			FREE_AND_NULL(transport->bundles);
>  	}
>
>  	if (refs)
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 693f02b958..1e944f81af 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1694,6 +1694,23 @@ static int do_fetch(struct transport *transport,
>  			retcode = 1;
>  	}
>
> +	/*
> +	 * Populate transport->bundles. We might get nothing or fail
> +	 * trying, but fetch can continue without bundles as well.
> +	 */
> +	transport_get_remote_bundle_uri(transport);
> +
> +	if (transport->bundles &&
> +	    hashmap_get_size(&transport->bundles->bundles) &&
> +	    (transport->bundles->heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)) {
> +		if (fetch_bundle_list(the_repository, transport->bundles))
> +			warning(_("failed to fetch advertised bundles"));
> +	}
> +
> +	clear_bundle_list(transport->bundles);
> +	if (transport->bundles)
> +		FREE_AND_NULL(transport->bundles);
> +
>  	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
>  				   &fetch_head, config)) {
>  		retcode = 1;
> diff --git a/t/t5584-fetch-bundle-uri.sh b/t/t5584-fetch-bundle-uri.sh
> new file mode 100755
> index 0000000000..6c2383646e
> --- /dev/null
> +++ b/t/t5584-fetch-bundle-uri.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='test use of bundle URI in "git fetch"'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'set up repos and bundles' '
> +	git init source &&
> +	test_commit -C source A &&
> +	git clone --no-local source go-A-to-C &&
> +	test_commit -C source B &&
> +	git clone --no-local source go-B-to-C &&
> +	git clone --no-local source go-B-to-D &&
> +	git -C source bundle create B.bundle main &&
> +	test_commit -C source C &&
> +	git -C source bundle create B-to-C.bundle B..main &&
> +	git -C source config uploadpack.advertiseBundleURIs true &&
> +	git -C source config bundle.version 1 &&
> +	git -C source config bundle.mode all &&
> +	git -C source config bundle.heuristic creationToken &&
> +	git -C source config bundle.bundle-B.uri "file://$(pwd)/source/B.bundle" &&
> +	git -C source config bundle.bundle-B.creationToken 1 &&
> +	git -C source config bundle.bundle-B-to-C.uri "file://$(pwd)/source/B-to-C.bundle" &&
> +	git -C source config bundle.bundle-B-to-C.creationToken 2
> +'
> +
> +test_expect_success 'fetches one bundle URI to get up-to-date' '
> +	git -C go-B-to-C -c transfer.bundleURI=true fetch origin &&
> +	test 1 = $(ls go-B-to-C/.git/objects/bundles | wc -l) &&
> +	test 2 = $(git -C go-B-to-C config fetch.bundleCreationToken)
> +'
> +
> +test_expect_success 'fetches two bundle URIs to get up-to-date' '
> +	git -C go-A-to-C -c transfer.bundleURI=true fetch origin &&
> +	test 2 = $(ls go-A-to-C/.git/objects/bundles | wc -l) &&
> +	test 2 = $(git -C go-A-to-C config fetch.bundleCreationToken)
> +'
> +
> +test_expect_success 'fetches one bundle URI and objects from remote' '
> +	test_commit -C source D &&
> +	git -C go-B-to-D -c transfer.bundleURI=true fetch origin &&
> +	test 1 = $(ls go-B-to-D/.git/objects/bundles | wc -l) &&
> +	test 2 = $(git -C go-B-to-D config fetch.bundleCreationToken)
> +'
> +
> +test_done
> --
> 2.45.2
