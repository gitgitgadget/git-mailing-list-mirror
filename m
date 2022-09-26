Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EE4C6FA90
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiIZRxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiIZRxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:53:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DB8E0D1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:28:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07532142DE7;
        Mon, 26 Sep 2022 13:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/dcN8GFrzk+ZMmPKX6SS8JL7eoXYNa1jzJq/i9
        gUTJY=; b=DIfeIRhXLOrXWj64a728I/eqI5ex3SxLDiUy5NFfWS+ohUHEOFrOBh
        lcFseQgdVEBqgqK6gXm4WQtsJzCuo+KXARbehoa1nLRnGE4ADzlms3R3TNezqPT1
        aytIxTuO14ixWAkGTUshJGACpyWY22QBF+TpJfHzGWO0e5oHwowyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F21D4142DE6;
        Mon, 26 Sep 2022 13:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6256D142DE5;
        Mon, 26 Sep 2022 13:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com,
        newren@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v6 1/1] builtin/grep.c: integrate with sparse index
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
        <20220923041842.27817-2-shaoxuan.yuan02@gmail.com>
        <xmqqy1uauixc.fsf@gitster.g>
Date:   Mon, 26 Sep 2022 10:28:13 -0700
In-Reply-To: <xmqqy1uauixc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        23 Sep 2022 09:58:23 -0700")
Message-ID: <xmqq5yhaqc42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99F2CC0A-3DC0-11ED-BF88-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
>
>> +test_expect_success 'grep with and --cached' '
>
> "with and --cached"?  "with and without --cached" is probably a good
> thing to test but you may need to add tests for "with" case, too?

I meant "for WITHOUT case, too", but ...

>> +	init_repos &&
>> +
>> +	test_all_match git grep --cached a &&
>> +	test_all_match git grep --cached a -- "folder1/*"
>> +'
>
> The above is very relevant for the purpose of ...
>
>> -	/* TODO: audit for interaction with sparse-index. */
>> -	ensure_full_index(repo->index);
>
> ... auditing.  Run the command with a pathspec that specify areas
> inside and outside the sparse cone(s) and ensure the result match
> those in a non-sparse-index, with test_all_match().
>
> As to the lack of the tests WITHOUT "--cached", I suspect that it is
> omitted because there is no checked-out copies to grep in, but I
> suspect that it is papering over a buggy design.

... in light of the recent "sparse-checkout.txt: ... directions"
document patch by Elijah

  http://lore.kernel.org/git/pull.1367.git.1664064588846.gitgitgadget@gmail.com/

I think I was quite mistaken.  The guiding principle should not be
to pretend that the paths stubbed out with sparse checkout mechanism
are unchanged from HEAD.  It should be to pretend that they do not
exist and they never existed.

So it is perfectly expected that the output with and without
"--cached" are different.  The former (without an option to ignore
paths outside the sparse checkout even for in-repository data)
should find stuff from in-tree, while the latter should look for
things only in the checked out files.
