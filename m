Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15251FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbcHWVfx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:35:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58676 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755425AbcHWVfw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C488B369D4;
        Tue, 23 Aug 2016 17:35:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PU5krUF8s90vwhFN8VKH2xp0/bM=; b=ML2esT
        AnlHsD9SCXnxjp99m+5H6n6zuyf0CKiZ+9PCsva9FVXLF6jmvxnQNNYJt+93rl7O
        sIlaFIgI0phsaxReEfXTaUYt0Zmb1cq8gobz0q317lGeJuM7rgvLmkZ1vookuO7p
        SoyUK9QKtsfQ8FrL+3IOb07o3A0Ro7UDue4Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tKe7zjM6B+UJlwxUn9OM7dVRGqWPWvl5
        AKDSGRFTxJMupEBhn4KDvEK3FcNu85DfkTZVcZxozl1gdDCqcLBR1L9DetH7AZnL
        /MeSNtKTpi+ciD3LFnj0jBByNx7I9rhPKI1ZgklTJ5/zPpXzh7fK0vNaQur7PJCQ
        Wk8kG6V8BHc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA615369D3;
        Tue, 23 Aug 2016 17:35:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39171369D2;
        Tue, 23 Aug 2016 17:35:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 5/7] xdl_change_compact(): introduce the concept of a change group
References: <cover.1471864378.git.mhagger@alum.mit.edu>
        <21ade4ab233a868cabbe15598cd7b2ff4d04d286.1471864378.git.mhagger@alum.mit.edu>
Date:   Tue, 23 Aug 2016 14:35:21 -0700
In-Reply-To: <21ade4ab233a868cabbe15598cd7b2ff4d04d286.1471864378.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Mon, 22 Aug 2016 13:22:44 +0200")
Message-ID: <xmqqeg5fuq1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F8130C2-6979-11E6-A117-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The idea of xdl_change_compact() is fairly simple:
>
> * Proceed through groups of changed lines in the file to be compacted,
>   keeping track of the corresponding location in the "other" file.
>
> * If possible, slide the group up and down to try to give the most
>   aesthetically pleasing diff. Whenever it is slid, the current location
>   in the other file needs to be adjusted.
>
> But these simple concepts are obfuscated by a lot of index handling that
> is written in terse, subtle, and varied patterns. I found it very hard
> to convince myself that the function was correct.
>
> So introduce a "struct group" that represents a group of changed lines
> in a file. Add some functions that perform elementary operations on
> groups:
>
> * Initialize a group to the first group in a file
> * Move to the next or previous group in a file
> * Slide a group up or down
>
> Even though the resulting code is longer, I think it is easier to
> understand and review.

Yup.  The important thing is that the length of the core logic of
sliding up and down becomes easier to read, because it shrinks; the
mechanics of sliding up and down may need more lines with boilderplate,
but they are isolated "do one thing and do it well" helpers.

Nice.


