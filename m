Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4711DC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 17:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351575AbiCURFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244316AbiCURFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 13:05:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE73C731
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:03:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79C881274E0;
        Mon, 21 Mar 2022 13:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7movOyTWgPyQPZTVr6IKy99T3s866kyBbK/PRV
        YVZ5U=; b=uBwsGJ/Vtyf7vfOe/EfxlqmTd0HJYntG+YZFRZfv40pZn+/+NtW3Uw
        IlOCS6DceDpEH5Fs41e6w0Cyz0TVeXbBeXrX/Li7yjoKeXHJJFvV88qsBaAmuMy2
        M3MLInJoW7JUlpFoc22IN5oC8R5tKc6MAoA+6F/BXAz51dRJ2h1MA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FB6E1274DF;
        Mon, 21 Mar 2022 13:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D66B71274DE;
        Mon, 21 Mar 2022 13:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/7] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 10:03:46 -0700
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> (Neeraj
        K. Singh via GitGitGadget's message of "Sun, 20 Mar 2022 07:15:53
        +0000")
Message-ID: <xmqqpmmf1bm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFC25FCE-A938-11EC-B7E2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> V2 changes:
>
>  * Change doc to indicate that only some repo updates are batched

OK.

>  * Null and zero out control variables in do_batch_fsync under
>    unplug_bulk_checkin

OK.

>  * Make batch mode default on Windows.

I do not care either way ;-)

>  * Update the description for the initial patch that cleans up the
>    bulk-checkin infrastructure.

OK.

>  * Rebase onto 'seen' at 0cac37f38f9.

That's unfortunate.  Having to depend on almost everything in 'seen'
is a guaranteed way to ensure that the topic would never graduate to
'next'.

For this topic, ns/core-fsyncmethod is the only thing outside of
'master' that the previous round needed, so I did an equivalent of

    $ git checkout -b ns/batch-fsync b896f729e2
    $ git merge ns/core-fsyncmethod 

to prepare fd008b1442 and then queued the patches on top, i.e.

    $ git am -s mbox

> This work is based on 'seen' at . It's dependent on ns/core-fsyncmethod.

"at ."?

In any case, I've applied them on 0cac37f38f9 and then re-applied
the result on top of fd008b1442 (i.e. the same base as the previous
round was queued), which, with the magic of "am -3", applied
cleanly.  Double checking the result was also simple (i.e. the tip of
such an application on top of fd008b1442 can be merged with
0cac37f38f9 and the result should be identical to the result of
applying them directly on top of 0cac37f38f9) and seems to have
produced the right result.

\Thanks.


