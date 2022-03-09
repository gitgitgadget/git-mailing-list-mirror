Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE92C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiCISmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiCISmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:42:14 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC317F69A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:41:14 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3026D10BB39;
        Wed,  9 Mar 2022 13:41:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f1k3TUHJ/c2nUF+VZlWukUCc9zQHNXECPMbExe
        jfmgU=; b=nmX0rSAJlxC3LuKbHwCW87x7kPR3aJL6HFRiKFET6zvDJBJgDewjGx
        J9CrZCwy6hhpkGfRYGEB3Bl59G3dR5CE7ojtAQ3LJo2xfM00JvVoUGJ4tEPq9Kgc
        GgP8ImSmXxfa5U1PiYgIrJVrsYYWSMyUZpI9J+WAVt5sZJkcWikhM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 272BE10BB38;
        Wed,  9 Mar 2022 13:41:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97D0710BB37;
        Wed,  9 Mar 2022 13:41:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 09/13] bundle: parse filter capability
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
        <faf7a38b0e595e6fdb89b62563dcff855466c796.1646841704.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 10:41:12 -0800
In-Reply-To: <faf7a38b0e595e6fdb89b62563dcff855466c796.1646841704.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 09 Mar 2022
        16:01:39 +0000")
Message-ID: <xmqqwnh3klyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F2389FE-9FD8-11EC-83A3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 72ab8139052..ac4c4352aae 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -75,8 +75,11 @@ verify <file>::
>  	cleanly to the current repository.  This includes checks on the
>  	bundle format itself as well as checking that the prerequisite
>  	commits exist and are fully linked in the current repository.
> -	'git bundle' prints a list of missing commits, if any, and exits
> -	with a non-zero status.
> +	Information about additional capabilities, such as "object filter",
> +	is printed. See "Capabilities" in link:technical/bundle-format.html
> +	for more information. Finally, 'git bundle' prints a list of
> +	missing commits, if any. The exit code is zero for success, but
> +	will be nonzero if the bundle file is invalid.

Hmph.  I wasn't expecting this change (not objecting, but mostly am
surprised) relative to the previous round where the filter was
mentioned only when we issue an error message.  I was expecting to
see something like "list-filters <file>", which is analog to the
"list-heads <file>", to help those who want to programatically build
around the "git bundle" command output.  Or "--list-capabilities" to
accomodate the current, this, and future capabilities.  We already
have the object-format thing before this series.  Do we have an
interface to expose that out of a given bundle file?

