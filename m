Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE09EE4993
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbjHWQIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbjHWQIM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 12:08:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6957E7B
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 09:08:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E716B19EBC3;
        Wed, 23 Aug 2023 12:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yPMrKtEX33EyrNJXx+SPKxocSHacmfyKWfWUhT
        4QUrE=; b=kCibjcpgwWsa741B99srMmTJzuDOXNQQcoR31GXXO+P6rRgDrOC6My
        AqPx9LtLYkE5/SwUd6xT8q99b8yPfWEwcYpKmrbMS0cSshmJp1Vb0ObAu6wTNoNH
        wMl8LN2dRIkgr5Q6ssxSMtE6R/7gF60GWLkhvzvZ11vwcwQoF/1uk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB56719EBC2;
        Wed, 23 Aug 2023 12:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB60219EBC1;
        Wed, 23 Aug 2023 12:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        'Jeff King' <peff@peff.net>, 'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>
Subject: Re: [PATCH] ci: avoid building from the same commit in parallel
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
        <xmqq7cpwjhr1.fsf@gitster.g>
        <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
        <xmqq350kjfk8.fsf@gitster.g>
        <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
        <ZNv5PQlkn6tbUcH7@nand.local>
        <20230816022420.GA2248431@coredump.intra.peff.net>
        <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
        <xmqqo7j5uqza.fsf@gitster.g>
        <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de>
        <xmqqttssqsj5.fsf@gitster.g> <xmqq1qfvor35.fsf_-_@gitster.g>
        <xmqqpm3fn16f.fsf@gitster.g>
        <99e19de6-c17d-e85f-dc58-1019aed1e2b1@gmx.de>
        <xmqqjztnm6v0.fsf@gitster.g>
        <1da763f3-60bf-a572-2c71-336b1fa5553d@gmx.de>
Date:   Wed, 23 Aug 2023 09:08:07 -0700
In-Reply-To: <1da763f3-60bf-a572-2c71-336b1fa5553d@gmx.de> (Johannes
        Schindelin's message of "Wed, 23 Aug 2023 10:42:45 +0200 (CEST)")
Message-ID: <xmqq4jkphhco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 404D25C4-41CF-11EE-8084-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 22 Aug 2023, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > Right, we'd need that `concurrency: ${{ github.sha }}` attribute on
>> > the `config` job.
>>
>> That was my first thought, but I am not sure how it would work.
>>
>> Doesn't skip-if-redundant grab the workflow runs that have succeeded
>> and then see if one for the same commit already exists?  If you used
>> concurrency on the 'config', what gets serialized between two jobs
>> for the same commit is only the 'config' phase, so 'master' may wait
>> starting (because 'config' is what everybody else 'needs' it) while
>> 'config' phase of 'main' runs, and then when it gets to the turn of
>> 'config' phase of 'master', it would not find the run for the same
>> commit being done for 'main' completed yet, would it?
>
> Yes, that's true.
>
> But there is a silver lining: the `concurrency` can not only be specified
> on the job level, but also on the workflow run level.
> I tested this, and present the corresponding patch at the end of this
> mail.

Yeah, serializing the whole thing was the only way I thought that
would work, and I am glad you already tested that it works.

Thanks.
