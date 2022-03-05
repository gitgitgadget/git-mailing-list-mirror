Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F692C4332F
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiCEAOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiCEAO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:14:29 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9B233E4D
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:13:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9903D17A8D0;
        Fri,  4 Mar 2022 19:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VwWEK4+b4nE7AIc1tdkQO2rWs2P+5pRMwwBmDI
        thCOo=; b=nr3opNguY2Z2RI7LDLWH6JW43u9lCGLm/gjQO8xqCZbe9LkVsHriDm
        G6Cng6HjDNdx3OpF2aEpm11QBhdMUvfbXvW+aWqSllpjHY94cilyZM1CFVWTow3j
        zAZvTg0wVLHBqs0MLpjPHLqpIxYptOmwWSvTbqxc1fpyYpDzwcRhs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90DD817A8CF;
        Fri,  4 Mar 2022 19:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1875317A89F;
        Fri,  4 Mar 2022 19:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 09/10] fetch: fetch unpopulated, changed submodules
References: <20220224100842.95827-1-chooglen@google.com>
        <20220304005757.70107-1-chooglen@google.com>
        <20220304005757.70107-10-chooglen@google.com>
        <xmqqsfry4f3z.fsf@gitster.g>
        <kl6l7d99494p.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 04 Mar 2022 16:13:36 -0800
In-Reply-To: <kl6l7d99494p.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 04 Mar 2022 14:59:18 -0800")
Message-ID: <xmqqk0d9w91r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A4F3644-9C19-11EC-9624-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> And now that you've pointed this out, I realize that we could do away
> with (.super_oid, .path) altogether if we had a variant of
> repo_submodule_init() that takes the submodule name instead of (path,
> treeish_name). (We have a similar submodule_from_name(), but that only
> reads the submodule config, not a struct repository.) I would prefer not
> to introduce such a function so late into the review cycle, but I could
> clean this up later.

I am puzzled.  What do you exactly mean by "late into the review
cycle"?

> - The changed_submodules string_list is basically a map that tells us,
>   for a given submodule _name_, which commits we need to fetch and where
>   repo_submodule_init() can read the submodule name from.
> - We only use cs_data as a string_list_item.util, and the
>   string_list_item.string is the submodule name itself.
> - .new_commits tells us which commits to fetch.
> - .super_oid and .path tells repo_submodule_init() how to get the name
>   of the submodule.
>
> So we don't need to make this a 3-tuple.

OK.  We need to learn in which local repository houses the submodule
we discover in cs_data resides.  It may or may not have a checkout
in the current checkout of the superorject commit.  And just one
<.super_oid, .path> tuple should be sufficient to tell us that,
because the mapping from submodule name to path may change as "git
mv" moves it around, but the mapping from submodule name to where
the submodule repository is stored in the .git/ directory of the
superproject should not change.  Am I following you so far
correctly?

I am wondering if we need even one <.super_oid, .path> tuple.
Looking at the implementation of repo_submodule_init(), I have a
feeling that a version of "initialize named submodule in a given
tree-ish in the superproject" would be rather trivial.  We already
have submodule name, so submodule_name_to_gitdir() would be all we
need, no?  After all, we are only interested in fetching objects to
fill missing commits (and possibly update the remote tracking
branches) and do not care about touching its working tree.  And once
we learn that .git/modules/<name>/ directory, we can fetch the
necessary commits into it, right?

Or am I oversimplifying the problem?
