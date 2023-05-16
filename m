Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87DC77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 23:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjEPXOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 19:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEPXOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 19:14:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9426A59DA
        for <git@vger.kernel.org>; Tue, 16 May 2023 16:14:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ECEF19EA95;
        Tue, 16 May 2023 19:14:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=22q0fJrMtb9Z+9LlLvpVidoHVyIZHyXrZgeY+g
        2Gxjw=; b=ykfKY/SrGf5ZrLekuq9iDYX8+tnPWX6zP6MMKeCJzNxmpx8x5MYsKv
        2XDP8JTHJsiuAFadAYFP3WXlt37JTY0Qi4N6IU55kDScL5CB0lx40OxqTA/q9qpJ
        n52glbR5ui+oCDdVNIBN5a+KXkwxiJTuWp5V/LYpF/c0ymXlASDdM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9548A19EA94;
        Tue, 16 May 2023 19:14:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DBB919EA91;
        Tue, 16 May 2023 19:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [RFC][PATCH V1] diff-tree: integrate with sparse index
References: <20230515191836.674234-1-cheskaqiqi@gmail.com>
        <fa24482c-7c48-9b7f-5d97-3dbf9822728c@github.com>
Date:   Tue, 16 May 2023 16:14:05 -0700
In-Reply-To: <fa24482c-7c48-9b7f-5d97-3dbf9822728c@github.com> (Victoria Dye's
        message of "Tue, 16 May 2023 14:19:04 -0700")
Message-ID: <xmqqsfbvswci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AE38D84-F43F-11ED-983F-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Longer version: 

Thanks, as usual, for a great review.  A lot of the stuff you wrote
should inspire and result in an improved log message that explains
why this change is sufficient to teach diff-tree to take advantage
of the sparse index.

> However, 'DIFF_SETUP_USE_SIZE_CACHE' seems to be unused as of 6e0b8ed6d35
> (diff.c: do not use a separate "size cache"., 2007-05-07) and nothing about
> 'detect_rename' otherwise indicates index usage, so AFAICT that whole
> condition can be dropped (along with DIFF_SETUP_USE_SIZE_CACHE,
> DIFF_SETUP_REVERSE, and diff_options.setup).

True.  The size cache does not exist anymore.  6b5ee137 (Diff
clean-up., 2005-09-21) restructured the command line option parsing
quite a bit, and we lost DIFF_SETUP_REVERSE, which is a bit that
gets OR'ed in to a file-scope diff_setup_opt static of each of the
command in the diff family.  The bit and the diff_setup_opt variable
got replaced with members of "struct diff_options", and I should
have removed the macro at the same time.

> Note that, if you want to make
> that change in this series, it should be done in a separate patch _before_
> this one (since dropping the deprecated setup infrastructure isn't really
> part of the sparse index integration).

Or after this one, perhaps?  I agree that the clean-up opportunity
you found is very much unrelated to the work to teach diff-tree to
take advantage of the sparse index.

THanks.
