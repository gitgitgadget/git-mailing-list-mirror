Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD2AEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjGERx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGERx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:53:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D1DF7
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:53:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B0AC3671C;
        Wed,  5 Jul 2023 13:53:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TSweX4kS2YzdxzTglN6FmhjgB4Vd2CByaMSQ6P
        LribQ=; b=Pv4nTvhScfvCk1TIgtesyGs9jXZV8dj5vOwZ+3zazCGyZyKcJvaer1
        a6pS02mnsNltN5MbNSrbUdZQF/ijVRECvfyYN7sepBpb31Trh3hMY1EPBZcK+sR4
        AJzI2flRZiQDArJOjBeM3a39fTzhRVw850UwabaRwjy8JsVyBVkBQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63C823671B;
        Wed,  5 Jul 2023 13:53:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 036B63671A;
        Wed,  5 Jul 2023 13:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-6-christian.couder@gmail.com>
Date:   Wed, 05 Jul 2023 10:53:52 -0700
In-Reply-To: <20230705060812.2865188-6-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 5 Jul 2023 08:08:09 +0200")
Message-ID: <xmqqh6qi1byn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E81E2BD4-1B5C-11EE-B4C0-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This could be useful if, for example, some large blobs take a lot of
> precious space on fast storage while they are rarely accessed. It could
> make sense to move them into a separate cheaper, though slower, storage.
>
> In other use cases it might make sense to put all the blobs into
> separate storage.

Minor nit.  Aren't the above two the same use case?

> This is done by running two `git pack-objects` commands. The first one
> is run with `--filter=<filter-spec>`, using the specified filter. It
> packs objects while omitting the objects specified by the filter.
> Then another `git pack-objects` command is launched using
> `--stdin-packs`. We pass it all the previously existing packs into its
> stdin, so that it will pack all the objects in the previously existing
> packs. But we also pass into its stdin, the pack created by the previous
> `git pack-objects --filter=<filter-spec>` command as well as the kept
> packs, all prefixed with '^', so that the objects in these packs will be
> omitted from the resulting pack.

When I started reading the paragraph, the first question that came
to my mind was if these two pack-objects processes can and should be
run in parallel, which is answered in the part near the end of the
paragraph.  It may be a good idea to start the paragraph with "by
running `git pack-objects` command twice in a row" or something to
make it clear that one should (and cannot be) run before the other
completes.

In fact, isn't the call site of write_filtered_pack() in this patch
a bit too early?  The subprocess that runs with "--stdin-packs" is
started and told about the names of the pack we are going to create,
and it does not start processing until it reads everything (i.e. we
run fclose(in) in the write_filtered_pack() function), but the loop
over "names" string list in the caller that moves the tempfiles to
their final filenames comes after the call to close_object_store()
we see in the post context of the call to write_filtered_pack() that
is new in this patch.

The "--stdin-packs" one is told to exclude objects that appear in
these packs, so if the main process is a bit slow to finalize the
packfiles it created (and told the "--stdin-packs" process about),
it will not lead to repository corruption---just some objects are
included in the packfiles "--stdin-packs" one creates even though
they do not have to.  So it does not sound like a huge problem to
me, but still it somehow looks wrong.  Am I misreading the code?

Thanks.
