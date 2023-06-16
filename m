Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6722EEB64DA
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 03:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbjFPDIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 23:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241691AbjFPDIu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 23:08:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE7E2D4D
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 20:08:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BE5C1EEC7;
        Thu, 15 Jun 2023 23:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n0urTDuVK+E+fArksXmvxJY5HacSEEFtJurNO4
        yb2/w=; b=SVFzDJoCvaJHJVa0kErY2cjHk4ZGSzpsN4Z0E4N7R818QMjBAf7pJ8
        WOiWkBBZHQewxm8OXVz0ybRrEgFr5yu7b2E+z7StB2beAAD1G6OPHCREKWZAbYWd
        G4UG7azcxpgRRoyj+G2Ic3gp2OBj/caQ3sDfiJ6XGXAudj/rMhVeI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62C561EEC6;
        Thu, 15 Jun 2023 23:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 818201EEC5;
        Thu, 15 Jun 2023 23:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/9] Repack objects into separate packfiles based on a
 filter
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <xmqqsfatwwtv.fsf@gitster.g>
Date:   Thu, 15 Jun 2023 20:08:44 -0700
In-Reply-To: <xmqqsfatwwtv.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        14 Jun 2023 14:36:12 -0700")
Message-ID: <xmqq5y7ortmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B25A72E-0BF3-11EE-B7DF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> In some discussions, it was mentioned that such a feature, or a
>> similar feature in `git gc`, or in a new standalone command (perhaps
>> called `git prune-filtered`), should put the filtered out objects into
>> a new packfile instead of deleting them.
>>
>> Recently there were internal discussions at GitLab about either moving
>> blobs from inactive repos onto cheaper storage, or moving large blobs
>> onto cheaper storage. This lead us to rethink at repacking using a
>> filter, but moving the filtered out objects into a separate packfile
>> instead of deleting them.
>>
>> So here is a new patch series doing that while implementing the
>> `--filter=<filter-spec>` option in `git repack`.
>
> Very interesting idea, indeed, and would be very useful.
> Thanks.

Overall, I have a split feeling on the series.

One side of my brain thinks that the series does a very good job to
address the needs of those who want to partition their objects into
two classes, and the problem I saw in the series was mostly the way
it was sold (in other words, if it did not mention unbloating lazily
cloned repositories at all, I would have said "Yes!  It is an
excellent series.", and if it said "this mechanism is not meant to
be used to unbloat a lazily cloned repository, because the mechanism
does not distinguish objects that are only locally available and
objects that are retrievable from the promisor remotes, among those
that match the filter", it would have been even better)

To the other side of my brain, it smells as if the series wanted to
address the unbloating issue, but ended up with an unsatisfactory
solution, and used "partitioning objects in a full repository on the
server side " as an excuse for the resulting mechanism to still
exist, even though it is not usable for the original purpose.

Ideally, it would be great to have a mechanism that can be used for
both.  The "partitioning" can be treated as a degenerate case where
the repository does not have its upstream promisor (hence, any
object that match the filtering criteria can be excluded from the
primary pack because there are no "not available (yet) in our
promisor" objects), while the "unbloat" case can know who its
promisors are and ask the promisors what objects, among those that
match the filtering criteria, are still available from them to
exclude only those objects from the primary pack.

In the second ideal world, we may not be ready to tackle the
unbloating issue, but "partitioning" alone may still be a useful
feature.  In that case, perhaps the series can be salvaged by
updating how the feature is sold, with some comments indicating the
future direction to extend the mechanism later.

Thanks.




