Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF1BC43331
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C82565002
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhCLKWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:22:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58912 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhCLKWe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 05:22:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 165D412FCEA;
        Fri, 12 Mar 2021 05:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xprJyRmyIZ3atsXCxjAIwlaPJS0=; b=ICjMTGK1TEsFxO5ZG1/U
        I2yp7ZDpCjCUxKuzTCOTc54QPw5rPQzCEDQaOzistaNO3OZ2PWB63dyo1HB6y3+e
        MXSmsvfwnTz1xEtmyJ/pGn08QEpB7ebyMhdseiLuTjM+3mfajklRqjPaCRtSKnbA
        RIvOp0HLpe9miID2E8BEOHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=LtpJYTUlYksFvhrxsjA7uXP0FnadFhjDRstcYcYgCHU4pT
        Ut/NLXccZbkXkL74tF4NOCF4AeOX9/PfvtB7xbJpmov0UArvRC8Y90uz9VGZK6Ti
        iH4OAadufDUR/FUSx8xL4dB8LNxhbwislwhf3PTXUX56jPYSdvPWyMFuqPj3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F4A612FCE9;
        Fri, 12 Mar 2021 05:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5750E12FCE8;
        Fri, 12 Mar 2021 05:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 10/37] hook: support passing stdin to hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-11-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 02:22:29 -0800
Message-ID: <xmqqczw48ye2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA89802A-831C-11EB-BB51-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/hook.c b/hook.c
> index 118931f273..f906e8c61c 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -240,6 +240,7 @@ void run_hooks_opt_init(struct run_hooks_opt *o)
>  {
>  	strvec_init(&o->env);
>  	strvec_init(&o->args);
> +	o->path_to_stdin = NULL;
>  	o->run_hookdir = configured_hookdir_opt();
>  }

The new member is initialized to NULL, and presumably the user of
the API would point an existing string with it.  Since there is no
free() in opt_clear() introduced by this patch, the member is
obviously a pointer to a borrowed piece of memory.

> diff --git a/hook.h b/hook.h
> index 0df785add5..2314ec5962 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -52,6 +52,9 @@ struct run_hooks_opt
>  	 * to be overridden if the user can override it at the command line.
>  	 */
>  	enum hookdir_opt run_hookdir;
> +
> +	/* Path to file which should be piped to stdin for each hook */
> +	const char *path_to_stdin;
>  };

And we mark the fact that hook subsystem does not own it by making
it "const char *".  Looks quite consistent.  Good.
