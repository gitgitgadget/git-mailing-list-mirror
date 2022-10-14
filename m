Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A12DC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJNSWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJNSWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 14:22:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB43164BE8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 11:22:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AA52145D21;
        Fri, 14 Oct 2022 14:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aBvPuCHRxNp2
        ct2bH4TeWQ6FW2gIDqaEroUBpKQJOas=; b=UDAUbXmZka5P1KnrgoJuir5drADA
        IRMF/5cpXsZIh4Mn/UWTvI9Ce40wXGeQCQYL8QEuqFFMqctb6SIfwD543ICGI+nB
        LuZDT86m4L9/7jnut/5ftqyfxf8srRioFoNvGeRkmbIwpLD4K4WJED8K3qYHYDCx
        78CE04/ub7FlaqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1042C145D20;
        Fri, 14 Oct 2022 14:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A618145D1F;
        Fri, 14 Oct 2022 14:22:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] run-command.c: refactor run_command_*_tr2() to
 internal helpers
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <patch-01.10-c1f701af6e8-20221014T153426Z-avarab@gmail.com>
Date:   Fri, 14 Oct 2022 11:22:18 -0700
In-Reply-To: <patch-01.10-c1f701af6e8-20221014T153426Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 14 Oct
 2022 17:40:13
        +0200")
Message-ID: <xmqq4jw69sf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 239D1660-4BED-11ED-AE43-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +static void run_command_set_opts(struct child_process *cmd, int opt)
> +{
> +	cmd->no_stdin =3D opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
> +	cmd->git_cmd =3D opt & RUN_GIT_CMD ? 1 : 0;
> +	cmd->stdout_to_stderr =3D opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
> +	cmd->silent_exec_failure =3D opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
> +	cmd->use_shell =3D opt & RUN_USING_SHELL ? 1 : 0;
> +	cmd->clean_on_exit =3D opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
> +	cmd->wait_after_clean =3D opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
> +	cmd->close_object_store =3D opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
> +}

This, combined with the change in the caller that loses the
corresponding lines, does make sense.  But


> @@ -1019,24 +1031,26 @@ int run_command_v_opt_cd_env(const char **argv,=
 int opt, const char *dir, const
>  	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
>  }
> =20
> +static int run_command_v_opt_cd_env_tr2_1(struct child_process *cmd, i=
nt opt,
> +					  const char *dir,
> +					  const char *const *env,
> +					  const char *tr2_class)
> +{
> +	run_command_set_opts(cmd, opt);
> +	cmd->dir =3D dir;
> +	if (env)
> +		strvec_pushv(&cmd->env, (const char **)env);
> +	cmd->trace2_child_class =3D tr2_class;
> +	return run_command(cmd);
> +}

This?

The original caller took argv and copied it into cmd.args itself and
the updated caller still does so because this new helper doesn't do
so for it, but it no longer does the copying of env because this
helper does it.

Unless we will add several more callers of this helper in later
steps, this sounds a bit too specialized to the way the first single
caller used to do it.

But let's keep reading to see if it is worth adding it.

>  int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const cha=
r *dir,
>  				 const char *const *env, const char *tr2_class)
>  {
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
>  	strvec_pushv(&cmd.args, argv);
> -	cmd.no_stdin =3D opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
> -	cmd.git_cmd =3D opt & RUN_GIT_CMD ? 1 : 0;
> -	cmd.stdout_to_stderr =3D opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
> -	cmd.silent_exec_failure =3D opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
> -	cmd.use_shell =3D opt & RUN_USING_SHELL ? 1 : 0;
> -	cmd.clean_on_exit =3D opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
> -	cmd.wait_after_clean =3D opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
> -	cmd.close_object_store =3D opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
> -	cmd.dir =3D dir;
> -	if (env)
> -		strvec_pushv(&cmd.env, (const char **)env);
> -	cmd.trace2_child_class =3D tr2_class;
> -	return run_command(&cmd);
> +	return run_command_v_opt_cd_env_tr2_1(&cmd, opt, dir, env, tr2_class)=
;
>  }
> =20
>  #ifndef NO_PTHREADS
