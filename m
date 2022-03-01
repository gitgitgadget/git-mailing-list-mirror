Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8179C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiCAHek (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiCAHej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:34:39 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50B7E08D
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:33:56 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F4D10A965;
        Tue,  1 Mar 2022 02:33:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XatrFF/DoltScBwvYkpQSlbbwffjzHumuF9hWa
        jU3Is=; b=qSq8xVhN7Fh9hAUaVOXzqmIzlQDGV5UiSthnGVnqVEHagGX9HwSfIV
        JeWxm+zD8ZSFUsXZOi7EPKSijTcJpGbZOATT2+DrNWN7ykUFBpvEMvn+3I7SyNRG
        32t8b84VJczLs8t/IoVcMz7F4/GXn2l6hIarLy6EP6mixL5Ou2ZvE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E0DE10A964;
        Tue,  1 Mar 2022 02:33:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95B3B10A963;
        Tue,  1 Mar 2022 02:33:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] name-rev: use generation numbers if available
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
        <20220228215025.325904-3-jacob.e.keller@intel.com>
        <xmqqpmn6wg98.fsf@gitster.g>
        <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
Date:   Mon, 28 Feb 2022 23:33:53 -0800
In-Reply-To: <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
        (Jacob Keller's message of "Mon, 28 Feb 2022 23:08:19 -0800")
Message-ID: <xmqqfso2t9cu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2B9AE3C-9931-11EC-A0B2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Feb 28, 2022 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>> > +test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
>> > +     test_config -C non-monotonic core.commitGraph false &&
>> > +     (
>> > +             cd non-monotonic &&
>> > +
>> > +             rm -rf .git/info/commit-graph* &&
>> > +
>> > +             echo "main~3 undefined" >expect &&
>> > +             git name-rev --tags main~3 >actual &&
>> > +
>> > +             test_cmp expect actual
>> > +     )
>> > +'
>>
>> I doubt it is wise to "test" that a program does _not_ produce a
>> correct output, or even worse, it produces a particular wrong
>> output.  This test, for example, casts in stone that any future
>> optimization that does not depend on the commit-graph is forever
>> prohibited.
>>
>> Just dropping the test would be fine, I would think.
>
> Stolee mentioned it. We could also convert it to a
> "test_expect_failure" with the expected output too... But that makes
> it look like something we'll fix

Neither sounds like a good idea anyway.  What we care most is with
commit graph, the algorithm will not be fooled by skewed timestamps.
