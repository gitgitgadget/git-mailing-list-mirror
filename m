Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC38FC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 16:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJRQkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJRQkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 12:40:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449579618
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 09:40:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03A8914F881;
        Tue, 18 Oct 2022 12:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EjrbpCj+PXwt3WgDiImgVQu2RW7fSp9bmGn0ZH
        fKFGw=; b=rANw/2dbdql24dkYRmncvvP3JX+/tWnVWG0VX36EPrWLuPVqoJxYza
        v3T0ZVQXYYhi6TubMFQLndMj7jThLQh/kU5Lwd4fS6myvRl4RBUrt/eq/P+L/MzL
        9ZnGztw1jszoIlfOr/cP6RZvv1ulK97riFASFB8JxGKxOjddnD5Ew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C82F614F87F;
        Tue, 18 Oct 2022 12:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2789914F87C;
        Tue, 18 Oct 2022 12:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Rav <m@git.strova.dk>
Cc:     git@vger.kernel.org, peff@peff.net, pwagland@gmail.com
Subject: Re: [PATCH] revision: ignore non-existent objects in resolve-undo list
References: <20221018175530.086c8c74@apus> <xmqqfsflum70.fsf@gitster.g>
Date:   Tue, 18 Oct 2022 09:40:01 -0700
In-Reply-To: <xmqqfsflum70.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 Oct 2022 09:32:35 -0700")
Message-ID: <xmqqbkq9ulum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8466AECA-4F03-11ED-8FEE-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Fix the error by emitting a warning when the resolve-undo list mentions
>> objects that do not exist and then ignoring the nonexistent object.
>
> ... this approach is about.  I think it is backwards to sweep the
> problem under the rug without fixing the underlying problem.
>
> We should instead be removing the reference that is no longer even
> usable for the purpose of resolve-undo, e.g. when "rerere forget
> <pathspec>" reads from the resolve-undo extension to recreate the
> conflicts.

Ah, I take half of it back.  "instead" -> "in addition".

The patch corresponds to revision.c::handle_one_reflog_commit() that
skips the object referenced by a reflog entry that no longer exists
as part of the solution to the same problem as "reflog --stale-fix"
solved, and needs to be an integral half of the solution to the
"older gc lose blobs referenced by resolve-undo extension" problem.

And the patch goes in the right direction.  It is a bit sad that it
now has to do parse_object() but in the normal case, the object
referenced should be a blob that exists, for which the cost of
parsing it would be none (just setting .parsed member to true), so
it should be OK.

Thanks.  Will queue.
