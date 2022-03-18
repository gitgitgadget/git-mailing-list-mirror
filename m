Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6846C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 01:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiCRBBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 21:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiCRBB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 21:01:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874F32571A2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 18:00:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B18518655F;
        Thu, 17 Mar 2022 21:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o3TaL+v1LsNbApu10Bgm2flYLWjRPH4HQFFrn4
        rktK4=; b=iAR0gdItBDOdXHHMON97+d2rtkI4USP74OpcKjwSGjKyHQcbLw43w4
        MwTAbjsD6B0jYc/H9YjubFiFyBtfyUgBW7LHKsd5MrFmGzokLGzppzmJN+j/dltr
        Z3hRiCmNAIDRuRgfDHZ5jm8OUfs8I3r3hkLlaWbjsXqy89arOEek4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 948B718655E;
        Thu, 17 Mar 2022 21:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35DEF186556;
        Thu, 17 Mar 2022 21:00:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
        <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
        <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
        <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
        <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
        <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
        <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
Date:   Thu, 17 Mar 2022 18:00:06 -0700
In-Reply-To: <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com> (Victoria Dye's
        message of "Thu, 17 Mar 2022 14:57:32 -0700")
Message-ID: <xmqqo824cbxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0B89A24-A656-11EC-8E98-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> I tested this and it fails as expected with:
>> "fatal: bad source, source=folder2/a, destination=deep/new"
>
> Great! This should then probably be turned into a "test_expect_fail" test in
> 't1092' - that'll make sure we get both the right behavior and right error
> message with sparse index after it's enabled.
>
> However, I also get the same result when I add the '--sparse' option. I
> would expect the behavior to be "move 'folder2/a' to 'deep/new' and check it
> out in the worktree" - this may be a good candidate for improving the
> existing integration with sparse *checkout* before enabling sparse *index*
> (e.g., like when 'git add' was updated to not add sparse files by default
> [1]).
> ...
> I think you're right that this is a bug. This appears to come from the fact
> that 'mv' decides whether a directory is sparse only *after* it sees that it
> doesn't exist on-disk. 
> ...
> So I think there are three potential things to fix here: 
>
> 1. When empty folder2/ is on-disk, 'git mv' (without '--sparse') doesn't
>    fail with "bad source", even though it should.
> 2. When you try to move a sparse file with 'git mv --sparse', it still
>    fails.
> 3. SKIP_WORKTREE is not removed from out-of-cone files moved into the sparse
>    cone.
>
> On a related note, there is precedent for needing to make fixes like this
> before integrating with sparse index. For example: in addition to the
> earlier examples in 'add' and 'reset', 'checkout-index' was changed to no
> longer checkout SKIP_WORKTREE files by default [3]. It's a somewhat expected
> part of this process ...
> ...
> Another tool that may help you here is 'git ls-files --sparse -t'. It lists
> the files in the index and their "tags" ('H' is "normal" tracked files, 'S'
> is SKIP_WORKTREE, etc. [4]), which can help identify when a file you'd
> expect to be SKIP_WORKTREE is not and vice versa.

Wonderful.

Quite honestly, because the code will most likely compile correctly
if you just remove the unconditional "we first expand the in-core
index fully" code, and because the "sparse index" makes the existing
index walking code fail in unexpected and surprising ways, I
consider it unsuitably harder for people who are not yet familiar
with the system.  Without a good test coverage (which is hard to
give unless you are familiar with the code being tested X-<), one
can easily get confused and lost.

Thanks for guiding a new contributor with the usual process of
loosening "require-full-index".
