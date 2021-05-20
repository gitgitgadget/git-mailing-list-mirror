Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCD3C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBA360FEE
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhETVqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:46:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50299 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhETVqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:46:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 470A513AC94;
        Thu, 20 May 2021 17:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=28cpK/lzqGzORx8i4LRpU8nCHbCeEB8R/ykMM3
        MeSIE=; b=RTKoqxPf7ZZuik7WI2+/H7pNxwV1tkIj27jF2x6tjCKrCJZNsCJRLX
        5X+KhTfIOvWS0eWFyJ1TiHWyj1I2pqSS9FNlI//0Kn3BhA/OnZeXM/ZIsZJ4iAWt
        2tQUanwDra9kZPngX6+NRd+U97XuCdJx4A8qYK8aL2AhXRmhvIvh8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F38B13AC93;
        Thu, 20 May 2021 17:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CC2413AC8F;
        Thu, 20 May 2021 17:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] Speed up connectivity checks via quarantine dir
References: <cover.1621451532.git.ps@pks.im>
        <YKaTUItbQ1pyMrrW@coredump.intra.peff.net>
Date:   Fri, 21 May 2021 06:45:02 +0900
In-Reply-To: <YKaTUItbQ1pyMrrW@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 20 May 2021 12:50:24 -0400")
Message-ID: <xmqqr1i1t6zl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2FBC748-B9B4-11EB-B517-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we have an unreachable tree in the object database which references
> blobs we don't have, that doesn't make the repository corrupt. And with
> the current code, we would not accept a push that references that tree
> (unless it also pushes the necessary blobs). But after your patch, we
> would, and that would _make_ the repository corrupt.
>
> I will say that:
>
>   1. Modern versions of git-repack and git-prune try to keep even
>      unreachable parts of the graph complete (if we are keeping object X
>      that refers to Y, then we try to keep Y, too). But I don't know how
>      foolproof it is (certainly the traversal we do there is "best
>      effort"; if there's a missing reference that exists, we don't
>      bail).
>
>   2. This is not the only place that just checks object existence in the
>      name of speed. When updating a ref, for example, we only check that
>      the tip object exists.

There might be already other ways to corrupt repositories, and a
corrupted repository to be left unnoticed, in other words.

But that does not make it OK to add more ways to corrupt
repositories.

>   1. We could easily keep the original rule by just traversing the
>      object graph starting from the ref tips, as we do now, but ending
>      the traversal any time we hit an object that we already have
>      outside the quarantine.
>
>   2. This tightening is actually important if we want to avoid letting
>      people _intentionally_ introduce the unreachable-but-incomplete
>      scenario. Without it, an easy denial-of-service corruption against
>      a repository you can push to is:
>
>        - push an update to change a ref from X to Y. Include all objects
> 	 necessary for X..Y, but _also_ include a tree T which points to
> 	 a missing blob B. This will be accepted by the current rules
> 	 (but not by your patch).
>
>        - push an update to change the ref from Y to C, where C is a
> 	 commit whose root tree is T. Your patch allows this (because we
> 	 already have T in the repository). But the resulting repository
> 	 is corrupt (the ref now points to an incomplete object graph).

Hmph, the last step of that attack would not work with our current
check; is this the same new hole the series brings in as you
explained earlier for a case where a newly pushed tree/commit starts
to reference a left-over dangling tree already in the repository
whose content blobs are missing?

> If we wanted to keep the existing rule (requiring that any objects that
> sender didn't provide are actually reachable from the current refs),
> then we'd want to be able to check reachability quickly. And there I'd
> probably turn to reachability bitmaps.

True.  As we are not "performance is king---a code that corrupts
repositories as quickly as possible is an improvement" kind of
project, we should keep the existing "an object can become part of
DAG referred by ref tips only when the objects it refers to all
exist in the object store, because we want to keep the invariant: an
object that is reachable from a ref is guaranteed to have everything
reachable from it in the object store" rule, and find a way to make
it fast to enforce that rule somehow.

Thank for a review.


