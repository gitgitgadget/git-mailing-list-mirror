Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB1C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 16:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJNQq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJNQqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 12:46:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3494BA246
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 09:46:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3F5C15F336;
        Fri, 14 Oct 2022 12:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ae/i9WcdUUMl+mIOcLTrcKeOgWl5hM7OifH7ZY
        oBtxc=; b=GPrt+mhLiWorpYovXaHGbzdfWXPGfzgV/S0iQFhWrBJ0yZz3JE8TDH
        1JGkYVczR9t57b1ZV6ENLgFFwNx60sz2AeTBsM5NJMX5ovp0VAgmm4G83RHsdSLW
        4Dd0E+N6k3byy3R9eLJrQ9KBxyIBlEfQ5/uASDgi2ANppB11Ea2Ts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABD0715F335;
        Fri, 14 Oct 2022 12:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AB3B15F334;
        Fri, 14 Oct 2022 12:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/3] Implement filtering repacks
References: <20221012135114.294680-1-christian.couder@gmail.com>
Date:   Fri, 14 Oct 2022 09:46:21 -0700
In-Reply-To: <20221012135114.294680-1-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 12 Oct 2022 15:51:11 +0200")
Message-ID: <xmqqilkm9wv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC89333A-4BDF-11ED-8944-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> For example one might want to clone with a filter to avoid too many
> space to be taken by some large blobs, and one might realize after
> some time that a number of the large blobs have still be downloaded
> because some old branches referencing them were checked out. In this
> case a filtering repack could remove some of those large blobs.
>
> Some of the comments on the patch series that John sent were related
> to the possible data loss and repo corruption that a filtering repack
> could cause. It's indeed true that it could be very dangerous, and we
> agree that improvements were needed in this area.

The wish is understandable, but I do not think this gives a good UI.

This feature is, from an end-user's point of view, very similar to
"git prune-packed", in that we prune data that is not necessary due
to redundancy.  Nobody runs "prune-packed" directly; most people are
even unaware of it being run on their behalf when they run "git gc".

Reusing pack-objects as an underlying mechanism is OK, but this
needs to be plumbed through to "git gc" for a more consistent
experience for the end users.

Is there a way to check if the "promisor remote" is still willing to
keep the previous promise it made, so that the users do not have to
see "we may corrupt the repository as the result of this operation,
you have been warned", by the way?  Possibly with a protocol
extension?

In a sense, once you made a partial clone, your repository is at the
mercy of the remote.  They can disappear any time with majority of
the data you depend on, leaving only what you created locally and
haven't pruned away, in a repository that may technically pass
"fsck", because the things that are supposed to exist locally
exists, but may not be usable in practice.  So from that point of
view, a simple check that asks "I earlier fetched from you with this
filter and these tips of histories; are you still willing to support
me?" and gets yes/no answer might be sufficient.  A remote that is
not trustworthy can say "yes" and still change their mind later, so
such a check may not even be needed.

The above two big paragraphs is a way to say that I am not all that
worried about losing objects that we should be able to refetch again
by adding this feature.  The perceived need for "--force" or "must
run from terminal" may be overblown.  I do not think this negatively
affects correctness or robustness at all (as long as the pruning is
not buggy, of course).

HOWEVER

Unlike prune-packed, pruning objects that could be refetched has
negative performance impact.  So adding an option to enable/disable
such pruning is needed.  If the frontmost UI entry point were "gc",
it needs an opt-in option to invoke the "filtering repack", in other
words.  "pack-objects" should not need any more work than what you
have here (with the "terminal" and "force" discarded), as "--filter"
is such an opt-in option already.

