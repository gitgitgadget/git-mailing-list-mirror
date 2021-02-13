Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4185C433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9253A64E01
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhBMBuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:50:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65385 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBMBuU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:50:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 538F011ACC0;
        Fri, 12 Feb 2021 20:49:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2SEbZhdZlBjnsxCx8keg4q/bf9g=; b=Tpazqc
        CnrbSKjrDMYKIrzOJHbfEMDVZ6JUK81q2zXR7Z6LKi5SiKUXKy1Hdkzu5gSTvrsM
        tkCV245U6yGOCVDvoxQhfceECPMERWEx6wUFTGy/l0jDh+0OIb0+boWKokd31Ija
        fO9Ad6CfrK6sMeWxqRvcOcJrS/IvRmrzpNvhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=maBSkIMljKQQQCgIJUwceFSwI7ahIq6A
        4dSIOs1D9jrhfMZ2L5kjqmbZFflUGyA01Drxx2PeqNkPjJBTlB4LYVIjRUMyCd3R
        Sd1cYEyPQlNaWQwMeUB/nbNxyPap+p5329+8S6YJhok35d6ohfliEpaA89J6d4xg
        KrNmSr5HBJ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BD3611ACBF;
        Fri, 12 Feb 2021 20:49:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9984D11ACBC;
        Fri, 12 Feb 2021 20:49:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/5] diffcore-rename: guide inexact rename detection
 based on basenames
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <2493f4b2f55d2b602e448db3f09da1ee3a97c81b.1612970140.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Feb 2021 17:49:33 -0800
In-Reply-To: <2493f4b2f55d2b602e448db3f09da1ee3a97c81b.1612970140.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 10 Feb 2021
        15:15:39 +0000")
Message-ID: <xmqqo8gou47m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B99F71C4-6D9D-11EB-9124-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 797343b38106..bf62537c29a0 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -280,8 +280,8 @@ test_expect_success 'basename similarity vs best similarity' '
>  	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
>  	# but since same basenames are checked first...

Here lies the answer to my earlier question ;-)

>  	cat >expected <<-\EOF &&
> -	R088	subdir/file.txt	file.md
> -	A	file.txt
> +	A	file.md
> +	R078	subdir/file.txt	file.txt
>  	EOF
>  	test_cmp expected actual
>  '
