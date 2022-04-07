Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FE6C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiDGPOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbiDGPOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 11:14:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1755BDA
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 08:12:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17AB917B6DB;
        Thu,  7 Apr 2022 11:11:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Iz9mRtCfkQ2LeqMz+qyWZhRp5DMv49uu4KH0Fm
        +yDkc=; b=DVMgfRQhVaFPUe/Uxy5hHnlv8u182bHdRvrTDyb1YckfbFOUnPejqb
        M8V+y/7eAM2A7p8W4Ter5O+TSM61XTyPF/b8wQed2paTcW/O6hvBJPGltGsRMvX0
        agG/cq5uyOJozbNKLgmaZlisNv4Jx6LvxGiFNkTcwr1F+Y4KK2lkU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1067517B6DA;
        Thu,  7 Apr 2022 11:11:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61DC017B6D9;
        Thu,  7 Apr 2022 11:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20220406232231.47714-1-chooglen@google.com>
        <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
        <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com>
Date:   Thu, 07 Apr 2022 08:11:48 -0700
In-Reply-To: <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com> (Derrick
        Stolee's message of "Thu, 7 Apr 2022 09:21:35 -0400")
Message-ID: <xmqqbkxdudvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C412770-B685-11EC-A7C5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> It is definitely good to keep in mind that other repositories have
> included bare repositories for convenience. I'm not sure that the behavior
> of some good actors should outweigh the benefits of protecting against
> this attack vector.

Good line of thinking.

>  2. Suppress warnings on trusted repos, scoped to a specific set of known
>     trees _or_ based on some set of known commits (in case the known trees
>     are too large).

Is "It is OK to check out an embedded repository from this commit or
any of its ancestors" the kind of suppression you meant by "known
commits"?

>  3. Prevent writing a bare repo to the worktree, unless the user provided
>     an opt-in to that behavior.
>
> Since your patch is moving in the right direction here, I don't think
> steps (2) and (3) are required to move forward with your patch. However,
> it is a good opportunity to discuss the full repercussions of this issue.

We can definitely start without (3).  Unleashing (1) before (2) is
ready would mean folks cannot clone projects like libgit2 until
later, which takes us back to the first point you made above.

Those who use embedded bare repositories as test vector can easily
switch to storing an equivalent of "a tarball that is expanded while
building and/or testing", and as long as the user trusts the project
enough to run its build procedure or tests, we are not adding much
to the attack surface, I would guess.
