Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9994FC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 16:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiHOQBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiHOQAf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 12:00:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083FC389C
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 09:00:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 294D4151B68;
        Mon, 15 Aug 2022 12:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PFEpK2CWXHFYNrvlktOR2M3MJFSxGkszGYFMLh
        qldjw=; b=lfjOFIjI4F8YyBKmDjDibgGsOim5OpQcUaXevwlLJVV1zGBDL6En2O
        j6YlKEC1XGjLLJbEghGpsL1rExm5aXPkDNY4N4HH+IJPrcoYENMnCQvUV7XgnqwZ
        5ScNcJvGi9KGslH1IhZLxv55IXAdAGYrbdN9xQpaho9HtcagSxWdk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F9F2151B67;
        Mon, 15 Aug 2022 12:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83D40151B66;
        Mon, 15 Aug 2022 12:00:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        newren@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
        <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
        <CAGTqyRw-SYDbQy9aktq5s3ZhoDhUOCf-pEopjH9m7v5+PH7Qqg@mail.gmail.com>
        <xmqqy1vq3zm3.fsf@gitster.g>
        <08a8e78d-7861-3da3-f6f6-bba466655071@gmail.com>
Date:   Mon, 15 Aug 2022 09:00:29 -0700
In-Reply-To: <08a8e78d-7861-3da3-f6f6-bba466655071@gmail.com> (Phillip Wood's
        message of "Mon, 15 Aug 2022 14:04:50 +0100")
Message-ID: <xmqqilmt4huq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 631820F0-1CB3-11ED-9C10-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I had not commented as I don't use the prompt. I have just had a quick
> read and I wonder if it would be more efficient to use
>     git diff --cached --quiet --diff-filter=U
> rather than
>     git ls-files --unmerged 2>/dev/null
> to check if there are unmerged entries,

The former reads the on-disk index into in-core index, and reads
tree objects (recursively for subdirectories) referenced by the
HEAD, walks both in parallel to find differences and filters out the
result to unmerged (I am not sure how well diff-filter works with
unmerged paths, though).

The latter rads the on-disk index into in-core index, scans the
entries and finds unmerged entries.

So if we compare the overhead to run either command standalone, I am
reasonably sure that the latter would be a lot more efficient.

But if the shell prompt code already needs to run the diff-index for
other reasons (e.g. to show if there is any modification added to
the index), that may change the equation.  Instead of adding a
separate and extra call to "ls-files -u", it might be more efficient
if you can somehow piggy-back on an existing diff-index call.  For
example, you may be running "git diff --cached --quiet" for exit code
to show if any change has been added, but you can instead run "git
diff --no-ext-diff --no-renames --cached --name-status" and (1) if
there is any output, then the index is dirty, and (2) if there is a
line that begins with "U", you have an unmerged path right there.
