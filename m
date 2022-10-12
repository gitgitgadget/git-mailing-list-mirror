Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA67C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJLQRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLQRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:17:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A349AFA4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:17:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60E5B1B5521;
        Wed, 12 Oct 2022 12:17:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i+PJaK98ALAx1U4GRJ1N8DEeTJg6RhIcxGR3LP
        SF/AM=; b=nUh48muUzb7Y24DG1pDXQpaAivcsctWTju2YgsHHQxkAZmduAnjYmv
        C2iN6o2FEde0tmdH4b50sSRiRpSxriQzyapN7sVL8gFOCg/jCi+1LAdFrduPAHKt
        42LVTPdQvlBn7YIXcU+JPoOkAckUE2rfU//0yKB4n06Ua2b0eCT7k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57F131B551F;
        Wed, 12 Oct 2022 12:17:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C4E91B551A;
        Wed, 12 Oct 2022 12:17:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 08/12] bundle: properly clear all revision flags
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
        <8dc5a8e4e63dc98642176e5b78be739ef721d2d8.1665579160.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:17:39 -0700
In-Reply-To: <8dc5a8e4e63dc98642176e5b78be739ef721d2d8.1665579160.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 12 Oct 2022
        12:52:35 +0000")
Message-ID: <xmqqy1tlkod8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64F5FA28-4A49-11ED-B56C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The verify_bundle() method checks two things for a bundle's
> prerequisites:
>
>  1. Are these objects in the object store?
>  2. Are these objects reachable from our references?
>
> In this second question, multiple uses of verify_bundle() in the same
> process can report an invalid bundle even though it is correct. The
> reason is due to not clearing all of the commit marks on the commits
> previously walked.
> ...
> Moving this loop to the cleanup step alone would cause a segfault when
> running 'git bundle verify' outside of a repository, but this is because
> of that error condition using "goto cleanup" when returning is perfectly
> safe. Nothing has been initialized at that point, so we can return
> immediately without causing any leaks.

Nicely analyzed.  The implementation clearly follows the design
described above.  Much better than the previous iteration.

Thanks.
