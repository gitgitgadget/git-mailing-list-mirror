Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251C0C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 21:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E2721835
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 21:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IkqUQe0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFVmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:42:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54988 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLFVmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 16:42:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6655FADCC8;
        Fri,  6 Dec 2019 16:42:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xqt7SKb9lt77FDMdzDskN1cr06s=; b=IkqUQe
        0hjgFkOFPnKEgo6HluzSGCPh4imUciwMsZLKAIoys5trKGR2LXof4EN0YZrT1fZF
        AMWykbPJfuz913rFJ8WgPqnvlEucvHyvrVHLEU4JbKCD7yXzLdHQaMP4HNMfLE/3
        t1UHaRF7Lp/rV5zcYkRigq2Xq8svaCgve5SIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IUp+rjMtvyQhw7eS5dOHDq9fTnALQE/H
        IycZ9G8x9pv1QqcgppFSVrMGl/6gsYvPletrqogNfqY3rP08zzkoT1dqYhvulrmd
        y+x2/pH6OyztVjvIa807IxLdVZoB7WosHOlVWhYZSPxRVw69uGtHHB1mfNctUens
        OTtljlYehWg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E365ADCC7;
        Fri,  6 Dec 2019 16:42:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 82C78ADCC6;
        Fri,  6 Dec 2019 16:42:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     peff@peff.net
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
        <20191115180319.113991-1-jonathantanmy@google.com>
        <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
        <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 06 Dec 2019 13:42:31 -0800
In-Reply-To: <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 25 Nov 2019 15:36:25 +0900")
Message-ID: <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FAFD60A-1871-11EA-B7D8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>>> It could be a good idea if Peff could answer some of the comments made
>>>> by Jonathan Tan about patch 9/9.
>>>> 
>>>> I have put Peff as the author of all the commits.
>>>
>>> Thanks. I think the series looks mostly good except for the questions I
>>> raised in patch 9/9, so I'll wait for Peff to respond too.
>>
>> Hmph, the round before this one has been in 'next' for quite a
>> while, so should I eject it before waiting for Peff to respond
>> before queuing this one?
>
> After rebasing these v3 patches on top of the base of the one in
> 'next', the only difference seems to be the log message of 3/9 and
> the contents of 9/9.  I guess I'll mark the topic as "on hold" for
> now before doing anything, as I am officially taking a time-off most
> of this week ;-)

So..., that week has passed---anything new?

Thanks.
