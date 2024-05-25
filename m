Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B0B644
	for <git@vger.kernel.org>; Sat, 25 May 2024 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716615904; cv=none; b=MnWSRZ6F3SQp7rZqzr5O1JqpfftszhfcA7Myxax8fgYqGT/PVZbw9oiWbYpPmIIkKxJH/WU7w8XCQcaV9oZ0Uf0kFwNKu3y1cGS7iFvJVSp04wumT+7Lo4hMwjcmMTN/VC4KY63BjAMwcNi9g9SMD5oXHicVfLhpzRrgDIk67kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716615904; c=relaxed/simple;
	bh=FE6v4NkUoicTxqBpit7S38Zhrt41FY5Heh7Bjd5xpWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nyPJkbqWbY1+N1/yHhgPbQNeKV/rrCT83waThx9/KMAUREMW+yJRoAYfK7oqw+l3s62cW7D9uvT+pxfNOdMcYRnXnFlLbFEx/4aDWmjP0LC3Os5wcPp1mp+9rbMULTVIWtOQWiJSO52kWz7ZPFInbnkF1Ea2XfnzHlD9E4c9AN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtQuSiDC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtQuSiDC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 444C92EB14;
	Sat, 25 May 2024 01:44:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FE6v4NkUoicTxqBpit7S38Zhrt41FY5Heh7Bjd
	5xpWc=; b=QtQuSiDC8QfnxTluJEc6U+/9G3GfntsOvgxFModJIvhYxY/TBzanWX
	KyTtK1LvfmEzb3WxQUKX4QIyshKAZvpEkv2GO4Ti674D3X87wWMoHIItlhhfd6Px
	cZniztLw1ZaLWjDBGYaPvIccbKgOTfp6nlxiCubCkKEDK3DPFOnlM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CB412EB13;
	Sat, 25 May 2024 01:44:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E2CC2EB12;
	Sat, 25 May 2024 01:44:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] run-command: show prepared command
In-Reply-To: <20240525012207.1415196-3-iwienand@redhat.com> (Ian Wienand's
	message of "Sat, 25 May 2024 11:20:52 +1000")
References: <20240524073411.1355958-1-iwienand@redhat.com>
	<20240525012207.1415196-1-iwienand@redhat.com>
	<20240525012207.1415196-3-iwienand@redhat.com>
Date: Fri, 24 May 2024 22:44:52 -0700
Message-ID: <xmqqr0dqigx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E984D6B0-1A59-11EF-9125-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> diff --git a/run-command.c b/run-command.c
> index 1b821042b4..9892c4421c 100644
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

This side is OK ...

> @@ -913,6 +915,7 @@ int start_command(struct child_process *cmd)
>  	else if (cmd->use_shell)
>  		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
>  
> +	trace_argv_printf(&cmd->args.v[1], "trace: start_command:");
>  	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
>  				  (char**) cmd->env.v,
>  				  cmd->dir, fhin, fhout, fherr);

... but this side should pass "cmd->args.v" (i.e., the entire array,
without omitting the zeroth element) to be consistent with the other
side.  I made the same mistake in my "how about doing it this way"
draft, by the way.

It is because prepare_cmd() does this:

        static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
        {
                ...
                /*
                 * Add SHELL_PATH so in the event exec fails with ENOEXEC we can
                 * attempt to interpret the command with 'sh'.
                 */
                strvec_push(out, SHELL_PATH);

                if (cmd->git_cmd) {
                        prepare_git_cmd(out, cmd->args.v);
                } else if (cmd->use_shell) {
                        prepare_shell_cmd(out, cmd->args.v);
                ...

So, the other side (i.e. non Windows, that used the result from
prepare_cmd()) skips the argv.v[0] element (which is the SHELL_PATH
pushed by prepare_cmd()), but because a bare use of
prepare_shell_cmd() done on the Windows side does not have that
excess element at the beginning.
