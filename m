Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F7C33CA2
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2EE20692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 20:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CqSc9PT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgAHUfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:35:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50146 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHUfe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 15:35:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95A8237FB2;
        Wed,  8 Jan 2020 15:35:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=froPqR+jd6jwLiZx2yM7L+qxXs8=; b=CqSc9P
        T7CbGk9+naPrgCsh+M3my/ZhguI2urfzVbnJwtPxayap1P6HCkVhwHiUH4+DuakB
        CrjwTwX5ZNyT7tvZpwCdT5v//BuIs0zV6zGTFlx13axnYojETFNlei5O1cOR9ycZ
        klDUUZCDV+T2fSECKVulwtBmqxdiR8hLqQa+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CwPsgFnQidiYzrc3aNQEpCPetrMnHouV
        DVGWq9qHw3hOwYzfilmCT0keh0iXS3khZFttZhEhdfDKkr8jjbvQ20/tdTcncxZQ
        Ndp+8pFiTL7ZCsMI149ljDWUdXRl1lTr9AE3mHPfYvqaFbjm3fjYm8pvzjrXPKGo
        /NDOrkRGyN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D03437FB0;
        Wed,  8 Jan 2020 15:35:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E79A437FAF;
        Wed,  8 Jan 2020 15:35:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH] unpack-trees: watch for out-of-range index position
References: <20200108023127.219429-1-emilyshaffer@google.com>
        <20200108071525.GB1675456@coredump.intra.peff.net>
        <xmqqeew93lfn.fsf@gitster-ct.c.googlers.com>
        <20200108193833.GD181522@google.com>
Date:   Wed, 08 Jan 2020 12:35:29 -0800
In-Reply-To: <20200108193833.GD181522@google.com> (Emily Shaffer's message of
        "Wed, 8 Jan 2020 11:38:33 -0800")
Message-ID: <xmqqo8vd1yb2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A44E1C8-3256-11EA-A7FF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > The new condition you added looks correct to me. I suspect this BUG()
>> > should not be a BUG() at all, though. It's not necessarily a logic error
>> > inside Git, but as you showed it could indicate corrupt data we read
>> > from disk. The true is probably same of the "pos >= 0" condition checked
>> > above.
>> 
>> It does not sound like a BUG to me, either, but the new condition
>> does look correct to me, too.  We can turn it into die() later if
>> somebody truly cares ;-)
>> 
>> Thanks, both.  Will queue.
>
> Thanks much for the quick turnaround. If I hear more noise I'll give it
> a try with die() or error code instead, but for now I'll move on to the
> next bug on my list. :)

By the way, it is somewhat sad that we proceeded that far in the
first place---such a corrupt on-disk index would have caused an
early die() if we did not get rid of the trailing-hash integrity
check.
