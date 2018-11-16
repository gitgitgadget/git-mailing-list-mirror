Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3992A1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 02:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeKPMz4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 07:55:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65423 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeKPMz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 07:55:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 432B3108CF5;
        Thu, 15 Nov 2018 21:45:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7OCGfAvE7brl0UWV4+3ihwMMiUI=; b=wWtb+R
        i0f20ZeJGVLbFsSI1jh+97un725RiJbjNMQHJJRzJQ5iiJI6yfEAoDeCqwtyT6vr
        BEUbhrDP7FT1EenWHABS66ng5xu4P2yXEbPAaIXt8yYlvE0sa1NQ6SxpkxdGi4ue
        vu8DUPRHtY0q00HSkS7mZbBGZQAxtoGH5oUAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ossCYeS9E7hT4DvpnGyAAQ+tLcq3BbyS
        EI+4ZXL27v1ORIs+FvVhwTznI0KY5WWuydtCMdrHzLCRPRk+8JmzpYxgTqs45qj5
        6bunw8f5YVoyMFY4wxpM6jPjBiE368LK7rfxr8dvv1kvy2zubtZvIsiqAMOZcMqs
        9xtkFHkGPxQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A756108CF4;
        Thu, 15 Nov 2018 21:45:23 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F43A108CF2;
        Thu, 15 Nov 2018 21:45:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
References: <cover.1539305180.git.steadmon@google.com>
        <cover.1542059029.git.steadmon@google.com>
        <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
        <xmqqr2fpwrqg.fsf@gitster-ct.c.googlers.com>
        <20181113225320.GG126896@google.com>
        <xmqq1s7os7rz.fsf@gitster-ct.c.googlers.com>
        <20181114195757.GJ126896@google.com>
Date:   Fri, 16 Nov 2018 11:45:21 +0900
In-Reply-To: <20181114195757.GJ126896@google.com> (Josh Steadmon's message of
        "Wed, 14 Nov 2018 11:57:57 -0800")
Message-ID: <xmqq4lchn3jy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9DF35F6-E949-11E8-AB73-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> What I was alludding to was a lot simpler, though.  An advert string
>> "version=0:version=1" from a client that prefers version 0 won't be
>> !strcmp("version=0", advert) but seeing many strcmp() in the patch
>> made me wonder.
>
> Ah I see. The strcmp()s against "version=0" are special cases for where
> it looks like the client does not understand any sort of version
> negotiation. If we see multiple versions listed in the advert, then the
> rest of the selection logic should do the right thing.

OK, let me try to see if I understand correctly by rephrasing.

If the client does not say anything about which version it prefers
(because it only knows about version 0 without even realizing that
there is a version negotiation exchange), we substitute the lack of
proposed versions with string "version=0", and the strcmp()s I saw
and was puzzled by are all about special casing such a client.  But
we would end up behaving the same way (at least when judged only by
externally visible effects) to a client that is aware of version
negotiation and tells us it prefers version 0 (and nothing else)
with the selection logic anyway.

Did I get it right?  If so, yeah, I think it makes sense to avoid
two codepaths that ends up doing the same thing by removing the
special case.

> However, I think that it might work to remove the special cases. In the
> event that the client is so old that it doesn't understand any form of
> version negotiation, it should just ignore the version fields /
> environment vars. If you think it's cleaner to remove the special cases,
> let me know.
