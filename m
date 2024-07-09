Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E6180047
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550670; cv=none; b=WAuLBfPudWRVBtMPxH8Dad9zGMFoPZYfXHxN9WoYQBv4hqRyiEhtNFf21GEjia723iS+KUZiFHR3u45elCYYml0or+OjuPfSw9ilx7FJX5PSeGJhcMLi5MlDERc6dQ5V85g6zvXRaVEtTN8HkT5ZGNmZShlLRpCGKStV0RZEIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550670; c=relaxed/simple;
	bh=Img9eJ5Gtymj4gF7VZyXI2WweQ3SmqOnNkbtes/wNhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+vp5E3nB216Oi6Ryib7pZKsUqDy/z30xZP0AkxIvVTtcYDkk59Yc+y5dNqvvlfqvKRb0KCxHEETu2TeHVptnQ0PgMu8u7WqNH3gCXjP0k8WdA0FfCvJRv34LNvnzVSQGIRwIbrI47/9/kHhf+U5vkqg/ucevfGkxLw0FMkDq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xQ0QnIyr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xQ0QnIyr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45AE135570;
	Tue,  9 Jul 2024 14:44:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Img9eJ5Gtymj4gF7VZyXI2WweQ3SmqOnNkbtes
	/wNhA=; b=xQ0QnIyrv4LBzZuISQF0BlAtz5vE8fTxjl5sIMCLR+BoPDCBjZJmfO
	ClV/q3DOJ2UlwnmohWuo+WRA4xxFlUlAir1PLG5mF/XWN289h8GyqbzE25u/B33i
	hdPLx9RI6pwWmKqMMGG/sEELXxoE9woLktJkdElxRWZqFqdmdMN1Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E11B3556F;
	Tue,  9 Jul 2024 14:44:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A31C33556D;
	Tue,  9 Jul 2024 14:44:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating remote
In-Reply-To: <20240709144931.1146528-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Tue, 9 Jul 2024 16:49:31 +0200")
References: <20240708140350.622986-1-karthik.188@gmail.com>
	<20240709144931.1146528-1-karthik.188@gmail.com>
Date: Tue, 09 Jul 2024 11:44:25 -0700
Message-ID: <xmqq4j8yflrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 448FD702-3E23-11EF-80E0-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> - Added more details to the commit message to clarify the issue at hand.

> Since 9badf97c42 (remote: allow resetting url list, 2024-06-14), we
> reset the remote URL if the provided URL is empty. When a user of
> 'remotes_remote_get' tries to fetch a remote with an empty repo name,
> the function initializes the remote via 'make_remote'. But the remote is
> still not a valid remote, since the URL is empty, so it tries to add the
> URL alias using 'add_url_alias'. This in-turn will call 'add_url', but
> since the URL is empty we call 'strvec_clear' on the `remote->url`. Back
> in 'remotes_remote_get', we again check if the remote is valid, which
> fails, so we return 'NULL' for the 'struct remote *' value

That's better, but it still talks only about the implementation and
control flow description without mentioning what end-user action it
breaks.  We see in the new test this:

    $ git push "" main

but is that something we even want to support?  Before 9badf97c
(remote: allow resetting url list, 2024-06-14), the command would
have failed with different way [*1*].

Is it merely "this is a nonsense request and must fail, but we do
not want to hit BUG in general"?  I think it is the latter, but
leaving it unsaid is confusing.  How about starting it more like...

    When an end-user runs "git push" with an empty string for the
    remote repository name, e.g.

        $ git push '' main

    "git push" fails with a BUG().  This is because ...

or something.

cmd_push() calls set_refspecs() on a repo (whose name is ""), which
then calls remote.c:remote_get() on it, which calls
remote.c:make_remote() to obtain a remote structure.

But during this calling sequence especially down from remote_get(),
there are inconsistent decisions made for an empty string as a name.
It is not a NULL pointer, so it does not benefit from the default
refspecs by calling get_default=remotes_remote_for_branch,
valid_remote_nick() considers it is not a valid nick so we do not
read remotes or branches configuration file, but we still think a
name was given (even though it is an empty string) and try to do
something useful by calling add_url_alias().

It is a mess and whoever designed this should be shot [*2*] ;-).

In any case, an obvious additional fix on top of your change might
be to do something like this:

        diff --git i/remote.c w/remote.c
        index 5fa046c8f8..d7f9ba3571 100644
        --- i/remote.c
        +++ w/remote.c
        @@ -682,7 +682,7 @@ remotes_remote_get_1(
                struct remote *ret;
                int name_given = 0;

        -	if (name)
        +	if (name && *name)
                        name_given = 1;
                else
                        name = get_default(remote_state, remote_state->current_branch,

which would give us the default remote name, and we would not call
add_url_alias() with a bogus empty string to nuke the list.

> - Cleaned up 'set_refspecs' by now accepting a remote instead of trying
>   to obtain one. 

The last one, which does make sense, is not mentioned in the
proposed log message.  Lazy remote creation does not help the
updated caller because it already has one.

> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
> @@ -38,6 +41,13 @@ test_expect_success 'detect missing sha1 expressions early' '
>  	test_cmp expect rp-ran
>  '
>  
> +# We need to use an existing local_ref so that the remote is mapped to
> +# it in 'builtin/push.c:set_refspecs()'.

Hmph, it is OK to force 'main' like the above as a workaround, but
wouldn't it be sufficient to do

    $ git push "" HEAD:refs/heads/main

or something to avoid having to know what our current branch is?

Thanks.


[Footnote }

 *1* For example, before Peff's series, here is what I got:

         $ git push "" HEAD:master
         fatal: no path specified; see 'git help pull' for valid url syntax

     It comes from transport_push() -> get_refs_via_connect() ->
     parse_connect_url() code path.

 *2* It probably is me writing in the original in shell script, so I
     can safely say this without offending anybody.


