Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF633C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 20:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiFFUDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 16:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiFFUDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 16:03:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC0C2BB3C
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 13:03:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2BF71904E1;
        Mon,  6 Jun 2022 16:03:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Ya/i/kYXG2JkzuSDSX/CCdVxJjF1d3hxz8IBY
        AIRHQ=; b=He4mtfBtZ2Gg4rVQLE0PfIMkNIqsXmXl+WdTU+HhlLAFO1vs5m+9KK
        i9dH9uJMi4cQEMeJVNiB0GFLkL5jHVPkJvPaRGtfS6SGF2zqsb9sAsc+tosnG86R
        +Z/4OgJGyMxgKF3+GVm7aAuvd0fru9H9rhYTuL0oawoqZ3fpTArIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA38D1904E0;
        Mon,  6 Jun 2022 16:03:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F0FD1904DE;
        Mon,  6 Jun 2022 16:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v13 5/7] object-file.c: add "stream_loose_object()" to
 handle large object
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
        <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
        <xmqqy1y960hq.fsf@gitster.g>
Date:   Mon, 06 Jun 2022 13:02:41 -0700
In-Reply-To: <xmqqy1y960hq.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        06 Jun 2022 12:44:01 -0700")
Message-ID: <xmqqk09t5zmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A968C1E8-E5D3-11EC-B3B6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Another difference with "write_loose_object()" is that we have no chance
>> to run "write_object_file_prepare()" to calculate the oid in advance.
>
> That is somewhat curious.  Is it fundamentally impossible, or is it
> just that this patch was written in such a way that conflates the
> two and it is cumbersome to split the "we repeat the sequence of
> reading and deflating just a bit until we process all" and the "we
> compute the hash over the data first and then we write out for
> real"?

OK, the answer lies somewhere in between.

The initial user of this streaming interface reads from an incoming
packfile and feeds the inflated bytestream to the interface, which
means we cannot seek.  That meaks it "fundamentally impossible" for
that codepath (i.e. unpack-objects to read from packstream and write
to on-disk loose objects).

But if the input source is seekable (e.g. a file in the working
tree), there is no fundamental reason why the new interface has "no
chance to run prepare to calculate the oid in advance".  It's just
that the such a different caller is not added by the series and we
chose not to allow the "prepare and then write" two-step process,
because we currently do not need it when this series lands.

> I am very tempted to ask why we do not do this to _all_ loose object
> files.  Instead of running the machinery twice over the data (once to
> compute the object name, then to compute the contents and write out),
> if we can produce loose object files of any size with a single pass,
> wouldn't that be an overall win?

There is a patch later in the series whose proposed log message has
benchmarks to show that it is slower in general.  It still is
curious where the slowness comes from and if it is something we can
tune, though.

Thanks.
