Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1579FC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB74F20857
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kw14O3eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDXUvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:51:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61230 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDXUvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:51:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD744D2EB5;
        Fri, 24 Apr 2020 16:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CEu+j8894WBCcy07KdGqPgMAQYk=; b=kw14O3
        eC2byBjwyIqux2Ws9VnpqTgzJAWk0RLrAPXMJC2r5yrT3TCHv2cCbWgKqcteTShD
        3PLcwVplfGBMpXrk4vnoGN8f7LM7xrJm7ajBOnQOlkGT+HKOwi1/d1GI64aKCppf
        YLr69GvF08Ft91IB5LDOl/2LavD2obGajrYhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ewq8a8QNkAvTuBtLJmZ384P6oO70vwaC
        xsZha+ApXlJT6xgOpGEF51+Ubdg5ypvSwNHlMSshX92iJLyN+xBhvQ8k17d8rA/8
        7SUGXL43tkBhPXfh2xpho5oHSqwR9XhKTmfv6MTRYn868MPNlufkdEcN7btyqJnc
        cjnpGkeKSW0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF274D2EB4;
        Fri, 24 Apr 2020 16:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14309D2EB3;
        Fri, 24 Apr 2020 16:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: fix GitHub workflow when on a tagged revision
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 13:50:55 -0700
In-Reply-To: <pull.619.git.1587748660308.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 24 Apr 2020 17:17:40
        +0000")
Message-ID: <xmqqlfmkbob4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BE38E62-866D-11EA-86DD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> However, our GitHub workflow does not trigger on tags, therefore, this
> logic results in a missing build for that revision.

Thanks for noticing.  The arrangement we had, which essentially said
"we know we will always build tagged version, so a push of a branch
that happens to have a tagged version at the tip can be ignored",
served us wonderfully.  Now the maintainers of projects (not just
this one) are forbidden from tagging the tip of master, queue
something else on top and push the result out, as it won't build or
test the tagged version, which is a bit sad.

>  ci/lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index dac36886e37..f151e2f0ecb 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -1,6 +1,7 @@
>  # Library of functions shared by all CI scripts
>  
>  skip_branch_tip_with_tag () {
> +	test -z "$DONT_SKIP_TAGS" || return 0
>  	# Sometimes, a branch is pushed at the same time the tag that points
>  	# at the same commit as the tip of the branch is pushed, and building
>  	# both at the same time is a waste.
> @@ -151,6 +152,7 @@ then
>  	CC="${CC:-gcc}"
>  
>  	cache_dir="$HOME/none"
> +	DONT_SKIP_TAGS=t

Quite straight-forward.  Thanks, will queue.

>  	export GIT_PROVE_OPTS="--timer --jobs 10"
>  	export GIT_TEST_OPTS="--verbose-log -x"
>
> base-commit: f72f328bc57e1b0db380ef76e0c1e94a9ed0ac7c
