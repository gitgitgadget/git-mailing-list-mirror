Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC238C433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B740F60E74
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhJLXup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 19:50:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhJLXuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 19:50:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BCE3E8997;
        Tue, 12 Oct 2021 19:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2aJm9jeLI0DVA9nukNFFy0RycaAsJhEwiKZ8fu
        YTdms=; b=CFoSt1SiFGisNmpJWP/COt2K02yRehA/orp4l40FYPxWIsPfgI+Uhp
        QBo9TWyyx/SoK5KNPNc0ftaMwX7X2Q8DRFX4yPAu+0V7Ow2BgxvW6r/7MDcWPdWe
        CIdJMITdtTqVNmkZN7SDOJ7BKPEdmWqtSwFi+JI4Us5ReCC/g1taQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44387E8996;
        Tue, 12 Oct 2021 19:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAF98E8995;
        Tue, 12 Oct 2021 19:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] config: include file if remote URL matches a glob
References: <cover.1634077795.git.jonathantanmy@google.com>
        <967680d27aa7a2709e528ff989a9dd534886efba.1634077795.git.jonathantanmy@google.com>
Date:   Tue, 12 Oct 2021 16:48:39 -0700
In-Reply-To: <967680d27aa7a2709e528ff989a9dd534886efba.1634077795.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 12 Oct 2021 15:57:23 -0700")
Message-ID: <xmqqk0ih24a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED503648-2BB6-11EC-A771-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I marked this as RFC because there are some design points that need to
> be resolved:
>
>  - The existing "include" and "includeIf" instructions are executed
>    immediately, whereas in order to be useful, the execution of
>    "includeIf hasremoteurl" needs to be delayed until all config files
>    are read. Are there better ways to do this?

An interesting chicken-and-egg problem.  Even if an included
configuration file does not have further "include", you may discover
there are more remotes, which may add new includes to fire from the
top-level configuration file.

What if we have multiple remotes?  Is it a sufficient match for only
one of them match what is mentioned in the includeIf condition?
Should all of them must match the pattern instead?  Majority,
perhaps?  Something else?

>  - Is the conditionally-included file allowed to have its own
>    "include{,If}" instructions? I'm thinking that we should forbid it
>    because, for example, if we had 4 files as follows: A includes B and
>    C includes D, and we include A and C in our main config (in that
>    order), it wouldn't be clear whether B (because A was first included)
>    or C (because we should execute everything at the same depth first)
>    should be executed first. (In this patch, I didn't do anything about
>    includes.)

Interesting.  The order of real inclusion obviously would affect the
outcome of the "last one wins" rule.  And this does not have to be
limited to this "hasremote" condition, so we need to design it with
a bit of care.

Would it be possible for a newly included file to invalidate an
earlier condition that was used to decide whether to include another
file or not?  If not, then you can take a two-pass approach where
the first pass is used to decide solely to discover which
conditionally included files are taken, clear the slate and the
parse these files in the textual order.  In the case of your example
above, the early part of the primary config would be the first to be
read, then comes A's early part, then comes B in its entirety, then
the rest of A, and then the middle part of the primary config, then
C's early part, then D, and then the rest of C,... you got the idea.

If it is possible for an included file to invalidate a condition we
have already evaluated to make a decision, it would become messy.
For example, we might decide to include another file based on the
value we discovered for a config variable:

    === .git/config ===
    [my] variable
    [your] variable = false

    [includeIf "configEq:my.variable==true"]
            file = fileA

but the included file may override the condition, e.g.

    === fileA ===
    [my] variable = false
    [your] variable = true

and applying the "last one wins" rule becomes messy.  I do not
offhand know what these

    $ git config --bool my.variable
    $ git config --bool your.variable

should say, and do not have a good explanation for possible
outcomes.

Maybe the above example can serve as a way to guide us when we
design the types of conditionals we allow in includeIf.  This
example tells us that it is probably a terrible idea to allow using
values of configuration variables as part of "includeIf" condition.

There may lead to similar "'hasremoteurl' makes a well-behaved
condition, because [remote] are additive and not 'last-one-wins',
but we cannot add 'lacksremoteurl' as a condition, because a file we
decide to include based on a 'lacks' predicate may invalidate the
'lacks' condition by defining such a remote" design decisions you'd
need to make around the URLs of the remotes defined for the
repository.


