Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3CDC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 22:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354031AbiBKWTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 17:19:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiBKWTt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 17:19:49 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7345BF1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 14:19:47 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82FCB114233;
        Fri, 11 Feb 2022 17:19:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KRlvU2GCJrqd4TbrGolEX5a78PYAcTptUQMxiS
        Qmy2k=; b=uOYsLQF0WxZEPdU4SXfkLjiYXWf9lm1257kdHsYJswVRmE4KK/Uel4
        Dp51bK5WEEXA1YP0kMw+zOx634s2YLIvXTNAu7ddfLLT24NrPWhuO9B1VqdlMAWO
        TYi0puzCTUgh7rz7n/O4pGqirapi7tl/BaWTMtrhmnl7anCKuc8rs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79F8B114232;
        Fri, 11 Feb 2022 17:19:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D436711422F;
        Fri, 11 Feb 2022 17:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
        <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
        <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g>
        <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
Date:   Fri, 11 Feb 2022 14:19:44 -0800
In-Reply-To: <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
        (Neeraj Singh's message of "Fri, 11 Feb 2022 13:18:09 -0800")
Message-ID: <xmqqczjt9hbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7E7D362-8B88-11EC-B2C2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> The main motivation for this more granular scheme is that I didn't
> think the current configuration follows a sensible principle. We
> should be fsyncing the loose objects, index, refs, and config
> files in addition to what we're already syncing today.  On macOS,
> we should be doing a full hardware flush if we've said we want to
> fsync.

If the "robustness vs performance" trade-off is unevenly made in the
current code, then that is a very good problem to address first, and
such a change is very much justified on its own.

Perhaps "this is not a primary work repository but is used only to
follow external site to build, hence no fsync is fine" folks, who do
not have core.fsyncObjectFiles set to true, may appreciate if we
stopped doing fsync for packs and other things.  As the Boolean
core.fsyncObjectFiles is the only end-user visible knob to express
how the end-users express the trade-off, a good first step would be
to align other file accesses to the preference expressed by it, i.e.
others who say they want fsync in the current scheme would
appreciate if we start fsync in places like ref-files backend.

Making the choice more granular, from Boolean "yes/no", to linear
levels, would also be a good idea.  Doing both at the same time may
make it harder to explain and justify, but as long as at the end, if
"very performant" choice uniformly does not do any fsync while
"ultra durable" choice makes a uniform effort across subsystems to
make sure bits hit the platter, it would be a very good idea to do
them.

Thanks.
