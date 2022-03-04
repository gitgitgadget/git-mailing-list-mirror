Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD3FC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiCDW6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCDW6N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:58:13 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2171822FD92
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:57:25 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2008D112A29;
        Fri,  4 Mar 2022 17:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yuqCVt5yj/LeJrUERcMar7apiUCawQsUQinRCY
        zhRIo=; b=PH62rQwD10GJxlSu2Iby7eXuBDWLIgcvjkH7l5Wc2sf5kNWNyLYesw
        SQqG3wAidNqG835WXluA+FsYfz2dCw7T4yCnd5lSLSCnIBL8pIrH+OHQztlO0TD/
        u0u+CcwPvRJttRx7PeI7v+rMBIfa+836piBDePULbEploI9ew+TGA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1721D112A28;
        Fri,  4 Mar 2022 17:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33F08112A27;
        Fri,  4 Mar 2022 17:57:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 07/11] bundle: safely handle --objects option
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 14:57:22 -0800
In-Reply-To: <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:07 +0000")
Message-ID: <xmqqmti5xr59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74104034-9C0E-11EC-A25C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Since 'git bundle' uses setup_revisions() to specify the object walk,
> some options do not make sense to include during the pack-objects child
> process. Further, these options are used for a call to
> traverse_commit_list() which would then require a callback which is
> currently NULL.
>
> By populating the callback we prevent a segfault in the case of adding
> the --objects flag. This is really a redundant statement because the
> bundles are constructing a pack-file containing all objects in the
> discovered commit range.
>
> Adding --objects to a 'git bundle' command might cause a slower command,
> but at least it will not have a hard failure when the user supplies this
> option. We can also disable walking trees and blobs in advance of this
> walk.

Wow.  That's fun.  

This commit makes me wonder if we are safe with --max-parents=,
--author=, and other nonsense options, but it is obvious that it is
a segfault waiting to happen by passing NULL to object callback,
which makes it worth singling out "--objects" and dedicate a commit
to fix it.

