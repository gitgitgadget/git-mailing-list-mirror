Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B32C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJOSfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOSfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:35:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E111742D64
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:35:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24D711665F2;
        Sat, 15 Oct 2022 14:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZpC+IpUCK48OEm0AvzKOJIuyzGr2N4J0Yfo+wr
        HbJwo=; b=iJJ2BQGpEYM58Y8k3fyZ9CyTeLEwwTWiBMrG8SYRN3oM4G98bcIS7k
        qqb2swErv9iymSkWVgYgh5rgEWjXf2hkF5zPofseQmmUeebLRJ5erwY+970UQjpy
        h1eGkoNmc9v07gNcluDKudhrxrX/G+bubgAWp+w8Pt1jkKvgnuABM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CEA31665F0;
        Sat, 15 Oct 2022 14:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FF301665EF;
        Sat, 15 Oct 2022 14:35:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rupinderjeet Singh <rupinderjeet47@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [suggestion] Fail cherry-pick if it overwrites untracked files
 with the matching file names
References: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
Date:   Sat, 15 Oct 2022 11:35:32 -0700
In-Reply-To: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
        (Rupinderjeet Singh's message of "Sat, 15 Oct 2022 23:39:34 +0530")
Message-ID: <xmqq7d11540b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 274CAF3E-4CB8-11ED-9041-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the situation is about cherry-picking a commit that adds a new
file F to a checkout of another commit that lacks the file F, I
think the command is working exactly as designed.

    $ git init
    $ git commit -m 'initial' --allow-empty
    $ git tag initial
    $ date >file
    $ git add file
    $ git commit -m 'add file'
    $ git tag added
    $ git checkout -b second initial
    ... at this point we are back to the original state
    ... without 'file'
    $ >file
    ... the file is untracked with precious contents
    ... and the presence of it stops a cherry-pick that clobbers it
    $ git cherry-pick added
    error: The following untracked working tree files would be overwritten by merge:
            file
    Please move or remove them before you merge.
    Aborting
    fatal: cherry-pick failed

Now continuing from the above, things get (slightly) interesting

    $ echo file >.gitignore
    $ git cherry-pick added

This will replace "file" with the one from the "added" commit, and
that is because the user marked that the "file" in the working tree
is expendable.

Files in a working tree controlled by git fall into one of three
classes.  Tracked files are those that are known to the index and
appear in "git ls-files" output.  Among the others, ignored files
are those that .gitignore mechanism says are expendable.  The rest
are "untracked", possibly containing valuable contents that should
not be lost as the user may choose to 'git add' them later.

Not just cherry-pick but any merge-related operations, including
"checkout", follow this semantics.  Untracked files are kept, but
ignored files are expendable and will be removed if they are in the
way to complete the operation the user asks.

    $ rm .gitignore
    $ git checkout master
    error: The following untracked working tree files would be overwritten by checkout:
            file
    Please move or remove them before you switch branches.
    Aborting

    $ echo file >.gitignore
    $ git checkout master
    ... this should succeed, removing "file" whose contents were
    ... marked expendable.

Of course, after switching to 'master' (or cherry-picking 'added'),
the project now cares about the 'file'.  After all, it bothered to
add it to keep track of the changes to its contents.  So it is
recommended that you would adjust the contents of .gitignore so that
it no longer is marked as expendable.
