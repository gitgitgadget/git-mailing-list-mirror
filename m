Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8CB20756
	for <e@80x24.org>; Fri, 13 Jan 2017 21:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751222AbdAMVUy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 16:20:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751104AbdAMVUy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 16:20:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B82865E183;
        Fri, 13 Jan 2017 16:20:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3N3Zhi2EE2GUU3rPSNXymXkpScc=; b=s/llAE
        8lgR0/Pwz+tJrHPfzdXxVTu6sTT1muOaIhPC8nRrCjt8bBEvDbKCI24HFnhX3fKY
        wWe29bJGxNaTvahKtUMaEmy2ssvAHZxbWfzTVsJDDJO5QecXiT2oJnBt4UNpaxvd
        ginj0C1wS+L3NcZ8VGjGvGjifUmkOUjPPIS4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eqlf+mcsSlr3iSVtHXz3jyQfyHHtHLYJ
        b7QPzp5fKh3p2bGYb3OxTeIlbVswy1m6sObyzV8LtfiGUfn1JAuGIwLihTkSWaJK
        xcIuYHTVbUcOS8Zmrzz61Auhy5V25rOlFuRjQKS1xYyXCAmCCL52qbtk1u71hypC
        c7WJXS7yRSQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF01F5E182;
        Fri, 13 Jan 2017 16:20:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1581F5E181;
        Fri, 13 Jan 2017 16:20:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, sbeller@google.com
Subject: Re: [PATCH 25/27] attr: store attribute stacks in hashmap
References: <20170112235354.153403-1-bmwill@google.com>
        <20170112235354.153403-26-bmwill@google.com>
Date:   Fri, 13 Jan 2017 13:20:50 -0800
In-Reply-To: <20170112235354.153403-26-bmwill@google.com> (Brandon Williams's
        message of "Thu, 12 Jan 2017 15:53:52 -0800")
Message-ID: <xmqqshomejwt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29551862-D9D6-11E6-9726-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The last big hurdle towards a thread-safe API for the attribute system
> is the reliance on a global attribute stack that is modified during each
> call into the attribute system.
>
> This patch removes this global stack and instead a stack is retrieved or
> constructed locally.  Since each of these stacks is only used as a
> read-only structure once constructed, they can be stored in a hashmap
> and shared between threads.

Very good.

The reason why the original code used a stack was because it wanted
to keep only the info read from releavant files in-core, discarding
ones from files no-longer relevant (because the traversal switched
to another subdirectory of the same parent directory), to avoid the
memory consumption grow unbounded.  It probably was a premature
"optimization" that we can do without, so keeping everything we have
read so far in a hashmap (which is my understanding of what is going
on in this patch) is probably OK.

I suspect that this hashmap may eventually need to become per
attr_check if we want to follow through the optimization envisioned
by patch 15/27.

Inside fill(), path_matches() is called for the number of match_attr
in the entire attribute stack but it is wasteful to check if the
path matches with the a.u.pat if none of the a.state[] entries talk
about attributes and macros that are eventually get used by the
caller of check_attr().  By introducing a wrapping structure, 15/27
wanted to make sure that we have a place to store a "reduced"
attribute stack that is kept per attr_check that has only entries
from the files that talk about the attributes the particular
attr_check wants to learn about.

I need to think about this a bit more, but I do not offhand think
that it makes future such enhancement to make it per-check harder to
move from a global stack to a global hashmap, i.e. the above is not
an objection to this step.

> One caveat with storing and sharing the stack frames like this is that
> the info stack needs to be treated separately from the rest of the
> attribute stack.  This is because each stack frame holds a pointer to
> the stack that comes before it and if it was placed on top of the rest
> of the attribute stack then this pointer would be different for each
> attribute stack and wouldn't be able to be shared between threads.  In
> order to allow for sharing the info stack frame it needs to be its own
> isolated frame and can simply be processed first to have the same affect
> of being at the top of the stack.

Good.

Thanks.
