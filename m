Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABAFC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 20:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbiBFUJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 15:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 15:09:37 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0CC043184
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 12:09:37 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9516610FD9A;
        Sun,  6 Feb 2022 15:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2e84XM7KDFMo
        szCbStr7Sv7m+L/HKn6a7qjbTl7WeQY=; b=PAZ1mSqcFLYGZEpKujIVd0r5vf41
        5OEsmf+Hcv0lOocpg9lKd4mkLykr7qb20uqp8U04bAa9gklZAc6D1QM2vfvT6dwt
        JAjLxySAtLHc0R8nivafMqbtgLIPNmW9SvWMUMR8JwqB9wbJXeR5jKH9xnwTi5g/
        +cM0C4bJpAn577U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BA6610FD98;
        Sun,  6 Feb 2022 15:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1553B10FD97;
        Sun,  6 Feb 2022 15:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Hongyi Zhao <hongyi.zhao@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?Q?Jo=C3=A3o?= Victor Bonfim 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: [PATCH v2 2/2] completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
References: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
        <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
        <patch-v2-2.2-2e2e3569e02-20220202T111228Z-avarab@gmail.com>
        <20220206133026.GB1936@szeder.dev>
Date:   Sun, 06 Feb 2022 12:09:35 -0800
In-Reply-To: <20220206133026.GB1936@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 6 Feb 2022 14:30:26 +0100")
Message-ID: <xmqq8runiwow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4D91694-8788-11EC-9A36-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> To complete only rarely used plumbing commands in a non-intrusive way,
> in my experience, it's best to first attempt to complete only
> porcelains and aliases, and fall back to complete all commands,
> plumbing included, only when no porcelains match the current word to
> be completed.  E.g.:
>
>   $ git d<TAB>
>   describe   diff   difftool
>   $ git diff-<TAB>
>   diff-files   diff-index   diff-tree

So after getting

    $ git diff<TAB>
    diff difftool

you _have_ to know, if you are not happy with these two, that the
next letter in the name of the command you forgot is a dash, to be
able to say

    $ git diff-<TAB>

which is a bit unfortunate, but I agree that it is much nicer than
getting all the plumbing when trying to complete "git d<TAB>".

I wonder if we can do better, and teach the completion logic an
ability to say this: "I gave 'diff and difftool' after being asked
for 'git diff<TAB>' and then the user is asking the same again
without choosing either. Perhaps I should add less frequent one to
the mix"?

I.e. the end-user session may look like

    $ git diff<TAB>
    diff difftool
    $ git diff<TAB>
    diff difftool diff-files diff-index diff-tree

?
