Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B616A947
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273488; cv=none; b=TJdNtzhZxT+6Sv8wMZhkueoTUkeTFqVjLBOwr2F65chY9YalF9IV1g8OKcZM4jzQ2SwcWhbzQSl7V7dCzs4LgxoE1yEsnbFHtBtw0JyiO1ZwuXbBiV8PQ1qL047XRRKGTO/gUG29XgRN14FSaDY9KxVi+Ny+pg7HxQfe1L4poBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273488; c=relaxed/simple;
	bh=e63FAwaMxyXMp8vruIXiseC0q5gMM+7q/AMJpY17t8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9VgNeZyLMKUmFXW+uz6Hyu7tIypsPBeIZr4LPBgvNvXyG3yWcoR/J/k0c7S0Ubz22EiIiQ4xIT7itHhP3O7Aq+4ZRQ7h+KsB0m80zTzIzKdo4hFjnRobmqh/dOyFZBfIjx0fMQu46WUCK3txe8sOBywBCkXYlWx+nzBrwyKYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HyLDP/0a; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HyLDP/0a"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D577423D5F;
	Mon, 29 Jul 2024 13:18:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e63FAwaMxyXMp8vruIXiseC0q5gMM+7q/AMJpY
	17t8g=; b=HyLDP/0a6u/lpMCbIiBbQ5vT5pwXZhLFBbJsI5vCh9Ad45Sj0+Gpog
	GfBebfhTZEti3PCx+2e1ISw9NwrXQjLfGnPoHj6NDjI6V0T+j53WU+v78gZxEGi0
	4xKvFAjBYZvz2ZSJhmTiNnnVGKA642KfSUXp8z4gyI9CnE0QaYtDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB09123D5E;
	Mon, 29 Jul 2024 13:18:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFD3423D5A;
	Mon, 29 Jul 2024 13:18:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Mike Hommey <mh@glandium.org>
Subject: Re: [2.46 regression] git ls-remote crash with import remote-helper
In-Reply-To: <Zqe4Mec80hKaPWfH@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Jul 2024 17:41:37 +0200")
References: <20240727191917.p64ul4jybpm2a7hm@glandium.org>
	<xmqqle1mrx22.fsf@gitster.g> <Zqe4Mec80hKaPWfH@tanuki>
Date: Mon, 29 Jul 2024 10:18:03 -0700
Message-ID: <xmqqplqwi0c4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84591F32-4DCE-11EF-BF96-BAC1940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> ...  After all, when SHA-256
>> repositories become common out in the world, you should be able to
>> say ls-remote against them from your SHA-1 repository and the fact
>> that the hash-algo is read from local repository and set to SHA-1
>> should *not* negatively affect our ability to receive the ls-remote
>> response from SHA-256 repositories.  But that are all for longer
>> term future.  At least assuming SHA-1 like we have always done
>> should be better than the current situation.
>
> I definitely agree that as a short-term solution it's probably the best
> way to handle this.
>
> The below patch is what I came up with to paper over the issue. This
> restores the old behaviour, which is somewhat broken because we end up
> mis-parsing refspecs. But I guess "somewhat broken" is arguably better
> than "completely broken".

It probably matters much more that this "will restore the old
behaviour" than it is "somewhat but not completely broken".  Going
back to the old behaviour is not making anything worse.

I do not consider this (or any other "a command that optionally can
work outside a repository no longer works") issue a ultra-high
priority.  If your "ls-remote $URL" does not work in a directory you
wanted to run it, you can temporarily create an empty repository
there and run the command to obtain the result you wanted to get (in
other words, there is an easy workaround).

I was scanning the command[] table in git.c for entries marked with
RUN_SETUP_GENTLY but other than ls-remote nothing that is commonly
used stood out.

So let's make this one of the early "oops, here is a fix for .1 when
enough of them have accumulated" patch.

Thanks.

> Patrick
>
> --- >8 ---
>
> commit c52112d3946b2fd8d030580cd7acb809fa54012a
> Author: Patrick Steinhardt <ps@pks.im>
> Date:   Mon Jul 29 17:21:00 2024 +0200
>
>     builtin/ls-remote: fall back to SHA1 outside of a repo
>     
>     In c8aed5e8da (repository: stop setting SHA1 as the default object hash,
>     2024-05-07), we have stopped setting the default hash algorithm for
>     `the_repository`. Consequently, code that relies on `the_hash_algo` will
>     now crash when it hasn't explicitly been initialized, which may be the
>     case when running outside of a Git repository.
>     
>     It was reported that git-ls-remote(1) may crash in such a way when using
>     a remote helper that advertises refspecs. This is because the refspec
>     announced by the helper will get parsed during capability negotiation.
>     At that point we haven't yet figured out what object format the remote
>     uses though, so when run outside of a repository then we will fail.
>     
>     The course of action is somewhat dubious in the first place. Ideally, we
>     should only parse object IDs once we have asked the remote helper for
>     the object format. And if the helper didn't announce the "object-format"
>     capability, then we should always assume SHA256. But instead, we used to
>     take either SHA1 if there was no repository, or we used the hash of the
>     local repository, which is wrong.
>     
>     Arguably though, crashing hard may not be in the best interest of our
>     users, either. So while the old behaviour was buggy, let's restore it
>     for now as a short-term fix. We should eventually revisit, potentially
>     by deferring the point in time when we parse the refspec until after we
>     have figured out the remote's object hash.
>     
>     Reported-by: Mike Hommey <mh@glandium.org>
>     Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index debf2d4f88..6da63a67f5 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -91,6 +91,21 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	dest = argv[0];
>  
> +	/*
> +	 * TODO: This is buggy, but required for transport helpers. When a
> +	 * transport helper advertises a "refspec", then we'd add that to a
> +	 * list of refspecs via `refspec_append()`, which transitively depends
> +	 * on `the_hash_algo`. Thus, when the hash algorithm isn't properly set
> +	 * up, this would lead to a segfault.
> +	 *
> +	 * We really should fix this in the transport helper logic such that we
> +	 * lazily parse refspec capabilities _after_ we have learned about the
> +	 * remote's object format. Otherwise, we may end up misparsing refspecs
> +	 * depending on what object hash the remote uses.
> +	 */
> +	if (!the_repository->hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +
>  	packet_trace_identity("ls-remote");
>  
>  	if (argc > 1) {
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 42e77eb5a9..bc442ec221 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -402,4 +402,17 @@ test_expect_success 'v0 clients can handle multiple symrefs' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'helper with refspec capability fails gracefully' '
> +	mkdir test-bin &&
> +	write_script test-bin/git-remote-foo <<-EOF &&
> +	echo import
> +	echo refspec ${SQ}*:*${SQ}
> +	EOF
> +	(
> +		PATH="$PWD/test-bin:$PATH" &&
> +		export PATH &&
> +		test_must_fail nongit git ls-remote foo::bar
> +	)
> +'
> +
>  test_done
