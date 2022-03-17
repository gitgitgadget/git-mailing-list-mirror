Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2FEC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiCQVMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiCQVMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 17:12:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF22261FD
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:10:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90830185F0D;
        Thu, 17 Mar 2022 17:10:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=khp0oO164k486N4WMFJmkD0+Yk3KtXDno4nNac
        6pifo=; b=o+pHxaChGky6qDQfPAxCupol6hwqSvynjz7Dtvn1kCFYoB/LfVNJDe
        +abuSRL351ttma9aS4wcEAr+uv35zJrlySjeGyRaQDhMt67/voeBvlW+b9YDX9IP
        f/525Y8nkgiOp/0TYmjNxKwCoCYfZFC8jrKkBo0+XMrVse6ylxBGo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88C59185F0C;
        Thu, 17 Mar 2022 17:10:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00505185EF7;
        Thu, 17 Mar 2022 17:10:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/3] rebase: test showing bug in rebase with non-branch
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
        <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
        <cac51a949eed0fa593247a593aae2b100be6f4f2.1647546828.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 14:10:50 -0700
In-Reply-To: <cac51a949eed0fa593247a593aae2b100be6f4f2.1647546828.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 17 Mar 2022 19:53:46
        +0000")
Message-ID: <xmqqo824e145.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9F8D67E-A636-11EC-A84E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Currently when rebase is used with a non branch, and <oid> is up to
> date with base:
>
> git rebase base <oid>
>
> It will update the ref that HEAD is pointing at to <oid>, and leave HEAD
> unmodified.
>
> This is a bug. The expected behavior is that the branch HEAD points at
> remains unmodified while HEAD is updated to point to <oid> in detached
> HEAD mode.

Never do tests this way.

The primary reason why we do not want to write our tests the way
this patch does is because we do not _care_ how it is broken in the
behaviour of the original code.  'main' moving out of $old_main is
the bug we care about.  It is still buggy if it did not move to
Second, but some other commit.  Yet this patch insists that 'main'
to move to Second and nothing else.  What we want is 'main' to stay
at $old_main in the end anyway, and we should directly test that
condition.

If you insist to have two commits (which I strongly recommend
against in this case), you write a test that makes sure that 'main'
stays at $old_main, but mark the test with test_expect_failure.  And
then later in the step that fixes the code, flip "expect_failure" to
"expect_success".

But it is not ideal, either.  Imagine what you see in "git show"
output of the commit that fixed the problem.  Most of the test that
shows the behaviour that the commit _cares_ about will be outside
post-context of the hunk that flips test_expect_failure to
test_expect_success.

The best and the simplest way, for a simple case like this, to write
test is to add the test to expect what we want to see in the end,
and do so in the same commit as the one that corrects the behaviour
of the code.  If somebody wants to see what the breakage looks like,
it is easy to

 (1) checkout the commit that fixes the code and adds such a test,

 (2) tentatively revert everything outside t/, and

 (3) run the test with "-i -v" options.

Then test_expect_success that wants to see 'main' to stay at
$old_main will show that 'main' moved by a test failure.  Working
from a patch is the same way, i.e. you can apply only the parts
inside t/ and run the current code to see the breakage, and then
apply the rest to see the fix.

> +test_expect_success 'switch to non-branch changes branch HEAD points to' '
> +	git checkout main &&
> +	old_main=$(git rev-parse HEAD) &&
> +	git rebase First Second^0 &&

> +	test_cmp_rev HEAD main &&
> +	test_cmp_rev main $(git rev-parse Second) &&
> +	git symbolic-ref HEAD

I already said that the second one should expect main to be at
$old_main, but the "HEAD and main are the same" and "HEAD is a
symolic-ref" test can be replaced with a single test that is "HEAD
is a symbolic-ref to 'main'", which would be more strict.  I.e.

	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
	test_cmp_rev main "$old_main"

And such a test that expects the correct behaviour we want to have
in the end should be added in [PATCH 3/3] when the code is fixed,
not here in a separate commit.

> +'

Thanks.
