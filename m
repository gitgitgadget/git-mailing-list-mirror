Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BE10A0A
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478168; cv=none; b=NfQjE5t2saKrlUN/hJcJKHGW+v1eN4r0LI7k+rxxG5oh6MGkr6LDrF99LivwjPCGvGw/9XchhZUB0hf4dHa4KBWhEzYby0XcdFNU9YWL+TAy93qJp4AJWJnGqEyLc9qKD9uP5CdHmk3aVakeJGUGO+5U3ukYXh+36LbgUzrbmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478168; c=relaxed/simple;
	bh=njadhwueF9lmY9YSsX1oFqT8jmPvpDX1ga8spSYnbC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIPV4WbDdKj0t5CRZiDzkOHcCZhg/Zd9RK8v6T4UQXXTJAKhgwTKK+DY4XSRfXfgtqVKwiw/CEX4MrvdwzhWcAfp9iaIvGVaNMEs7L7Q7Bhdc7xbrOyil/iBv3wjIxNao7yk2jULdq0tTIq2ANQzaTdliE/oeIEmZfQEb4JMaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pHh7oacF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pHh7oacF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D31C1CED5;
	Thu, 23 May 2024 11:29:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=njadhwueF9lmY9YSsX1oFqT8jmPvpDX1ga8spS
	YnbC4=; b=pHh7oacF7AvfihU42euPFNSpsmNlO3YR8wlurjFnD1+uBX6fWZ8/Qi
	8wDmPo9bzSgIRCmpxkPNTlfINu5l+ZRpUPjpDLabnv2AcsE4jI6cCcTngJcEXLUR
	M4C2dZBdCO/ccRNMJDpSjZzvX4NKoHTH7EmiYy38VIUqMrzSG6V5k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 457691CED4;
	Thu, 23 May 2024 11:29:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA29C1CED3;
	Thu, 23 May 2024 11:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
In-Reply-To: <20240523043806.1223032-3-iwienand@redhat.com> (Ian Wienand's
	message of "Thu, 23 May 2024 14:37:56 +1000")
References: <20240523042143.1220862-1-iwienand@redhat.com>
	<20240523043806.1223032-1-iwienand@redhat.com>
	<20240523043806.1223032-3-iwienand@redhat.com>
Date: Thu, 23 May 2024 08:29:21 -0700
Message-ID: <xmqqpltcwnqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B2748AA-1919-11EF-B93C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> This adds a trace point in prepare_cmd, so we can see the actual
> command being run without having to resort to strace/code inspection.
>
> e.g. "test = !echo" when run under GIT_TRACE will show:
>
>  $ GIT_TRACE=1 git test hello
>  10:58:56.877234 git.c:755               trace: exec: git-test hello
>  10:58:56.877382 run-command.c:657       trace: run_command: git-test hello
>  10:58:56.878655 run-command.c:657       trace: run_command: echo hello
>  10:58:56.878747 run-command.c:437       trace: prepare_cmd: /usr/bin/echo hello
>  hello

Nice.

> A "split" alias, e.g. test = "!echo $*" will show the shell wrapping
> and appending of "$@".
>
>  $ GIT_TRACE=1 git test hello
>  11:00:45.959420 git.c:755               trace: exec: git-test hello
>  11:00:45.959737 run-command.c:657       trace: run_command: git-test hello
>  11:00:45.961424 run-command.c:657       trace: run_command: 'echo $*' hello
>  11:00:45.961528 run-command.c:437       trace: prepare_cmd: /bin/sh -c 'echo $* "$@"' 'echo $*' hello
>  hello hello

Nice again.

But ...

> For example, this can be very helpful when an alias is giving you an
> unexpected syntax error that is very difficult figure out from only
> the run_command trace point, e.g.
>
> test = "!for i in 1 2 3; do echo $i; done"
>
> will fail if there is an argument given, we can see why from the
> output.

... if the reader truly understands "the alias gives the command and
its leading arguments, to which the invocation can supply even more
arguments", the reader wouldn't be writing such a command line to
begin with, no?

So I find the example a bit suboptimal.  Hopefully additional
explanation in patch 2/3 stressed on that point well enough with
much more stress than it talks about the implementation detail of
using "sh -c" and "$@", so that readers who read it would not even
dream of writing such an alias in the first place.

> diff --git a/run-command.c b/run-command.c
> index 1b821042b4..36b2b2f194 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -435,6 +435,7 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
>  		}
>  	}
>  
> +	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
>  	return 0;
>  }

Nice addition that is obviously correct.

> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index 95568342be..75c8763a6c 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -44,4 +44,11 @@ test_expect_success 'run-command formats empty args properly' '
>      test_cmp expect actual
>  '
>  
> +test_expect_success 'tracing a shell alias with arguments shows full prepared command' '
> +	git config alias.echo "!echo \$*" &&
> +	env GIT_TRACE=1 git echo argument 2>output &&
> +	cp output /tmp/output &&
> +	test_grep "^trace: prepare_cmd: /bin/sh -c '\''echo \$\* \"\$@\"" output
> +'

This is probably too specific search string, I suspect, given that
runcommand.c:prepare_shell_cmd() uses SHELL_PATH or "sh" so if your
SHELL_PATH is anything but /bin/sh (or if you are unlucky enough to
be running this test on Windows), the pattern would not match.
You'd want to loosen it a bit, perhaps with "/bin/sh" -> ".*", as
the rest of the output are expected to stay constant.

By the way, common to this step and also to the previous step,
you'd want to use

	echo "$@"

instead of

	echo $*

to encourage better variable reference hygiene.  It makes difference
when any arguments given to "e" has whitespace, i.e.

    $ sh -c 'echo $*'   - a 'b    c'
    a b c
    $ sh -c 'echo "$@"' - a 'b    c'
    a b    c

Thanks.
