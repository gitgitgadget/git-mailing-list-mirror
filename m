Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09237C433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhLRAIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:08:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54333 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLRAIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:08:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5E0B1043EE;
        Fri, 17 Dec 2021 19:08:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T1RZ7DHAN5toV4stWdbjGZr4vkjrZLM3vizT5j
        6IyG8=; b=tGcRSg1SV8eyGTMgourpDwUn4eYG+JmGeHrKmAY7l0ol6IkfDjNe3m
        A2mPo/MOcWwAB0tG7sKivD7FwPypIhI5F3+5ObueBLYSfO+FiQcxRCjqDBnLEoD+
        suVZ0AeAg3P1WouoVvWAYPq+Tu8oE0mD/V79nuWraHyd+V5sdhg+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB9381043ED;
        Fri, 17 Dec 2021 19:08:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CA381043EC;
        Fri, 17 Dec 2021 19:08:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Subject: Re: Should update-index --refresh force writing the index in case
 of racy timestamps?
References: <d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com>
        <Ybz9ruQ/uOfFbn3W@camp.crustytoothpaste.net>
Date:   Fri, 17 Dec 2021 16:08:32 -0800
In-Reply-To: <Ybz9ruQ/uOfFbn3W@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 17 Dec 2021 21:14:22 +0000")
Message-ID: <xmqqee6a22rj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A364BD10-5F96-11EC-998A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-12-17 at 10:44:32, Marc Strapetz wrote:
>> For one of my Git-LFS test repositories, switching between branches quite
>> often results in lots of racy index timestamps. Subsequent calls to "git
>> update-index --refresh" or "git status" will invoke the "lfs" filter over
>> and over again, just to figure out that all entries are still up-to-date.
>> Hence, the index will never be rewritten and racy timestamps will remain.
>> 
>> To break out of this state, it seems favorable to write the index if any
>> racy timestamp is detected. We will be able to provide a patch if this
>> change sounds reasonable.
>
> Sure, this sounds reasonable, especially if, as you mentioned, git
> status already does this.  We might as well make the plumbing commands
> as functional as the porcelain commands.

Given that "update-index --refresh" is a way to say "we know
something changed to make cached stat information dirty even for
otherwise clean paths and we want our 'diff-files' and other
plumbing command to start relying on the cached stat information
again, so please do as much I/O as you need", I agree that it should
do as thourough job as necessary.
