Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C99A1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757434AbcIGSkC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:40:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54187 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755188AbcIGSkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:40:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8BAD3C3C4;
        Wed,  7 Sep 2016 14:39:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EVvnw/WAKylkuaLhdh2uFozFeeA=; b=g1R4hc
        UnW2d0ReExKbNofsXlT+nDq+T2mjfCW+IbHHBJrWijag/CmmF/F+yY9qTXBKbSuI
        sgHeHfiaNU5PEG2zlPhGMK/tYP4sJNBoZPua6EwxxvFjuOl5FHQV+wYgecBVTXK4
        dbB1+MobmjiEfsQmZf+lhWdcYt5GyliHm3xwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ITrOUi+2tAQMK/xtKHX6DSgGU7G7KOEw
        6OFq7mXT7uuVrXkqXmQMcVJRNl69ndHGsvDeyFXFimqpvCWL+zYo1gglfPdbGDei
        ml+f0AihSSCVTbmWqnvGmOQI+pBEmJNxx4UH8Pr0d9561cLwe5QUmo8UaSQR/n2r
        sc3jl/q0ryU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C00F33C3C3;
        Wed,  7 Sep 2016 14:39:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4937D3C3C2;
        Wed,  7 Sep 2016 14:39:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash directory
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
        <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net>
Date:   Wed, 07 Sep 2016 11:39:57 -0700
In-Reply-To: <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Sep 2016 03:27:07 -0400")
Message-ID: <xmqq4m5rmu4i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AF1F69C-752A-11E6-9124-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 05, 2016 at 09:03:48PM +0200, Johannes Sixt wrote:
>
>> The process spawned in the hook uses the test's trash directory as CWD.
>> As long as it is alive, the directory cannot be removed on Windows.
>> Although the test succeeds, the 'test_done' that follows produces an
>> error message and leaves the trash directory around. Insert a delay to
>> give the hook time to go away.
>
> Ugh. I'd love it if we could avoid inserting a sleep, which wastes time
> in the optimistic case and is insufficient in the pessimistic one.
>
> The fact that the hook is already using sleep is even nastier, as it
> that's a potential race on a loaded system.
>
> Can we do some signaling with fifos to tell the hook when it is safe to
> exit? Then we would just need to `wait` for its parent process.

Is fifo safe on Windows, though?

With v2 that explicitly kills, I guess we can make the sleep longer
without slowing down in the optimistic case?
