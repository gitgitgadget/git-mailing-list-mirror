Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9D1EB2B
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710537; cv=none; b=rqzJ35AmsMzodTuTPISL6OTjlIgaOhpfy1JwU5xwefjl6toalfVyE/2FLVLXvX3+fJUXxCLz90NF25MQ7h0MAw67ro+2JgOQtgycaweUg3LV0ulbTRCMcOX0fvUnKackn9Z8JBA0KJooKQEUtLhcsOqXHmjmM0658bLEdLzEF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710537; c=relaxed/simple;
	bh=6Zjs4QASl2N5m/EoQSrLSX3d6TTen6YsVljBk37Tv+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BB+IF4Z7wc22hRkmTsDwjhMyNpdAUyBz6mRJTIJhuVLonlBGVQeoYeSiBj4KB7R6GDb/9phaB5umctktiMUelQp3XtDHHSjt2w8vYjgJkyf1eb9cwIiSXImVUAwNDbuN5TDAsX2dT4i+dFCAN09rTqbeKoK7ISZoMAtFH39dxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wUfgQGJP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wUfgQGJP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2C3D2790A;
	Thu, 11 Jul 2024 11:08:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6Zjs4QASl2N5m/EoQSrLSX3d6TTen6YsVljBk3
	7Tv+g=; b=wUfgQGJPGBxUS7fF0wsrztQ4rH/CjjYqtVH+KZhqnU9Bezl8LHNlnU
	PgvFcm24LqmKmX8JJsJMcFfY0PSTAdfwWHMDYtXpl4MocxCKLJjQDqNsUWONpsyI
	D2Fq6TcRDZ5uq055qRUFm4axG9wYyyNpnSpt2EbVLcW7x4rjdCz3Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B12A27909;
	Thu, 11 Jul 2024 11:08:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1370C27908;
	Thu, 11 Jul 2024 11:08:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v3] builtin/push: call set_refspecs after validating remote
In-Reply-To: <20240711093954.20317-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 11 Jul 2024 11:39:54 +0200")
References: <20240709144931.1146528-1-karthik.188@gmail.com>
	<20240711093954.20317-1-karthik.188@gmail.com>
Date: Thu, 11 Jul 2024 08:08:52 -0700
Message-ID: <xmqqo774neyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CF7627A-3F97-11EF-B436-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> When an end-user runs "git push" with an empty string for the remote
> repository name, e.g.
>
>     $ git push '' main
>
> "git push" fails with a BUG(). Even though this is a nonsense request
> that we want to fail, we shouldn't hit a BUG().  Instead we want to give
> a sensible error message, e.g., 'bad repository'".
>
> This is because since 9badf97c42 (remote: allow resetting url list,
> 2024-06-14), we reset the remote URL if the provided URL is empty. When
> a user of 'remotes_remote_get' tries to fetch a remote with an empty
> repo name, the function initializes the remote via 'make_remote'. But
> the remote is still not a valid remote, since the URL is empty, so it
> tries to add the URL alias using 'add_url_alias'. This in-turn will call
> 'add_url', but since the URL is empty we call 'strvec_clear' on the
> `remote->url`. Back in 'remotes_remote_get', we again check if the
> remote is valid, which fails, so we return 'NULL' for the 'struct
> remote *' value.
>
> The 'builtin/push.c' code, calls 'set_refspecs' before validating the
> remote. This worked with empty repo names earlier since we would get a
> remote, albeit with an empty URL. With the new changes, we get a 'NULL'
> remote value, this causes the check for remote to fail and raises the
> BUG in 'set_refspecs'.
>
> Do a simple fix by doing remote validation first. Also add a test to
> validate the bug fix. With this, we can also now directly pass remote to
> 'set_refspecs' instead of it trying to lazily obtain it.
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> ...
>  builtin/push.c         | 21 +++++++--------------
>  t/t5529-push-errors.sh | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 14 deletions(-)

Everything makes sense to me.  Thanks.

> diff --git a/builtin/push.c b/builtin/push.c
> index 8260c6e46a..7a67398124 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -96,9 +96,8 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
>  	refspec_append(refspec, ref);
>  }
>  
> -static void set_refspecs(const char **refs, int nr, const char *repo)
> +static void set_refspecs(const char **refs, int nr, struct remote *remote)
>  {
> -	struct remote *remote = NULL;
>  	struct ref *local_refs = NULL;
>  	int i;
>  
> @@ -124,17 +123,10 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
>  				local_refs = get_local_heads();
>  
>  			/* Does "ref" uniquely name our ref? */
> -			if (count_refspec_match(ref, local_refs, &matched) != 1) {
> +			if (count_refspec_match(ref, local_refs, &matched) != 1)
>  				refspec_append(&rs, ref);
> -			} else {
> -				/* lazily grab remote */
> -				if (!remote)
> -					remote = remote_get(repo);
> -				if (!remote)
> -					BUG("must get a remote for repo '%s'", repo);
> -
> +			else
>  				refspec_append_mapped(&rs, ref, remote, matched);
> -			}
>  		} else
>  			refspec_append(&rs, ref);
>  	}
> @@ -630,10 +622,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	if (tags)
>  		refspec_append(&rs, "refs/tags/*");
>  
> -	if (argc > 0) {
> +	if (argc > 0)
>  		repo = argv[0];
> -		set_refspecs(argv + 1, argc - 1, repo);
> -	}
>  
>  	remote = pushremote_get(repo);
>  	if (!remote) {
> @@ -649,6 +639,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		    "    git push <name>\n"));
>  	}
>  
> +	if (argc > 0)
> +		set_refspecs(argv + 1, argc - 1, remote);
> +
>  	if (remote->mirror)
>  		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
>  
> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> index 0247137cb3..17d7257892 100755
> --- a/t/t5529-push-errors.sh
> +++ b/t/t5529-push-errors.sh
> @@ -2,6 +2,9 @@
>  
>  test_description='detect some push errors early (before contacting remote)'
>  
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
> @@ -38,6 +41,20 @@ test_expect_success 'detect missing sha1 expressions early' '
>  	test_cmp expect rp-ran
>  '
>  
> +# We use an existing local_ref, since it follows a different flow in
> +# 'builtin/push.c:set_refspecs()' and we want to test that regression.
> +test_expect_success 'detect empty remote with existing local ref' '
> +	test_must_fail git push "" main 2> stderr &&
> +	grep "fatal: bad repository ${SQ}${SQ}" stderr
> +'
> +
> +# While similar to the previous test, here we want to ensure that
> +# even targeted refspecs are handled.
> +test_expect_success 'detect empty remote with targeted refspec' '
> +	test_must_fail git push "" HEAD:refs/heads/main 2> stderr &&
> +	grep "fatal: bad repository ${SQ}${SQ}" stderr
> +'
> +
>  test_expect_success 'detect ambiguous refs early' '
>  	git branch foo &&
>  	git tag foo &&
