Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B950C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 21:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiERVQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243187AbiERVQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 17:16:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22880666A6
        for <git@vger.kernel.org>; Wed, 18 May 2022 14:16:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D521A1123AF;
        Wed, 18 May 2022 17:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xv/qlzhEUV6Yr2sx+KQCgzl/KAvQfg+GGS5RVZ
        rFjs4=; b=TQYIuqxFYql7XZKBvv0xyz89sQZBAA4qeTsnP3P2aG+xG4u1FQyvQb
        Awh2/VOynCGa079xHqjt1PPjncna7n4sUhIhZbem/ySrAfd8ykr42StVzZrXZ1n9
        UvUSaqxN5CgtZhOaH0OdXhjmKLAsXpk7375tcpy7hX74/7yk6okqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAF551123AE;
        Wed, 18 May 2022 17:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C82F1123AD;
        Wed, 18 May 2022 17:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] builtin/receive-pack.c: remove redundant 'if'
References: <d22f2ca975778d594449857d64be8cd8c0d4a327.1652905549.git.me@ttaylorr.com>
Date:   Wed, 18 May 2022 14:16:11 -0700
In-Reply-To: <d22f2ca975778d594449857d64be8cd8c0d4a327.1652905549.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 18 May 2022 16:26:02 -0400")
Message-ID: <xmqqo7zutuck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF058010-D6EF-11EC-8296-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The conversion in c7c4bdeccf was mostly plug-and-play, with the snag
> that some instances of strvec_pushv() became guarded with a NULL check
> to ensure that the second argument was non-NULL.

Thanks.  I am not sure about the reference to plug-and-play but most
of the changes in the commit were mechanical conversion akin to

	@@
	struct child_process C;
	expression V;
	@@
	-C.env = V;
	+strvec_pushv(&C.env_array, V);

but a few have rewritten them to

	@@
	-C.env = V;
	+if (V) strvec_pushv(&C.env_array, V);

And this hunk is one of them.  If we know V is never NULL, the check
becomes redundant, and we can tell tmp_objdir is not NULL at this
point in the control flow.  If C.env (or C.env_array) weren't empty
by the time the control reaches at this point, however, this rewrite
changes behaviour X-<.

Another one in connected.c looks like this:

        diff --git a/connected.c b/connected.c
        index 35bd4a2638..ed3025e7a2 100644
        --- a/connected.c
        +++ b/connected.c
        @@ -109,7 +109,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
                                     _("Checking connectivity"));

                rev_list.git_cmd = 1;
        -	rev_list.env = opt->env;
        +	if (opt->env)
        +		strvec_pushv(&rev_list.env_array, opt->env);
                rev_list.in = -1;
                rev_list.no_stdout = 1;
                if (opt->err_fd)

If opt->env can be NULL, the original code would have just cleared
existing rev_list.env but new code instead keeps whatever is in
rev_list.env, which technically speaking changes the behaviour but
we are saved by the fact that rev_list.env hasn't been touched at
this point in the control flow since it was initialized, which makes
it a correct conversion.

There are few others in editor.c::launch_specified_editor(),
run-command.c::run_command_v_opt_cd_env_tr2() and
run-command.c::run_hook_ve(), but the story is identical in these
places.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9aabffa1af..f673e0e76e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2214,8 +2214,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  			close(err_fd);
>  		return "unable to create temporary object directory";
>  	}
> -	if (tmp_objdir)
> -		strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
> +	strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
>  
>  	/*
>  	 * Normally we just pass the tmp_objdir environment to the child

So, in short, looks good, well spotted, and will apply.

Thanks.
