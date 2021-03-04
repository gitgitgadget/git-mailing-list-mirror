Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95244C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6849564FF3
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCDWzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:55:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64341 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCDWzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 17:55:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC45DA8DA0;
        Thu,  4 Mar 2021 17:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o1DZ8rOEaw4wPmHEvc7P9EvgDNE=; b=TDyLl9
        Mm0JaCtAShrZ0sTP8XzFS3dXCBZ7RZuBcph42C72W3D1Dcbbg02ZHJwIO5Xsn1YE
        ex5qJ/ApW7xjNLGt9B3xNT/XvM/6NBlrINRdPvH7x0ROTT0Z2L4O3AbBaYvTWWe8
        WZHfFGSOFwqZZl9YB15UBSbzS5n0VZ+h6KHnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z31Hfsoz9XzDdPPHIzua+ZIKFzvAvTGu
        zy5ep+QkG9FtA89/HrfyYdJSOkQEQ+HlSy16VaS9fVHQAp2uChDODr64K6EKoJ5z
        skLGsuFktyGHpF78XWbCxdyFfK4yL8XMkphn9RdS9wgCfyMm7lckl4ausokuiDVG
        YHw6XPL/lmA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1DDDA8D9F;
        Thu,  4 Mar 2021 17:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B523A8D9E;
        Thu,  4 Mar 2021 17:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/8] pkt-line: remove buffer arg from
 write_packetized_from_fd_no_flush()
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
        <d6ea7688dfb2536312b627f7ed47ff7f42091f60.1614889047.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 14:55:09 -0800
In-Reply-To: <d6ea7688dfb2536312b627f7ed47ff7f42091f60.1614889047.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 04 Mar 2021
        20:17:20 +0000")
Message-ID: <xmqqh7lqcywi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC1B8836-7D3C-11EB-898C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Remove the scratch buffer argument from `write_packetized_from_fd_no_flush()`
> and allocate a temporary buffer within the function.
>
> In 3e4447f1ea (pkt-line: eliminate the need for static buffer in
> packet_write_gently(), 2021-02-13) we added the argument in order to
> get rid of a static buffer to make the routine safe in multi-threaded
> contexts and to avoid putting a very large buffer on the stack.  This
> delegated the problem to the caller who has more knowledge of the use
> case and can best decide the most efficient way to provide such a
> buffer.
>
> However, in practice, the (currently, only) caller just created the
> buffer on the stack, so we might as well just allocate it within the
> function and restore the original API.

Hmph, I would have expected, since we already have changed the
callchain to pass the buffer down, that we'd keep the structure and
update the caller to heap-allocate, but I think I like the result of
this patch better.  It's not like the caller can allocate and reuse
a single buffer with repeated calls to the function; rather, the
caller makes a single call that results in relaying many bytes by
the helper, all done in a loop, and it is sufficient for the helper
to allocate/deallocate outside of its loop to reuse the buffer.

