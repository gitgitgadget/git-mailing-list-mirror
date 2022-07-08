Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F6C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 00:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiGHAjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 20:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGHAjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 20:39:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145001EAD1
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 17:39:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37FFD1B107E;
        Thu,  7 Jul 2022 20:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hfwgriQt8cb6/DJxtlwj87yXes86yIgI6PQybj
        WmZLM=; b=U/ULVjqD/8TK80bHnfrRm2pAa0dQdz7SmHdG/nBAuy2rt/PL/RA3sl
        ev9nOAIO3obxlno0TQXcpUDQ8fs9ksbYD9lElchLBGf4mbfixn3tnp410r5C09Co
        CHL4hiuERZzi26JWEcDHWbhEPo7DG0GnoLae9qL0bSbEXsmgKl00A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EAE31B107D;
        Thu,  7 Jul 2022 20:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D82C31B107C;
        Thu,  7 Jul 2022 20:39:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v7 2/5] Documentation: define protected configuration
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
        <58f25612aa385c3ac9f48f908ccc4d0d02d58b8c.1657234914.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 17:39:28 -0700
In-Reply-To: <58f25612aa385c3ac9f48f908ccc4d0d02d58b8c.1657234914.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Thu, 07 Jul 2022 23:01:51
        +0000")
Message-ID: <xmqqy1x4wi7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D7AAE94-FE56-11EC-9CFA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> For security reasons, there are config variables that are only trusted
> when they are specified in certain configuration scopes, which are
> sometimes referred to on-list as 'protected configuration' [1]. A future
> commit will introduce another such variable, so let's define our terms
> so that we can have consistent documentation and implementation.
>
> In our documentation, define 'protected configuration' as the system,
> global and command config scopes. As a shorthand, I will refer to
> variables that are only respected in protected configuration as
> 'protected configuration only', but this term is not used in the
> documentation.
>
> This definition of protected configuration is based on whether or not
> Git can reasonably protect the user by ignoring the configuration scope:
>
> - System, global and command line config are considered protected
>   because an attacker who has control over any of those can do plenty of
>   harm without Git, so we gain very little by ignoring those scopes.
> - On the other hand, local (and similarly, worktree) config are not
>   considered protected because it is relatively easy for an attacker to
>   control local config, e.g.:
>   - On some shared user environments, a non-admin attacker can create a
>     repository high up the directory hierarchy (e.g. C:\.git on
>     Windows), and a user may accidentally use it when their PS1
>     automatically invokes "git" commands.
>
>     `safe.directory` prevents attacks of this form by making sure that
>     the user intended to use the shared repository. It obviously
>     shouldn't be read from the repository, because that would end up
>     trusting the repository that Git was supposed to reject.
>   - "git upload-pack" is expected to run in repositories that may not be
>     controlled by the user. We cannot ignore all config in that
>     repository (because "git upload-pack" would fail), but we can limit
>     the risks by ignoring `uploadpack.packObjectsHook`.

This is only about the formatting, but have a blank line between
each bullet-point (e.g. before the line that talks about "On some
shared user enviornments, ..." and "git upload-pack").  A paragraph
break within a single bullet-point (i.e. the paragraph that talks
about `safe.directory` is a second paragraph of hte same bullet
point as the paragraph before it) looks like a stronger break than
separation between each bullet-point, which you wrote without any
blank lines in between.

> Only `uploadpack.packObjectsHook` is 'protected configuration only'. The
> following variables are intentionally excluded:
>
> - `safe.directory` should be 'protected configuration only', but it does
>   not technically fit the definition because it is not respected in the
>   "command" scope. A future commit will fix this.
>
> - `trace2.*` happens to read the same scopes as `safe.directory` because
>   they share an implementation. However, this is not for security
>   reasons; it is because we want to start tracing so early that
>   repository-level config and "-c" are not available [2].
>
>   This requirement is unique to `trace2.*`, so it does not makes sense
>   for protected configuration to be subject to the same constraints.

Very well reasoned.

