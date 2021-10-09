Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6999BC433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 07:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351E960F70
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 07:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhJIH0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 03:26:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51048 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhJIH0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 03:26:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05FFAE70AF;
        Sat,  9 Oct 2021 03:24:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=twcLt968r4r/By0uKjuw9zgcecrx/Vzk0ljEPEWy95c=; b=f6Tl
        pfi941HEvmj9mOvovZlxUG0UNjTm0UY0RTVn5q2Ktgzgk2nAcwkJWI31/9Mqf52T
        HZisDSGX2MxbpIp58fkgAHi9/UDoK9cXZd6ryeOJkUos0qPdl+cUnpPM0nrHcWzN
        6kuTTzi6KqOpK6WejnK9nI/pbU2m0km8oVaiXNU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD5D6E70AE;
        Sat,  9 Oct 2021 03:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EA3DE70AD;
        Sat,  9 Oct 2021 03:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
References: <20210917225459.68086-1-chooglen@google.com>
        <20211005001931.13932-1-chooglen@google.com>
Date:   Sat, 09 Oct 2021 00:24:14 -0700
Message-ID: <xmqqfstafyox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8E2D7D8-28D1-11EC-B81A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hi everyone! This patch was created in response to something we observed in
> Google, where fsck failed to detect that the commit graph was invalid. We
> initially assumed that fsck never checked the commit graph, but it turns out
> that it does so only when core.commitgraph is set, even though we set defaults
> for "whether to use the commit graph" in the repository settings.

With this merged to 'seen', the CI job with the extra set of
GIT_TEST_X settings fail.  When this topic is excluded, with
all the other topics in flight in 'seen', everything seems to
be OK.

For which GIT_TEST_X environment variables to set and export while
testing to trigger the problem, see [*1*]

For a successful test run of 'seen' without this topic, see [*2*]

For the test log of the failing run with this topic, see [*3*];
you'd need to be logged into GitHub to see the details of the errors
(e.g. click on "regular (linux-gcc...)" with red X sign on the left
hand side, then open "Run ci/print-test-failures.sh" and look for
"not ok").


[References]

*1* https://github.com/git/git/runs/3843549095?check_suite_focus=true#step:4:1677

    export GIT_TEST_SPLIT_INDEX=yes
    export GIT_TEST_MERGE_ALGORITHM=recursive
    export GIT_TEST_FULL_IN_PACK_ARRAY=true
    export GIT_TEST_OE_SIZE=10
    export GIT_TEST_OE_DELTA_SIZE=5
    export GIT_TEST_COMMIT_GRAPH=1
    export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
    export GIT_TEST_MULTI_PACK_INDEX=1
    export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
    export GIT_TEST_ADD_I_USE_BUILTIN=1
    export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
    export GIT_TEST_WRITE_REV_INDEX=1
    export GIT_TEST_CHECKOUT_WORKERS=2

*2* https://github.com/git/git/actions/runs/1322907901 (feff65d)

    A successful CI run of 'seen' without gc/use-repo-settings.

*3* https://github.com/git/git/actions/runs/1322842689 (54a31af)

    CI run of 'seen' with gc/use-repo-settings that fails.

    The commits that is in the failing 'seen' but not in the
    succeeding tree are those from this topic, as can be seen here:

    $ git shortlog --no-merges 54a31af ^feff65d
    Glen Choo (3):
          fsck: verify commit graph when implicitly enabled
          fsck: verify multi-pack-index when implictly enabled
          gc: perform incremental repack when implictly enabled

