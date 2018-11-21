Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999CF1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 04:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeKUPZK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 10:25:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50309 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKUPZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 10:25:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FDE03255F;
        Tue, 20 Nov 2018 23:52:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MkVoGInbaRdAU0zHymKZWJQiEBA=; b=lYA7mr
        3USmZrH6Q2+t3MLBDYR4wx7W1Go8oiWCZxc7fW+5OOFr8H0ZUiNiviIBabf9eXZN
        IErkKCqZntc8WTGeavGRRrzP4K1WnX99A6kqshb74gpEBCJVE+IVhpe3U8+LcyrT
        OwYM+VWmtzpjBXZ8rrvPm/APZNnBdX4fMLNto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fqpPpXlkjGqVEQaQLjF1Xjy2smln+CKT
        BO3xCkGkMeBGy92x7PlWPDySqxcoP5x9I7CO4hgMgvWcIRAA8lHIDJ22npNVbMi4
        4DR05YbYoimT3qaq0l84fZK5evluOiBJQQniLNLLBZcFs71gmycf0Ct788QzyrY6
        anaixSXteos=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79FD63255E;
        Tue, 20 Nov 2018 23:52:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F5393255A;
        Tue, 20 Nov 2018 23:52:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] pack-objects: fix tree_depth and layer invariants
References: <20181120094451.GA21725@sigill.intra.peff.net>
        <20181120094638.GA22742@sigill.intra.peff.net>
Date:   Wed, 21 Nov 2018 13:52:13 +0900
In-Reply-To: <20181120094638.GA22742@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 20 Nov 2018 04:46:38 -0500")
Message-ID: <xmqqa7m3822q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3799C1F6-ED49-11E8-9DAC-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But in (b), we use the number of stored objects, _not_ the allocated
> size of the objects array. So we can run into a situation like this:
>
>   1. packlist_alloc() needs to store the Nth object, so it grows the
>      objects array to M, where M > N.
>
>   2. oe_set_tree_depth() wants to store a depth, so it allocates an
>      array of length N. Now we've violated our invariant.
>
>   3. packlist_alloc() needs to store the N+1th object. But it _doesn't_
>      grow the objects array, since N <= M still holds. We try to assign
>      to tree_depth[N+1], which is out of bounds.

Ouch.  I see counting and allocationg is hard (I think I spotted a
bug in another area that comes from the same "count while filtering
and then allocate" pattern during this cycle).  Thanks for spotting.

