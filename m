Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9DAC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbiAFTkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:40:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53428 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiAFTkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:40:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CABF9164680;
        Thu,  6 Jan 2022 14:40:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a8XYemEa9CPsetcZS+ks9b9Dksthdat9EXx0BA
        fevG0=; b=CuA+Rova/+dNCm0wsSuwjVXzWWk5SVOjCrN+I13MUWzgHHFrEtpYyH
        suOvFirHrFCYdOW/167tYZCwFO7iJlulDajrRxP7ACepl+JmXFLc89GjS38lLgzl
        uxUVxaosfV5HdkIoHVW7GP+/KsH0sUCgAHWIudWrPOWhFnsM4N3P4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C334816467F;
        Thu,  6 Jan 2022 14:40:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3659116467E;
        Thu,  6 Jan 2022 14:40:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5] receive-pack.c: consolidate find header logic
References: <pull.1125.v4.git.git.1641396098056.gitgitgadget@gmail.com>
        <pull.1125.v5.git.git.1641430309837.gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 11:40:16 -0800
In-Reply-To: <pull.1125.v5.git.git.1641430309837.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 06 Jan 2022 00:51:49 +0000")
Message-ID: <xmqqmtk8d55r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79ACAA18-6F28-11EC-AEA2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      ++	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
>      ++	 * given by len. However, current callers are safe because they compute
>      ++	 * len by scanning a NUL-terminated block of memory starting at msg.

OK.  Because the caller didn't die with SIGBUS owhen they scanned
the memory to figure out len, we know scanning between msg[0] and
msg[len] is safe.

>      ++	 * Make this function safer by checking if the input is NUL-terminated
>      ++	 * or has a NL between line[0] and msg[len].

This comment however feels wrong.  The function is _safe_ if the
input is NUL-terminated already.  And it is very expected that the
msg[] has LF between msg[0] and msg[len]---after all that is why we
use strchrnul() to scan it.

Perhaps replace it with something like "But nevertheless it would be
better to make sure the function does not look at msg beyond len
that was provided by the caller", perhaps?

The most problematic case happens when msg points into somewhere
inside a page and &msg[len] is still inside that page, but (1) there
is no LF nor NUL in the page after &msg[0], and (2) the page after
the page &msg[0] and &msg[len] are in is not mapped.  Letting
strchrnul() scan msg[] beyond len will lead us to attempt to read
the first byte of the next page and killed with SIGBUS (I recall
that I had to debug a mysterious breakage in strlen or strchr on
SunOS, which tried to grab 8-byte at a time and crossed page
boundary to get an unnecessary SIGBUS).
