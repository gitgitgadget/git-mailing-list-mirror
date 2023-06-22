Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13792EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 18:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFVSce (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjFVSca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 14:32:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3231FC2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 11:32:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3316B1A64B6;
        Thu, 22 Jun 2023 14:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N9bwG7z+ZaWAoS0ZmjOdpa1ja0NrLJjPTBsHuu
        +HuKI=; b=UE5HM8zvCMPTR8Vf1RuB7+XNjTIhRteCUgozcBU2C9ffTwp8bfavlm
        gfLWPTGWOa+xd+TeO1cFbLX2XwicIO83kmPBNvcBcM957679AjaafVlz6Vnc+3GJ
        ArmmB/3RhE4rkS1Yib/zgaeCmzd0GLYaSiUXye/EpeH7PUq9ZGWIE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29C7C1A64B3;
        Thu, 22 Jun 2023 14:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DB461A64B2;
        Thu, 22 Jun 2023 14:32:24 -0400 (EDT)
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
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-7-christian.couder@gmail.com>
        <xmqqmt10s0cw.fsf@gitster.g>
        <CAP8UFD3864uUjb0vR+B7xETJTFJoWdEqA5Gdyr42Lg3t8Auk=Q@mail.gmail.com>
        <xmqqy1kchi3l.fsf@gitster.g>
        <CAP8UFD30Kx_vYfdV4ipPPXNVr76pKshjTUQGcJfkUvG_+KD3zQ@mail.gmail.com>
Date:   Thu, 22 Jun 2023 11:32:23 -0700
In-Reply-To: <CAP8UFD30Kx_vYfdV4ipPPXNVr76pKshjTUQGcJfkUvG_+KD3zQ@mail.gmail.com>
        (Christian Couder's message of "Thu, 22 Jun 2023 10:39:09 +0200")
Message-ID: <xmqqa5wrfivc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21F3B0AE-112B-11EE-ABDD-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I may be missing something, but to me, the above sound more like a
>> tail wagging the dog.
> ...
> This might be a good idea, but what if users prefer to send to a
> promisor remote the objects that should be on that promisor remote as
> soon as possible, instead of keeping them on the local machine where
> they take up possibly valuable space for no good reason?
> ...
> There are some configurations where users never want to delete any git
> object. In those cases it doesn't matter if the promisor remote is a
> "dumping ground".

When one says "everything" in these sentences, I doubt one
necessarily means "everything".  A topic one works on will have
iterations that is never pushed out, a topic one started may not
even get to the state that is pushable to the central server.  But
the objects that need to support such a topic (and its historical
versions in its reflog) would need to be retained until they are
expired.

Certainly, by pushing even such objects, you can say "here is a pack
with filter=blob:none, and because I sent every blob every time I
create locally to the promisor, I can always refetch what is not in
them by definition".

But is that a good use of everybody's resources?  The key phrase in
what I said was "... and still leve the resulting promisor usable".

The promisor remote is in the unfortunate and unenviable position
that it cannot garbage collect anything because there may be
somebody who is still depending on such an object nobody planned to
use, but there is no mechanism to let it find out which ones are in
active use (or if you added some recently that I am forgetting, it
would change the equation---please remind me if that is the case).

So I would imagine that it would be fairly high in the priority list
of server operators and project leads to make sure their promisor
remotes do not become a true "dumping ground".

For "trim a bloated lazy clone" problem, I suspect that you would
need to know what is currently re-fetchable from the promisor and
drop those objects from your local repository, and the computation
of what is currently re-fetchable would certainly involve the filter
specification you had with the promisor.  The remote-tracking
branches you have for the promisor would serve as the other source
of input to perform the computation.

For "partition local and complete object store" problem, using
filter specification to sift the objects into two bins (those that
match and the rest), as the code changes in the series implements,
may be a useful mechansim.  I briefly had to wonder if partitioning
into two (and not arbitrary number N) bins is sufficient, but did
not think of a scenario where we would benefit from 3 bins more than
having 2 bins offhand.

Thanks.
