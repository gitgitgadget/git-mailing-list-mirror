Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF151C6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 16:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIWQ6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiIWQ63 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 12:58:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E261438CD
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 09:58:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED25D1B7BA6;
        Fri, 23 Sep 2022 12:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3nLAG9PXfXwGiAR9iTwZGecBqM2WBbo/mChXHG
        LEgMg=; b=Bs6FsZ3QdITHvfjPt/9g9xmGRsixToNci2ypWb1iYkTQXR9TpQuuvW
        ECN1XG7J8J/0pNKP/qF7FFBN7mdxrTxAp+FqqzdLpsuOKOHTOJ2TZwBhHZ5dvWyw
        a/s3eQKciS2Wgx1P4xgbmKn0/S7Pdd3Flh+OM6Cen1fSdKp6ZF9zw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E51F31B7BA4;
        Fri, 23 Sep 2022 12:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4EAEA1B7BA3;
        Fri, 23 Sep 2022 12:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com,
        newren@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v6 1/1] builtin/grep.c: integrate with sparse index
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
        <20220923041842.27817-2-shaoxuan.yuan02@gmail.com>
Date:   Fri, 23 Sep 2022 09:58:23 -0700
In-Reply-To: <20220923041842.27817-2-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Thu, 22 Sep 2022 21:18:42 -0700")
Message-ID: <xmqqy1uauixc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFBC8D04-3B60-11ED-B1E5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> +test_expect_success 'grep with and --cached' '

"with and --cached"?  "with and without --cached" is probably a good
thing to test but you may need to add tests for "with" case, too?

> +	init_repos &&
> +
> +	test_all_match git grep --cached a &&
> +	test_all_match git grep --cached a -- "folder1/*"
> +'

The above is very relevant for the purpose of ...

> -	/* TODO: audit for interaction with sparse-index. */
> -	ensure_full_index(repo->index);

... auditing.  Run the command with a pathspec that specify areas
inside and outside the sparse cone(s) and ensure the result match
those in a non-sparse-index, with test_all_match().

As to the lack of the tests WITHOUT "--cached", I suspect that it is
omitted because there is no checked-out copies to grep in, but I
suspect that it is papering over a buggy design.  If we do not by
default limit the operation only to paths inside sparse cone(s),
shouldn't we be treating the paths outside as if they exist with the
same contents as they are in the index (and unmodified)?  If we take
the position that "working tree files on paths outside the sparse
cone(s) do not exist", "git diff" would need to say that they are
all removed to be consistent, which probably is not what we want to
see.

> +test_expect_success 'grep is not expanded' '
> +	init_repos &&
> +
> +	ensure_not_expanded grep a &&
> +	ensure_not_expanded grep a -- deep/* &&
> +
> +	# All files within the folder1/* pathspec are sparse,
> +	# so this command does not find any matches
> +	ensure_not_expanded ! grep a -- folder1/* &&
> +
> +	# test out-of-cone pathspec with or without wildcard
> +	ensure_not_expanded grep --cached a -- "folder1/a" &&
> +	ensure_not_expanded grep --cached a -- "folder1/*" &&
> +
> +	# test in-cone pathspec with or without wildcard
> +	ensure_not_expanded grep --cached a -- "deep/a" &&
> +	ensure_not_expanded grep --cached a -- "deep/*"
> +'

It is not wrong per-se, but I am not sure how relevant these tests
are.

The implementation of ensure_not_expanded very intimately knows
that a call to ensure_full_index() is the one we are trying to avoid
(and we do not even detect if another way to fully expand the index
is invented and used), and we know we are removing the only call to
the function in "git grep".

Thanks.
