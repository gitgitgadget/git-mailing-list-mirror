Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73662C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 16:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380014AbiAaQ5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:57:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59529 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380677AbiAaQ5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 11:57:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A15B51627FC;
        Mon, 31 Jan 2022 11:57:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cj9rNBZjnGW6yKdiy07JnR/jAMVSKhRPANGuB+
        ZbB00=; b=utTBXfCl65eq5flFh5zPNL8Rq9RnQCEkxJ3YdjDD8IJo8hRwdyNWxd
        EJrr4GT675g+gyVGp6a4q+Out4eAoo3yifpvAVWdU0ODEKYplHpbl2D4xEzEbfh2
        GlvlZh2uoOWgL20Wk8VjJsihN+oGKi5ML8B3AwdcY7yVAJSWi3rS4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8846A1627FB;
        Mon, 31 Jan 2022 11:57:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE5261627F9;
        Mon, 31 Jan 2022 11:57:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
        <220128.86ee4scn2s.gmgdl@evledraar.gmail.com>
        <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
Date:   Mon, 31 Jan 2022 08:57:27 -0800
In-Reply-To: <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 28 Jan 2022 17:40:18 -0800")
Message-ID: <xmqqfsp3kfm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFA22FE0-82B6-11EC-8930-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I.e. =default should always be equivalent to not declaring that config
>> at all anywhere, and not drift to being a reference to some name that
>> happens to be "default", as in the GNOME case.
>
> No, we have the same problem as the Gnome case.  See this part of the
> documentation for fetch.negotiationAlgorithm:
>
> """
>     The default is "default" which instructs Git to use the
>     default algorithm that never skips commits (unless the server has
>     acknowledged it or one of its descendants).
> """

That looks more like one of the bugs introduced when skipping was
turned on for the "experimental" folks.  To fix this, without
turning skipping into the default too hastily, there needs two and
half things to happen:

 * Give a new name for the non-skipping algorithm, and describe the
   algorithm like the above.

 * Describe "default" is "non-skipping" but "feature.experimental"
   makes "skipping" the default.

 * Support "non-skipping" in the configuration parser, so that even
   when something else becomes the default, people can choose it.

I would think.
