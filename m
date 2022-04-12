Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467C0C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 06:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbiDLGfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 02:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbiDLGfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 02:35:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF74735857
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 23:33:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4479711B66E;
        Tue, 12 Apr 2022 02:33:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HPs/Xuqc3AN/OB7Y1K1TlMP3QYGzMe0Q072dq3
        JRB3I=; b=aUJc5jo1OBh5kCp7R0zqRrpmWFikADrrBty5Y+0UN6A0U8YHsbeceN
        ISlhWRSKg9tI5g4NU+NM5crFOIovCJrdT7HLZJ8mhLwg1apBNu+ah4mrefT2eMr/
        w2jmKV8kDxa++TtDTjZbdvtpu06ftQ64eNI/AJ5R+rEbVlxf9VJ88=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB59811B66D;
        Tue, 12 Apr 2022 02:33:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D15511B66B;
        Tue, 12 Apr 2022 02:32:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/4] object-name: diagnose trees in index properly
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <99c09ccc2406e4f54c620bd7fb2d1205386e23a6.1649349442.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Apr 2022 23:32:58 -0700
In-Reply-To: <99c09ccc2406e4f54c620bd7fb2d1205386e23a6.1649349442.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 07 Apr 2022
        16:37:22 +0000")
Message-ID: <xmqqlewaerqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65C8F6E4-BA2A-11EC-BB9E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When running 'git show :<path>' where '<path>' is a directory, then
> there is a subtle difference between a full checkout and a sparse
> checkout. The error message from diagnose_invalid_index_path() reports
> whether the path is on disk or not. The full checkout will have the
> directory on disk, but the path will not be in the index. The sparse
> checokut could have the directory not exist, specifically when that
> directory is outside of the sparse-checkout cone.
>
> In the case of a sparse index, we have yet another state: the path can
> be a sparse directory in the index. In this case, the error message from
> diagnose_invalid_index_path() would erroneously say "path '<path>' is in
> the index, but not at stage 0", which is false.
>
> Add special casing around sparse directory entries so we get to the
> correct error message. This requires two checks in order to get parity
> with the normal sparse-checkout case.

That all makes sense, but let me ask a more basic (and possibly
stupid) question and a half. 

 - When running 'git cmd :<path>' where '<path>' is a directory,
   even before the "sparse-index" or "sparse-checkout" world, I
   sometimes wished that ":<path>" resolved to the object name of
   the tree recorded in the cache-tree, if we have one.  If we are
   living in the "sparse-index" world, and the paths underneath
   '<path>' are not in the index (because we are not interested in
   them), we should be able answer "git rev-parse :<path>" with the
   name of the tree object.  It is a "new feature" regardless of
   sparse-index, but I wonder if it is sensible to add more code to
   engrave in stone that we would not support it and keep treating
   the index as if it is a flat list of paths to blobs (and commits,
   for submodules)?

 - When running 'git cmd :<path>' where '<path>' is *not* a
   directory but is not in the index because of "sparse-index"
   (i.e. a leading directory of '<path>' is represented as a tree in
   the index), should ":<path>" index expand the "tree" index entry
   on-demand, so that <path> has its own entry in the index, as if
   no "sparse-index" is in effect?  The tests I saw in the series
   were mostly asserted with test_sparse_match, not test_all_match,
   so I couldn't tell what the expectations are.

 - More generally, if <leading> path is represented as a
   "sparse-dir" entry, should ":<leading>/<lower>" cause the index
   entry for <leading> path to be expanded on-demand?  I am guessing
   that the answer is yes, as we wouldn't be able to even tell if
   such a path <leading>/<lower> would exist in the index if the
   index were converted to full upfront.

Thanks.
