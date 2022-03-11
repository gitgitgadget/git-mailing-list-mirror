Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CCAC4321E
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 05:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbiCKGAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 01:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347111AbiCKF6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 00:58:02 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4B1AD94D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 21:55:42 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D7651871F5;
        Fri, 11 Mar 2022 00:55:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j6j+4d6G2BuUJjkQMhy/WnygmmhH7J5gsKKCuN
        V1i0U=; b=Mv00VD6H+npksYpTYagIZmh0PkIMSJ0hU2Gw7C0KzSa0wNZwjIj28k
        nueZwvCzZOt85hBpwtoqZaYMWlcwQUURWKeiXjJwakeidGgE+Prjrm8Gogh8HEbX
        7Bib2dJWE6xJidRSMYEPNoR71R+dXD9zPD4sVHx1Y1sy4meOGGfj8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 468681871F4;
        Fri, 11 Mar 2022 00:55:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8DC01871F3;
        Fri, 11 Mar 2022 00:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 21:55:38 -0800
In-Reply-To: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 11 Mar 2022 05:05:44 +0000")
Message-ID: <xmqq5yolav8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1484ACA-A0FF-11EC-B615-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is happening because on a fast foward with an oid as a <branch>,
> update_refs() will only call update_ref() with REF_NO_DEREF if
> RESET_HEAD_DETACH is set. This change was made in 176f5d96 (built-in rebase
> --autostash: leave the current branch alone if possible,
> 2018-11-07). In rebase, we are not setting the RESET_HEAD_DETACH flag,
> which means that the update_ref() call ends up dereferencing
> HEAD and updating it to the oid used as <branch>.
>
> The correct behavior is that git rebase should update HEAD to $(git
> rev-parse topic) without dereferencing it.

It is unintuitive that unconditionally setting the RESET_HEAD_DETACH
bit is the right solution.

If the command weren't "rebase master side^0" but "rebase master
side", i.e. "please rebase the side branch itself, not an unnamed
branch created out of the side branch, on master", according to
<reset.h>, we ought to end up being on a detached HEAD, as
reset_head() with the bit

    /* Request a detached checkout */
    #define RESET_HEAD_DETACH (1<<0)

requests a detached checkout.  But that apparently is not what would
happen with your patch applied.

Puzzled.  The solution to the puzzle probably deserves to be in the
proposed log message.

Thanks.

