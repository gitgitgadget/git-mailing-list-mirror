Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D75C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFB1610F7
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhDPWGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:06:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51559 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhDPWGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 18:06:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F7DBB03E1;
        Fri, 16 Apr 2021 18:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=31VirPXeH4kAXBeGxNZq74hocRQ=; b=VDNNsZ
        WrdihopbrTQcn8J9NNPVUlVxlWAzDJKwMUwjKvY+2eAQUU0z831vTnTt6KeIASck
        ffGIRwGw67zJBgXJ0hZHQjazJoV+P95ZqpwM8bebJpisQhmImLOZKOzRt8XIsvqG
        eNXs1mBghFZBzYMsJEfBQai43OdNJWJ2AKtBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PsbcgtaedgkkdbPJHj2+nTH09lEQ/A2M
        fRszYq9h3XCVmP+p4ZBw0cbQezLa2bwIF92fcdgIFzeArwsEifP8qFKnW26U0f18
        bZthxl7R+Sdl4eMFuXfjjefv+/SWt3wL7zn29/4JPqQT2HndyfKRbASov29UMtB1
        OFrQpt8hP6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87746B03E0;
        Fri, 16 Apr 2021 18:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BD9CB03DF;
        Fri, 16 Apr 2021 18:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net> <YHVQ9RPLk8/r+8mS@ncase>
        <YHgKiXRMq/1Fpg2x@coredump.intra.peff.net>
Date:   Fri, 16 Apr 2021 15:06:10 -0700
In-Reply-To: <YHgKiXRMq/1Fpg2x@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 15 Apr 2021 05:42:33 -0400")
Message-ID: <xmqqlf9hkhpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3EEA172-9EFF-11EB-8003-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Furthermore, the filter also allows future iterations which build on top
>> of this. If we had a combined OR filter in addition to the existing
>> combined AND filter, the user could say "Give me all blobs which aren't
>> bigger than a specific size PLUS all trees with a depth smaller than 5
>> PLUS all commits and tags". It's not like I'd know of a specific usecase
>> for this right now, but I think the potential of having such filters in
>> the future is a plus.
>
> Yeah, that's true. My biggest complaint is lack of an OR filter, but we
> could add that later. And then we would be _more_ flexible, as you note,
> since we could and/or more filters.
>
> So I'm OK proceeding with this direction.

I think the only remaining issues are the comments on 5/8 on tests,
then?  Hopefully we can have one more iteration to finalize the
topic and merge it down to 'next'?

Thanks.
