Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC2C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 19:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiHETZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241513AbiHETZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 15:25:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42BC7C19F
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 12:24:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1199F1B6A4D;
        Fri,  5 Aug 2022 15:24:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VjtuX1GbZTZfq+I0R/OZEEfE/VR6BgGlHfqBFo
        hro4w=; b=A6YdgrZAHA5FVq0aPKOuBzztxhUGOJrCQLaBeL/17YMjOs3uCVlH7R
        cWdIPElM3l7lhVol6l/Jaa+5sPdx3LAHIYKe1FigqB4ViCmyuZ2Xp2aLMuy0eciL
        E/qmGTvP91GYmjHLchUXKSUsw4m9aY1UXOeVSwHnv4QnGiqXc+jsA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A25F1B6A4C;
        Fri,  5 Aug 2022 15:24:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 535AA1B6A4B;
        Fri,  5 Aug 2022 15:24:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        shaoxuan.yuan02@gmail.com, newren@gmail.com
Subject: Re: [PATCH 4/4] unpack-trees: handle missing sparse directories
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <016971a67112efe2d15fe7908e86c5d2631f8e66.1659645967.git.gitgitgadget@gmail.com>
        <xmqqa68j1tlr.fsf@gitster.g>
        <3825ef9a-4c71-21ed-6452-bbd322ca839c@github.com>
Date:   Fri, 05 Aug 2022 12:24:51 -0700
In-Reply-To: <3825ef9a-4c71-21ed-6452-bbd322ca839c@github.com> (Victoria Dye's
        message of "Fri, 5 Aug 2022 09:36:47 -0700")
Message-ID: <xmqqiln6ze64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47905882-14F4-11ED-AC3E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> If I'm reading this correctly, it's not quite what I meant - the situation
> this patch addresses is when _nothing_ in the tree rooted at 'A/' (files,
> subdirectories) exists in the index, but 'unpack_trees()' is merging tree(s)
> where 'A/' *does* exist.

OK, that is very different from my flawed readign.

> Maybe it would be clearer to describe it with a different perspective: "If
> 'unpack_callback()' is merging a new tree into a sparse index, merge the
> tree as a sparse directory rather than traversing its contents" or something
> like that? I'll try to come up with a better way of explaining this and
> update in V2. 

Yeah, that explains a typical scenario where you want to do this
kind of thing better.  Right now, do we just merge in the contents
of that whole tree whether the root of that new tree is or is not in
the sparse cone(s)?  Noticing that the new tree is outside the cones
of our interest and populating the index minimally, just enough to
be able to write the resulting index as a tree, does make sense.

> I wrote 'missing_dir_is_sparse()' in an attempt keep some complex logic out
> of the already-complicated 'unpack_single_entry()', but as part of that it
> relies on information already established by its caller.
>
> We know 'p' is a directory because 'missing_dir_is_sparse()' is called
> inside a 'mask == dirmask' condition.

Ahh, thanks---that is exactly what I missed, and led to my questions.

> 'mask' is a representation of which
> trees being traversed have an entry with the given name and 'dirmask' is a
> representation of which of those entries are directories, so the only way
> 'mask == dirmask' and 'p' is *not* a directory is if the currently-traversed
> entries in all of the trees do not exist. *That* won't happen because
> 'unpack_callback()' won't be invoked at all by 'traverse_trees()' if 'mask'
> is 0.
>
> Given that it requires jumping through multiple function invocations and
> callbacks to figure that out, I can add some assertions or 'return 0'
> conditions at the beginning of 'missing_dir_is_sparse()' to codify its
> assumptions. Even if the assertions are slightly redundant now, they'll make
> the code clearer and make the function safer for reuse.

Sounds good.

Thanks.
