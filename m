Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589EBC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 00:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FE623715
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 00:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbhAHAUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 19:20:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57573 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAHAUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 19:20:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE74E103D1D;
        Thu,  7 Jan 2021 19:19:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tV+V/lB6V4C9qGZALiRbcdnhOoo=; b=qkO2Vy
        l7YmYA9iO6U4KI+00PBGuIJRwjvvIejGroQwKgabO/UObquIZ70/41ldUo1QY6Yv
        LeX8NCgwNkCbSTb5C5valragg6ATGG5ztI7aPr4s5LyPs7uJMwQgZnmP+o5+2M0d
        Yuh6rgj74Bai4FW0/NbVJdXAkc82tmaQihhTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MGhi2rY3bQ+4BZjgDLmziBB1wFz5L2h1
        vxn0/M14HOPtoLvfdipRXEdA+7rSCADGbAOqpsMw0HJC2GZldBCLVOi8Mc2mH8bV
        047gCQ8QMTFXqBRE3jkdQFSqNunSABZL2haBLHF2pTkt8AB1fwJ+lt08VhrAfM3Y
        ulG4teDQRw4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D76DD103D1C;
        Thu,  7 Jan 2021 19:19:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F6BB103D1B;
        Thu,  7 Jan 2021 19:19:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: implement support for atomic reference updates
References: <cover.1610027375.git.ps@pks.im>
        <4807344e92bedbac37243434850da1f0787ad496.1610027375.git.ps@pks.im>
Date:   Thu, 07 Jan 2021 16:19:37 -0800
In-Reply-To: <4807344e92bedbac37243434850da1f0787ad496.1610027375.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 7 Jan 2021 14:51:44 +0100")
Message-ID: <xmqqeeiwjn52.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32398FCA-5147-11EB-B6F1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Similar to `git push --atomic`, this commit thus introduces atomic
> fetches. Instead of allocating one reference transaction per updated
> reference, it causes us to only allocate a single transaction and commit
> it as soon as all updates were received. If locking of any reference
> fails, then we abort the complete transaction and don't update any
> reference, which gives us an all-or-nothing fetch.
>
> Note that this may not completely fix the first of above downsides, as
> the consistent view also depends on the server-side. If the server
> doesn't have a consistent view of its own references during the
> reference negotiation phase, then the client would get the same
> inconsistent view the server has. This is a separate problem though and,
> if it actually exists, can be fixed at a later point.

With the help of the previous step, it is trivial to see that the
single transaction around store_updated_refs() would be sufficient
to achieve the atomicity.

But what about FETCH_HEAD?  Do we refrain from writing and/or appending
to it when there is any failure?

Thanks.
