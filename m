Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0005C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiGNXDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNXDp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 19:03:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2FDFA8
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 16:03:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B0B71A275A;
        Thu, 14 Jul 2022 19:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J8l5Sk+vFvD0YAgyaMUXplatHlp4fjeqrRTiPN
        aygbs=; b=Iyu5qbTP1QLwQvTXawVxUXW3DijM5gtk8YbgIsv8O+34z2sxf9AFnp
        0NvMWl46ueVSf+S1mBsfxwWutAIHdGcdidXjgcOF8FCbKFsGbuTiwbng3q7v1SBe
        gq6wqWxUkndYZZuIVpndKh33RNncguXQ5KFqqrMWIQHoiphYRNiFc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11FC21A2759;
        Thu, 14 Jul 2022 19:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3B5B1A2758;
        Thu, 14 Jul 2022 19:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Julian Prein <druckdev@protonmail.com>
Subject: Re: [PATCH] hooks--pre-commit: detect non-ASCII when renaming
References: <pull.1291.git.git.1657837073372.gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 16:03:37 -0700
In-Reply-To: <pull.1291.git.git.1657837073372.gitgitgadget@gmail.com> (Julian
        Prein via GitGitGadget's message of "Thu, 14 Jul 2022 22:17:53 +0000")
Message-ID: <xmqqedyn2t6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 326050B6-03C9-11ED-BEF8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Julian Prein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julian Prein <druckdev@protonmail.com>
>
> Currently the diff-filter that is used to check for non-ASCII characters
> in filenames only checks new additions.
>
> Extend the diff-filter in the pre-commit sample to include `CR` as well.
> This way non-ASCII character in filenames are detected on a rename/copy
> as well.

It would probably be a better implementation to disable the rename
detection, instead of adding Copies and Renames.

> Signed-off-by: Julian Prein <druckdev@protonmail.com>
> ---
>     hooks--pre-commit: detect non-ASCII when renaming
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1291%2Fdruckdev%2Fpre-commit-renames-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1291/druckdev/pre-commit-renames-v1
> Pull-Request: https://github.com/git/git/pull/1291
>
>  templates/hooks--pre-commit.sample | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index e144712c85c..95c327832da 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -28,7 +28,7 @@ if [ "$allownonascii" != "true" ] &&
>  	# Note that the use of brackets around a tr range is ok here, (it's
>  	# even required, for portability to Solaris 10's /usr/bin/tr), since
>  	# the square bracket bytes happen to fall in the designated range.
> -	test $(git diff --cached --name-only --diff-filter=A -z $against |
> +	test $(git diff --cached --name-only --diff-filter=ACR -z $against |
>  	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
>  then
>  	cat <<\EOF
>
> base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
