Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D8C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbiFCShG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347551AbiFCSgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:36:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B848F2623
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:31:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 299E2186985;
        Fri,  3 Jun 2022 14:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VuPIvT3RXg9lCpZzGwFVcNEfWsnVblJSOFM4Ti
        P+VkI=; b=SSRTaMCZXajmWj2xbLEGl/PVWGOOMPsm0OCv7uww0v67aeEeocrHuq
        8JODmfj4zqszlLiMqwVtUL/y1z8zu2DaZ//EmsTOG3mWhWKYp311SLOgjLJf3EDn
        SS7R9LZXRYz0mVr78YAcq2fQUCIUUMNw4UkfMnMCHPf2faHRNA2cc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21D51186983;
        Fri,  3 Jun 2022 14:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF82C186980;
        Fri,  3 Jun 2022 14:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] branch: add branch_checked_out() helper
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654263472.git.gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 11:31:35 -0700
In-Reply-To: <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654263472.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 03 Jun 2022
        13:37:50 +0000")
Message-ID: <xmqqzgitfvjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66D6BE76-E36B-11EC-AB79-C85A9F429DF0-77302942!pb-smtp20.pobox.com
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
get_worktrees() and reuse the result of get_worktrees().

There also was another topic that was triggered by
find_shared_symref() being relatively heavy-weight, which suggests a
more involved refactoring.

I wonder if we rather want to rewrite find_shared_symref() *not* to
take the target parameter at all, and instead introduce a new
function that iterates over worktrees and report the branch that is
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
