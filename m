Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC8C3524A
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC3B24658
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aAnmdI6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgA0SPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:15:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62035 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0SPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 13:15:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45646A628A;
        Mon, 27 Jan 2020 13:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CPg8kkL33LVo2RrGsjDcu4PaexU=; b=aAnmdI
        6mk34r5dmRUdDaqqhSZNZf5Zmz2J5QkHFiqw/yHv6TXmSoS7U2no5+ToXF0ompxF
        WkRETNXOjjrOCNv/Aq26Qc4i+f2SVs0Ti0A59YpZZVsqlS63I6bnZsfPd4Qexfqp
        dhsG2BWl1FNb61Vdey/71PTlJSMeQwVGam5GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ohlvjJMpIMkDFbkb+CRuOzGBM9ZHzCU5
        uRHSWYJQnSVJaHDD6qQFAun6TB1z5f1PNgCWlQl55ulKIsTzoh5VYPUvPI5zSz2O
        DYLrS87+QeqnIsqqTSyFAWaWLDstHAr30hk5QycSjDufNK5cFWraGQb7aBWJVuBD
        6csSU7aMqPc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E782A6289;
        Mon, 27 Jan 2020 13:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6780BA6287;
        Mon, 27 Jan 2020 13:15:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
Subject: Re: [PATCH v4 1/2] t7400: add a testcase for submodule status on empty dirs
References: <xmqq7e1g3ggd.fsf@gitster-ct.c.googlers.com>
        <1580115989-32649-1-git-send-email-peter.kaestle@nokia.com>
Date:   Mon, 27 Jan 2020 10:15:40 -0800
In-Reply-To: <1580115989-32649-1-git-send-email-peter.kaestle@nokia.com>
        (Peter Kaestle's message of "Mon, 27 Jan 2020 10:06:28 +0100")
Message-ID: <xmqqzhe8bwab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0790F9B0-4131-11EA-9EDD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Kaestle <peter.kaestle@nokia.com> writes:

> We have test coverage for "git submodule status" output in
> various cases, i.e.
>
>   1) not-init, not-cloned: status should initially be "missing"
>   2) init, not-cloned: status should be "missing"
>   3) not-init, cloned:
>   4) init, cloned:'status should be "up-to-date" after update
>   4.1) + modified: status should be "modified" after submodule commit
>   4.2) + modified, committed: status should be "up-to-date" after update
>
> Case 2) will be covered by this patch.  Case 3) remains uncovered.
>
> Test that submodule status reports initialized but not cloned
> submodules as missing to fill the gap in test coverage.

Thanks for an update.
