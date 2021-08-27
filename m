Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB798C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC5360F4C
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhH0RMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:12:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58924 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhH0RMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 13:12:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 768DC152C46;
        Fri, 27 Aug 2021 13:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wGeWFPcnNZ/9EWEKRqWq9uKvKJa26QBtf5AdB6
        H0JT0=; b=lQuP2I8xLOa3+fquT0ZJKughgdJrBvopL3FKo9aBNcEBdi9yxSMuX4
        IkVUPQlyHHX6P0EQV6PpKbvlePJLTY2exsBKr6gFMaca1JBzUEEF/nLO9mn1rn25
        sGGdVa/4ewUicf+pOiUqZu3rz0FOqPhoCscWV52LejoKFAXc16yE4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E2CA152C45;
        Fri, 27 Aug 2021 13:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA077152C44;
        Fri, 27 Aug 2021 13:11:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
References: <20210809063004.73736-1-carenas@gmail.com>
        <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
        <xmqqpmumftry.fsf@gitster.g>
        <b554c82a-4da1-9676-4d93-b769ab6bbcbd@jeffhostetler.com>
        <xmqqsfyvbg8m.fsf@gitster.g>
        <CAPUEsphe0N6w_qCTAp46YPH7vBj2dkJa9kOm2HaixkFkVuk3GA@mail.gmail.com>
Date:   Fri, 27 Aug 2021 10:11:22 -0700
In-Reply-To: <CAPUEsphe0N6w_qCTAp46YPH7vBj2dkJa9kOm2HaixkFkVuk3GA@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 26 Aug 2021 23:04:09 -0700")
Message-ID: <xmqq1r6ebyo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE5A4976-0759-11EC-B471-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Thu, Aug 26, 2021 at 10:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Here is what I had to do to work around
>>
>>  https://github.com/git/git/runs/3438543601?check_suite_focus=true#step:5:136
>
> correct; that was 1/2 of the fixups I proposed and were waiting for the reroll.
>
> interesting that the job was able to build without 2/2[1] but it might
> be because clang is even more pedantic.
>
> Carlo
>
> [1] https://lore.kernel.org/git/20210809063004.73736-3-carenas@gmail.com/

One thing I noticed is that simple-ipc.h can disable itself
altogether with "#ifdef SUPPORTS_SIMPLE_IPC", so the unconditional
use of "enum ipc_active_state" by fsmonitor-ipc.h would still be a
problem.  fsmonitor-ipc.h is included even in help.c so it seems
that with this topic, you practically will not get a working Git at
all with -pedantic when SUPPORTS_SIMPLE_IPC is not true.

