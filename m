Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A14BC433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183DD64DDE
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhA1UVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:21:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55934 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhA1UVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 15:21:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0237D96BE1;
        Thu, 28 Jan 2021 15:20:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z+2Rb+GXGZqsFo3GnkayONvp/gg=; b=LqBW8I
        qib/Rh3y5lV0nKQ5MAKqMazZvTPFQuq6HKU0wx/5ubQdm7UY5IUMWU39eo5iH9ni
        ebrzNvp7jpk0vY3btd6X0FoyNLbb8SHYWa2GN/968MFPcQ3oKjBioBmIk0Xagf/X
        V8znXyRbNPvC2gMN8GWEn0DiDzWxOC1h62tYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uMPOvpRnaNtGagSt45shpU4IQl9c8uD7
        r4lWfqd8Lae9jKGhjwS6ZaNEQfhUkKI1eSTFK1NzyWEwx+geYcchx8PLxqBupEYV
        WFm5iIeMsUxN9SkMsPu/zfBVGA3B2aLD8XWhhk27WFsYv7pzfE6xOVyd7lckRxP+
        XfXQIFTuTqY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE57196BE0;
        Thu, 28 Jan 2021 15:20:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B8B096BD7;
        Thu, 28 Jan 2021 15:20:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net, gitster@pobox.net,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Speed up remove_redundant()
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 12:20:32 -0800
In-Reply-To: <pull.852.git.1611851095.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Thu, 28 Jan 2021 16:24:51 +0000")
Message-ID: <xmqqzh0svmnj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46348BFA-61A6-11EB-B3D7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Michael Haggerty pointed out that git merge-base --independent is quite slow
> when many commits are provided in the input. This boils down to some
> quadratic behavior in remove_redundant() because it calls
> paint_down_to_common() in a loop.
>
> This series avoids that by using a single commit walk, pushing a flag that
> means "this commit is reachable from a parent of a commit in the list." At
> the end of the walk, the input commits without that flag are independent.

Yay.  I've been quite unhappy with the loop ever since I wrote it
back in 2012.

Thanks for cleaning it up.
