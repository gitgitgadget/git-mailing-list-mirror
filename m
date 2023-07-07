Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF3EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjGGSoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGGSoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 14:44:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705B1BF4
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 11:44:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87D1D288A7;
        Fri,  7 Jul 2023 14:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z2IwCqZ0QqgZxuLVS8lg3M/O9LNas0sVAS01eP
        38uPs=; b=lCdqWDF6rNQZrTDcoc2I5VkHW8u0Jgnrgzxx5F+C5nz7MWTtZ6SI+W
        FDz9Es9Qag5ny5yss9kXCnzG3Jk/LP/sCW+Zy4r8e2zZkgYNJkWwL2OX6VWbco7Z
        nzN4uomGxy1vZx7jAnf3v7zRTo8assltUBCpxZoI9zmmBBn+PWmAk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80201288A6;
        Fri,  7 Jul 2023 14:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A6F3288A5;
        Fri,  7 Jul 2023 14:44:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] push: advise about force-pushing as an
 alternative to reconciliation
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
        <20230706040111.81110-1-alexhenrie24@gmail.com>
        <20230706040111.81110-3-alexhenrie24@gmail.com>
        <82255166-49ac-3c10-1744-27d6d436822e@gmail.com>
Date:   Fri, 07 Jul 2023 11:44:02 -0700
In-Reply-To: <82255166-49ac-3c10-1744-27d6d436822e@gmail.com> (Phillip Wood's
        message of "Fri, 7 Jul 2023 09:49:22 +0100")
Message-ID: <xmqqy1jr8sul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F19D5D8-1CF6-11EE-9D3F-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Alex
>
> On 06/07/2023 05:01, Alex Henrie wrote:
>> Also, don't put `git pull` in an awkward parenthetical, because
>> `git pull` can always be used to reconcile branches and is the normal
>> way to do so.
>
> This message would also benefit from adding explanation as to why this
> change is desirable.

Yes, at least some essence from the lengthy discussion we had in the
review threads for the expected use cases deserve to be summarized
to help future developers who run "git log" (and "git blame") to
find this commit.

Unlike the [1/2] step, where the commands like "status" and
"checkout" that are detached far away from the actual "push" are
affected, this is exactly about "push has failed, now what"
situation, where a change from "you must reconcile" to "if you want
to reconcile, you could do this, but it may be that discarding the
work on the other side is the right thing, if that is just a stale
copy of what you are pushing" is very much welcome.

> It makes the advice longer  but the user get a specific suggestion for
> their current situation rather than a generic suggestion to delete the
> remote changes without discussing the implications. In this case we
> know that it was the current branch that was rejected and so should
> fill in the branch name in the advice as well.
>
> My main issue with the changes in this series is that they seem to
> assume the user is (a) pushing a single branch and (b) they are the
> only person who works on that branch. That is a common but narrow case
> where force pushing is perfectly sensible but there are many other
> scenarios where suggesting "push --force" would not be a good idea.

Yup.  Thanks for a review.
