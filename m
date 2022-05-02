Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FBC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 06:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355882AbiEBG03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 02:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiEBG0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 02:26:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855A72723
        for <git@vger.kernel.org>; Sun,  1 May 2022 23:22:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 878BC132D02;
        Mon,  2 May 2022 02:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=WTTmw4XI4pFKSU5DGnY8Fzzvs0sjbaIiEId8YTgCiI4=; b=lObK
        /PyTe6VSy3VlF+XJDoxeg6x3TAg7MiNYCingBdsFaIVYTQ4tTy3qXV/ClT13No8h
        O7geZqVvY9EAz6A9P3uCUWYycaDt0O+aFWtoYfptYCFutBoQ4csD0Fbhv5nQ1zEn
        FeNBVAnouAMPUs/fH9vIPXErHuHoTyeLhI3/tZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80210132D01;
        Mon,  2 May 2022 02:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFB01132D00;
        Mon,  2 May 2022 02:22:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
        <20220430041406.164719-2-gitter.spiros@gmail.com>
        <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
        <xmqqpmky70jb.fsf@gitster.g>
        <a3e06290-052e-af36-4170-301e567d561d@iee.email>
        <xmqqr15e5fm3.fsf@gitster.g> <xmqqmtg25cjw.fsf@gitster.g>
        <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
        <xmqqbkwg4zi7.fsf@gitster.g>
Date:   Sun, 01 May 2022 23:22:52 -0700
Message-ID: <xmqqmtg01mir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CC2D942-C9E0-11EC-AD51-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> To avoid unnecessary conflicts with in-flight topics, ideally, we
> perhaps could do something along this line:
>
>  * Pick a recent stable point that is an ancestor of all topics in
>    flight.  Add the new coccinelle rule file, take "make coccicheck"
>    output and create a two-patch series like Philip suggested.  Queue
>    the result in a topic branch B.
>
>  * For each topic in flight T, make a trial merge of T into B, and
>    examine "make coccicheck" output.  Any new breakages such a test
>    finds are new violations the topic T introduces.  Discard the
>    result of the trial merge, and add one commit to topic T that
>    corrects the violations the topic introduced, and send that fixup
>    to the author of the topic for consideration when the topic is
>    rerolled (or if the topic is in 'next', acked to be queued on
>    top).  Do not fix the violations that is corrected when branch B
>    was prepared above.
>
> As I assumed that applying the patches in this series would create
> the branch B, and then I saw that the tip of 'seen' after merging
> this topic still needed to have a lot more fixes according to "make
> coccicheck", I got a (false) impression that there are too many new
> violations from topics in flight, which was the primary source of my
> negative reaction against potential code churn.  If we try the above
> exercise, perhaps there may not be too many topics that need fix-up
> beyond what we fix in the branch B, and if that is the case, I would
> not be so negative.

So I tried that myself, and the topic branch B was fairly
straightforward to create.

We have ~60 topics in flight (not counting this one), and it turns
out that there is no topic that introduces new code that fails the
equals-null.cocci rule.  IOW, the follow-up fixup per topic turns
out to be an empty set.

So, I'd probably use the [01/23] and then a single ~5k lines patch
that was generated with equals-null.cocci rule as the branch B
above, let it percolate down from 'seen' to 'next' to eventually
'master'.

Thanks.
