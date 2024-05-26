Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73617C96
	for <git@vger.kernel.org>; Sun, 26 May 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716740458; cv=none; b=iS6PIIY6c/iIYdzrdfiw1h068RYjM5IMgYq122fBwQSkKCpzF7Wrs9D4uDd9jbd9HoD3ISJ8SlTfkbXN69O4PTtZgY/Oc6Qdici62GQXWPbIP8mjr5ROGu1jO912tqlvSgjDnS9K61pPulSoLUG14m5aTSUp8p1QjxPnC14mWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716740458; c=relaxed/simple;
	bh=JeTlQTZP9NLPCxShy/7rH9yBNUOjWMdhkB45TmIFTFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZdVa7ukHLH96TrK4Jbbp1GPP93qlUJoit6EC7A0q49W5S9OFQNNL31s7hRII/YnFwH8kSr8f6HRR19O0JoNKxCuR04U3sTrVHM9kq50V/cBicdMU+8JsQwuQkc3M7DtvPWaILi7Fj1w3aQKGhBq/JIpD2w/F032huKYfBBJ78TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTxVqnTE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTxVqnTE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DD7136025;
	Sun, 26 May 2024 12:20:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JeTlQTZP9NLPCxShy/7rH9yBNUOjWMdhkB45Tm
	IFTFk=; b=hTxVqnTEjRXZ94xcOkyFJrwhwBOqJ7VFVWPSbOnlvFrlkvGbcVlt1R
	oI6JtBho5IFEL578xd3qAH0ZG+88GwL5u5C7PgVebcW5PxVGtVn/hg5/a7AwToIi
	535UzDMkT3kbf96onOUK8ICUzcjl0Ir7s1n89raTbBhGaidYxVbss=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75E2C36024;
	Sun, 26 May 2024 12:20:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9172336023;
	Sun, 26 May 2024 12:20:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v6 3/3] run-command: show prepared command
In-Reply-To: <20240525234454.1489598-3-iwienand@redhat.com> (Ian Wienand's
	message of "Sun, 26 May 2024 09:44:35 +1000")
References: <20240525012207.1415196-1-iwienand@redhat.com>
	<20240525234454.1489598-1-iwienand@redhat.com>
	<20240525234454.1489598-3-iwienand@redhat.com>
Date: Sun, 26 May 2024 09:20:46 -0700
Message-ID: <xmqqh6ekh7dt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E904C42A-1B7B-11EF-808C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> This adds a trace point in start_command so we can see the full
> command invocation without having to resort to strace/code inspection.
> For example:
>
>  $ GIT_TRACE=1 git test foo
>  git.c:755               trace: exec: git-test foo
>  run-command.c:657       trace: run_command: git-test foo
>  run-command.c:657       trace: run_command: 'echo $*' foo
>  run-command.c:749       trace: start_command: /bin/sh -c 'echo $* "$@"' 'echo $*' foo
>
> Prior changes have made the documentation around the internals of the
> alias command execution clearer, but I have still found this detailed
> view of the aliased command being run helpful for debugging purposes.
>
> A test case is added.  This simply looks for the trace point output;
> the details change depending on platform -- the important thing is
> that we have a verbose log point, not so much the details of what
> happens on each platform.
>
> Signed-off-by: Ian Wienand <iwienand@redhat.com>
> ---
>  run-command.c    |  3 +++
>  t/t0014-alias.sh | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index 1b821042b4..31b20123d8 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -746,6 +746,8 @@ int start_command(struct child_process *cmd)
>  		goto end_of_spawn;
>  	}
>  
> +	trace_argv_printf(&argv.v[1], "trace: start_command:");
> +
>  	if (pipe(notify_pipe))
>  		notify_pipe[0] = notify_pipe[1] = -1;
>  
> @@ -913,6 +915,7 @@ int start_command(struct child_process *cmd)
>  	else if (cmd->use_shell)
>  		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
>  
> +	trace_argv_printf(cmd->args.v, "trace: start_command:");
>  	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
>  				  (char**) cmd->env.v,
>  				  cmd->dir, fhin, fhout, fherr);
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index 95568342be..634f6d78ef 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -44,4 +44,16 @@ test_expect_success 'run-command formats empty args properly' '
>      test_cmp expect actual
>  '
>  
> +test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
> +	cat >expect <<-EOF &&
> +	trace: start_command: SHELL -c ${SQ}echo \$* "\$@"${SQ} ${SQ}echo \$*${SQ} arg
> +	EOF
> +	git config alias.echo "!echo \$*" &&
> +	env GIT_TRACE=1 git echo arg 2>output &&
> +	# redact platform differences
> +	cat output &&

That "cat" is not about "redact"ing platform differences.  Leftover
debugging?  I'll remove it while queuing.

> +	sed -n -e "s/^\(trace: start_command:\) .* -c /\1 SHELL -c /p" output >actual &&
> +	test_cmp expect actual
> +'

Other than that, this step looks good to me.

Thanks.
