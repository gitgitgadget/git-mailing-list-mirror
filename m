Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CDC54EE9
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 02:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiI1ClI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 22:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI1ClG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 22:41:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA17105D6C
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 19:41:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5090D1A0A20;
        Tue, 27 Sep 2022 22:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LsW2IuBEP8ycSjBgHhX98fIWZjKLdNJFFuiRbmOci/A=; b=vgyC
        TKw0r9Hsjtum4G0KBi0wgyw/rJLsAsvJSlEUvzd1BQYJgkFJYF7tKu74Sxm2Dj6p
        SenkpO9Kc5J4xcH7HzyI8nmG1kKka2dmb8cLuvaTuYRNYpKWQbKqfnHwqmXqDCVv
        8xZoOUOAP7vXyHjUsze3RSxsRTSlrh+kbpIpsSg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 489AB1A0A1F;
        Tue, 27 Sep 2022 22:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CA581A0A1C;
        Tue, 27 Sep 2022 22:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/5] [RFC] config API: return empty list, not NULL
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 19:40:58 -0700
Message-ID: <xmqq35cc1arp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC1C1532-3ED6-11ED-A5A2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This work changes the behavior of asking for a multi-valued config key to
> return an empty list instead of a NULL value. This simplifies the handling
> of the result and is safer for development in the future.
>
> This is based on v4 of my unregister series [1]
>
> [1]
> https://lore.kernel.org/git/pull.1358.v4.git.1664287021.gitgitgadget@gmail.com/
>
> This idea came about due to a bug in the git maintenance unregister work
> where the result from git_config_get_value_multi() was sent directly to
> for_each_string_list_item() without checking for a NULL value first.
>
> I'm sending this as an RFC mostly because I'm not 100% sure this shift is
> worth the refactoring pain and effort. I personally think getting an empty
> list is a safer choice, but I can also understand if someone has a different
> opinion.

Thanks.

I actually am in favor of the idea that a NULL can be passed around
to signal the lack of a string_list (or the lack of a instance of
any "collection" type), and the current code is structured as such,
and it gives us extra flexibility.  Of course, we need to see if
that extra flexibility is worth it.

With a colleciton col, "if (col && col->nr)" checks if we have
something to work on.  But a code like this (which is a longhand for
the for_each_string_list_item() issue we just reencountered):

    col = git_get_some_collection(...);
    if (!col)
	return; /* no collection */
    if (!col->nr)
	git_add_to_some_collection(col, the default item);
    for (i = 0; i < col->nr; i++)
	do things on col.stuff[i];

can react differently to cases where we have an empty collection
and where we do not have any collection to begin with.  

The other side of the coin is that it would make it harder to treat
the lack of collection itself and the collection being empty the
same way.  The above code might need to become

    col = git_get_some_collection(...);
    if (!col)
	col = git_get_empty_collection();
    if (!col->nr)
	git_add_to_some_collection(col, the default item);
    for (i = 0; i < col->nr; i++)
	do things on col.stuff[i];

but if the "get the collection" thing returns an empty collection
when there is actually no collection, we can lose two lines from
there.

Between these two positions, I am in favor of the flexibility that
we can use NULL to signal the lack of collection, not a presence of
a collection with zero items, as it feels conceptually cleaner.

Counting the hunks in [2/5] and [5/5], it seems that "when no
variable with given key is defined, we return an empty set" makes us
to have more code in 7 places in [PATCH 2/5], while allowing us to
lose code in 10 places in [PATCH 5/5].
