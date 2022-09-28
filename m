Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E9C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 22:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiI1WVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 18:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiI1WVH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 18:21:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50DEFA59
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 15:21:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7151C1B831E;
        Wed, 28 Sep 2022 18:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=I4vddjhGZ0tHju1b+qwmf+Vq3AEK+arF2z4LHNyhzpQ=; b=Z0dQ
        PK7+jN78OIH6LJSC2mSh1zFr65eX8HVMfNaw1DMfX1DPNTTo3rPuKdQvefApLYiT
        mdA5vyn/kz4tp9dhu99Yj7kewH79D4OzgbtDgPaAw2o5UBbcapp4SiVtrqsfqH0g
        3ES9FN8imuUblhFq4d4pw/dAXeVP82HufZQ6Log=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 692231B831D;
        Wed, 28 Sep 2022 18:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31BC71B831B;
        Wed, 28 Sep 2022 18:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
Subject: Re: [PATCH 01/10] technical doc: add a design doc for the evolve
 command
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <a0cf68f8ba2adefae4fceeab0d438d05e355e695.1663959324.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 15:20:58 -0700
Message-ID: <xmqqedvvqgxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4360E06-3F7B-11ED-A67D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Rebase
> +------
> +In general the rebase command is treated as a modify command. When a change is
> +rebased, the new commit replaces the original.
> +
> +Rebase --abort is special. Its intent is to restore git to the state it had
> +prior to running rebase. It should move back any changes to point to the refs
> +they had prior to running rebase and delete any new changes that were created as
> +part of the rebase. To achieve this, rebase will save the state of all changes
> +in refs/metas prior to running rebase and will restore the entire namespace
> +after rebase completes (deleting any newly-created changes). Newly-created
> +metacommits are left in place, but will have no effect until garbage collected
> +since metacommits are only used if they are reachable from refs/metas.

One thing that makes me nervous is how well your analysis capture
"unusual" but still reasonable ways to use these commands, as the
workflows of people are quite different.

For example, I almost never do "git checkout topic && git rebase
origin"; instead I would do "git checkout topic && git rebase origin
HEAD^0" to first make a detached HEAD out of the topic, in order to
have two copies explicitly available to be compared after "rebase"
finishes.  After doing so and get satisfied by the result of
comparison between topic and HEAD, I may do "git checkout -B topic"
to update.  Would that leave exactly the same set of metacommits as
the case where I didn't do the "first rebase the detached HEAD and
then update the bracnh for real" and instead "rebase the topic"
directly?
