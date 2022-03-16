Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC2C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 05:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbiCPFfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbiCPFfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 01:35:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4D65F8FD
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 22:33:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FEED121DA6;
        Wed, 16 Mar 2022 01:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CoX7JDdU2WfrFPXBsps+DUw3aXsaYVqpKNLASlN4uVQ=; b=L27P
        hQKeizcAHfaUDfdjb26GRw2s3EreZGIqDAX/7xwNLy9qxj8v+Vt6uh6ZygEWxwkP
        FDL4o1AvLW61oypB71gZg2fJZyYS7bKWnhM7aJMCvdITSkBmNoJyZEzFVFAGJnQG
        VR3eu9I77b5LeZkGrG48BUF5Ms1itIEdsqQmXYI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6722F121DA5;
        Wed, 16 Mar 2022 01:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C55A4121DA3;
        Wed, 16 Mar 2022 01:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 1/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <a77d02df626ed6dff485e1342ff7affd6999ec44.1647379859.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 22:33:51 -0700
Message-ID: <xmqqbky6bgw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA4FAB96-A4EA-11EC-9782-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.
>
> * Rename 'state' variable to 'bulk_checkin_state', since we will later
>   be adding 'bulk_fsync_objdir'.  This also makes the variable easier to
>   find in the debugger, since the name is more unique.
>
> * Move the 'plugged' data member of 'bulk_checkin_state' into a separate
>   static variable. Doing this avoids resetting the variable in
>   finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
>   seem to unintentionally disable the plugging functionality the first
>   time a new packfile must be created due to packfile size limits. While
>   disabling the plugging state only results in suboptimal behavior for
>   the current code, it would be fatal for the bulk-fsync functionality
>   later in this patch series.

Sorry, but I am confused.  The bulk-checkin infrastructure is there
so that we can send many little objects into a single packfile
instead of creating many little loose object files.  Everything we
throw at object-file.c::index_stream() will be concatenated into the
single packfile while we are "plugged" until we get "unplugged".

My understanding of what you are doing in this series is to still
create many little loose object files, but avoid the overhead of
having to fsync them individually.  And I am not sure how well the
original idea behind the bulk-checkin infrastructure to avoid
overhead of having to create many loose objects by creating a single
packfile (and presumably having to fsync at the end, but that is
just a single .pack file) with your goal of still creating many
loose object files but synching them more efficiently.

Is it just the new feature is piggybacking on the existing bulk
checkin infrastructure, even though these two have nothing in
common?

