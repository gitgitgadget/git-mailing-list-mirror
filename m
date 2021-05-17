Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355EC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B68A60FEB
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhEQUac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 16:30:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54355 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhEQUab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 16:30:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AFDABF42B;
        Mon, 17 May 2021 16:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VBuNCXKnYcTnSrhJhFrtfWUnv5mdpBL2zOuVou
        TqhRg=; b=glFgrO8IUb/d8OgCwJSzeNi3w87ySqow6w/gd8CPHjlko+J9aQW46c
        4Lyjtn4FmZemM3kHSKWXdi7h1hMY+EM4IKvIjbz/wKi9OGgpJ0eCvkHuGULymgH8
        kYGn8JcpO+VdDAans3MIYcy0BJjqgx0+1rNKvxoWyU3yPYcUkUmuU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22FE6BF42A;
        Mon, 17 May 2021 16:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB50FBF429;
        Mon, 17 May 2021 16:29:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 5/9] diff-merges: move specific diff-index "-m"
 handling to diff-index
In-Reply-To: <20210517155818.32224-6-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 17 May 2021 18:58:14 +0300")
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <20210517155818.32224-6-sorganov@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Tue, 18 May 2021 05:29:12 +0900
Message-ID: <xmqqv97h5ckn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AB1D974-B74E-11EB-909A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Move specific handling of "-m" for diff-index to diff-index.c, so
> diff-merges is left to handle only diff for merges options.
>
> Being a better design by itself, this is especially essential in
> preparation for letting -m imply -p, as "diff-index -m" obviously
> should not imply -p, as it's entirely unrelated.
>
> To handle this, in addition to moving specific diff-index "-m" code
> out of diff-merges, we introduce new
>
>   diff_merges_suppress_options_parsing()
>
> and call it before generic options processing in cmd_diff_index().

This change has a small but obvious fallout.

    $ git diff-index -c --cached HEAD^

now starts failing loudly.  Earlier, it silently fell back to
"combined" diff of one parent, which is "-p".

I think the end result is good (and luckily, "DIFF FORMAT FOR
MERGES" section explicitly limits "-c" and "--cc" to diff-tree,
diff-files and diff (and by implication excludes diff-index) so I am
sure there are small but non-zero number of people somewhere in the
world who has "diff-index -c" in their scripts that suddenly starts
failing with the version of Git with this change, but we can just
say their use was broken ;-)

Having said all that, I have to wonder if it still is needed to keep
the "diff-index -m" working, or we would be better off breaking it
to avoid a change like this that makes us bend over backwards to
work around the command line parsing infrastructure.

The only reason why "diff-index -m" exists is because it was part of
the idea Linus had for the merge implementation that we ended up
deciding not taking, where merges and possibly other bulk operations
that would affect the working tree is done in a separate, temporary
directory that is sparsely populated, the user is asked to edit away
conflicts in the temporary directory and expected to monitor his or
her own progress using "diff-index -m".  Our plan was to populate
such a temporary directory with only paths that are involved in the
operation in progress, without instantiating paths that are not
touched, so "treat missing files as if they haven't been modified"
was a handy ingredient for such a mode of operation.

But we ended up going with a different design, in which the main
working tree area is used to perform merges and to resolve
conflicts, which made this "pretend missing files as unmodified"
unnecessary feature.  In the end, we made a good move, as the
current design allows users to verify their changes in the context
of a full checkout (e.g. "make" would not have been a good way to
validate the conflict resolution if it is done in a separate
temporary directory that is sparsely populated with only the paths
involved in the merge---you need all files for building, including
the ones that are not modified, and "make" does not know to treat
missing files as if they are unmodified).


