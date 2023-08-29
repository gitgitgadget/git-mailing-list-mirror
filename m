Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDFC71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 01:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjH2BUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 21:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjH2BUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 21:20:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8413E
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 18:20:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A92332AFC;
        Mon, 28 Aug 2023 21:20:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CGdqz4LjMLpXEvnSau8A//SjhtLrV0s8CqTbGH
        gVoC4=; b=b+C24Rk12M2db0ut4iH3mjPeQnutK69s+gPOrOhX3t51knfeTcmFjR
        159RWTnauTSJ51Oy7MHMnzy4LI8PSiSN2YgOATAjgxpeHmDgcFnHjNs6axOHqcD8
        k/Rv0Uh1+iVNe7VWLmlSakHBWkzye+BdSyh8ns9ZueZp1Hmmp2vpc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 936FA32AFB;
        Mon, 28 Aug 2023 21:20:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 20B3D32AFA;
        Mon, 28 Aug 2023 21:20:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: Strange diff-index with fsmonitor, submodules
References: <20230829005606.136615-1-jonathantanmy@google.com>
Date:   Mon, 28 Aug 2023 18:20:04 -0700
In-Reply-To: <20230829005606.136615-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 28 Aug 2023 17:56:04 -0700")
Message-ID: <xmqqcyz6fxvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FDA3B8E-460A-11EE-9F64-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There is a strange interaction where diff-index not only produces
> different results when run with and without fsmonitor, but produces
> different results for 2 entries that as far as I can tell, should behave
> identically (sibling files in the same directory - file_11 and file_12,
> and both of these filenames are only mentioned once each in the entire
> test).

Picking those who had non-clean-up changes to fsmonitor out of the
output from

    $ git shortlog -n --since=2.year --no-merges ':(glob)**/*fsmonitor*'

and adding them to CC: for their attention.

> You can see this with this patch:
>
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 0c241d6c14..e9e5e32016 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -809,6 +809,11 @@ my_match_and_clean () {
>                 status --porcelain=v2 >actual.without &&
>         test_cmp actual.with actual.without &&
>  
> +       git -C super --no-optional-locks diff-index --name-status HEAD >actual.with &&
> +       git -C super --no-optional-locks -c core.fsmonitor=false \
> +               diff-index --name-status HEAD >actual.without &&
> +       test_cmp actual.with actual.without &&
> +
>         git -C super/dir_1/dir_2/sub reset --hard &&
>         git -C super/dir_1/dir_2/sub clean -d -f
>  }
> @@ -837,6 +842,7 @@ test_expect_success 'submodule always visited' '
>         # some dirt in the submodule and confirm matching output.
>  
>         # Completely clean status.
> +       echo Now running for clean status &&
>         my_match_and_clean &&
>
> and this is the output:
>
> ++ echo Now running for clean status
> Now running for clean status
> ++ my_match_and_clean
> ++ git -C super --no-optional-locks status --porcelain=v2
> ++ git -C super --no-optional-locks -c core.fsmonitor=false status --porcelain=v2
> ++ test_cmp actual.with actual.without
> ++ test 2 -ne 2
> ++ eval 'diff -u' '"$@"'
> +++ diff -u actual.with actual.without
> ++ git -C super --no-optional-locks diff-index --name-status HEAD
> ++ git -C super --no-optional-locks -c core.fsmonitor=false diff-index --name-status HEAD
> ++ test_cmp actual.with actual.without
> ++ test 2 -ne 2
> ++ eval 'diff -u' '"$@"'
> +++ diff -u actual.with actual.without
> --- actual.with	2023-08-29 00:39:26
> +++ actual.without	2023-08-29 00:39:26
> @@ -1 +0,0 @@
> -D	dir_1/file_11
> error: last command exited with $?=1
> not ok 61 - submodule always visited
>
> Notice that with fsmonitor, diff-index reports a "D" line that is not
> present when fsmonitor is off. To add to that, it only reports "D" for
> file_11 when I would expect that if it reported file_11, it would report
> file_12 as well.
>
> I'll continue investigating this myself, but does anyone know what is
> going on?
