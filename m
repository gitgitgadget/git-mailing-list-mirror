Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03F3C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 01:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiBBBmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 20:42:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60215 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243698AbiBBBme (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 20:42:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68FD4177A53;
        Tue,  1 Feb 2022 20:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bx2EMU/NPwGIXfY512zmSaDilq95Az5EsR+lOo
        IKAGk=; b=dD0a0Q3+R4F1B9uybtubu0Mg5Ry2zoSz/aJbIk2J36Ln0ubK/ilznv
        kyKfXwj4JJtBpZKLQbERgMPBvmqiilX//O/Zs2zSBPW2kYiF6dw/5hCgztdzUVVu
        6Rpwg0hX27qiJIRxTqr3m9ec/FAOuTz9VoyyrBqDKtAKJcrQc3jWk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61C61177A52;
        Tue,  1 Feb 2022 20:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8D03177A4E;
        Tue,  1 Feb 2022 20:42:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
        <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
        <xmqqr18m8514.fsf@gitster.g>
Date:   Tue, 01 Feb 2022 17:42:30 -0800
In-Reply-To: <xmqqr18m8514.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        01 Feb 2022 16:51:19 -0800")
Message-ID: <xmqqy22u6o3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 633EFDE8-83C9-11EC-88C7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not quite sure if this is way too complex (e.g. what does it
> mean that we do not care much about loose-object safety while we do
> care about commit-graph files?) and at the same time it is too
> limited (e.g. if it makes sense to say a class of items deserve more
> protection than another class of items, don't we want to be able to
> say "class X is ultra-precious so use method A on them, while class
> Y is mildly precious and use method B on them, everything else are
> not that important and doing the default thing is just fine").
>
> If we wanted to allow the "matrix" kind of flexibility,...

To continue with the thinking aloud...

Sometimes configuration flexibility is truly needed, but often it is
just a sign of designer being lazy and not thinking it through as an
end-user facing problem.  In other words, "I am giving enough knobs
to you, so it is up to you to express your policy in whatever way
you want with the knobs provided" is a very irresponsible thing to
tell end-users.

And this one smells like the case of a lazy design.

It may be that it makes sense in some workflows to protect
commit-graph files less than object files and pack.idx files can be
corrupted as long as pack.pack files are adequately protected
because the former can be recomputed from the latter, but in no
workflows, the reverse would be true.  Yet the design gives such
needless flexibility, which makes it hard for lay end-users to
choose the best combination and allows them to protect .idx files
more than .pack files by mistake, for example.

I am wondering if the classification itself introduced by this step
actually can form a natural and linear progression of safe-ness.  By
default, we'd want _all_ classes of things to be equally safe, but
at one level down, there is "protect things that are not
recomputable, but recomputable things can be left to the system"
level, and there would be even riskier "protect packs as it would
hurt a _lot_ to lose them, but losing loose ones will typically lose
only the most recent work, and they are less valuable" level.

If we, as the Git experts, spend extra brain cycles to come up with
an easy to understand spectrum of performance vs durability
trade-off, end-users won't have to learn the full flexibility and
easily take the advice from experts.  They just need to say what
level of durability they want (or how much durability they can risk
in exchange for an additional throughput), and leave the rest to us.

On the core.fsyncMethod side, the same suggestion applies.

Once we know the desired level of performance vs durability
trade-off from the user, we, as the impolementors, should know the
best method, for each class of items, to achieve that durability on
each platform when writing it to the storage, without exposing the
low level details of the implementation that only the Git folks need
to be aware of.

So, from the end-user UI perspective, I'd very much prefer if we can
just come up with a single scalar variable, (say "fsync.durability"
that ranges from "conservative" to "performance") that lets our
users express the level of durability desired.  The combination of
core.fsyncMethod and core.fsync are one variable too many, and the
latter being a variable that takes a list of things as its value
makes it even worse to sell to the end users.


