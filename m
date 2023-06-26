Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B892EEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFZTGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZTGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:06:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F3E72
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:06:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88FE4349D6;
        Mon, 26 Jun 2023 15:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fank4u0hiSsBNT4ANmtc9XOuU5vRPlMeJA+vB4
        PN7oI=; b=kn78Vvzfe0rKzb49Rcw7clcQTGTUBlvpu5lyiekZ92qp3TGebjplHW
        XvhexVekVDSH20BzWzGTVAsQF5U9d46P5KVRtsv9wvtyn47EijaCOVphxA7oMRBX
        OcX5rPLj2e/E6cz+tXrKPUOOBQ5j/awpuB0p7UaADCqt/yfWqxdtc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81439349D4;
        Mon, 26 Jun 2023 15:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB024349D3;
        Mon, 26 Jun 2023 15:06:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jesse Kasky <jkasky@slack-corp.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] config: don't BUG when both kvi and source are set
References: <pull.1535.git.git.1687801297404.gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 12:06:42 -0700
In-Reply-To: <pull.1535.git.git.1687801297404.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Mon, 26 Jun 2023 17:41:37 +0000")
Message-ID: <xmqq352e59h9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96EF9FCC-1454-11EE-8302-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Therefore, fix the bug by removing the BUG() check. We're reverting to
> an older, less safe state, but that's generally okay since
> key_value_info is always preferentially read, so we'd always read the
> correct values when we iterate a config set in the middle of a config
> parse (like we are here).

I wonder if the source being pushed and config_kvi value at this
point have some particular relationship (like "if kvi exists, the
source must match kvi's source" or something) that we can cheaply
use to avoid "reverting to an older less safe state"?

I would agree that, as long as we know by the end of this summer a
real fix would come to rescue us ;-), it is sensible not to add too
much code to work it around for the short-term.

> The reverse would be wrong, but extremely
> unlikely to happen since very few callers parse config without going
> through a config set.

Sorry, but I do not quite get this comment.

>     Here's a quick fix for the bug reported at [1]. As noted in the commit
>     message and that thread, I think the real fix to take [2], which
>     simplifies the config.c state and makes this a non-issue, so this is
>     just a band-aid while we wait for that.

Thanks for a quick fix.  Will queue.

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index f519d2a87a7..8759fc28533 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -257,8 +257,8 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 works with submod
>  	test_commit -C submodule mycommit &&
>  
>  	test_create_repo src_with_sub &&
> -	test_config -C src_with_sub uploadpack.allowfilter 1 &&
> -	test_config -C src_with_sub uploadpack.allowanysha1inwant 1 &&
> +	git -C src_with_sub config uploadpack.allowfilter 1 &&
> +	git -C src_with_sub config uploadpack.allowanysha1inwant 1 &&

We only tentatively configured uploadpack in src_with_sub in the
original because this single test piece was the only place where
src_with_sub repository was used, but now we use a more permanent
configuration because ...

> @@ -270,6 +270,12 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 works with submod
>  	test_when_finished rm -rf dst
>  '
>  
> +test_expect_success 'lazily fetched .gitmodules works' '
> +	git clone --filter="blob:none" --no-checkout "file://$(pwd)/src_with_sub" dst &&
> +	git -C dst fetch &&
> +	test_when_finished rm -rf dst
> +'

... we run another "git clone" from the repository now.

OK.

Thanks.
