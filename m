Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC091FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 19:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbcHWT3v (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 15:29:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57777 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753204AbcHWT31 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 15:29:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DD23373F7;
        Tue, 23 Aug 2016 15:29:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aAKou8MNoxdRBL3mBFbBFz3jcvE=; b=vZ0o1o
        MRnz2zJZR55Qxzuz/LQwAY0MHwitecM7ge5VEIUGefbTkkULHWq6qaMzGKvq2aKd
        yebAh9NCz0ayb0MyRJR+rjhYmeTWCb27cKQNTlCVrvrx7bzfzJ9fw4ZB4fTbQ81I
        lzKwtupwHJvoDbLU0+6QTy9TVg8ANnR4tmOvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=txchcpGkmIn0WU8GBLGmbj0kXCAHRxNT
        n0ESJ1HEAxVwvDy6sgo0jD+zCn7AisPiw1eyLI6B94LhzCY0qnmNMUeHOKDTUR/S
        75Ao98VFPa5p/PJj0CRFE1k70bgRI3VCM2EBIb+QDs/hM83M417q+VVw8nwiQZQo
        Il2U5K2zAJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 364ED373F6;
        Tue, 23 Aug 2016 15:29:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACE8D373F5;
        Tue, 23 Aug 2016 15:29:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joshua Phillips <jphillips@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: Possible bug: git pull --rebase discards local commits
References: <1471969497.3553135.703756633.0F6CCC4C@webmail.messagingengine.com>
Date:   Tue, 23 Aug 2016 12:28:59 -0700
In-Reply-To: <1471969497.3553135.703756633.0F6CCC4C@webmail.messagingengine.com>
        (Joshua Phillips's message of "Tue, 23 Aug 2016 16:24:57 +0000")
Message-ID: <xmqqvayruvwk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D88F20B4-6967-11E6-8AD5-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Phillips <jphillips@imap.cc> writes:

> I've found a case where git pull --rebase discards commits in my branch
> if the remote-tracking branch was rewound (and the remote tracking
> branch's reflog contains my branch's latest commit). This is due to
> git-pull's usage of git merge-base --fork-point.
>
> On one hand, this behaviour might be correct since the remote repository
> essentially removed that commit from master by 'reset --hard'. On the
> other hand, I was surprised that git pull --rebase discarded a commit in
> my branch.

Yup, that sounds like a bad way to handle the situation.  After all,
the upstream may have first accepted your first attempt, and then
decided that it was premature and rewound it, expecting you to give
an improved reroll.  But I also agree with you that it may be
correct to drop it because the upstream already rejected it.

Since Git cannot tell between these two cases, we should play safer
than what the current code does, I would think.

