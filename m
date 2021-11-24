Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BCC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 05:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhKXFtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 00:49:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59607 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhKXFtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 00:49:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86F9B1012C5;
        Wed, 24 Nov 2021 00:46:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YeShdswJ5EQ73yrP/Bi8tt4Zur5zmMXpvWPQBd
        AST4Q=; b=rVKzONvxTxJwUBB54brHq1mlnr2HhUtwP/UZSjtMZDdAXzoU9VQ26F
        SO1B0fqfm7VVRkhW/+rAhUn3lDGT6dmpwOW5Hv62C9XliCkYkYbYnTZcsVyyi6t2
        xjyKqOhYE8c7iW4Sta1yQAzLu6GQT3kmADF+K2jrwBdy0biJzZaSI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E82C1012C4;
        Wed, 24 Nov 2021 00:46:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 630331012C3;
        Wed, 24 Nov 2021 00:46:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
        <20211123003958.3978-1-chooglen@google.com>
        <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
        <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
        <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BHn0bE4ZSx25+28GD58sae=FVs63eQW-Fp8zwFAALcKFA@mail.gmail.com>
        <kl6ltug2tmhy.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 23 Nov 2021 21:46:04 -0800
In-Reply-To: <kl6ltug2tmhy.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 23 Nov 2021 16:39:53 -0800")
Message-ID: <xmqqh7c23y3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0B5F99C-4CE9-11EC-9B2C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> To me, a more compelling argument is that protecting cwd is important
> in order to ensure correctness, and user experience is an incidental
> benefit. AFAICT that is not the argument you are making, but perhaps
> there is some correctness benefit as well?

I doubt there is.

It would be annoying if the command fails to remove a directory that
becomes empty after an operation only because your interactive shell
that spawned "git" was there, especially if your system allows
interactive shell to still sit in an unlinked directory.  After such
a rmdir, `/bin/pwd` or `cd ..` may not work, but then the only thing
you need to do to recover from this situation is to run `cd
/path/to/repository` and we can continue working, without having to
worry about a leftover directory.

That may be a more pleasant end-user experience than what is being
proposed, which forces you (1) to realize that you are in a
directory that was to be removed if you weren't sitting there, and
(2) to compute how many levels of otherwise empty directories were
left because of your presense, and (3) to go up sufficient number of
levels and manually run "rm -fr" the hierarchy, to recover.

So, I dunno.  It does make the end-user experience on such a system
that allows your cwd to go away equally unpleasant to the end-user
experience on a system that does not allow your cwd to go away, so
we might be gaining a bit in the consistency department, but as has
been already discussed, "git" level protection can only notice the
process immediately above us and we wouldn't be able to pay
attention to the fact some other unrelated process is using a
directory as its cwd, so even such a consistency argument does not
go all that far.
