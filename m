Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CCEC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 20:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BEE20661
	for <git@archiver.kernel.org>; Tue,  5 May 2020 20:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WoPPDApi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgEEUaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 16:30:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53870 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEEUaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 16:30:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F15CBD835;
        Tue,  5 May 2020 16:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F/VPTn1K5LBBFYxnP92AKymtMxQ=; b=WoPPDA
        pi7ck0Om/MHQPtmXhWNIl8K9seZSSu6QatCPavwOksHqHI474Q6yN9XWMvnk2vJP
        34xFqMB0LoSavhky6YQCMDgx701Q+An7tYVFiI7moXS9ragpDeqeNi1evNY7413e
        ik6pLcHo3Hf541gi080pu48aOb3nUOwq5apq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wj6yeOrs5pjkdYW/Zt98jNS0dxhEunsq
        6mQrSBsoTbI4RzADUv7RSEogyHz33sJ79yuRdGXUqp2A53MmTscf4jFuPdblVOCN
        Rvv5AiVVYZ1ui4uhlVUDPhqIWPmgX8tXB6eC8q0fAjvpp4A+Tx0TPKjs8azPn4Jw
        8IL8p5u9vNM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36363BD834;
        Tue,  5 May 2020 16:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 523EFBD833;
        Tue,  5 May 2020 16:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
        <20200504213326.GA31037@coredump.intra.peff.net>
        <20200504220916.GF45250@syl.local>
Date:   Tue, 05 May 2020 13:30:04 -0700
In-Reply-To: <20200504220916.GF45250@syl.local> (Taylor Blau's message of
        "Mon, 4 May 2020 16:09:16 -0600")
Message-ID: <xmqqv9la9lbn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34EE5322-8F0F-11EA-8FCD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > +				/*
>> > +				 * i2 refers to a fixup commit in the middle of
>> > +				 * a fixup chain
>> > +				 */
>> > +				next[i] = next[i2];
>> > +				next[i2] = i;
>> > +				continue;
>> > +			}
>>
>> I do have one question, though. What happens if we add a second
>> fixup-of-a-fixup?
>
> Thanks for asking this question, I was a little curious about it, too.

Interesting that three people looked at the same patch and asked the
same question in different ways ;-)

