Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ECC61F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 01:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfJ3BNb (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 21:13:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63311 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfJ3BNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 21:13:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C17933D22D;
        Tue, 29 Oct 2019 21:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gdOWZkjOaQXOqmjw6cu6HfH55A4=; b=rN/qU8
        1/opDptqm1ltBP+vYWAwwq6YHJb2BF32OrTI231qRgxuqCTg4uwh5gNyNt/Vr/lz
        9G7B+Lj+NQYf/MRoVm8h2JMy04NNU8c98qqhVejPqf4Qtk+lE6Bc7kLL5kGR9joR
        a674fjJwniFh/7apra1QUBT2K5mLHVXk+mLQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xr6LGw4a6gn7DAVmF2+RnXEJwF8EXzkl
        6NQf86IIFrba96/iJ4ZO+XEhUftGhEQRPn0Tuw6hr8yOX+dGMkuxFokYF2Hzye0N
        dOP+sW/rYoWthc85wZr8L/qGkMZz2RjC6tC3RYAqbeWkVoTOA2vtzV62kFhbz5VV
        6YuLTMkjUeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7C5C3D22C;
        Tue, 29 Oct 2019 21:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D4003D22B;
        Tue, 29 Oct 2019 21:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] update-index: optionally leave skip-worktree entries alone
References: <pull.355.git.gitgitgadget@gmail.com>
        <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
        <86dbb11f159375da281acd6266df019106abeadb.1572261615.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 10:13:26 +0900
In-Reply-To: <86dbb11f159375da281acd6266df019106abeadb.1572261615.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 28 Oct 2019
        11:20:14 +0000")
Message-ID: <xmqq5zk7593d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A26D528-FAB2-11E9-87F7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> While `git update-index` mostly ignores paths referring to index entries
> whose skip-worktree bit is set, in b4d1690df11 (Teach Git to respect
> skip-worktree bit (reading part), 2009-08-20), for reasons that are not
> entirely obvious, the `--remove` option was made special: it _does_
> remove index entries even if their skip-worktree bit is set.
>
> Seeing as this behavior has been in place for a decade now, it does not
> make sense to change it.

If this were end-user facing Porcelain behaviour, even it is a
decade old, the story would have been different, but given that it
is in an obscure corner in a plumbing command, I agree that it does
not make sense to even transition the default over releases.

> +test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '
> +	test_commit geroff-me &&
> +	git update-index --skip-worktree geroff-me.t &&
> +	rm geroff-me.t &&

I do not see a need to swear with a sample file name.  It may make
sense to use words that relate to what the test is checking (e.g.
skip-me or something like that), but otherwise meaningless filenames
used in other tests (like 1, 2, etc) would be more in line with the
existing tests.

> +
> +	: ignoring the worktree &&
> +	git update-index --remove --ignore-skip-worktree-entries geroff-me.t &&
> +	git diff-index --cached --exit-code HEAD &&

HEAD has it, working tree does not, and the one in the index should
have been kept thanks to the new option added by this patch.  Makes
sense.

> +	: not ignoring the worktree, a deletion is staged &&
> +	git update-index --remove geroff-me.t &&
> +	test_must_fail git diff-index --cached --exit-code HEAD

Testing the other side of the coin (i.e. adding the new feature did
not accidentally stop the command from removing by default) is good;
"should have no difference" was a good test for the other side, but
in contrast, "should have some difference" is a very loose test when
the difference we want to see is that the particular path gets removed
and no other changes.

> +'
> +
>  #TODO test_expect_failure 'git-apply adds file' false
>  #TODO test_expect_failure 'git-apply updates file' false
>  #TODO test_expect_failure 'git-apply removes file' false
