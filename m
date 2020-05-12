Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211B0C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 22:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C5F20747
	for <git@archiver.kernel.org>; Tue, 12 May 2020 22:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UuO4zth2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgELWOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 18:14:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63007 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgELWOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 18:14:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BA1A4B7A5;
        Tue, 12 May 2020 18:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9SKQ46HQF6tJw/PkxySyro5gQRs=; b=UuO4zt
        h2b6L+t/GaAxUFyqnZ1BpcXcDO1Kziqmm1zvyRyl5K+1CV/U17HxVV6BBI7W5dVX
        QAVHe/WEfCt4KpQlk1+mBxxO4UfgVCgIhlhd74NYkeoUXnIKqtGkrawIL0+SEc3D
        20dCrmZ695GcPAizUZeMe5RR6iX0VzesMF2eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GEKKy+75qmUhSvllvQBPoOHOnVJ4mGjn
        cxM0F8+IlS7H3uoEle/yPO5uE0AVyVzRlioQl0XpIIoDRrUhCVVyZtJvRYvAhKxy
        Xlb5KcYkjUSb5I5RaXKyNNFvtBT0oErahiekvQbLCCB9mwrmMfhc9vDHlV7SLg4l
        Bxo6bXzPD1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53E004B7A4;
        Tue, 12 May 2020 18:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D09524B7A3;
        Tue, 12 May 2020 18:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
References: <20200512214420.36329-1-emilyshaffer@google.com>
Date:   Tue, 12 May 2020 15:14:13 -0700
In-Reply-To: <20200512214420.36329-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Tue, 12 May 2020 14:44:20 -0700")
Message-ID: <xmqqr1voajii.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9A244FC-949D-11EA-88BD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Rather than teaching only one operation, like 'git fetch', how to write
> down throughput to traces, we can learn about a wide range of user
> operations that may seem slow by adding tooling to the progress library
> itself. Operations which display progress are likely to be slow-running
> and the kind of thing we want to monitor for performance anyways. By
> showing object counts and data transfer size, we should be able to
> make some derived measurements to ensure operations are scaling the way
> we expect.

Excellent observation ;-)

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> One note: by putting trace collection into the progress library, we end
> up with data events which have titles like "Receiving objects" - not
> very machine-parseable. An alternative might be to ask for a
> machine-readable title in the progress struct, but I didn't think it was
> worth the code churn.

Perhaps make it an optional member of the struct, and convert only a
selected few callers to set it and see how well it helps, while
leaving all the other callers set NULL to the member to keep showing
not-very-useful titles?

> CI run here, although it failed on the same error Junio noted today[1]:

I think Dscho's latest patch, even though it didn't mention my message,
is to fix that error.  So with that queued in the same batch, we'll
see a full CI coverage again.

Will queue.  Thanks.

