Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44754C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 23:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352639AbiBKXP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 18:15:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKXPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 18:15:25 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A2CD62
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 15:15:23 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E12B1148B3;
        Fri, 11 Feb 2022 18:15:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JoEfVOr12ALRua7ElqX0v6peXuGUpVLBFf5K3e
        OCjnI=; b=rQJfLZuR0+Pht3qjfoDp9r1VNLcAqdQhshlsMlApWHiOo4M6GUXVdM
        5KDwADYDmjs1+JOPwBI1y2hwsWHK6YrTfleAenROEg4Wj87F+74X2FQEOIJ8DTLW
        JoWGiCY5h+UhySkac+bM0usWxhhz9l8YzNiDHmY/JK9qdj7QInTy4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 300111148B2;
        Fri, 11 Feb 2022 18:15:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FFBC1148B1;
        Fri, 11 Feb 2022 18:15:21 -0500 (EST)
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
        <xmqqczjt9hbz.fsf@gitster.g>
        <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
Date:   Fri, 11 Feb 2022 15:15:20 -0800
In-Reply-To: <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
        (Neeraj Singh's message of "Fri, 11 Feb 2022 15:04:23 -0800")
Message-ID: <xmqq35kp806v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BFEE13A-8B90-11EC-9681-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> In practice, almost all users have core.fsyncObjectFiles set to the
> platform default, which is 'false' everywhere besides Windows.  So at
> minimum, we have to take default to mean that we maintain behavior no
> weaker than the current version of Git, otherwise users will start
> losing their data.

Would they?   If they think platform default is performant and safe
enough for their use, as long as our adjustment is out outrageously
more dangerous or less performant, I do not think "no weaker than"
is a strict requirement.  If we were overly conservative in some
areas than the "platform default", making it less conservative in
those areas to match the looseness of other areas should be OK and
vice versa.

> One path to get to your suggestion from the current patch series would
> be to remove the component-specific options and only provide aggregate
> options.  Alternatively, we could just not document the
> component-specific options and leave them available to be people who
> read source code. So if I rename the aggregate options in terms of
> 'levels of durability', and only document those, would that be
> acceptable?

In any case, if others who reviewed the series in the past are happy
with the "two knobs" approach and are willing to jump in to help new
users who will be confused with one knob too many, I actually am OK
with the series that I called "overly complex".  Let me let them
weigh in before I can answer that question.

Thanks.


