Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006CC433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 00:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355273AbiE1A2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355270AbiE1A2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 20:28:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDDA11C1A
        for <git@vger.kernel.org>; Fri, 27 May 2022 17:28:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCA9A1889B1;
        Fri, 27 May 2022 20:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FELzd8pUXzXnBtreI9tAYCg/MlbGTwPdmlpvya
        zTl7E=; b=IEbDLCchzUbvtctKWKpUtZBJAB2I23uvyyTuTgZPI0YMe5S016+9cw
        LUCmtLcTv1DV+RadoW9QUgf3NKc4Q4T2aEXa5MD6DFFi5EV1+rXOR4Z8LRgq74jS
        0eweuLPhN0dEFW5iJUTtXcI1WMdklNiihMNWS+Lhuy5Hf0sBGnz4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B477B1889B0;
        Fri, 27 May 2022 20:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 566D41889AF;
        Fri, 27 May 2022 20:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 2/5] config: read protected config with
 `git_protected_config()`
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <7499a2809615d42eaf3649e1c33f38d099d27c1a.1653685761.git.gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 17:28:14 -0700
In-Reply-To: <7499a2809615d42eaf3649e1c33f38d099d27c1a.1653685761.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Fri, 27 May 2022 21:09:18
        +0000")
Message-ID: <xmqqbkvi1owx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 107D1E7E-DE1D-11EC-8D59-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Protected config is read using `read_very_early_config()`, which has
> several downsides:
>
> - Every call to `read_very_early_config()` parses global and
>   system-level config files anew, but this can be optimized by just
>   parsing them once [1].
> - Protected variables should respect "-c" because we can reasonably
>   assume that it comes from the user. But, `read_very_early_config()`
>   can't use "-c" because it is called so early that it does not have
>   access to command line arguments.

Now we are talking about protected "variable".  Is that a synonym
for "config", or are there some distinctions between them?

> - Protected config is stored in `the_repository` so that we don't need
>   to statically allocate it. But this might be confusing since protected
>   config ignores repository config by definition.

Yes, it indeed is.  Is it because we were over-eager when we
introduced the "struct repository *repo" parameter to many functions
and the configuration system wants you to have some repository, even
when you know you are not reading from any repository?  

I am wondering if it is a cleaner solution *not* to hang the
protected config as a configset in the_repository, but keep the
configset as a separate global variable, perhaps static to config.c
and is meant to be only accessed via git_protected_config() and the
like.

> @@ -295,6 +295,11 @@ void repo_clear(struct repository *repo)
>  		FREE_AND_NULL(repo->remote_state);
>  	}
>  
> +	if (repo->protected_config) {
> +		git_configset_clear(repo->protected_config);
> +		FREE_AND_NULL(repo->protected_config);
> +	}
> +

This becomes necessary only because each repository instance has
protected_config, even though we need only one instance, no matter
how many repositories we are accessing in this single invocation of
Git, no?

How should "git config -l" interact with "protected config" and
"protected variables", by the way?  Should a user be able to tell
which ones are coming from protected scope?  Should we gain, next to
--global, --system, etc., --protected option to list only the
protected config/variable?

This is another thing that I find iffy on terminology.  Should a
random variable, like user.name, be a "protected config", if it is
found in $HOME/.gitconfig?  If it comes from there, surely we can
trust its value, but unlike things like safe.directory, there is no
code that wants to enforce that we pay attention only to user.name
that came from trusted scopes.  Should such a variable be called
"protected variable"?

Thanks.
