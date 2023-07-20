Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF6EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 19:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGTT0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGTT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 15:26:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34196171D
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 12:26:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3163B1A033B;
        Thu, 20 Jul 2023 15:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=RzqY9NO+H1TN7aVKbUdw93PahlUsiJW9dHjdhvvclEc=; b=hkiI
        9IPdI3NZEQYSb9UFtYz4fASiw13Kcp7hFtpoJoYpwl0ZcOErJdAtTKRky6XPJXpp
        6O+qy08uj14itFGyXAShjNUcEYvT9AvRR/pki9JPJ0Dy/yJ+bhGAJdaVUDndtD9U
        SAKy71fomG4sBb3KRkm1xocMDA2Qmr0+syxzeaU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26EB21A033A;
        Thu, 20 Jul 2023 15:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86FB41A0338;
        Thu, 20 Jul 2023 15:26:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Calvin Wan <calvinwan@google.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 2/2] wrapper: use trace2 counters to collect fsync stats
References: <20230720164823.625815-1-dev+git@drbeat.li>
Date:   Thu, 20 Jul 2023 12:26:44 -0700
Message-ID: <xmqq5y6e2xl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D36E19A-2733-11EE-A50B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> As mentioned in the thread starting at [1], trace2 counters should be
> used to count events instead of ad-hoc static variables.
>
> Convert the two fsync static variables to trace2 counters, reducing the
> coupling between wrapper.c and the trace2 subsystem. Adjust t/t5351 to
> match the trace2 counter output format.
>
> The counters are not per-thread because the ones being replaced also
> were not.
>
> [1] https://lore.kernel.org/git/20230627195251.1973421-2-calvinwan@google.com/
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> v2:
> - Adjust t/t5351
> - Update commit message

I also spotted this change since v1:

- Rename trace2 counters to use "-" (not "_") as inter-word separators.

Since I do not seem to be able to find any review comments regarding
the variable naming in the v1's thread, let's ask stakeholders.

Are folks involved in the trace2 subsystem (especially Jeff
Hostetler---already CC:ed---who presumably has the most stake in it)
OK with the naming convention of the multi-word variable?  This is
the first use of multi-word variable name in tr2_ctr, and thus will
establish whatever convention you guys want to use.  I do have a
slight preference of "writeout-only" over "writeout_only" but that
is purely from visual appearance.  If there is a desire to keep the
names literally reusable as identifiers in some languages used to
postprocess trace output, or something, that might weigh
differently.

>  t/t5351-unpack-large-objects.sh |  6 +++---
>  trace2.c                        |  1 -
>  trace2.h                        |  4 ++++
>  trace2/tr2_ctr.c                | 10 ++++++++++
>  wrapper.c                       | 19 ++-----------------
>  wrapper.h                       |  5 -----
>  6 files changed, 19 insertions(+), 26 deletions(-)

Very nice to see clean-up patch that reduces the amount of code.
Nicely done.

Thanks, will queue.  If folks do not find issues in a few days,
let's merge it to 'next'.
