Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC84420281
	for <e@80x24.org>; Thu, 21 Sep 2017 04:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdIUE4D (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:56:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56085 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750795AbdIUE4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:56:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF4129536E;
        Thu, 21 Sep 2017 00:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gJUY/rApTO85/tg3VUey/nPvtx4=; b=FhJ2xZ
        sP44xRMosMnf9NOx/pHBMjiQfBDj6p9bLktc6nNK72iSRVtEM1KKy79Bk7W8rq7s
        13j6EEh9wZF9RgO06j31jO+iRwckrc3fvCH1otuLSZLet7S8U4QDRWBE0NboDYV1
        aIcx4A0gzhbs/xYmPUfKBqBP9FNhiZubl9xeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qAccxsffKd1VYGNlDKKfuPEAzxJOxDCC
        ePAtKe/yp566OeUUYOeBtYQDhSBzahtD3s27TFuUJZK9hMoZBsSbJB6qTr+cXstq
        egovX+WbtaDTymD9ppqcaLD/qSb5uqlaCyge02aPXPG00Fc2qGIp9yBlwkOLLMiv
        ocl+dw+RFrA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D54319536C;
        Thu, 21 Sep 2017 00:56:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C929395368;
        Thu, 21 Sep 2017 00:55:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
Date:   Thu, 21 Sep 2017 13:55:58 +0900
In-Reply-To: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 21 Sep 2017 00:32:15 -0400")
Message-ID: <xmqqbmm4lkf5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2947E584-9E89-11E7-9700-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Johannes, this is an adaptation of your 67e5ce7f63 (status: offer *not*
> to lock the index and update it, 2016-08-12). Folks working on GitHub
> Desktop complained to me that it's only available on Windows. :)
>
> I expanded the scope a bit to let us give the same treatment to more
> commands in the long run.  I'd also be OK with just cherry-picking your
> patch to non-Windows Git if you don't find my reasoning below
> compelling. But I think we need _something_ like this, as the other
> solutions I could come up with don't seem very promising.

The phrase 'optional lock' does not answer this question clearly,
though: does it make sense to extend the coverage of this option in
the future to things more than the "opportunistic update to the
index file"?

If the answer is no, then having 'index' instead of 'lock' in the
name of the option would make more sense (and 'opportunistic' over
'optional', too), because what the change is about is to allow other
processes that are directly interacting with the user to update the
index, and 'lock' being hindrance is merely an implementation
detail.  The comment on the "test" in the log message mentions as if
it were a short-coming that it does not check the lock but checks
if the index is written, but I think that is testing what matters
and preferable than testing "did we lock and then unlock it?"

On the other hand, if the answer is yes, then I am curious what
other things this may extend to, and if these other things are also
opportunistic optimizations.

Other than that, I think this change (including the part that this
is done globally and down to subprocesses as needed) makes sense.

Thanks (and sorry for not being Johannes ;-).


