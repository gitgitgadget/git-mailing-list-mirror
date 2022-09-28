Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F48C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 15:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiI1Pxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1Px1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 11:53:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7344D98E7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:53:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23ABC153CCF;
        Wed, 28 Sep 2022 11:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n6Bp2mcMSaFtRD9WIL1msEaRfkVRpIF+KBvlKF
        briJo=; b=SJdEplLLf1+zvenxHAdSs9mqOhisDuYDykIg1H5RY8J5SNQofB15vQ
        D3hm4L+L5n8sBCJDrd5F3SJg67hpvpj95vXcCv5CYswJUD5FGU7q2GzZd4WZ3m3X
        2OzqJteG0ybOgYtnU7/Prje1iFqXgnZotI1dlI4XTVKdDe9ltWc7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ACD0153CCD;
        Wed, 28 Sep 2022 11:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EF4C153CCC;
        Wed, 28 Sep 2022 11:53:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] merge-ort: return early when failing to write a
 blob
References: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
        <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com>
        <bfc71a2d8adfbf9b899a47d469fe2343e4703ff7.1664350162.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 08:53:24 -0700
In-Reply-To: <bfc71a2d8adfbf9b899a47d469fe2343e4703ff7.1664350162.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 28 Sep 2022
        07:29:22 +0000")
Message-ID: <xmqqleq3zea3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFEFD72E-3F45-11ED-B5DA-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This is _not_ just a cosmetic change: Even though one might assume that
> the operation would have failed anyway at the point when the new tree
> object is written (and the corresponding tree object _will_ be new if it
> contains a blob that is new), but that is not so: As pointed out by
> Elijah Newren, when Git has previously been allowed to add loose objects
> via `sudo` calls, it is very possible that the blob object cannot be
> written (because the corresponding `.git/objects/??/` directory may be
> owned by `root`) but the tree object can be written (because the
> corresponding objects directory is owned by the current user). This
> would result in a corrupt repository because it is missing the blob
> object, and with this here patch we prevent that.
>
> Note: This patch adjusts two variable declarations from `unsigned` to
> `int` because their purpose is to hold the return value of
> `handle_content_merge()`, which is of type `int`. The existing users of
> those variables are only interested whether that variable is zero or
> non-zero, therefore this type change does not affect the existing code.
>
> Reviewed-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks.  The first paragraph in the quoted part above is new and not
exactly "reviewed" by Elijah yet, so let's ask ;-)  

To me the description of the issue looks reasonable to me.  Any
comments, Elijah?

The code is the same as the one in the previous round and Elijah
gave his Reviewed-by, and does look good to me, too.

>  merge-ort.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Thanks, all.  Queued.

