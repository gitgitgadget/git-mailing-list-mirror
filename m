Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0602FC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 21:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiEIVUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 17:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiEIVUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 17:20:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC32CE37
        for <git@vger.kernel.org>; Mon,  9 May 2022 14:16:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91C9419A698;
        Mon,  9 May 2022 17:16:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F6TN807+a72LpXMwfHQm4Zb3vQbjazfOMUJ1Fy
        +cQbs=; b=kwbJ94jMoaUQpPLxeYvd5BzUDa95yJ6e9Y7jQP7Sdl2wYJFmFN3Zu2
        lp8UC7WjxheZSksEYpSjFhKedGZRhiIuA00oU8NGWla7hRtnbgrKvT9iUsbQ/H/r
        lG+kS7zwAp2+hf0EfxfN0wWdCdBhQCrBeln94e8bBmQJVUrfHU1/k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A15B19A697;
        Mon,  9 May 2022 17:16:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3512119A694;
        Mon,  9 May 2022 17:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 10/15] dir-iterator: refactor dir_iterator_advance()
References: <20220509175159.2948802-1-kioplato@gmail.com>
        <20220509175159.2948802-11-kioplato@gmail.com>
Date:   Mon, 09 May 2022 14:16:40 -0700
In-Reply-To: <20220509175159.2948802-11-kioplato@gmail.com> (Plato
        Kiorpelidis's message of "Mon, 9 May 2022 20:51:54 +0300")
Message-ID: <xmqqr152be4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 529C666E-CFDD-11EC-9CB2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plato Kiorpelidis <kioplato@gmail.com> writes:

> Simplify dir_iterator_advance() by converting from iterative to
> recursive implementation. This conversion makes dir-iterator more
> maintainable for the following reasons:
>   * dir-iterator iterates the file-system, which is a tree structure.
>     Traditionally, tree traversals, in textbooks, lectures and online
>     sources are implemented recursively and not iteratively. Therefore
>     it helps reduce mental load for readers, since it's easier to follow
>     as it reminds of the same tree traversals we use on tree structures.

Careful.

Many algorithms that are taught in the recursive form in textbooks
are turned into iterative in production systems for a reason.  To
avoid too deep a recursion wasting too much stack space.  A loop
with management of work items using in-program data structures like
stack or queue often makes a large traversal bearable.

The most obvious example is our history traversal code.  History
stored in Git is a tree structure, but no sane reimplementation of
Git (well, at least those that want to be able to deal with a
history larger than a toy project) would implement "git log" using a
recursive algorithm.


