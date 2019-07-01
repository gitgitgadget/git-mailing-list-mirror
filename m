Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111B21F461
	for <e@80x24.org>; Mon,  1 Jul 2019 18:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfGASf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 14:35:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64654 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGASfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 14:35:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4DA06C991;
        Mon,  1 Jul 2019 14:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SAi6deg/TiDv/ds5WmIOfDd+7DQ=; b=T9jWK2
        67f86Un3iSM8uji/gWCFIpn/ACRsNwAUpv7GHuZTYO1cZPRqKVhPIoD5aXEdVWY1
        XB9vplQzcLB0rRRUZTEk/mp/NtNY0RDmfysEEX95c2WbJNYLJ3LNzVAhBPc7lY8U
        ZkoNwO/dxTROuns522/TsOV/kPFGKGFitPlDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vVxwMx8LfUSawbFkLHtELXDU+lm5gpwV
        bYYz8jvT3W2/pG+ELj4h96dKXBB8n8qbUKp1QeF5Q71SZWp6WshcL7mHMEgUF4cb
        h5dIyH3XjVj1s7uubLvHUMbT9RJhMMXFPrK1ou6ZfFRKxqAJTNjZoTP9eMUv348y
        zCBc2hWDVf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC7776C990;
        Mon,  1 Jul 2019 14:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E73CC6C98B;
        Mon,  1 Jul 2019 14:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
References: <20190630051816.8814-1-eantoranz@gmail.com>
        <20190630065358.GB31264@sigill.intra.peff.net>
Date:   Mon, 01 Jul 2019 11:35:15 -0700
In-Reply-To: <20190630065358.GB31264@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 30 Jun 2019 02:53:59 -0400")
Message-ID: <xmqq36jp7gd8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F97C6320-9C2E-11E9-AE9C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> First, we create a (temporary) merge commit of both branches (M3)
>> 
>> ------------
>> 	R1---R2---R3---R4---R5---R6---R7---M3
>> 	 \         \              \       /
>> 	  F1---F2---M1---F3---F4---M2---F5
>> ------------
>> 
>> At this point, all differences between M3 and R7 are the changes related to the
>> feature branch, so we can run git reset --soft from M3 to R7 to put all those
>> differeces in index, and then we create single revision that is both
>> squashed/rebased for our feature branch.
>
> So if I understand correctly, our goal is:
>
>   R1--R2--...--R7--R8
>
> where R8 has the same tree as M3?
>
> Wouldn't doing "git merge --squash" do the same thing?

Yup, from Edmundo's description, I agree that they are equivalent,
modulo the merge direction.

That affects two things, though.  Who becomes the first parent is
obviously swapped, but equally importantly, the merge conflicts are
presented as if you are merging from the upstream, taking assortment
of random changes into a stale codebase with slight modification.
Swapping the direction would present the merge much better in that
it let you pretend as if you started from the up-to-date upstream
and replayed your own changes in the topic, and because you are by
definition more familiar with your own changes, during conflict
resolution, you would understand the output from "git diff HEAD"
much better than the case where you merge upstream into your topic.

But "rebase the feature branch on updated upstream and then merge
the result, optionally squashing all of them into one big ball of
wax" *could* be a lot more useful feature, serving as poor-man's
imitation of "git imerge", *but* only if the final squashing is made
optional (that at the same time means that sometimes the M3 merge
can be unmanageably messy and stepwise rebase may make it
manageable).  

If M3 merge is always easier to manage than incremental stepwise
rebase of the topic, then doing the "git merge --reverse-squash"
would be a saner interface and also conceptually simpler.

