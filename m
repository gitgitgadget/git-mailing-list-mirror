Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B8C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 07:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiBJHHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 02:07:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiBJHHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 02:07:13 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95C61BF
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 23:07:09 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45CCA1931CF;
        Thu, 10 Feb 2022 02:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y87QnUmdMWSunBU7mMVaKo5moX74N1anbu6hAG
        RiGYo=; b=eWcnkFw1VaIO1WKJu+V/w9iWil8Om+0Lz5HRgU8wqDQgqjK71oen1b
        LZSh9XB+zks796X0d2wLcqYMAX1GrTOAGQ7zaQbCC7B9dl3zRCrLviuZ3bZhP8be
        Ie5uHWunLVKVL2rsW/HZXZTbRht/iN3d9dUR+7uLldUbjufoFqgm0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3172B1931CE;
        Thu, 10 Feb 2022 02:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EE1A1931CC;
        Thu, 10 Feb 2022 02:07:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/8] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220210044152.78352-1-chooglen@google.com>
Date:   Wed, 09 Feb 2022 23:07:05 -0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com> (Glen Choo's message
        of "Thu, 10 Feb 2022 12:41:44 +0800")
Message-ID: <xmqqsfsrw67a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E5FD964-8A40-11EC-83CC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> = Background
>
> When fetching submodule commits, "git fetch --recurse-submodules" only
> considers populated submodules, and not all of the submodules in
> $GIT_DIR/modules as one might expect. As a result, "git fetch
> --recurse-submodules" behaves differently based on which commit is
> checked out.

After getting 'init'ed, which is a sign that the user is interested
in that submodule, when we happen to check out a superproject commit
that lack the submodule in question, do we _lose_ the record that it
was once of interest?  I do not think so.  The cloned copy in
$GIT_DIR/modules/ would not go away, so we _could_ update it, even
there is no checkout, when the superproject we currently have may
not have the submodule.

But I am not sure if that is a problem.  After all, the recursive
fetch tries to make sure that the superproject commit that is
checked out is reproduced as recorded by fetching the submodule
commit recorded in the superproject commit, not a commit that
happens to be at the tip of random branch in the submodule.

It is OK to allow fetching into submodule that is not currently have
a checkout, but I think we should view it purely as prefetching.  We
do not even know, after doing such a fetch in the submodule, we have
the commit necessary for the _next_ commit in superproject we will
check out.

> This can be a problem, for instance, if the user has a branch with
> submodules and a branch without:
>
>   # the submodules were initialized at some point in history..
>   git checkout -b branch-with-submodules origin/branch-with-submodules
>   git submodule update --init
>
>   # later down the road..
>   git checkout --recurse-submodules branch-without-submodules
>   # no submodules are fetched!
>   git fetch --recurse-submodules
>   # if origin/branch-with-submodules has new submodule commits, this
>   # checkout will fail because we never fetched the submodule
>   git checkout --recurse-submodules branch-with-submodules

That is expected, and UNLESS we fetched _everything_ offered by the
remote repository to the submodule in the previous step, there is no
guarantee that this "recurse-submodules" checkout would succeed.

> This series makes "git fetch" fetch the right submodules regardless of
> which commit is checked out, as long as the submodule has already been
> cloned. In particular, "git fetch" learns to:
>
> 1. read submodules from the relevant superproject commit instead of
>    the file system
> 2. fetch all changed submodules, even if they are not populated

The real question is not "in which submodules we fetch", but "what
commits we fetch in these submodules".  I do not think there is a
good answer to the latter.

Of course, we we take this sequence instead:

	git checkout branch-with-submodules
	git fetch --recurse-submodules
	git checkout --recurse-submodules branch-with-submodules
	
things should work correctly (I think we both are assuming that the
other side allows to fetch _any_ object, not just ref), as "fetch"
knows what superproject commit it is asked to complete, unlike the
previous example you gave, where it does not have a clue on what
superproject commit it is preparing submodules for, right?

So, I am not quite sure if we are solving the right problem, let
alone with the right approach.

Also, if the strategy is to prefetch in all submodules that were
'init'ed, we do not have to read .gitmodules from the superproject
commit at all, right?  We can just go check .git/modules/ which is
available locally.  We need to see which submodules are of local
interest by consulting .git/config and/or .git/modules/ anyway even
if we read .gitmodules from the superproject commit to learn what
modules are there.

Thanks.
