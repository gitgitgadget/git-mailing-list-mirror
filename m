Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B57DEB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 18:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGXS3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjGXS26 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 14:28:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF1A10F6
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 11:28:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EF351A6302;
        Mon, 24 Jul 2023 14:28:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U4WZMlug3Wv1VRKp0dQszBlwxpCQ5Q/s61e7vg
        RMIUk=; b=BmaiRWBCL2zUSedvG0wkgXp3auPxS06h+TH5NrC4maz2tjfEEwWiTM
        iM6uQAIJ7IazqQq5VqoYIeoITWt5i/5LJLptci3KrP3AOREi/yAlyilbBW1kYwDT
        jo7dP0MoSsNUaW3faJfNOZL/kM9itXjVgMrX+lDA6z57ItYataZwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94A9D1A6301;
        Mon, 24 Jul 2023 14:28:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03F021A6300;
        Mon, 24 Jul 2023 14:28:44 -0400 (EDT)
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
        <xmqqh6qi1byn.fsf@gitster.g>
        <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
Date:   Mon, 24 Jul 2023 11:28:43 -0700
In-Reply-To: <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
        (Christian Couder's message of "Mon, 24 Jul 2023 11:01:48 +0200")
Message-ID: <xmqqila9p3j8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC4D64AC-2A4F-11EE-822E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> Minor nit.  Aren't the above two the same use case?
>
> In the first case only some large blobs are moved to slower storage
> and in the other case all the blobs are moved to slower storage. So
> yeah the use cases are very similar. Not sure if and how I can improve
> the above wording though.

Just by removing one or the other, it would be quite improved, no?
Moving away some blobs could move away all or just a selected
subset.

> I think it can work if the call to write_filtered_pack() is either
> before the call to close_object_store() or after it. It would just use
> the tempfiles with their temporary name in the first case and with
> their final name in the second case.
>
> write_filtered_pack() is very similar to write_cruft_pack() which is
> called before the call to close_object_store(), so I prefer to keep it
> before that call too, if possible, for consistency.

As long as the set-up is not racy, either would be OK, as the names
are not recorded in the end result.

If the upstream tells the downstream the temporary's name and then
finializes the temporary to the final name before the downstream
reacts to the input, however, then by the time downstream starts
working on the file, the file may not exist under its original,
temporary name, and that kind of race was what I was worried about.

> Perhaps this could be dealt with separately though, as I think we
> might want to fix write_cruft_pack() first then.

Sorry, I am not understanding this quite well.  Do you mean we
should add one more known-to-be-racy-and-incorrect codepath because
there is already a codepath that needs to be fixed anyway?

If write_cruft_pack() has a similar issue, then yeah, let's fix that
first (testing might be tricky for any racy bugs).  And let's use
the same technique as used to fix it in this series, too, so that we
do not reintroduce a similar bug due to racy setup.

Thanks.

