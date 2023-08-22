Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E941EE49AB
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 19:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjHVTaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjHVTae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 15:30:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681CCDD
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 12:30:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95B3B1C369D;
        Tue, 22 Aug 2023 15:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lIVfO5LLm6TthfENGfQaAGFwhQV+/KxmkuHgg5
        7U50g=; b=MY5QSWtO4GVd42lVSwErTuPxGcqbpjC2eZ9JeKcYar9jkcIhvnHoaH
        0KC94C1PDe7K1Gma2hKqPuCLeEdK8PnBLPGPgxBp9kX6Ibq9Ot/dIDvxdwELDTnN
        HVE3442ziLf/y5sgvtYvRL5//vRZmPTIxu8ibxXAEE/kLM8aYmmnc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C3491C369C;
        Tue, 22 Aug 2023 15:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBDA61C369B;
        Tue, 22 Aug 2023 15:30:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] setup: add discover_git_directory_reason()
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
        <787af0f9744e2f18c9ab680886650278a9d2f8d0.1692725056.git.gitgitgadget@gmail.com>
Date:   Tue, 22 Aug 2023 12:30:26 -0700
In-Reply-To: <787af0f9744e2f18c9ab680886650278a9d2f8d0.1692725056.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 22 Aug 2023
        17:24:14 +0000")
Message-ID: <xmqqttsqlvsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59692182-4122-11EE-AB4C-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> There are many reasons why discovering a Git directory may fail. In
> particular, 8959555cee7 (setup_git_directory(): add an owner check for
> the top-level directory, 2022-03-02) added ownership checks as a
> security precaution.
>
> Callers attempting to set up a Git directory may want to inform the user
> about the reason for the failure. For that, expose the enum
> discovery_result from within setup.c and into cache.h where
> discover_git_directory() is defined.
>
> I initially wanted to change the return type of discover_git_directory()
> to be this enum, but several callers rely upon the "zero means success".
> The two problems with this are:
>
> 1. The zero value of the enum is actually GIT_DIR_NONE, so nonpositive
>    results are errors.
>
> 2. There are multiple successful states; positive results are
>    successful.
>
> It is worth noting that GIT_DIR_NONE is not returned, so we remove this
> option from the enum. We must be careful to keep the successful reasons
> as positive values, so they are given explicit positive values.
> Further, a use in scalar.c was previously impossible, so it is removed.
>
> Instead of updating all callers immediately, add a new method,
> discover_git_directory_reason(), and convert discover_git_directory() to
> be a thin shim on top of it.
>
> One thing that is important to note is that discover_git_directory()
> previously returned -1 on error, so let's continue that into the future.
> There is only one caller (in scalar.c) that depends on that signedness
> instead of a non-zero check, so clean that up, too.
>
> Because there are extra checks that discover_git_directory_reason() does
> after setup_git_directory_gently_1(), there are other modes that can be
> returned for failure states. Add these modes to the enum, but be sure to
> explicitly add them as BUG() states in the switch of
> setup_git_directory_gently().
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  scalar.c |  3 ---
>  setup.c  | 34 ++++++++++++----------------------
>  setup.h  | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 44 insertions(+), 28 deletions(-)
>
> diff --git a/scalar.c b/scalar.c
> index 938bb73f3ce..02a38e845e1 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -686,9 +686,6 @@ static int cmd_reconfigure(int argc, const char **argv)
>  				warning(_("removing stale scalar.repo '%s'"),
>  					dir);
>  			strbuf_release(&buf);
> -		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
> -			warning_errno(_("git repository gone in '%s'"), dir);
> -			res = -1;
>  		} else {
>  			git_config_clear();
>  

In the original before this series, and also after applying [PATCH
3/3], the reconfiguration is a three-step process:

 - what if we cannot go to that directory?
 - what if the directory is not a usable repository?
 - now we are in a usable repository, let's reconfigure.

and this seems to lose the second step tentatively?  It is
resurrected in a more enhanced form in [PATCH 3/3] so it may not be
a huge deal, but it looks like it is not intended lossage.

