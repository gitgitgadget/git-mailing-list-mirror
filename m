Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D29C43219
	for <git@archiver.kernel.org>; Tue, 17 May 2022 10:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiEQK1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbiEQK1g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 06:27:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC0ACEE
        for <git@vger.kernel.org>; Tue, 17 May 2022 03:27:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F720197DE6;
        Tue, 17 May 2022 06:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=OvrYlvRlS/AJpqcJYrsILLh4sekkXyhW2a7PytQmGfQ=; b=QZRY
        gIy580oSWN95LkyQPiTwQhLUgjQvUBlFmFmXpp8gwHFEyPiFGgPdOi+UrKafnLoA
        a3opoYvxp3nfGzMYU1QVkIwpFjMDxVyQaxBgmts2MMQsbRo6mBcB6Bsgi+EVvBTd
        6Z9bNtVl3DuO/XiNcQM5+FeyulNuaQuN0THc07Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3977E197DE5;
        Tue, 17 May 2022 06:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4349197DE4;
        Tue, 17 May 2022 06:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch: limit shared symref check only for local
 branches
References: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
        <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com>
        <xmqqv8u54gcm.fsf@gitster.g>
        <CAGHpTBJDeOMCfv36Sey1tGadQThS8mGR00YiK4C16BbV==W8XQ@mail.gmail.com>
Date:   Tue, 17 May 2022 03:27:04 -0700
Message-ID: <xmqqtu9oxxmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E63353DA-D5CB-11EC-B534-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad Shaneh <orgads@gmail.com> writes:

>> Another thing that is surprising is that you say this loop is
>> expensive when there are many tags or branches.  Do you mean it is
>> expensive when there are many tags and branches that are updated, or
>> it is expensive to merely have thousands of dormant tags and
>> branches?  If the latter, I wonder if it is sensible to limit the
>> check only to the refs that are going to be updated.
>
> It's expensive even when *nothing* is updated. I have a repo with 44K
> tags, 13K of the tags are annotated, 134 remote branches and 4
> worktrees (except the main repo) with 33 local branches.
>
> I counted the calls to find_shared_symref - it was called 35755 times,
> and refs_read_raw_ref was called 357585 times.

That is exactly why I asked, as the above number hints that it could
be a viable optimization to omit calls for refs whose old_ and
new_oid are the same, just like you omit calls for refs that are not
inside refs/heads/ in your patch, perhaps?
