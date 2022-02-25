Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D206C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiBYTIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiBYTIa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:08:30 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4653181E7A
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:07:56 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F24BB10225C;
        Fri, 25 Feb 2022 14:07:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ukyWf//6dqSrEU8qr3OEFU8u26fPE7GTyGaRy
        f50yk=; b=iMnWhDwBaeANWtDYu2HF5+QrRjIHKIpnE2SytGqpfFqF36nVoAobHL
        2DInKq2h0TASz0eQVLzSVrEHGKgn+y/8Z9YCJQxW1VtDS/7668n1cSP0wc7Bk1KB
        WCJvB2niX9ZU6aeUWEboPq+WA60gOrFGrtTS1RWO4kiJFCvAOTNoE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAFD210225A;
        Fri, 25 Feb 2022 14:07:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C821102259;
        Fri, 25 Feb 2022 14:07:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2 1/3] t7519: avoid file to index mtime race for
 untracked cache
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
        <9421b71540d1f1764db6931d0781576d8a710866.1645809015.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:07:54 -0800
In-Reply-To: <9421b71540d1f1764db6931d0781576d8a710866.1645809015.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Fri, 25 Feb 2022 17:10:12
        +0000")
Message-ID: <xmqqr17qbw8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CE6E752-966E-11EC-82F3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> In t7519 there is a test that writes files to disk, and immediately
> writes the untracked index. Because of mtime-comparison logic that

"untracked cache", I think.

> uses a 1-second resolution, this means the cached entries are not
> trusted/used under some circumstances
> (see read-cache.c#is_racy_stat()).
>
> Untracked cache tests in t7063 use a 1-second delay to avoid this
> issue, but we don't want to introduce arbitrary slowdowns, so instead
> use test-tool chmtime to backdate the files slightly.

Good approach.  Perhaps fixing 7063 can be marked as #leftoverbit?

> This change doesn't actually affect the outcome of the test, but does
> enhance its validity, and becomes relevant after later changes.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>  t/t7519-status-fsmonitor.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index a6308acf006..3f984136ea9 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -324,13 +324,19 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
>  		cd dot-git &&
>  		mkdir -p .git/hooks &&
>  		: >tracked &&
> +		test-tool chmtime =-60 tracked &&
>  		: >modified &&
> +		test-tool chmtime =-60 modified &&
>  		mkdir dir1 &&
>  		: >dir1/tracked &&
> +		test-tool chmtime =-60 dir1/tracked &&
>  		: >dir1/modified &&
> +		test-tool chmtime =-60 dir1/modified &&
>  		mkdir dir2 &&
>  		: >dir2/tracked &&
> +		test-tool chmtime =-60 dir2/tracked &&
>  		: >dir2/modified &&
> +		test-tool chmtime =-60 dir2/modified &&
>  		write_integration_script &&
>  		git config core.fsmonitor .git/hooks/fsmonitor-test &&
>  		git update-index --untracked-cache &&
