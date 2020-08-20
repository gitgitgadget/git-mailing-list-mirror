Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E46BC433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 20:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377B1207BB
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 20:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R7rA+8x9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHTULZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:11:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54084 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgHTULX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 16:11:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5EC67DB82;
        Thu, 20 Aug 2020 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0dLIiilcpSIQl9fz1cu4lvOdyLs=; b=R7rA+8
        x9x9D0jvZ6MyFyqL+Q4k/WBWpxL4ooB6AQPyOoZEQHgQEMtVN2OcmnNzzvEJayyK
        NByRAxVBD2O7rDEQtHeRtghB45kxZqnpwJ115g9QnaZTi4+mPVFinyh1yqHEBoWM
        IPWc9j1mqdHisxc/F+Xp+i45rs3xHThwQlmBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RnaZd4CyiFHDlLuvpau5me7YlCzXMS08
        uJX4uN/7WQwYdnTEQkQM4w/vXy+vxFY3LiF1AVpyBve/TiuEX1YV9/BSOTbE4qyj
        l+oxZw41YUBgnWjaPsyllC7UlHsGf4bn39uxRS/AVXvg6C+vVnxhvf5uwGyFXFHY
        5LSu21Dg5j8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE97C7DB81;
        Thu, 20 Aug 2020 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 267E97DB7F;
        Thu, 20 Aug 2020 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: in partial clone, pass --promisor
References: <20200820175116.3889786-1-jonathantanmy@google.com>
Date:   Thu, 20 Aug 2020 13:11:20 -0700
In-Reply-To: <20200820175116.3889786-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 20 Aug 2020 10:51:16 -0700")
Message-ID: <xmqqimddaxhz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5078F046-E321-11EA-84A7-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When fetching a pack from a promisor remote, the corresponding .promisor
> file needs to be created. "fetch-pack" originally did this by passing
> "--promisor" to "index-pack", but in 5374a290aa ("fetch-pack: write
> fetched refs to .promisor", 2019-10-16), "fetch-pack" was taught to do
> this itself instead, because it needed to store ref information in the
> .promisor file.

So is this patch a fix for a regression in v2.25?

> This causes a problem ...
> ...
> An alternative is to instead move object checking to "fetch-pack", and
> let "index-pack" only index the files. However, since "index-pack" has
> to inflate objects in order to index them, it seems reasonable to also
> let it check the objects (which also require inflated files).

I can see why it might feel attractive to draw the line to divide
the labor between the two that way, but I 100% agree with your
reasoning---index-pack needs to inspect the objects in order for it
to be able to index, and in order for us to be able to trust the
resulting index, it should be validating the objects it identified
while it was indexing the pack stream.

> +
> +		if (args->from_promisor)
> +			/*
> +			 * write_promisor_file() may be called afterwards but
> +			 * we still need index-pack to know that this is a
> +			 * promisor pack. For example, if transfer.fsckobjects
> +			 * is true, index-pack needs to know that .gitmodules
> +			 * is a promisor object (so that it won't complain if
> +			 * it is missing).
> +			 */
>  			strvec_push(&cmd.args, "--promisor");
>  	}
>  	else {
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 8827c2ed18..5a01466db4 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -163,6 +163,22 @@ test_expect_success 'manual prefetch of missing objects' '
>  	test_line_count = 0 observed.oids
>  '
>  
> +test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
> +	test_create_repo submodule &&
> +	test_commit -C submodule mycommit &&
> +
> +	test_create_repo src_with_sub &&
> +	test_config -C src_with_sub uploadpack.allowfilter 1 &&
> +	test_config -C src_with_sub uploadpack.allowanysha1inwant 1 &&
> +
> +	git -C src_with_sub submodule add "file://$(pwd)/submodule" mysub &&
> +	git -C src_with_sub commit -m "commit with submodule" &&
> +
> +	git -c transfer.fsckobjects=1 \
> +		clone --filter="blob:none" "file://$(pwd)/src_with_sub" dst &&
> +	test_when_finished rm -rf dst
> +'
> +
>  test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack --fsck-objects' '
>  	git init src &&
>  	test_commit -C src x &&
