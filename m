Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F06920281
	for <e@80x24.org>; Thu, 21 Sep 2017 01:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdIUBcE (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:32:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61659 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751189AbdIUBcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:32:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 434E9A67E3;
        Wed, 20 Sep 2017 21:31:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6JvXUvmbsLOkExB3aJUjsNhDJWw=; b=LfKm5g
        h16kWKcmntuvgxhINUw07cpJmzzyIw+BkZWLGVDCphRAi95OfXimMeJ5iJkwJSxW
        4OALZ5MIjQpsb/QsuSPSDLmUu3oDXJIGsCWSy2nL/N0kvcSJDCn+x1lW5fnABqLS
        DC1Er2QYa33C1CqykPDVsie8l8On0PLmlJFOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G4JjDyTqQABQe972FYEk+mpe4SpsAiov
        HUtfC6OOYZ7KgUrTyx07uAEpXCv+LuZ1A6w7fY64xjz1SbMK6mOBtCIsYS7Nrgy9
        P9A1KDDpEoPT/OQKmWOLchJ/Dhs+2PJP2nWdiK7IUBrr5EUhAfxE1FC7f6W3K7S/
        53bGlVt5dHU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BF0AA67E2;
        Wed, 20 Sep 2017 21:31:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A06A3A67E1;
        Wed, 20 Sep 2017 21:31:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] builtin/checkout: avoid usage of '!!'
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
        <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
        <20170919071525.9404-2-kaarticsivaraam91196@gmail.com>
        <xmqq8thaow8f.fsf@gitster.mtv.corp.google.com>
        <e07a613e-8b69-e382-777b-b5797270ecaf@gmail.com>
        <fbe3d3e2-a14c-fe7c-7e5d-c24789b249ca@gmail.com>
Date:   Thu, 21 Sep 2017 10:31:56 +0900
In-Reply-To: <fbe3d3e2-a14c-fe7c-7e5d-c24789b249ca@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 20 Sep 2017 16:56:48 +0530")
Message-ID: <xmqqlgl8n8fn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A861B63C-9E6C-11E7-B57F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Wait, I missed a contradiction here.
> ..
> Documentation/SubmittingPatches says:
>
>>  - Some clever tricks, like using the !! operator with arithmetic
>>    constructs, can be extremely confusing to others.

What does "with arithmetic constructs" mean?  Would it refer to
things like

	!!i != !!(j + 3)

that unnecessarily obfuscates what is going on?

The primary reason why !!ptr is good in the code that this patch
touches is because what is doubly negated is a pointer, not an
integer or other things.  The called function does *not* limit its
input to 0 or 1 (it wants 0 for false and everything else for true),
so we wouldn't be doing !!i if what we are passing is already an
integer.  But we cannot just pass a pointer to such a parameter
without getting the compiler upset.


