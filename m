Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 19:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D23D161074
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 19:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhJLTSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 15:18:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62636 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhJLTSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 15:18:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F16A314B249;
        Tue, 12 Oct 2021 15:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4xl7mnYjlgGBI1a9bDGjuKL/ha+VtubcvkH/GMCah/A=; b=BWnp
        53HneV2C6P+NTUVSOJ5PVYaDa7f2L+QkSIMYfsrz1YPyJlhpFEa8pjFKJgD/7h+4
        RzelsJOH1OGeUwuaDp1anPBOyz1ZgO/9uEc2D5w6w0N+dJYN5bSkIl2aXxld7db0
        AkJtpZeOpW2PwYe9ILG/PYr2SZCCf4YsC+Zl74Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9E6314B248;
        Tue, 12 Oct 2021 15:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BB9114B246;
        Tue, 12 Oct 2021 15:15:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
        <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
        <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
        <xmqq1r4vl65w.fsf@gitster.g>
        <47d4c810-0b56-45b0-944c-72c4d047f9b6@gmail.com>
        <xmqqlf30edvf.fsf@gitster.g>
        <cd62bf13-fdf1-af00-cc25-ef20abcfe152@gmail.com>
Date:   Tue, 12 Oct 2021 12:15:58 -0700
Message-ID: <xmqqv9222gwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D53F049C-2B90-11EC-80BF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I haven't really thought this through but could we teach
> unpack_trees() to call prime_cache_tree() rather than
> cache_tree_update() when that would be safe? For callers that use
> oneway_merge() merge it should always be safe I think and it might be
> possible to modify twoway_merge() to signal if the final tree in the
> index matches the second one passed to it. We could have a more
> general mechanism for the callback to signal if it is safe to prime
> the tree but I suspect the callers that are using custom callbacks are
> not updating the whole tree.

Before going in any direction, other than doing nothing ;-), we'd
need to see how expensive "prime" and "update" are.  

Having said that.

 * Your idea is quite beneficial for callers of unpack_trees() as
   they no longer have to decide whether they want to make a
   separate call to "prime".

 * Right now we do not seem to have a codepath that

   (1) populates the index entries from existing trees (not
   necessarily making the index in complete sync with the trees)
   without unpack_trees() and

   (2) does "prime" to fix the cache tree

   but such a codepath may want to do either "prime" or "update", or
   neither.  When it knows that it damages cache-tree so badly, and
   that it is often expected that the user would make many other
   changes to the index before writing it out as a tree, it may
   choose not to do either.

Thanks.
