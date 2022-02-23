Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87428C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbiBWXSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiBWXSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:18:49 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8AF3879B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:18:20 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3287179C3A;
        Wed, 23 Feb 2022 18:18:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9aG5Lmvh76tptTSTLi9cJ8r20i8ARg6YXS7jPc
        18J6k=; b=mBVCAfh9ZWfPjUtPWWd4eUneoEdMGAE7Rq2GjBjJ4KrYynUSDbcqfG
        VFg1bwnVsm2imx68Lxd+MvWC4whyKkjsFzCxz3QHnqiehluLHR1YNEKGe2V4wHhu
        QO+skdgdFKwlBjLM/hBfGibsiAiyp5YSqPqw7JBLx6CA66LsyjcHM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CDF3179C39;
        Wed, 23 Feb 2022 18:18:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11CFA179C38;
        Wed, 23 Feb 2022 18:18:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: fast-import, ftruncate, and file mode
References: <CABPp-BERVCynOVvBq0QL49Ah+gy3W2snUVWBHfzXaVpXX3Dpyg@mail.gmail.com>
        <3bdff4ba-fb5f-e369-306d-5510ab20893a@gmail.com>
        <CABPp-BF_ygATPVGfSR24URm5ZTHBJwJd0miMtgMgNWfw_o33Nw@mail.gmail.com>
Date:   Wed, 23 Feb 2022 15:18:17 -0800
In-Reply-To: <CABPp-BF_ygATPVGfSR24URm5ZTHBJwJd0miMtgMgNWfw_o33Nw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 23 Feb 2022 07:33:29 -0800")
Message-ID: <xmqqo82xp3ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E24C1684-94FE-11EC-A134-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Am I missing something or is this really a file system bug? Surely if we
>> have opened a file for writing the file permissions when we call
>> ftruncate() should be irrelevant?
>> ...
> Oh, indeed, looks like I can't read late at night.  Sorry for the noise.

Was wondering the same thing.

We open for writing, write one object at a time and when we realize
we do not have to, we rewind that stream we are writing into using
ftruncate().  It would be a serious problem if we cannot do that.
