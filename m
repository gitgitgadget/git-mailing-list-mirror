Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E46BC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378323AbiFPUUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378316AbiFPUUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:20:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCAC5B3F9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:20:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A012C12A8E7;
        Thu, 16 Jun 2022 16:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jo312b+1lHhAFJp1KGpameP4WJWXje5tOfMVUJ
        l9Qqs=; b=AKEWHa5k5FfJyB90EMlPGPHj7iKaLr6ftwDfivTxGRxaRlftt+vrMO
        OZ6ZF8oCRGjmIzD5J3VcPR+h75fOatVDiu2jiBniUc8urt1KK6vwTjPedWsTIj1+
        t8k7R84SBKo9qmtyS+PhPLCkDybP80CdvaaSG0fyM9I2v7vdkBa1U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9796D12A8E5;
        Thu, 16 Jun 2022 16:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E9B112A8E4;
        Thu, 16 Jun 2022 16:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] mingw: avoid accessing uninitialized memory in
 `is_executable()`
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <679ea7421f73ce41515aca549982233f88bcefef.1655336146.git.gitgitgadget@gmail.com>
        <98ff788a-d621-cf3f-aed5-66ae763b381f@web.de>
        <xmqqmtecs6ws.fsf@gitster.g>
Date:   Thu, 16 Jun 2022 13:20:39 -0700
In-Reply-To: <xmqqmtecs6ws.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        16 Jun 2022 13:13:55 -0700")
Message-ID: <xmqqilp0s6lk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAE730EE-EDB1-11EC-A64E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Hmm, but buf _is_ initialized fully?  Line 149:
>>
>>         char buf[3] = { 0 };
>
> Ahh, yeah, that changes the landscape quite a bit.

Just for reference, this piece of code has been correct ever since
it was introduced to help.c by cc3b7a97 (Windows: Make 'git help -a'
work., 2008-01-14).  With a larger context, we can see buf[3] that
is NUL filled, which receives 2 bytes by read(), and strcmp() does
look semantically more correct than memcmp(), even though there
probably shouldn't be any correctness or performance difference.

So, strcmp -> memcmp in this case is a strict dis-improvement.  I
merged it already to 'next', but I haven't pushed the result out, so
I'll redo 'next' before I push the result out.

Thanks.

