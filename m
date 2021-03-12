Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8803C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A049F65002
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhCLKWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:22:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65045 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhCLKWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 05:22:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB5F812FCE7;
        Fri, 12 Mar 2021 05:22:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=TWdDpEhqsAkopSOXKICsxxpgXS8=; b=cAo1JoEoxMS8HO4LaOoP
        ttoMrhoC7ShUQscoz/s7yuZxWnvVbGNyh9YVrbRLiQovTyXLZ0s8LDCscF6xVgz0
        dC2wKxiq37vmT/d0kNjQ9FT/WgE2Fb6znxGxJod82bPWGU7DneTD3aFoPK9Vzch6
        Uz5PCl9XBcUgxu3rKhZC6iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=StbnQ8IkM1g6Qo29kUu8KE+YZ5MpEPEu8l8h24ItuBY20f
        7Nj0j1JPRk0JZIq5WrMRqm3CRUi9Cd0ECP1PpH+XNHKwoXJ8epxKXIIqIIYOzdlK
        9jB/+ZSNlIl6zSPdSY3dkf6g4zm0eCUhWB/mcUzskXmWkMWPKxltcz6oTXm3o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4E6B12FCE6;
        Fri, 12 Mar 2021 05:22:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17AD712FCE4;
        Fri, 12 Mar 2021 05:22:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 23/37] read-cache: convert post-index-change hook to
 use config
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-24-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 02:22:08 -0800
Message-ID: <xmqqr1kk8yen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDDDC106-831C-11EB-AC3E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -3070,6 +3071,8 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>  				 unsigned flags)
>  {
>  	int ret;
> +	struct run_hooks_opt hook_opt;
> +	run_hooks_opt_init_async(&hook_opt);
>  

Nit. blank line between the last of decls and the first stmt (many
identical nits exist everywhere in this series).

>  	/*
>  	 * TODO trace2: replace "the_repository" with the actual repo instance
> @@ -3088,9 +3091,13 @@ static int do_write_locked_index(s
>  	else
>  		ret = close_lock_file_gently(lock);
>  
> -	run_hook_le(NULL, "post-index-change",
> -			istate->updated_workdir ? "1" : "0",
> -			istate->updated_skipworktree ? "1" : "0", NULL);
> +	strvec_pushl(&hook_opt.args,
> +		     istate->updated_workdir ? "1" : "0",
> +		     istate->updated_skipworktree ? "1" : "0",
> +		     NULL);
> +	run_hooks("post-index-change", &hook_opt);
> +	run_hooks_opt_clear(&hook_opt);

There is one early return before the precontext of this hunk that
bypasses this opt_clear() call.  It is before any member of hook_opt
structure that was opt_init()'ed gets touched, so with the current
code, there is no leak, but it probably is laying a landmine for the
future, where opt_init() may allocate some resource to its member,
with the expectation that all users of the API would call
opt_clear() to release.  Or the caller of the API (like this one) may
start mucking with the opt structure before the existing early return,
at which point the current assumption that it is safe to return from
that point without opt_clear() would be broken.

I saw that there are other early returns in the series that are safe
right now but may become unsafe when the API implementation gets
extended that way.  If it does not involve too much code churning,
we may want to restructure the code to make these early returns into
"goto"s that jump to a single exit point, so that we can always
match opt_init() with opt_clear(), like the structure of the
existing code allowed cmd_rebase() to use the hooks API cleanly in
[v8 22/37].

Thanks.
