Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EB4C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF73A610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348467AbhIHTSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:18:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64700 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhIHTSK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:18:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32EED166F16;
        Wed,  8 Sep 2021 15:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/STERWpadJMUIbtYogrzRK2kTSyivPydFMkdRi
        y9A8Y=; b=dfSPtoQ1a2hqfI0QQm8lgFMrKFzshWe++OstV/roJ84p4c4ZOqQmvA
        KrnRvj9cUV4TLaTq9ioOMfpnf8iR3bFB2bn31y/B8WrqpEyBo0Ks0LkM3/TG8nrq
        F6N8UKj+epvXuyLYvibNKnrCp5rQchNLZKXkxCp0Ln1BWylf/1tzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C0A9166F14;
        Wed,  8 Sep 2021 15:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 531E9166F12;
        Wed,  8 Sep 2021 15:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] pull: release packs before fetching
References: <pull.1032.git.1631089771.gitgitgadget@gmail.com>
        <0e956ae7bba906277c77103ae329bce6d6da4cfe.1631089771.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 12:16:56 -0700
In-Reply-To: <0e956ae7bba906277c77103ae329bce6d6da4cfe.1631089771.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 08 Sep 2021
        08:29:31 +0000")
Message-ID: <xmqqh7eu3mjb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 564E4B60-10D9-11EC-8975-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, files cannot be removed nor renamed if there are still
> handles held by a process. To remedy that, we try to release all open
> handles to any `.pack` file before e.g. repacking (which would want to
> remove the original `.pack` file(s) after it is done).
>
> Since the `read_cache_unmerged()` and/or the `get_oid()` call in `git
> pull` can cause `.pack` files to be opened, we need to release the open
> handles before calling `git fetch`: the latter process might want to
> spawn an auto-gc, which in turn might want to repack the objects.
>
> This commit is similar in spirit to 5bdece0d705 (gc/repack: release
> packs when needed, 2018-12-15).
>
> This fixes https://github.com/git-for-windows/git/issues/3336.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/pull.c | 2 ++
>  1 file changed, 2 insertions(+)

After run_fetch() returns, we then go on to access objects from our
object store (that's natural---after all, we fetched because we
wanted to access the objects we have plus objects they have to offer
to us) and the object store is transparently reopened for us.  Which
may make a bit confusing API to newbies, but is an easy one to use,
once we get used to it.

A few general comments.

 * Right now, run_fetch() does not do anything that needs to access
   objects, but there is no reason to expect that will continue to
   be the case, and once we added an call to an innocuous helper
   function that happens to access objects, the close_object_store()
   call made by the caller before run_fetch() was called becomes
   moot.  The more we can delay the call to close_object_store(),
   the better.  And the absolute last point we can defer the call to
   close_object_store() is where immediately before run_fetch() calls
   run_command_v_opt() to spawn "git fetch".

 * Which makes me wonder if we may be better off having a bit in the
   flags word the run_command() API takes to make a call to
   close_object_store() for us.  run_fetch() that uses the
   run_command API can use that bit without having to worry about
   making a call to close_object_store() itself and when.

 * Hits from "git grep -A2 close_object_store()" shows a notable
   pattern.  Before run_auto_maintenance(), we often see a call to
   it.  It almost feels (but I didn't dig it deeper) that a call to
   run_auto_maintenance() that does not call close_object_store()
   before doing so is a bug (there is one in builtin/commit.c).

 * Which in turn makes me wonder if these many calls to close before
   run_auto_maintenance() should be moved to run_auto_maintenance()
   itself (which in turn can use the new flags bit in the
   run_command() API).

Sprinkling yet another call to close_object_store() as we discover
need for doing so like this patch does is certainly OK, but as we
add new hooks and higher-level commands, it will get messier and
messier.  It probably may make sense to go in and clean it up,
hopefully guided by the above observations, either before this
"fix", or soon after it graduates before we forget.

Will queue, but will not merge down to 'next' until I hear an Ack on
the commit-graph stuff.

Thanks.



> diff --git a/builtin/pull.c b/builtin/pull.c
> index 3e13f810843..d9f0156d969 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -26,6 +26,7 @@
>  #include "wt-status.h"
>  #include "commit-reach.h"
>  #include "sequencer.h"
> +#include "packfile.h"
>  
>  /**
>   * Parses the value of --rebase. If value is a false value, returns
> @@ -998,6 +999,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  			oidclr(&rebase_fork_point);
>  	}
>  
> +	close_object_store(the_repository->objects);
>  	if (run_fetch(repo, refspecs))
>  		return 1;
