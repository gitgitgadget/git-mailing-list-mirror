Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECC2C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349189AbiC3RNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349211AbiC3RM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:12:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C347073
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:11:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3695A11798D;
        Wed, 30 Mar 2022 13:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ES8MwtJcf0PDcBtT65Q329cTVyJ0ytRX/kTzOn
        ORjlc=; b=Ndg163jCQ2fuLLD4s4jVc94d6lOCofU41K/RnXQy6FsQx3rKKN721i
        TFp8MN7sZKNoyktUqNnr+9by5E58wehSot9ZQNLOZdtCUNlwxtzVumXdkp4H0s6e
        Dad2kTNnBUpbMdYxWQPPoULwm9inFVGbGnIZPKdDECKCc/DqBc5Lo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28CD411798C;
        Wed, 30 Mar 2022 13:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 330F211798B;
        Wed, 30 Mar 2022 13:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 01/14] bulk-checkin: rename 'state' variable and
 separate 'plugged' boolean
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 10:11:06 -0700
In-Reply-To: <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:19
        +0000")
Message-ID: <xmqqpmm39xhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63EFAFE4-B04C-11EC-AD29-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Batched fsync will fit into bulk-checkin by taking advantage of the
> plug/unplug functionality to determine the appropriate time to fsync
> and make newly-added objects available in the primary object database.
>
> * Rename 'state' variable to 'bulk_checkin_state', since we will later
>   be adding 'bulk_fsync_objdir'.  This also makes the variable easier to
>   find in the debugger, since the name is more unique.
>
> * Move the 'plugged' data member of 'bulk_checkin_state' into a separate
>   static variable. Doing this avoids resetting the variable in
>   finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
>   seem to unintentionally disable the plugging functionality the first
>   time a new packfile must be created due to packfile size limits. While
>   disabling the plugging state only results in suboptimal behavior for
>   the current code, it would be fatal for the bulk-fsync functionality
>   later in this patch series.

Paraphrasing to make sure I understand your reasoning here...

In the "plug and then perform as many changes to the repository and
finally unplug" flow, before or after this series, the "perform"
step in the middle is unaware of which "bulk_checkin_state" instance
is being used to keep track of what is done to optimize by deferring
some operations until the "unplug" time.  So bulk_checkin_state is
not there to allow us to create multiple instances of it, pass them
around to different sequences of "plug, perform, unplug".  Each of
its members is inherently a singleton, so in the extreme, we could
turn these members into separate file-scope global variables if we
wanted to.  The "plugged" bit happens to be the only one getting
ejected by this patch, because it is inconvenient to "clear" other
members otherwise.

Is that what is going on?

If it is, I am mildly opposed to the flow of thought, from at least
two reasons.  It makes it hard for the next developer to decide if
the new members they are adding should be in or out of the struct.

More importantly, I think the call of finish_bulk_checkin() we make
in deflate_to_pack() you found (and there may possibly other places
that we do so; I didn't check) may not appear to be a bug in the
original context, but it already is a bug.  And when we change the
semantics of plug-unplug to be more "transaction-like", it becomes a
more serious bug, as you said.

There is NO reason to end the ongoing transaction there inside the
while() loop that tries to limit the size of the packfile being
used.  We may want to flush the "packfile part", which may have been
almost synonymous to the entirety of bulk_checkin_state, but as you
found out, the "plugged" bit is *outside* the "packfile part", and
that makes it a bug to call finish_bulk_checkin() from there.

We should add a new function, flush_bulk_checking_packfile(), to
flush only the packfile part of the bulk_checkin_state without
affecting other things---the "plugged" bit is the only one in the
current code before this series, but it does not have to stay to be
so.  When you start plugging the loose ref transactions, you may
find it handy (this is me handwaving) to have a list of refs that
you may have to do something at "unplug" time kept in the struct,
and you do not want deflate_to_pack() affecting the ongoing
"plugged" ref operations by calling finish_bulk_checkin() and
reinitializing that list, for example.

And then we should examine existing calls to finish_bulk_checkin()
and replace the ones that should not be finishing, i.e. the ones
that wanted "flush" but called "finish".

