Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CAC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C729206D5
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hJaCxszO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFTFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:05:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55303 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFTFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 14:05:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D423B20DE;
        Fri,  6 Mar 2020 14:05:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oS2UDVMWWO5SZ7xsD0+lIbcO0oA=; b=hJaCxs
        zOgJdbuoXVUKaRhMHpobip8gHK0lf+y3F2Z1Y5FYnv/kkKVpuynKtr/nOOXf2qKd
        kQ/YCu9rkchgRJMJ5y/8dN/R4DCPpRpGqAeuOKc3Yt9OfOV3cbh2LnkbC32cGM01
        6k/SnhmIEQ/yl/WH/dMp2O6c80VPpJRXnQue4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SkJ8zQC4dy5a8i+xN/YvPCoEQqVwt0tU
        e6djZoUeS+UAT2R/JWE5bjim49HwgMz4xL7BrW+Hm5T0SdgJrf0iFr4CqsEUQaYZ
        2ml8zqt/XTyiaaOYAqghedvLRNPVpgCsDSJFVBoKryjqJlzPO8w8CqO0cbyOPH06
        71Bp7xpIaOs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8580BB20DD;
        Fri,  6 Mar 2020 14:05:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB077B20DC;
        Fri,  6 Mar 2020 14:05:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 02/10] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
References: <20200226101429.81327-1-mirucam@gmail.com>
        <20200226101429.81327-3-mirucam@gmail.com>
        <xmqqzhd5i1na.fsf@gitster-ct.c.googlers.com>
        <CAN7CjDDwgR=y8gyYmDzmuTW3AKvb1N=EdCtH-8Tr7T=b6cG5gQ@mail.gmail.com>
        <xmqqwo88f0do.fsf@gitster-ct.c.googlers.com>
        <CAN7CjDCb3Bo-reyCZBxMuxX7ecCRLo6XaZHUE5fKGnQav9g_xQ@mail.gmail.com>
Date:   Fri, 06 Mar 2020 11:05:13 -0800
In-Reply-To: <CAN7CjDCb3Bo-reyCZBxMuxX7ecCRLo6XaZHUE5fKGnQav9g_xQ@mail.gmail.com>
        (Miriam R.'s message of "Fri, 6 Mar 2020 19:19:09 +0100")
Message-ID: <xmqqimjh2tjq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69E3A1BA-5FDD-11EA-AB4F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

> To my understanding, it looks like calling reset_revision_walk() after
> the while() loop should be enough. Am I right or am I missing
> something?

I suspect that reset_revision_walk() may be too-big a hammer, as it
clears everything, regardless of the reason why the flag bits were
set.  On the other hand, the clearly strategy that uses
clear_commit_marks() is to clear only the flag bits that were set
during the previous revision walk from only the commits that were
walked during the previous revision walk.

I offhand do not know what flag bits on what objects that were not
involved in the previous revision walk are still necessary at the
point of the call made by the caller (that's a question for your
mentors who volunteered their expertise on the program in question),
so if there isn't any, reset_revision_walk() may be an easy way out.
I just do not know if it clears too much to break the code that
comes after the function returns.

Thanks.
