Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E3C433FE
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6AA610F7
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhKIAM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:12:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50966 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhKIAMz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 19:12:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F2EAF0492;
        Mon,  8 Nov 2021 19:10:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IiRXHIGvStTklDXj5ad7aCkgLaVcwfWqJ+2d8n
        kpPZo=; b=Z7R6UUMlz1U5I4zXG2fWPIEdXf4zpwT16QxhnJWcuY6plJp5TM0TbW
        yRiZA2QgHPpbvODSec8aZwTgLveEQs/KY/jG2HZZdPGd6r8R0hUDBTiFyIs0sMOk
        ZB3LSJPT2Zbx9pk4c9Kj+2ufEp/7+QGO0OLskf80i6iDBuFGd4WaQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14544F0490;
        Mon,  8 Nov 2021 19:10:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54CBDF048F;
        Mon,  8 Nov 2021 19:10:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/3] gitfaq: add entry about syncing working trees
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
        <20211107225525.431138-4-sandals@crustytoothpaste.net>
        <CAPig+cRtOpaPd_HCQAW=33-vxhP4Knijo3g0dUA9HVb4_=JH4w@mail.gmail.com>
        <xmqqmtmes3ix.fsf@gitster.g>
Date:   Mon, 08 Nov 2021 16:10:05 -0800
In-Reply-To: <xmqqmtmes3ix.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        08 Nov 2021 14:09:42 -0800")
Message-ID: <xmqqtugm42aq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 657C89B0-40F1-11EC-8BA7-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Doesn't rsync work the same per-file fashion, and the only reason
> why it is a better fit is because it is not continuous, not
> attempting to "sync" while the repository is in use, until the user
> explicitly says "OK, I am ready to go home, so let's stop working
> here and send everything over to home with rsync"?

OK, so not "per-file" but "continuous" is the root problem, and
"cloud" would be a good word because all the popular ones share that
"continuous" trait.

This part of the proposed patch text may need rethinking a bit.

> +or added files, broken refs, and a wide variety of other corruption.  These
> +services tend to sync file by file and don't understand the structure of a Git
> +repository.  This is especially bad if they sync the repository in the middle of

That is, "file by file" is not a problem per-se, "don't understand
the structure" is a huge problem, and "continuous" may contribute to
the problem further.

I wonder if you let the "cloud" services to continuously sync your
repository, then go quiescent for a while and then start touching
the destination, it would be sufficient, though.  The refs with
funny "2" suffixes and the like are the symptom of two sides
simultanously mucking with the same file (e.g ".git/refs/main") and
the "cloud sync" could not decide what the right final outcome is,
right?

I also wonder if we add a way to transfer reflog entries, that imply
the object reachability, say "git push --with-reflog", over the
wire, it would be sufficient to do everything with Git.

Before you go home, you'd do

    git stash save --untracked && git stash apply
    git push --mirror --with-reflog --with-stash

to save away modified and untracked files to a stash entry [*], and push
all the refs with their reflog entries (including refs/stash which
normally gets refused because it has only two levels).

    Side note. If there were a variant of "git stash save" that only
    saves away without modifying the working tree and the index, I'd
    use that single command instead of "save and immediately restore
    by applying" kludge.

Then at the destination, you'd figure out what the current branch
was (the stash message should record tha name of the branch), check
that branch out, and running "git stash pop" will give you pretty
much the same environment.
