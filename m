Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08BCC4332F
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiJJVCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiJJVBS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 17:01:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73C2FD
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 14:00:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25AB8144034;
        Mon, 10 Oct 2022 17:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n1v/iG50hX8MkOWZn+FQEGFY85k1CyO7ubW5Rq
        dX408=; b=Mxo9a3H7o4eOtDsZSVKH/mCHPXY03lUumVTu5EC/xUZMgnAj8E1sLr
        fHZfafSnVxVZerw6X6mhl/em1gYOzFD3Bpej/ntywaF2r/W4BO8kBVnjhOwn5ovY
        yCRNzxCK4iGIW7rvr1Osxd+8YOWYEcexE9EiQOb5O9DrQM8a7qBeU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BF22144033;
        Mon, 10 Oct 2022 17:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 685A9144032;
        Mon, 10 Oct 2022 17:00:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH 2/2] ci(main): linux32 uses actions/checkout@v2
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
        <4ee163b9a2c4c657e649159ae6c83b13613028f3.1665388136.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 14:00:16 -0700
In-Reply-To: <4ee163b9a2c4c657e649159ae6c83b13613028f3.1665388136.git.gitgitgadget@gmail.com>
        (Oscar Dominguez via GitGitGadget's message of "Mon, 10 Oct 2022
        07:48:56 +0000")
Message-ID: <xmqqo7uj1jj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B3EB902-48DE-11ED-BA54-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Oscar Dominguez <dominguez.celada@gmail.com>
>
> to prevent issue tracked in https://github.com/actions/checkout/issues/560
>
> Signed-off-by: Oscar Dominguez <dominguez.celada@gmail.com>
> ---
>  .github/workflows/main.yml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

So, this is "[Patch 1/2] broke the musl job by blindly updating them
to v3 and here is a fix-up" patch?  Can we rearrange so that we have
no such "oops here is a fix" that breaks bisection easily?

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 8dc9d938159..4eb5042f0d6 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -281,17 +281,20 @@ jobs:
>          vector:
>          - jobname: linux-musl
>            image: alpine
> +          checkout_version: 3
>          - jobname: linux32
>            os: ubuntu32
>            image: daald/ubuntu32:xenial
> +          checkout_version: 2
>          - jobname: pedantic
>            image: fedora
> +          checkout_version: 3
>      env:
>        jobname: ${{matrix.vector.jobname}}
>      runs-on: ubuntu-latest
>      container: ${{matrix.vector.image}}
>      steps:
> -    - uses: actions/checkout@v3
> +    - uses: actions/checkout@${{matrix.vector.checkout_version}}
>      - run: ci/install-docker-dependencies.sh
>      - run: ci/run-build-and-tests.sh
>      - name: print test failures
