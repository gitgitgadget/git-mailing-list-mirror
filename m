Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D21CABF
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333798; cv=none; b=c06+uvgams9ILGekBtoK1GqOYDLPhRinv0PfUV0KLqSURGJZGkd1wDvUqauaYoTw9uW7aezbHzICQQdK9kTeO5dnjt0ztnxWgZLtw0EQYs6IQsH5sEvWd7hJ6OAqCjUzDvxBT/2frUPtaNQWeYpXEvHNsH1lKIc7w3DbVo+hO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333798; c=relaxed/simple;
	bh=sGdjybqk53Tq6sPEKnBN06F3Snho9GTN/gbBWdJl9L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nxbsdNLWBSqpfH2yeDP8xzbwk/MnhBEq9qLVWM0F5S8Mw1nziv17rdlyEZVj511qK2nvFM+khFP3JYAZzm8B77jQiPoVNm6aRSuKRsAzLRhNwpuBIqPC0s4NC24TaErjnAxJHhccqJ5H3Ntu4T//pvIHA+5lG+wU22UnY31H4tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x8STSgBl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x8STSgBl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BBFEF18F75;
	Sat, 14 Sep 2024 13:09:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sGdjybqk53Tq6sPEKnBN06F3Snho9GTN/gbBWd
	Jl9L4=; b=x8STSgBlY0674Bo7SE4fsFEgJ+R+NmJXf2raWg3EuwuwKLKMqVqNnp
	8PInv3eGdsq9px0Bd7Uh4cZO1ITwTv3r2G7fAj7aOgWKVtQsbDu82lg2rwXHid0Z
	0Elskf6TFAoZeDq+4ViSIXMYFAUQEoFTemWF97Qskb5qwWNQc3drs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B407018F74;
	Sat, 14 Sep 2024 13:09:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 235B618F73;
	Sat, 14 Sep 2024 13:09:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t5512.40 sometimes dies by SIGPIPE
In-Reply-To: <20240914064130.GA1284567@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Sep 2024 02:41:30 -0400")
References: <xmqqmskbwe1a.fsf@gitster.g>
	<20240914064130.GA1284567@coredump.intra.peff.net>
Date: Sat, 14 Sep 2024 10:09:52 -0700
Message-ID: <xmqqa5gatb4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 292763C2-72BC-11EF-9773-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I really wish there was a way to ignore SIGPIPE per-descriptor (or even
> tell which descriptor triggered it in a signal handler), but I don't
> think there is.
> ...
> Another option is to selectively disable/re-enable SIGPIPE for
> individual write() calls. That's not thread-safe, and I imagine may have
> some performance penalty in practice due to the extra syscalls. But it
> might make sense to do it selectively.

All true.

> +static int write_constant_gently(int fd, const char *str)
>  {
>  	if (debug)
>  		fprintf(stderr, "Debug: Remote helper: -> %s", str);
>  	if (write_in_full(fd, str, strlen(str)) < 0)
> +		return -1;
> +	return 0;
> +}
> +
> +static void write_constant(int fd, const char *str)
> +{
> +	if (write_constant_gently(fd, str) < 0)
>  		die_errno(_("full write to remote helper failed"));
>  }

The _gently variant is meant to be (optionally) used while SIGPIPE
is ignored, and this one is meant to be always used while SIGPIPE is
not.  If the reading end closed the fd, the underlying write would
fail and trigger SIGPIPE.  This die_errno() will not trigger in such
a case.  But for other kind of errors, we die just like we used to
in the original code.  OK.

> @@ -168,13 +175,16 @@ static struct child_process *get_helper(struct transport *transport)
>  		die_errno(_("can't dup helper output fd"));
>  	data->out = xfdopen(duped, "r");
>  
> -	write_constant(helper->in, "capabilities\n");
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	if (write_constant_gently(helper->in, "capabilities\n") < 0)
> +		die("remote helper '%s' aborted session", data->name);
> +	sigchain_pop(SIGPIPE);

And the only caller of the _gently variant with SIGPIPE ignored
supplies its own error message.  It is easier for the end-user to
identify than a generic "Broken pipe".  Nice.

We identified a helper that closes the connection even before it
hears from us, so we say "aborted".

>  	while (1) {
>  		const char *capname, *arg;
>  		int mandatory = 0;
>  		if (recvline(data, &buf))
> -			exit(128);
> +			die("remote helper '%s' aborted session", data->name);

Here, we found a helper that failed to talk back to us (they may
have actually read what we wrote initially, or what we wrote may be
hanging in the pipe buffer without being read).  It depends on the
timing between which of the above two points we detect such a
helper, so using the same error message does make sense.

> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 20f43f7b7d..d21877150e 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -344,4 +344,15 @@ test_expect_success 'fetch tag' '
>  	compare_refs local v1.0 server v1.0
>  '
>  
> +test_expect_success 'totally broken helper reports failure message' '
> +	write_script git-remote-broken <<-\EOF &&
> +	read cap_cmd
> +	exit 1
> +	EOF
> +	test_must_fail \
> +		env PATH="$PWD:$PATH" \
> +		git clone broken://example.com/foo.git 2>stderr &&
> +	grep aborted stderr
> +'
> +
>  test_done

The code change covers both a helper that disconnects before we
write the first greeting and a helper that disconnects while we are
still expecting it to talk to us.  The test explicitly covers the
latter by reading our greeting (in other words, it does not die
before we do our initial "write"---no risk of the SIGPIPE) and then
stopping without writing anything.  As we are waiting to read from
the helper, we will see an error in recvline().

Nice.

If the test loses the initial "read the greeting", then some of the
time our greeting would be hanging in the pipe, we wait in read, and
notice that the helper died, to trigger the "recvline() failed" code
path.  But other times, the helper would die even before we write
the greeting, so we'd see an error from write_constant_gently() and
die with an identical message.  Such a test won't suffer from any
flakyness but makes me feel somewhat dirty, so the above is good
;-).

Thanks.
