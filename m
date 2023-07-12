Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09AEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 15:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjGLPtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjGLPtR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 11:49:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A298A2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 08:49:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5D961B5230;
        Wed, 12 Jul 2023 11:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jQYTwCo15E+X+cLVfUMLuaPezW+7yZfa1c1tlk
        /CO1g=; b=Zof4FglwYbJKXrt1i85x11IztQ7I0VmsN6Wdp/ygmmKVZTTn2Nmb4F
        QWEEeoi8PJoeBThijiG4S7ouV3i8GO1PqNWo2w9XfVZF1TN7FbFYwu1LzWTqvF3p
        2euLFUVKr0dOVwstxVnLu4tEbdmf1vgGIYt0x4jcJbjUZQ+1dh1qc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE9F31B522F;
        Wed, 12 Jul 2023 11:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 460881B522E;
        Wed, 12 Jul 2023 11:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Manuel Ricci <manuelricciwc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible typo in git stash doc page
References: <CAMvNOSqDgDnchNdNq7AvBYbMTFfy0mWMygHnX_8HjTAnBA=AnQ@mail.gmail.com>
Date:   Wed, 12 Jul 2023 08:49:12 -0700
In-Reply-To: <CAMvNOSqDgDnchNdNq7AvBYbMTFfy0mWMygHnX_8HjTAnBA=AnQ@mail.gmail.com>
        (Manuel Ricci's message of "Wed, 12 Jul 2023 17:01:29 +0200")
Message-ID: <xmqq1qhduo3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6261696-20CB-11EE-B86A-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manuel Ricci <manuelricciwc@gmail.com> writes:

> In the doc page about git stash, specifically where there're the
> details about git stash push
> https://git-scm.com/docs/git-stash#Documentation/git-stash.txt-push-p--patch-S--staged-k--no-keep-index-u--include-untracked-a--all-q--quiet-m--messageltmessagegt--pathspec-from-fileltfilegt--pathspec-file-nul--ltpathspecgt82308203
>
> There's a reference about --staged or -S. I tried to execute the
> command with that flag and the output is like this one:
>
> error: unknown switch `S'
> usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
> ...
> Even if the flag is --staged
>
> error: unknown option `staged'
> usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
> ...

This is not a very reproducibly-helpful bug report.  Re-reading the
above, we do not even learn what exact command you typed, and what
the state the repository you saw the error message was in.

In a random repository I happened to be in, that had Makefile tracked,
I did this:

    $ git version
    git version 2.41.0-327-gaa9166bcc0
    $ git stash -S
    No local changes to save.
    $ echo "# junk" >>Makefile
    $ git stash -S
    No staged changes.
    $ git add Makefile
    $ git stash -S
    Saved working directory and index state WIP on ...

The commands in various state seem to be working as expected.  It
would complain when there is nothing to save, it complains
differently when there is something to save but the change is not in
the index, and it reports what it did when it did save.

The option was implemented with 41a28eb6 (stash: implement
'--staged' option for 'push' and 'save', 2021-10-18) that first
appeared in Git 2.35, so it is possible that the version of Git
you are using is too old to have it, but from your bug report we
cannot tell if that is the case.

HTH?
