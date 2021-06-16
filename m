Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA423C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A959C61369
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFPEmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:42:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63106 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFPEmq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 00:42:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10D6A12FBCB;
        Wed, 16 Jun 2021 00:40:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wGxlnMa6yIFiuC0U83pgUVXTzY7+q0QFGXjjwE
        7cS1o=; b=hWaxHkaC195SYPID+wuBofq6U1pZyxqoyyuxKCE00HP2/5kEfMSPIn
        niS5OYsLg9YGPESU1b6wyu7I3dLKGeLQC0h0RTJzyLH8xC3oMPXcNGINVrWgALfT
        lv0m888u6zXN1xo9TqxveIHTzWWV6920Ob7tLxwdKvxsJQgtXxXKA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1EF812FBCA;
        Wed, 16 Jun 2021 00:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60AE612FBC9;
        Wed, 16 Jun 2021 00:40:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
References: <20210616004508.87186-1-emilyshaffer@google.com>
        <20210616004508.87186-3-emilyshaffer@google.com>
Date:   Wed, 16 Jun 2021 13:40:36 +0900
In-Reply-To: <20210616004508.87186-3-emilyshaffer@google.com> (Emily Shaffer's
        message of "Tue, 15 Jun 2021 17:45:06 -0700")
Message-ID: <xmqqsg1iqv5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF8412CE-CE5C-11EB-9FA4-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach submodules a reference to their superproject's gitdir. This allows
> us to A) know that we're running from a submodule, and B) have a
> shortcut to the superproject's vitals, for example, configs.
>
> By using a relative path instead of an absolute path, we can move the
> superproject directory around on the filesystem without breaking the
> submodule's cache.
>
> Since this cached value is only introduced during new submodule creation
> via `git submodule add`, though, there is more work to do to allow the
> cache to be created at other times.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/config/submodule.txt | 12 +++++++++
>  builtin/submodule--helper.c        |  4 +++
>  t/t7400-submodule-basic.sh         | 40 ++++++++++++++++--------------
>  3 files changed, 38 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index d7a63c8c12..7c459cc19e 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -90,3 +90,15 @@ submodule.alternateErrorStrategy::
>  	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
>  	or `info`, and if there is an error with the computed alternate, the
>  	clone proceeds as if no alternate was specified.
> +
> +submodule.superprojectGitDir::
> +	The relative path from the submodule's worktree  to the superproject's
> +	gitdir. This config should only be present in projects which are
> +	submodules, but is not guaranteed to be present in every submodule. It
> +	is set automatically during submodule creation.
> ++
> +	In situations where more than one superproject references the same
> +	submodule worktree, the value of this config and the behavior of
> +	operations which use it are undefined. To reference a single project
> +	from multiple superprojects, it is better to create a worktree of the
> +	submodule for each superproject.

You'd need to dedent the second paragraph that follows a lone '+'
sign to typeset this correctly.

The new paragraph suggests separate worktrees for the same submodule
repository, but for that to work correctly,

 - "git clone [--recurse-submodules]" that clones the second
   superproject that shares the same submodule with a superproject
   that we already locally has to support a way for users to tell
   where to grab that existing submodule from and arrange a new
   worktree, instead of creating another instance of the submodule
   repository by cloning it afresh.

 - The "submodule.superprojectGitDir" needs to be set to
   per-worktree half of the repo-local configuration file.

Because I usually do not pay much attention to the submodule part of
the toolset, I may well be mistaken, but I suspect that the former
does not exist yet.  If I recall correctly, the latter was a NEEDSWORK
item in the previous round of this patchset?

As I said, I think it is OK for now to stop at declaring that you
cannot simply do it without hinting something that may not fully
work.

Thanks.
