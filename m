Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571DC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhKWXmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:42:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52897 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbhKWXmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:42:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 182EEFF348;
        Tue, 23 Nov 2021 18:39:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xoJXW6yErrRRdsJSi4znfY3xO053AP1JvtudH2
        UOrNY=; b=htveEMt0MOIcfbycFFhp1Qj2tVuLmjQDTytqmp9fEh1KTjd8xfiDgt
        N71Nn/+khoaC1rfZ9cwN2lcFrTKfZLnONis+C/Fj0T3eo/sf5GfslfLSRb/JscBy
        xeCXH9WP2Rk7XB8RXYDMpyfRP70OWM1g+BzE41Sq0pjXVwRCc7S04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 091B4FF347;
        Tue, 23 Nov 2021 18:39:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A0D4FF346;
        Tue, 23 Nov 2021 18:39:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 15:39:31 -0800
In-Reply-To: <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Mon, 22 Nov 2021
        22:42:35 +0000")
Message-ID: <xmqq8rxe787g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BD61F32-4CB6-11EC-89D3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Check whether git dir exists before adding any repo settings. If it
> does not exist, BUG with the message that one cannot add settings for an
> uninitialized repository. If it does exist, proceed with adding repo
> settings.
>
> Additionally, ensure the above BUG is not triggered when users pass the -h
> flag by adding a check for the repository to the checkout and pack-objects
> builtins.
>
> Finally, ensure the above BUG is not triggered for commit-graph by
> returning early if the git directory does not exist.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  builtin/checkout.c     | 6 ++++--
>  builtin/pack-objects.c | 9 ++++++---
>  commit-graph.c         | 5 ++++-
>  repo-settings.c        | 3 +++
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8c69dcdf72a..31632b07888 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1588,8 +1588,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  
>  	git_config(git_checkout_config, opts);
>  
> -	prepare_repo_settings(the_repository);
> -	the_repository->settings.command_requires_full_index = 0;
> +	if (startup_info->have_repository) {
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.command_requires_full_index = 0;
> +	}

I am kind-a surprised if the control reaches this deep if you are
not in a repository.  In git.c::commands[] list, all three primary
entry points that call checkout_main(), namely, cmd_checkout(),
cmd_restore(), and cmd_switch(), are marked with RUN_SETUP bit,
which makes us call setup_git_directory() even before we call the
cmd_X() function.  And setup_git_directory() dies with "not a git
repository (or any of the parent directories)" outside a repository.

So, how can startup_info->have_repository bit be false if the
control flow reaches here?  Or am I grossly misunderstanding what
you are trying to do?

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1a3dd445f83..45dc2258dc7 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3976,9 +3976,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	read_replace_refs = 0;

Ditto wrt RUN_SETUP.

> diff --git a/commit-graph.c b/commit-graph.c
> index 2706683acfe..265c010122e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -632,10 +632,13 @@ static int prepare_commit_graph(struct repository *r)
>  	struct object_directory *odb;
>  	/*
> +	 * Early return if there is no git dir or if the commit graph is
> +	 * disabled.
> +	 *
>  	 * This must come before the "already attempted?" check below, because
>  	 * we want to disable even an already-loaded graph file.
>  	 */
> -	if (r->commit_graph_disabled)
> +	if (!r->gitdir || r->commit_graph_disabled)
>  		return 0;

I haven't followed the control flow, but this one probably is a good
addition (in other words, unlike cmd_pack_objects(), I cannot convince
myself that r->gitdir will never be NULL here).

> diff --git a/repo-settings.c b/repo-settings.c
> index b93e91a212e..00ca5571a1a 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
>  	char *strval;
>  	int manyfiles;
>  
> +	if (!r->gitdir)
> +		BUG("Cannot add settings for uninitialized repository");
> +

This is a very good idea.  If I recall correctly, I think I reviewed
a bugfix patch that would have been simplified if we had this check
here.
