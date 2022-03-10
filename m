Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F514C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiCJRQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbiCJRQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:16:12 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FE184602
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:15:11 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C576F189978;
        Thu, 10 Mar 2022 12:15:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XSOuw+zixuKVejWSCbzaMBU+Izh77/KLBhwcFO
        pVRxU=; b=Fewdba1VW08EjWGz0sX+5tae6r/KpkVqWfVSl2ozynoK9Bkobg8sLX
        esXjKOZ6D1C131I5vBRjqIglXOs0bFTkpo0kglPTz2NTiAXTUIjIuW/SdKPE8kyg
        NWwaFGM/F9sRcEI3gueke9ORE0D56kPRfjJRz6IquE+dLt/fRzZBE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE50E189976;
        Thu, 10 Mar 2022 12:15:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35540189975;
        Thu, 10 Mar 2022 12:15:07 -0500 (EST)
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
References: <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g>
        <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
        <xmqqczjt9hbz.fsf@gitster.g>
        <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
        <xmqq35kp806v.fsf@gitster.g> <Ygn/GvLEjbCxN3Cc@ncase>
        <xmqqh7914bbo.fsf@gitster.g> <YiiuqK/tCnQOXrSV@ncase>
        <xmqqpmmuki68.fsf@gitster.g> <YinwACkic3X1DKdr@ncase>
Date:   Thu, 10 Mar 2022 09:15:06 -0800
In-Reply-To: <YinwACkic3X1DKdr@ncase> (Patrick Steinhardt's message of "Thu,
        10 Mar 2022 13:33:04 +0100")
Message-ID: <xmqq8rthhgpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A221CB42-A095-11EC-B971-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> How about doing a series to unconditionally sync loose ref creation
>> and modification?
>> 
>> Alternatively, we could link it to the existing configuration to
>> control synching of object files.
>> 
>> I do not think core.fsyncObjectFiles having "object" in its name is
>> a good reason not to think those who set it to true only care about
>> the loose object files and nothing else.  It is more sensible to
>> consider that those who set it to true cares about the repository
>> integrity more than those who set it to false, I would think.
>> 
>> But that (i.e. doing it conditionally and choose which knob to use)
>> is one extra thing that needs justification, so starting from
>> unconditional fsync_or_die() may be the best way to ease it in.
>
> I'd be happy to revive my old patch series, but this kind of depends on
> where we're standing with the other patch series by Neeraj. If you say
> that we'll likely not land his patch series for the upcoming release,
> but a small patch series which only starts to sync loose refs may have a
> chance, then I'd like to go down that path as a stop-gap solution.
> Otherwise it probably wouldn't make a lot of sense.

The above was what I wrote before the revived series from Neeraj.
Now I've seen it, and more importantly, the most recent one from you
on top of that to add ref hardening as a new "component" or two, I
like the overall shape of the end result (except for the semantics
implemented by the configuration parser, which can be fixed without
affecting how the hardening components are implemented).  Hopefully
the base series of Neeraj can be solidified soon enough to make it
unnecessary for a stop-gap measure.  We'll see.

Thanks.
