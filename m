Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 101601FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934448AbcIETKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:10:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57349 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932226AbcIETKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 15:10:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD4F63BBD6;
        Mon,  5 Sep 2016 15:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pBMW9yGqp7EHMKaMw5fv/wZEqgA=; b=jvmeSM
        /yqUJ6NLmWn7IpagXOuZL9eGOhYFVwJM9Er36rajL3whty1uc9TCoWMm5V36CU4D
        3kPnBvrcUvyC4Fqpjl5hnMus0ydXnkjnfZAv/D85AJg9/+tAlcLpN169WVm8lR1w
        2tLXz7NqTINp+GXz3wqu7LNhnryfwfWWgrpdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BpD8ILxBLN5XbKsL1pOm2RX0dCJbqTKT
        LKuucjEQoyCLmHy7+WXy76K6ZfhWrpY4fvTPzNxKvpTyODufPi9Yj971SwN5z1zw
        FmY44zXWfPyzdjIwHCVps4tFfvZDbLchX+4NrpZmL1jWdZjJky3QmTv4sufSTm68
        5i54CnKDADo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5C883BBD5;
        Mon,  5 Sep 2016 15:10:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 552C63BBD4;
        Mon,  5 Sep 2016 15:10:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on mmap()ed data
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
Date:   Mon, 05 Sep 2016 12:10:11 -0700
In-Reply-To: <cover.1473090278.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Mon, 5 Sep 2016 17:44:57 +0200 (CEST)")
Message-ID: <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F60A124-739C-11E6-9D8C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series addresses a problem where `git diff` is called using
> `-G` or `-S --pickaxe-regex` on new-born files that are configured
> without user diff drivers, and that hence get mmap()ed into memory.

Good spotting.  This has been with us almost forever; I do not think
the original pickaxe had it, but I am sure it is broken after the
"--pickaxe-regex" enhancement.

I am somehow surprised that this is a problem on Windows, though.
Wouldn't we be at least running CRLF conversions, and causing diff
or grep machinery to work on a NUL-terminated buffer?  The convesion
code would have to look at mmap'ed memory but I do not think it
assumes NUL-termination.  Perhaps people on Windows do not usually
use straight-through and that is why this was discovered after many
years, or something?  In any case, that is a digression.

> Windows (the bug does not trigger a segmentation fault for me on Linux,
> strangely enough, but it is really a problem on Windows).

I think it is an issue on all platforms that lets us use mmap().
When the size of a file is multiple of pagesize, the byte past the
end of the file can very well fall on an unmapped address.

> So at least I have a workaround in place. Ideally, though, we would
> NUL-terminate the buffers only when needed, or somehow call regexec() on
> ptr/size parameters instead of passing a supposedly NUL-terminated
> string to it?

I see two reasonable approaches.

 * We may want to revisit the performance numbers to see if using
   mmap() to read from the working tree files still buys us much.
   If not, we should stop borrowing from the working tree using
   mmap(); instead just slurp in and NUL-terminate it.

 * We could use <ptr,len> variant of regexp engine as you proposed,
   which I think is a preferrable solution.  Do people know of a
   widely accepted implementation that we can throw into compat/ as
   fallback that is compatible with GPLv2?

