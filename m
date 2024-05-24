Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48A41755
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578199; cv=none; b=Soa817Q0p3RC+z+FNinEKBHzLnmeM1In96W0jTsutN/1c+DqTGQCjZ7LZluYx5/Qs801Y93rMl4e0SXtrRwDSzp7lClFFQ5QLsHSIr7nrR6HQubE92pmoYUB0QlgQnwniLzbnKWUJHFgWuetfbkppnwpLFMjw1rrUPPEUdBOkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578199; c=relaxed/simple;
	bh=L0G023TTU/JTitLG1aSTXNljT2/AFDTQ/ROxyz3W6fY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6eSY1CW2gvTOJugLcadPsghEcYL6PXYZHLhvNwyJFZLY7ceKx4YHSRb5+Sp5TsWlr4WmTaeeXos7DSajyFTds7Ps8snLp4H+NzYTHsQz7Id/cAr021edG9aXdwoR+vfu+LJA80iyMDAtLE3KEmNGnfywda7B3kwzxd51OP+Vx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g/ucf+xX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g/ucf+xX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9783F1BA47;
	Fri, 24 May 2024 15:16:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L0G023TTU/JTitLG1aSTXNljT2/AFDTQ/ROxyz
	3W6fY=; b=g/ucf+xXqehZg3hqPDdTogjcNrCCwBtQkN46U+390thtDq/XTDjIpL
	NrDUXVTgP7rtM4wmW4HtOXvLxDOpKpUAotJzNeqBlAiaf/yXjHFkzHAcDCOvWYDq
	0Hkt7fo4Ua1TOL9A5Fh+ttb+HIZUwNp+h0Ls9YGXtvo12K/ufnTws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 900961BA46;
	Fri, 24 May 2024 15:16:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 062481BA45;
	Fri, 24 May 2024 15:16:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] run-command: show prepared command
In-Reply-To: <20240524073411.1355958-3-iwienand@redhat.com> (Ian Wienand's
	message of "Fri, 24 May 2024 17:32:44 +1000")
References: <20240523043806.1223032-1-iwienand@redhat.com>
	<20240524073411.1355958-1-iwienand@redhat.com>
	<20240524073411.1355958-3-iwienand@redhat.com>
Date: Fri, 24 May 2024 12:16:34 -0700
Message-ID: <xmqqzfsfja0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 238C8554-1A02-11EF-8269-25B3960A682E-77302942!pb-smtp2.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> +test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
> +	git config alias.echo "!echo \$*" &&
> +	env GIT_TRACE=1 git echo argument 2>output &&
> +	test_grep "^trace: prepare_cmd:.*" output
> +'

If you run

    $ cd t && sh ./t0014-alias.sh -d && cat trash*.t0014-alias/output

you'll see two "prepare_cmd" logged, because you added one to
prepare_shell_cmd() and another to prepare_cmd().  If you were
tracing something that uses prepare_git_cmd() on Windows, you would
not see any trace output, on the other hand, I would suspect (I do
not do Windows so this is from code inspection only).

Perhaps squashing something like this is sufficient?

 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/run-command.c w/run-command.c
index 13e35fb76e..7eb68a541d 100644
--- c/run-command.c
+++ w/run-command.c
@@ -296,7 +296,6 @@ static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 	}
 
 	strvec_pushv(out, argv);
-	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
 	return out->v;
 }
 
@@ -436,7 +435,6 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 		}
 	}
 
-	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
 	return 0;
 }
 
@@ -747,6 +745,7 @@ int start_command(struct child_process *cmd)
 			error_errno("cannot run %s", cmd->args.v[0]);
 		goto end_of_spawn;
 	}
+	trace_argv_printf(&argv.v[1], "trace: prepare_cmd:");
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
@@ -914,6 +913,7 @@ int start_command(struct child_process *cmd)
 		cmd->args.v = prepare_git_cmd(&nargv, sargv);
 	else if (cmd->use_shell)
 		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
+	trace_argv_printf(&cmd->args.v[1], "trace: prepare_cmd:");
 
 	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
 				  (char**) cmd->env.v,



