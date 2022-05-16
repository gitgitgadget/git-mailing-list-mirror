Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC8C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 16:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiEPQBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245527AbiEPQBG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 12:01:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9B10B
        for <git@vger.kernel.org>; Mon, 16 May 2022 09:01:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EDAA18E81A;
        Mon, 16 May 2022 12:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nF+TWD5qP0Bze6Rj8wGdfDAbkWfyNHM2E+ThFi
        RbrHA=; b=mtlsLwncGJ20V2p/yrImBHZV6i3rXu9jP2b43j1xtCtj5sVOKBME5+
        83d7bGcTtwNTzDNwh1FwAye3wWNcSr0KrgrE8mBKYB5GrSh+IgBi6YhILkw8oCc3
        Y49Vv6xta5FNNHMeq63TI/jpI+y+guJz/mKm2ol2j1z56wBuoDJvo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5863618E819;
        Mon, 16 May 2022 12:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E601B18E813;
        Mon, 16 May 2022 12:00:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v2] fetch: limit shared symref check only for local
 branches
References: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
        <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 09:00:57 -0700
In-Reply-To: <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com>
        (Orgad Shaneh via GitGitGadget's message of "Mon, 16 May 2022 08:41:41
        +0000")
Message-ID: <xmqqv8u54gcm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 606E23AA-D531-11EC-BC82-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> This check was introduced in 8ee5d73137f (Fix fetch/pull when run without
> --update-head-ok, 2008-10-13) in order to protect against replacing the ref
> of the active branch by mistake, for example by running git fetch origin
> master:master.
>
> It was later extended in 8bc1f39f411 (fetch: protect branches checked out
> in all worktrees, 2021-12-01) to scan all worktrees.
>
> This operation is very expensive (takes about 30s in my repository) when
> there are many tags or branches, and it is executed on every fetch, even if
> no local heads are updated at all.
>
> Limit it to protect only refs/heads/* to improve fetch performance.

The point of the check is to prevent the index+working tree in the
worktrees to go out of sync with HEAD, and HEAD by definition can
point only into refs/heads/*, this change should be OK.

It is surprising find_shared_symref() is so expensive, though.  If
you have a dozen worktrees linked to the current repository, there
are at most a dozen HEAD that point at various refs in refs/heads/
namespace.  Even if you need to check a thousand ref_map elements,
it should cost almost nothing if you build a hashmap to find matches
with these dozen HEADs upfront, no?

Another thing that is surprising is that you say this loop is
expensive when there are many tags or branches.  Do you mean it is
expensive when there are many tags and branches that are updated, or
it is expensive to merely have thousands of dormant tags and
branches?  If the latter, I wonder if it is sensible to limit the
check only to the refs that are going to be updated.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e3791f09ed5..eeee5ac8f15 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1440,6 +1440,7 @@ static void check_not_current_branch(struct ref *ref_map,
>  	const struct worktree *wt;
>  	for (; ref_map; ref_map = ref_map->next)
>  		if (ref_map->peer_ref &&
> +		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
>  		    (wt = find_shared_symref(worktrees, "HEAD",
>  					     ref_map->peer_ref->name)) &&
>  		    !wt->is_bare)
>
> base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
