Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41C1C6B8
	for <git@vger.kernel.org>; Fri, 10 May 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366848; cv=none; b=RW2PcA0+N+O05mUJzSb1/7KGrD8diSruwRgqPNmfMTcAxzChGsHkibJdI41FGstNis1Rh2RxDOMovbU7kI0DFMIMKlfYVEQsiQxqUKpRN7ALnMhRlq2AC8l8lUk2k18rHJWRYtMaoQRi1Y4gYWD1yjHqqdK8tp6AvaVf5wguVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366848; c=relaxed/simple;
	bh=/FqES2mdf+FPO3PyXflQlG3ekbObdH8KD26WQBLeEVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eH5+POU26yjmEIygJOHEWA1CInW2ie1y7SlrGPIuKiLUtl9DbHM9ew3fSwAqV2pG1B08KF6f/TnelKEaBnAofs7dWJJlJLPnPApqLxou0SYEsPODcspGR0+4nWIW4dde0eQNwnkpJ0V5vLyVG6FrioCzcbEd/HqEmqTJrD63XkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rGgtIQ3j; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rGgtIQ3j"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6013135F37;
	Fri, 10 May 2024 14:47:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/FqES2mdf+FPO3PyXflQlG3ekbObdH8KD26WQB
	LeEVE=; b=rGgtIQ3jY7lumK8L0DudBQppJZQU4D38iPAKkZqXdNjBirYtxM0qRH
	qo1i+CduzjM5vlWSfQTwtpSmXAC0uITuz34o47tWlLUcNW4Xu9hMFRIrIrEIrqyP
	Fa4CaENEyuGIeHWSe2f6/4YpDJ+quxYunR/VpJDKLk745yziN1Ngs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 555E835F36;
	Fri, 10 May 2024 14:47:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CEBE135F35;
	Fri, 10 May 2024 14:47:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org,  git@jeffhostetler.com,  Emily Shaffer
 <nasamuffin@google.com>
Subject: Re: [PATCH] trace2: intercept all common signals
In-Reply-To: <20240510172243.3529851-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Fri, 10 May 2024 10:22:43 -0700")
References: <20240510172243.3529851-1-emilyshaffer@google.com>
Date: Fri, 10 May 2024 11:47:21 -0700
Message-ID: <xmqqv83l4i86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BCC9F022-0EFD-11EF-B394-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Emily Shaffer <emilyshaffer@google.com> writes:

> From: Emily Shaffer <nasamuffin@google.com>
>
> We already use trace2 to find out about unexpected pipe breakages, which
> is nice for detecting bugs or system problems, by adding a handler for
> SIGPIPE which simply writes a trace2 line. However, there are a handful
> of other common signals which we might want to snoop on:
>
>  - SIGINT, SIGTERM, or SIGQUIT, when a user manually cancels a command in
>    frustration or mistake (via Ctrl-C, Ctrl-D, or `kill`)
>  - SIGHUP, when the network closes unexpectedly (indicating there may be
>    a problem to solve)
>
> There are lots more signals which we might find useful later, but at
> least let's teach trace2 to report these egregious ones. Conveniently,
> they're also already covered by the `_common` variants in sigchain.[ch].
>
> Sigchain itself is already tested via helper/test-sigchain.c, and trace2
> is tested in a number of places - let's also add tests demonstrating
> that sigchain + trace2 works correctly.
>
> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> ---
>  t/helper/test-trace2.c   | 17 +++++++++++++++++
>  t/t0210-trace2-normal.sh | 22 ++++++++++++++++++++++
>  trace2.c                 |  2 +-
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> index 1adac29a57..8970956ea8 100644
> --- a/t/helper/test-trace2.c
> +++ b/t/helper/test-trace2.c
> @@ -231,6 +231,22 @@ static int ut_010bug_BUG(int argc UNUSED, const char **argv UNUSED)
>  	BUG("a %s message", "BUG");
>  }
>  
> +static int ut_011signal(int argc, const char **argv)
> +{
> +	const char *usage_error = "expect <bool common>";
> +	int common = 0;
> +
> +	if (argc != 1 || get_i(&common, argv[0]))
> +		die("%s", usage_error);
> +
> +	/*
> +	 * There is no strong reason SIGSEGV is ignored by trace2 - it's just
> +	 * not included by sigchain_push_common().
> +	 */
> +	raise(common ? SIGINT : SIGSEGV);
> +	return 0; /*unreachable*/
> +}
> +
>  /*
>   * Single-threaded timer test.  Create several intervals using the
>   * TEST1 timer.  The test script can verify that an aggregate Trace2
> @@ -482,6 +498,7 @@ static struct unit_test ut_table[] = {
>  	{ ut_008bug,      "008bug",    "" },
>  	{ ut_009bug_BUG,  "009bug_BUG","" },
>  	{ ut_010bug_BUG,  "010bug_BUG","" },
> +	{ ut_011signal,   "011signal","" },
>  
>  	{ ut_100timer,    "100timer",  "<count> <ms_delay>" },
>  	{ ut_101timer,    "101timer",  "<count> <ms_delay> <threads>" },
> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index c312657a12..c34ccc518c 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -244,6 +244,28 @@ test_expect_success 'bug messages followed by BUG() are written to trace2' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'trace2 reports common signals' '
> +	test_when_finished "rm trace.normal actual" &&
> +
> +	# signals are fatal, so expect this to fail
> +	! env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 011signal 1 &&

Is it deliberate that this does not use test_must_fail or is it an
oversight?  The same comment applies to all other uses of "! env".

We often see the use of "env" in conjunction with a test that is
expected to fail because

    test_must_fail VAR=VAL cmd

simply does not work.  If you are not using test_expect_fail, then

    ! VAR=VAL cmd

should be sufficient, but it would mean that you will be happy even
if the way "cmd" dies is not in a controlled way (e.g. due to
receiving a signal).

Ah, perhaps that is it?  Is "test-tool trace2 011signal 1" raise a
signal to kill itself and after showing the event in the trace
stream it is expected to die the narual death of receiving the same
signal by re-raising it?

If that is what is happening here, not using test_must_fail is
absolutely the right thing to do, but then I doubt you need "env"
there.  Also, if we know what signal is raised, then we should also
know the exit status from this (i.e. signal number plus 128 or
something) that we want to validate?  I dunno.


> diff --git a/trace2.c b/trace2.c
> index f894532d05..3692010f5d 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -231,7 +231,7 @@ void trace2_initialize_fl(const char *file, int line)
>  	tr2_sid_get();
>  
>  	atexit(tr2main_atexit_handler);
> -	sigchain_push(SIGPIPE, tr2main_signal_handler);
> +	sigchain_push_common(tr2main_signal_handler);
>  	tr2tls_init();
>  
>  	/*
