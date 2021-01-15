Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A2C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B504023AC6
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbhAOCXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:23:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55015 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbhAOCXj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:23:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45268A07FF;
        Thu, 14 Jan 2021 21:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qtugYQGwBdFvDC0cZzwDSg3Wv+E=; b=JuSyxY
        sX2RKhpMSannSm/rSJbIUfUG3MVw11qv2sjRlcnNa+wW1xvpZ9eGkOvl+Pynn/Lb
        5fOu+7rAVak4tzMH5Gmovu2UTbO0myAbODVDaCMQ9rLK8wjZ85pKPsrlorvMLhVA
        nAiu2exg45NV6KEHHs/CWmlopMJH+1ykfcId8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YuN+E9YWM7zoMvGrjOaiJpTNqmRBynpw
        6sPwYfOgvGVWIvZVdUw99RpvwXv1ZqH6lmkNvNl9ZDeOJuXL7ATmqMkGlTX+Rfw7
        nnlmR3p/A6ZA2MZjv0MxSPrP2KKGCzCSL3l/1/Q4nObd5uhHW8pEg++4TUxPUyh7
        tf4+851zpWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D31CA07FD;
        Thu, 14 Jan 2021 21:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC573A07FC;
        Thu, 14 Jan 2021 21:22:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
        <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
        <YACcoNY/SiEbBSgh@coredump.intra.peff.net>
        <YAClXle+utN/VnVZ@coredump.intra.peff.net>
        <YACmcG4bNugX3WfK@nand.local>
Date:   Thu, 14 Jan 2021 18:22:56 -0800
In-Reply-To: <YACmcG4bNugX3WfK@nand.local> (Taylor Blau's message of "Thu, 14
        Jan 2021 15:15:44 -0500")
Message-ID: <xmqqo8hruef3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 946B012E-56D8-11EB-966E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jan 14, 2021 at 03:11:10PM -0500, Jeff King wrote:
>> On Thu, Jan 14, 2021 at 02:33:53PM -0500, Jeff King wrote:
>>
>> > So "pos" in this case is not wrong. But I agree that it could stand to
>> > be more clear. Saying "nth" does not help things IMHO (there is an "nth"
>> > pack position, as well).
>> >
>> > But maybe this makes it more clear (or possibly just the name change
>> > without the comment):
>>
>> Here it is again, but with a signoff and commit message, and done on top
>> of your series (so if we agree this is a good resolution, it can just be
>> picked up on top, but I am also happy for it to be squashed into patch
>> 15).
>
> Much appreciated. This looks good to me (and I have no opinion whether
> it is picked up on top, or squashed into patch 15).
>
>   Acked-by: Taylor Blau <me@ttaylorr.com>

OK, so I'll make this 21/20 and rebase the other one...
