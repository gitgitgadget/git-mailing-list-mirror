Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9DC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 15:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJQPiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJQPiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 11:38:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD53BC7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 08:38:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D9D6145D05;
        Mon, 17 Oct 2022 11:38:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0NeEXE02C8m1Zhh9Vje/qnnhZ2qDP4YdPM+J6Y
        MPE7I=; b=Xnn78o5AWBnG6rT86VBHRoI88QHFvMM1tSPxHGzUAF8w6tKTvMdTYI
        TKHgzlv30s4QsNkO0vX+IapNevkTMng1D6Y0p3eEKRMNHmIlIxIiYLrn3P8faePo
        7KCBfWL5CyomJxQ7PxPIa9/RmHvSWKiqwdYfF8U80aR/cFStzItDM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 678F2145D04;
        Mon, 17 Oct 2022 11:38:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14A25145D03;
        Mon, 17 Oct 2022 11:38:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v3 5/7] builtin: patch-id: add --include-whitespace as a
 command mode
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <bbaa2425ad0cbb4b945cdce3402c6ed5fab381ec.1665737804.git.gitgitgadget@gmail.com>
        <xmqqbkqe6qv4.fsf@gitster.g>
Date:   Mon, 17 Oct 2022 08:38:00 -0700
In-Reply-To: <xmqqbkqe6qv4.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Oct 2022 14:24:15 -0700")
Message-ID: <xmqq7d0y1mw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF605C7A-4E31-11ED-A02B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +--include-whitespace::
>> +	Use the "stable" algorithm described below and also don't strip whitespace
>> +	from lines when calculating the patch-id.
>> +
>> +	This is the default if patchid.includeWhitespace is true and implies
>> +	patchid.stable.
>
> This seems very much orthogonal to "--stable/--unstable.  
>
> Because the "--stable" variant is more expensive than "--unstable",

Sorry, I misspoke.  The way we make the result stable is *not* by
enforcing a fixed order to the input of the hash (which would have
been more expensive), but by hashing each file separately and
summing up the hashes, and it shouldn't be noticeably more expensive
than the unstable variant.

So, I do not think I mind if we introduced --include-whitespace as a
third option in addition to --stable and --unstable, instead of allowing
it to be combined with both --stable and --unstable.

But I wonder:

 * (minor) Would "--verbatim" work as a better option name?  The
   name "--include-whitespace" can apply even to an implementation
   that squashes multiple consecutive spaces and tabs into a single
   space, i.e. we keep words on a single line as separate words,
   instead of squishing them together, when hashing.

 * Do users even care about the internal reliance on the "stable"
   algorithm?  Wouldn't it be better to leave such an implementation
   detail unsaid?  After all, "--verbatim --unstable" would not work
   as they expect.

So I would suggest dropping "and implies patchid.stable" from the
above description.


