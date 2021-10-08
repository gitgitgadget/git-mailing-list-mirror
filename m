Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83095C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6053860F02
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJHSdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:33:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63975 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhJHSdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 14:33:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B54F01437CF;
        Fri,  8 Oct 2021 14:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1DE4auQEQ9UiK+HfXVjGdBwMpFR+jwfeGdqck9
        YKE0A=; b=fHzxTzGiwOg8/PRvbzc23hBqfUgWhFEZm5f2kEaJrClOcijhn4kjGK
        o2JeREEE9fEl6n6pNh8u1QXsJP1aqvIFrV9f7/Ajx/+sE9sfg4prvhA2P/jkM+ie
        5kMZj2/bLPvf8XmGWkwmk0AIl/GmmAYFS1U3HF7WBA3yuD+rkq0KA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC0BF1437CE;
        Fri,  8 Oct 2021 14:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2BCE1437CD;
        Fri,  8 Oct 2021 14:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
        <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
        <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
Date:   Fri, 08 Oct 2021 11:31:39 -0700
In-Reply-To: <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com> (Victoria Dye's
        message of "Fri, 8 Oct 2021 13:14:13 -0400")
Message-ID: <xmqq1r4vl65w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB089F72-2865-11EC-9D2E-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Phillip Wood wrote:

>> I was looking at the callers to prime_cache_tree() this morning
>> and would like to suggest an alternative approach - just delete
>> prime_cache_tree() and all of its callers!

Do you mean the calls added by new patches without understanding
what they are doing, or all calls to it?

Every time you update a path in the index from the working tree
(e.g. "git add") and other sources, the directory in the cache-tree
that includes the path is invalidated, and the surviving subtrees of
cache-tree is used to speed up writing the index as a tree object,
doing "diff-index --cached" (hence "git status"), etc.  So over
time, the cache-tree "degrades" as you muck with the index entries.

When you write out the index as a tree, we by definition have to
know the object names of all the tree objects that correspond to
each directory in the index.  A fully valid cache-tree is saved when
it happens, so the above process can start over.

There are cases other than "git write-tree" that we can cheaply
learn the object names of all the tree objects that correspond to
each directory in the index.  When we read the index from an
existing tree object, we know which tree (and its subtrees) we
populated the index from, so we can salvage a degraded cache-tree.

"reset --hard" and "reset --mixed" may be good opportunities, so is
"checkout <branch>" that starts from a clean index.  And cache tree
priming is a mechanism to take advantage of such an opportunity.

The cache-tree does not have to be primed and all you lose is
performance, so priming can be removed mostly "without an issue", if
you are not paying attention to cache-tree degradation.  Priming
with incorrect data, however, would leave permanent damage by
writing a wrong tree via "git write-tree" (hence "git commit") and
showing a wrong diff via "git diff-index [--cached]" (hence "git
status" and probably "git add -- <pathspec>"), so not priming is
safer than priming incorrectly.

HTH.
