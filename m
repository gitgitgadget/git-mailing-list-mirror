Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE435C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0D860F58
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhHQWjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:39:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55697 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhHQWjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 18:39:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05E19148813;
        Tue, 17 Aug 2021 18:38:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KKInpLXTSCzVKqaZ21tbG0SspdrYVt4NZOMhrz
        6UbM0=; b=sUqTMcMcA7Ot8GZ7N74RgUxT6PM/42/WhNvTbTadKMkuI5eiiGVxpG
        bnCa2mdj7A+egAIHX+V0UID+o75gQ3YXykHlljeX/9UFG93Jyjv3Dzuh/jAKED3h
        gaHl8+j7FmyqVtSD6huPeKWC+W1WoH2pxGTDmCNHAzvCRDMFE3YzE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F26CB148812;
        Tue, 17 Aug 2021 18:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F31AE148811;
        Tue, 17 Aug 2021 18:38:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] fixup! propagate errno from failing read
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 15:38:38 -0700
In-Reply-To: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 17 Aug 2021 12:31:29
        +0000")
Message-ID: <xmqq4kbn7l3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE5DE5D6-FFAB-11EB-9193-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This fixes a crash triggered by the BUG() statement.
>
> This can occur with symlinked .git/refs. To check availability,
> refs_verify_refname_available will run refs_read_raw_ref() on each prefix,
> leading to a read() from .git/refs (which is a directory).
>
> When handling the symlink case, it is probably more robust to re-issue the
> lstat() as a normal stat(), in which case, we would fall back to the directory
> case.
>
> For now, propagating errno from strbuf_read() is simpler and avoids the crash.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>     fixup! propagate errno from failing read

Hmph, I do not see a commit with "propagate errno from failing read"
in its title anywhere in 'seen'.

I think the convention to assign errno to myerr in this codepath
originates in a0731250 (refs: explicitly return failure_errno from
parse_loose_ref_contents, 2021-07-20), and it forgot the part of the
code being fixed with this patch.  The commit being fixed is already
is in 'next' as part of the hn/refs-errno-cleanup topic.

Usually, a flaw in a topic that is already in 'next' is corrected by
a follow-up patch, but then they won't say "fixup!" (none of our
bugfix patches do).  But a post-release is a special time, as we
will soon be rewinding 'next', restarting it from the latest release
and we have a choice to tentatively eject a topic, fix it up or
even replace it, before merging the corrected topic to 'next'.

Do you mean that you want me to squash this change into that commit
before the topic graduates to 'master' during the new development
cycle?  If so please be a bit more explicit next time.  Using the
title of the commit after "fixup!" would be a good starting point.

Thanks.

