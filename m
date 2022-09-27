Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E805C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiI0Qpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiI0QpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:45:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9813D5B
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:45:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B5F214BD02;
        Tue, 27 Sep 2022 12:45:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pmtFhw/R7YwUMFdoB7txbVWZ2HjWG4RE7lUl4i
        QA0FA=; b=Ao9aO2C2opJcYFP1cdq0V+Qo4WzA+73kKwzFV8+a04TQMD6ojqWuuV
        lfaSMfyUpWyDNYoS0hX8C8LwBZyN2kuLVRqADuHyIGAOle7tWsbC68xCiuomNWo6
        /NsJopUXuDWO8VeEJLeqT6qsxR9N29oWAx4ua+UfOGpNPU7JDslK0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4212514BD00;
        Tue, 27 Sep 2022 12:45:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AC9114BCFF;
        Tue, 27 Sep 2022 12:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/2] merge-ort: return early when failing to write a
 blob
References: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
        <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
        <087207ae0b0932fcec9aa25e97bbe9227eff81cb.1664229348.git.gitgitgadget@gmail.com>
        <CABPp-BHau2qwoxj121H-cpjTPPCpfxjMpmhya0mV79qyvkpQ+g@mail.gmail.com>
Date:   Tue, 27 Sep 2022 09:45:18 -0700
In-Reply-To: <CABPp-BHau2qwoxj121H-cpjTPPCpfxjMpmhya0mV79qyvkpQ+g@mail.gmail.com>
        (Elijah Newren's message of "Tue, 27 Sep 2022 01:05:32 -0700")
Message-ID: <xmqqill87om9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5AE35C8-3E83-11ED-B1CB-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Since we will always write out a new tree object in addition to the blob
>> (and if the blob did not exist in the database yet, we can be certain
>> that the tree object did not exist yet), the merge will _still_ fail at
>> that point, but it does unnecessary work by continuing after the blob
>> could not be written.
>
> I don't think this is quite true.  I've had a number of users come to
> me with "messed up git repositories" where I eventually discover that
> users just randomly add "sudo" to some of their commands because when
> things don't work, sometimes "sudo" fixes it.  That means they've
> created stuff in their .git directory which may be owned by root,
> perhaps even some of the .git/objects/XX directories.  However, they
> may have other .git/objects/XX directories owned by their normal user.
>
> If just some .git/objects/XX directories are owned by root and not
> others, then it may be when users run git commands as themselves that
> some things can be written to the object database but not others.  In
> particular, it could be that writing blob objects fail, but writing a
> tree object which references those blobs succeeds.

It is a good example scenario that argues even more strongly for
this change.  We may know the correct object contents and name for
the top-level tree and even manage to write it out, after computing
all the blobs and the trees contained within, some of which we may
know the object name but have failed to write out.  Letting such a
breakage unnoticed would be, eh, bad.

> Patch looks good to me, though.

Yup, thanks for a review.
