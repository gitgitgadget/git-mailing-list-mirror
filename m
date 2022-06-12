Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C8C43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 23:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiFLXbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 19:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiFLXa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 19:30:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A66354188
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 16:30:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 588371A09C8;
        Sun, 12 Jun 2022 19:30:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=KfmriyhymFQd8cZHa0xDIUjAtzhl6rDNOYKmEuMpa/o=; b=lf9c
        vViKlwBpZOdCWoPDu3ZgGqbkItL4q9Kra84pSCm7+vQ+4G5mjvnOa3WQerIOBYLO
        7IGn77cy0Grcaj+i7/W+uTpB6bbZn3iIikxR+E/QXsFeoFYu/QFXVLbkH6UuHdoL
        rUlyPj4mwMinbm30BVx9tR4+pVko5ZPxZH9Merw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 529661A09C7;
        Sun, 12 Jun 2022 19:30:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F34801A09C6;
        Sun, 12 Jun 2022 19:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] submodule merge: update conflict error message
References: <20220606235449.2890858-1-calvinwan@google.com>
        <20220610231152.2594428-1-calvinwan@google.com>
        <CABPp-BHe7wdd3LMYtZ83ZgapvUxzQYcK-3=sdMAD5Ozs4YmKyw@mail.gmail.com>
Date:   Sun, 12 Jun 2022 16:30:52 -0700
Message-ID: <xmqqk09l8no3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3E369D8-EAA7-11EC-8922-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Git is left in a conflicted state, which requires the user to:
>>  1. merge submodules
>>  2. add submodules changes to the superproject
>>  3. merge superproject
>
> I think we may need to tweak these steps a bit:
>
>    1. merge submodules OR update submodules to an already existing
> commit that reflects the merge (i.e. as submodules they may well be
> independently actively developed.  Someone may have already merged the
> appropriate branch/commit and the already extant merges should be used
> in preference to creating new ones.)

That is a very good point.

I suspect we should encourage users to find an existing merge, and
possibly even discourage them from creating a new one on their own.
There may not be much point in creating the same merge of identical
parent commits with the same result that only has different
metadata.

It may be tempting to argue that an existing merge in a submodule
and the merge you are creating now are made in different context
because the superproject merges that necessitate thse submodule
merges are different, but I doubt that is a healthy argument.  A
commit in the submodule should be able to explain its reason to
exist on its own---after all, the superproject may know which
submodules are used for what purpose, but a submodule does not have
to know where it is used, and that is how it is made more reusable.

>    2. <just as you said>
>    3. FINISH merging the superproject (i.e. don't redo the merge)

Yes, exactly.  FWIW, an earlier draft was telling users to abort the
merge in the first step, and its review corrected it.  1 and 2 are
to be done in the context of the interrupted superproject merge, so
its logical consequence is to conclude the merge at step 3.
