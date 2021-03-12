Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D868C433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5157C65027
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhCLKY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:24:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55117 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhCLKYr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 05:24:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6315412FCF7;
        Fri, 12 Mar 2021 05:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=lYsWDxi5050tvI2M7vQBhLVfc+w=; b=CUyV2O4j8DHE14nE24v2
        vADDVSU5w5qmnkuf+A1XDvEyp86FY3clMtIKp8UDIWT6drjIG0p8QHlO6eT70Hd8
        ue4z83WrokAqRfWhQDtWSMHp2Sw8qSFlKME13+hwCg49m9Fjq1tJtWf9Bel1Dss8
        rwOO56bvz8AyFFk5cNHaTBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=f1eYxOL/FopK+jIBhXtg0WtHIH7nDj8dT8uzZCCH95ihsC
        y0nBl3y/r8ZogxGdLEW9nqudIevs7rhRZvFJY/qyy+Wy6+AOjApTdWQxHJL81U1T
        5PGCTPYxYHwmqO+uC2RfLkGVHw1sNrUTfIIEzULuEPOFVaZ6JxgMQd3bV7TzA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F73212FCF6;
        Fri, 12 Mar 2021 05:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6918312FCF5;
        Fri, 12 Mar 2021 05:24:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 24/37] receive-pack: convert push-to-checkout hook to
 hook.h
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-25-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 02:24:41 -0800
Message-ID: <xmqqk0qc7jpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 294284E6-831D-11EB-A2B9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -1435,12 +1436,19 @@ static const char *push_to_checkout(unsigned char *hash,
>  				    struct strvec *env,
>  				    const char *work_tree)
>  {
> +	struct run_hooks_opt opt;
> +	run_hooks_opt_init_sync(&opt);
> +
>  	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
> -	if (run_hook_le(env->v, push_to_checkout_hook,
> -			hash_to_hex(hash), NULL))
> +	strvec_pushv(&opt.env, env->v);
> +	strvec_push(&opt.args, hash_to_hex(hash));
> +	if (run_hooks(push_to_checkout_hook, &opt)) {
> +		run_hooks_opt_clear(&opt);
>  		return "push-to-checkout hook declined";
> -	else
> +	} else {
> +		run_hooks_opt_clear(&opt);
>  		return NULL;
> +	}
>  }

OK, we opt_init(), futz with opt, call run_hooks() and opt_clear()
regardless of the outcome from run_hooks().  Narrow-sighted me
wonders if it makes the use of the API easier if run_hooks() did the
opt_clear() before it returns, but I haven't yet seen enough use at
this point to judge.

Thanks.
