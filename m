Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF89C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 01:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiFHBmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387957AbiFHBhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 21:37:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD796459E63
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 15:10:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13F6D1268C7;
        Tue,  7 Jun 2022 18:09:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qSGltga8dJqZrUXVbubQl0WKi9mEcL9wUOaEqe
        fN4XM=; b=FIOwni2Fws8gcNAfEJWgI3JwmVC5apWSYj8jkHyea9D6c9HGumw0fk
        84otwbUEyE3E2XPVl97DkuGwiTeJm51pZihr0rkXeZonyBnZzeiUwhMmgtNn5K/F
        mRuTyAisW452C6aVABy6MTucHHEvEh1yRKLSI0RhM/oL0Hq1L+DM0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B3361268C6;
        Tue,  7 Jun 2022 18:09:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62D8A1268C3;
        Tue,  7 Jun 2022 18:09:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/7] branch: add branch_checked_out() helper
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654634569.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 15:09:53 -0700
In-Reply-To: <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654634569.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 07 Jun 2022
        20:42:44 +0000")
Message-ID: <xmqqr140t9am.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F48B918-E6AE-11EC-90FE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +int branch_checked_out(const char *refname, char **path)
> +{
> +	struct worktree **worktrees = get_worktrees();
> +	const struct worktree *wt = find_shared_symref(worktrees, "HEAD", refname);
> +	int result = wt && !wt->is_bare;
> +
> +	if (result && path)
> +		*path = xstrdup(wt->path);
> +
> +	free_worktrees(worktrees);
> +	return result;
> +}

Don't you plan to call this repeatedly from the for_each_deco
iteration?  I am wondering if it should take the result of
get_worktrees() and reuse the result of get_worktrees(), instead of
enumerating the list of worktrees and freeing for each of the
branches you need to inspect.

There also was another topic

https://lore.kernel.org/git/pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com/

that was triggered by find_shared_symref() being relatively
heavy-weight, which suggests a more involved refactoring.

I wonder if we rather want to rewrite find_shared_symref() *not* to
take the target parameter at all, and instead introduce a new
function that takes a worktree, and report the branch that is
checked out (or being operated on via rebase or bisect).  Then we
can

 - create a strset out of its result, i.e. set of branches that
   should not be touched;

 - iterate over refs that point into the history being rebased
   (using for_each_decoration()), and consult that strset to see if
   any of them is being rewritten.

With the API of find_shared_symref(), we'd need to iterate over all
worktrees for each decoration.  With such a restructuring, we can
iterate over all worktrees just once, and match the result with
decoration, so the problem becomes O(N)+O(M) and not O(N*M) for
number of worktrees N and number of decorations M.
