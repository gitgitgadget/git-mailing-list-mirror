Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D48C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D88822582
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgLHUrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:47:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58419 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLHUrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:47:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC855B64EE;
        Tue,  8 Dec 2020 15:46:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0/jCVJnpmCGQ4xEetpTK77HTsEk=; b=CnLeoH
        OyhmzTB2mCoHGvHiPS0STpU7qZrqGvV5kG3ja6dbuHbsnoViksxNNPqXpX2L1wZp
        ITIsUdPCcdmpPkr7TD2twcVju19G5jvS0oD/kUc+Wa/4GJWy2jKCn2fuDw7PZlbW
        AwY0Io2sxt5JcQjMdJfVsikGgZiH7TmpN9E4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aHJCJG4aU4R8HzUMm4RNit3ZCX1s6oUr
        rL4y3vVIMgt0nQTRyoC6NLcGc31+yP+Wsvld1ZQBYiX25LDwdxlC93Fe6Du8bDbe
        er/vXi1KasDfeo/X5ZEdj+J3ODgcwbobmpD2a/WbqMHc3et4gSwpxOrUh6jPDJD7
        4gxyhDsOMSc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3C32B64ED;
        Tue,  8 Dec 2020 15:46:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64D29B64EC;
        Tue,  8 Dec 2020 15:46:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v3] submodules: fix of regression on fetching of
 non-init subsub-repo
References: <d52db91d-af6d-c93c-2c4a-e2460905623d@nokia.com>
        <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
Date:   Tue, 08 Dec 2020 12:46:56 -0800
In-Reply-To: <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
        (Peter Kaestle's message of "Tue, 8 Dec 2020 16:42:06 +0100")
Message-ID: <xmqqr1o06n5r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8338742C-3996-11EB-AAB7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Kaestle <peter.kaestle@nokia.com> writes:

> A regression has been introduced by a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28).
>
> The scenario in which it triggers is when one has a repository with a
> submodule inside a submodule like this:
> superproject/middle_repo/inner_repo
>
> Person A and B have both a clone of it, while Person B is not working
> with the inner_repo and thus does not have it initialized in his working
> copy.
>
> Now person A introduces a change to the inner_repo and propagates it
> through the middle_repo and the superproject.
>
> Once person A pushed the changes and person B wants to fetch them using
> "git fetch" at the superproject level, B's git call will return with
> error saying:
>
> Could not access submodule 'inner_repo'
> Errors during submodule fetch:
>          middle_repo
>
> Expectation is that in this case the inner submodule will be recognized
> as uninitialized submodule and skipped by the git fetch command.
>
> This used to work correctly before 'a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28)'.
>
> Starting with a62387b the code wants to evaluate "is_empty_dir()" inside
> .git/modules for a directory only existing in the worktree, delivering
> then of course wrong return value.
>
> This patch ensures is_empty_dir() is getting the correct path of the
> uninitialized submodule by concatenation of the actual worktree and the
> name of the uninitialized submodule.
>
> Furthermore a regression test case is added, which tests for recursive
> fetches on a superproject with uninitialized sub repositories.  This
> issue was leading to an infinite loop when doing a revert of a62387b.
>
> The first attempt to fix this regression, in 1b7ac4e6d4 (submodules:
> fix of regression on fetching of non-init subsub-repo, 2020-11-12), by
> simply reverting a62387b, resulted in an infinite loop of submodule
> fetches in the simpler case of a recursive fetch of a superproject with
> uninitialized submodules, and so this commit was reverted in 7091499bc0
> (Revert "submodules: fix of regression on fetching of non-init
> subsub-repo", 2020-12-02).
> To prevent future breakages, also add a regression test for this
> scenario.
>
> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> CC: Junio C Hamano <gitster@pobox.com>
> CC: Philippe Blain <levraiphilippeblain@gmail.com>
> CC: Ralf Thielow <ralf.thielow@gmail.com>
> CC: Philippe Blain <levraiphilippeblain@gmail.com>
> ---

Thanks, will replace.
