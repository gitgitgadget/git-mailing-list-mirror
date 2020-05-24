Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35686C433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1133620776
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lt1LYtIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgEXQIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 12:08:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63367 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgEXQIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 12:08:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C1E3D8A19;
        Sun, 24 May 2020 12:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CtpzyuHVL7ejCkIARgQ59eb6ztw=; b=Lt1LYt
        Ixx0tsfxLWDD0pVGI6eIcfk8QITrMjW4jIr8sA7I7kIDiELRtTgfol76lJyrNYUW
        8YS4K2dWDfS0Af7S1yEDXFp9JPa4wH/XClK3PXGCXflx32np3ApuEvx7O9Byyk/2
        5s7Lgu4QK/nha4E/flcxzG3RsjHRl4TfnjRCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XRSBrqzPzMJkp+Jd0CUg+F0IMZmQtT2G
        8Ktdhc9L9xKcb/rYkRylZRpSOoA3Ybrk90+geomhyFpz2mxbBeMTdYu3phuSzPd2
        tPayTAwAwAFW4GOduz09fBZW/+PvomQFz+2FQTK2AlyaHtfNQdrUP74r3DTLtQX/
        1GwE8Y5/WX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71F5AD8A18;
        Sun, 24 May 2020 12:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B6342D8A17;
        Sun, 24 May 2020 12:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, congdanhqx@gmail.com,
        sunshine@sunshineco.com, liu.denton@gmail.com
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell to C
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
        <xmqqk115ruux.fsf@gitster.c.googlers.com>
        <20200521190329.GB615266@generichostname>
        <xmqqftbtrrt6.fsf@gitster.c.googlers.com>
        <20200522193907.GA4780@konoha>
Date:   Sun, 24 May 2020 09:07:56 -0700
In-Reply-To: <20200522193907.GA4780@konoha> (Shourya Shukla's message of "Sat,
        23 May 2020 01:09:07 +0530")
Message-ID: <xmqqmu5xqpsz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBCF34EC-9DD8-11EA-B1AA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> On 21/05 12:50, Junio C Hamano wrote:
>> OK, so "we accept -q for uniformity across subcommands, but there is
>> nothing to make less verbose in this subcommand" is the answer to my
>> question.
>> 
>> That cannot be read from "... is currently not used"; especially
>> with "currently", I expect that most readers would expect we would
>> start using it in the (near) future, and some other readers would
>> guess that something used to be talkative and we squelched it using
>> the option but there no longer is such need because that something
>> is now quiet by default and there is no option to make it talkative.
>
> What do you think should be the most apt comment here?

"we accept -q for uniformity across subcommands, but there is nothing
to make less verbose in this subcommand", perhaps?

> Also, the rest of the code is fine right?

I didn't spot anything bad worth pointing out when I sent the review
message, but that does not necessarily mean the code is "fine" ;-) 

I see you have v4 sent out already, which probably has more
improvements based on others' input.  Thanks for working on this
topic.

