Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813DCC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiCIUEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiCIUEN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 15:04:13 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3147BE5
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 12:03:13 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 267E110C690;
        Wed,  9 Mar 2022 15:03:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DDCuCyVbnT2LV/W1N7o0GcECrfFCpHAPum58mx
        E6Zzw=; b=g6qPCuXhM4a7tRvSl7/2Hn5DHsfFN6nKfpQ8KnZODOZkdnFRSOyeFK
        rIEGM/LnwuQ3HwkWgJsTzptK8tOzaasYXP/nb5scCDoAN9iX2bmYJj9eil8x63Lb
        fsr47j3Am+s4Sspq9NSmKoYX44Y1MCTAhqAKgTUHOY5A0o41ioTm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CEB510C68F;
        Wed,  9 Mar 2022 15:03:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79B6F10C68E;
        Wed,  9 Mar 2022 15:03:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
        <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g>
        <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
        <xmqqczjt9hbz.fsf@gitster.g>
        <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
        <xmqq35kp806v.fsf@gitster.g> <Ygn/GvLEjbCxN3Cc@ncase>
        <xmqqh7914bbo.fsf@gitster.g> <YiiuqK/tCnQOXrSV@ncase>
Date:   Wed, 09 Mar 2022 12:03:11 -0800
In-Reply-To: <YiiuqK/tCnQOXrSV@ncase> (Patrick Steinhardt's message of "Wed, 9
        Mar 2022 14:42:00 +0100")
Message-ID: <xmqqpmmuki68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F304A276-9FE3-11EC-BAE5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> If the user cares about fsynching loose object files in the right
>> way, we shouldn't leave loose ref files not following the safe
>> safety level, regardless of how this new core.fsync knobs would look
>> like.
>> 
>> I think we three are in agreement on that.
>
> Is there anything I can specifically do to help out with this topic? We
> have again hit data loss in production because we don't sync loose refs
> to disk before renaming them into place, so I'd really love to sort out
> this issue somehow so that I can revive my patch series which fixes the
> known repository corruption [1].

How about doing a series to unconditionally sync loose ref creation
and modification?

Alternatively, we could link it to the existing configuration to
control synching of object files.

I do not think core.fsyncObjectFiles having "object" in its name is
a good reason not to think those who set it to true only care about
the loose object files and nothing else.  It is more sensible to
consider that those who set it to true cares about the repository
integrity more than those who set it to false, I would think.

But that (i.e. doing it conditionally and choose which knob to use)
is one extra thing that needs justification, so starting from
unconditional fsync_or_die() may be the best way to ease it in.

