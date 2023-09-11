Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98554CA0EC6
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349162AbjIKVcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbjIKTCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 15:02:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F3D8
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 12:02:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 437853750B;
        Mon, 11 Sep 2023 15:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=cQ0EXSr9mo2Be2AtolT+79BG5mv+4OWT1yOiL1
        G5HqI=; b=vaiz9suNoSvxCOymGOV6eODX/7XDHNa334GD2EKz2bprCmf7S0FaoA
        hIJp/lLdYcPR5i6yptjKoprJIlZc+Bkjrvwai4sfcFwZ04ETrh9lKGdI054dHM2y
        0uRZ0jbOLq6wyDRTG2ahNR/YNwNvkJ7I4YCztY8Y7wotIWGF7XhJk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AFDD3750A;
        Mon, 11 Sep 2023 15:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7DAD37509;
        Mon, 11 Sep 2023 15:01:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 6/6] trailer: use offsets for trailer_start/trailer_end
In-Reply-To: <0463066ebe0889b72b6a1f6c344f2de127458391.1694240177.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 09 Sep 2023 06:16:17
        +0000")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <0463066ebe0889b72b6a1f6c344f2de127458391.1694240177.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Sep 2023 12:01:55 -0700
Message-ID: <xmqqmsxsv8ik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADB59AA0-50D5-11EE-90C2-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Previously these fields in the trailer_info struct were of type "const
> char *" and pointed to positions in the input string directly (to the
> start and end positions of the trailer block).
>
> Use offsets to make the intended usage less ambiguous. We only need to
> reference the input string in format_trailer_info(), so update that
> function to take a pointer to the input.

Hmm, I am not sure if this is an improvement.  If the underlying
buffer can be reallocated (to grow), the approach to use the offsets
certainly is easier to deal with, as they will stay valid even after
such a reallocation.  But you lose the obvious sentinel value NULL
that can mean something special, and have to make the readers aware
of the local convention you happened to have picked with a comment
like ...

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 17 ++++++++---------
>  trailer.h |  7 +++----
>  2 files changed, 11 insertions(+), 13 deletions(-)
> ...
>  	/*
> -	 * Pointers to the start and end of the trailer block found. If there
> -	 * is no trailer block found, these 2 pointers point to the end of the
> -	 * input string.
> +	 * Offsets to the trailer block start and end positions in the input
> +	 * string. If no trailer block is found, these are set to 0.
>  	 */

... this, simply because there is no obvious sentinel value for an
unsigned integral type; even if you count MAX_ULONG and its friends,
they are not as obvious as NULL for pointer types.

So, I dunno.
