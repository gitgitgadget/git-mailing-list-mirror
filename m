Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC501C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbhLVTaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:30:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50113 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhLVTaF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:30:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C71B1610A3;
        Wed, 22 Dec 2021 14:30:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V4JIx6WmGDlNOdX2W+YpeDUaHNcDaK5IPfjuML
        oORxw=; b=sB6hNlqOMJmryKaPNahjRrh3iitSShEPz/IwFpCPtVFk7zSVAujKO4
        2ZrZ/CNuwZuH173+JiPdddfwsgDc6ousLz8w/Qb7WYaRdP4t+NUeDfugqk0mBhRR
        25PtVcvkgGeTQbZoiT/kl6B6Lxo8QqPSC1RzT7qoE0lsBhT7w2/fU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 250C41610A2;
        Wed, 22 Dec 2021 14:30:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7279B161097;
        Wed, 22 Dec 2021 14:30:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/3] builtin/fetch: skip unnecessary tasks when using
 --negotiate-only
References: <20211217000235.68996-1-chooglen@google.com>
        <20211222001134.28933-1-chooglen@google.com>
        <20211222001134.28933-3-chooglen@google.com>
        <xmqqa6gtkumz.fsf@gitster.g>
        <kl6l8rwczgzy.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 22 Dec 2021 11:29:59 -0800
In-Reply-To: <kl6l8rwczgzy.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 22 Dec 2021 09:28:17 -0800")
Message-ID: <xmqqpmpojv48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E75B448-635D-11EC-993E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I would have come to same conclusion if I agreed that we should recurse
> into submodules even if no objects are fetched. When I first wrote this
> patch, I was convinced that "no new objects" implies "no need to update
> submodules" (see my response at [1]), but I'm not sure any more and I'd
> like to check my understanding.

For example, there is a "everything_local()" optimization in the
fetch-pack codepath where the following steps happen:

 (1) we look at the current value of the remote refs we are fetching
     from their ls_refs output (let's call it "new tips");

 (2) we notice that all of these objects happen to exist in our
     object store.

 (3) we make sure that we do not see any "missing links" if we run a
     reachability traversal that starts from these objects and our
     existing refs, and stops when the traversal intersect.

When the last step finds that all objects necessary to point at
these "new tips" with our refs safely, then we have no reason to
perform physical transfer of objects.  Yet, we'd update our refs
to the "new tips".

This can happen in a number of ways.  

Imagine that you have a clone of https://github.com/git/git/ for
only its 'main' branch (i.e. a single-branch clone).  If you then
say "git fetch origin maint:maint", we'll learn that the tip of
their 'maint' branch points at a commit, we look into our object
store, find that there is no missing object to reach from it to the
part of the object graph that is reachable from our refs (i.e. my
'maint' is always an ancestor of my 'main'), and we find that there
is no reason to transfer any object.  Yet we will carete a new ref
and point at the commit.

Or if you did "git branch -d" locally, making objects unreachable in
your object store, and then fetch from your upstream, which had fast
forwarded to the contents of the branch you just deleted.

Or they rewound and rebuilt their branches since you fetched the
last time, and then they realized their mistake and now their refs
point at a commit that you have already seen but are different from
what your remote-tracking branches point at now.

Or you are using Derrick's "prefetch" (in "git maintenance run") and
a background process already downloaded the objects needed for the
branch you are fetching in the past.

Depending on what happened when these objects were pre-fetched, such
a real fetch that did not have to perform an object transfer may
likely to need to adjust things in the submodule repository.
"prefetch" is designed not to disrupt and to be invisible to the
normal operation as much as possible, so I would expect that it
won't do any priming of the submodules based on what it prefetched
for the superproject, for example.

So in short, physical object transfer can be optimized out, even
when the external world view, i.e. where in the history graph the
refs point at, changes and makes it necessary to check in the
submodule repositories.

