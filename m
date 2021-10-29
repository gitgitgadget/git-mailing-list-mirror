Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DBCC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EB6610E5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ2XC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:02:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61466 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2XC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:02:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C9A116BE3A;
        Fri, 29 Oct 2021 19:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bgrWMBxy7se/R1MZsc7aQUkrsHHeu+Jar0H9AF
        v7XaY=; b=DhR5qkOgfUIVki1oumXqSltclFIkiOdtxWyUucWGln2gf/OfC1Ha17
        Sn/PQDvaAcN/WBCzUwXSycPWoank1LOhFz4KsJRG9TF3iZpOV7JS/+mUtjAPRgGq
        Qwkl4iwS87oL8ZuClzy14KzZZH3tNjuRgYznG68aem+0yRKziB8V4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04B1516BE39;
        Fri, 29 Oct 2021 19:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B49E016BE36;
        Fri, 29 Oct 2021 19:00:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 4/8] t1051: introduce a smudge filter test for
 extremely large files
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <ce9dfaac9f8693890aa402161b38292b31d3690c.1635515959.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 16:00:22 -0700
In-Reply-To: <ce9dfaac9f8693890aa402161b38292b31d3690c.1635515959.git.gitgitgadget@gmail.com>
        (Matt Cooper via GitGitGadget's message of "Fri, 29 Oct 2021 13:59:15
        +0000")
Message-ID: <xmqqo877h1x5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF9D940A-390B-11EC-8E40-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matt Cooper <vtbassmatt@gmail.com>
>
> The filter system allows for alterations to file contents when they're
> added to the database or workdir. ("Smudge" when moving to the workdir;
> "clean" when moving to the database.) This is used natively to handle CRLF
> to LF conversions. It's also employed by Git-LFS to replace large files
> from the workdir with small tracking files in the repo and vice versa.

Not a huge deal, but make it a habit to spell "working tree" not "workdir",
as someday you'd write end-user facing documentation in our tree ;-).
 
> Git pulls the entire smudged file into memory.

Giving "for what" would be helpful to readers.

    Git reads the entire smudged file into memory to convert it into
    a "clean" form to be used in-core.

> While this is inefficient,
> there's a more insidious problem on some platforms due to inconsistency
> between using unsigned long and size_t for the same type of data (size of
> a file in bytes). On most 64-bit platforms, unsigned long is 64 bits, and
> size_t is typedef'd to unsigned long. On Windows, however, unsigned long is
> only 32 bits (and therefore on 64-bit Windows, size_t is typedef'd to
> unsigned long long in order to be 64 bits).
>
> Practically speaking, this means 64-bit Windows users of Git-LFS can't
> handle files larger than 2^32 bytes. Other 64-bit platforms don't suffer
> this limitation.
>
> This commit introduces a test exposing the issue; future commits make it
> pass. The test simulates the way Git-LFS works by having a tiny file
> checked into the repository and expanding it to a huge file on checkout.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1051-large-conversion.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
> index 8b7640b3ba8..bff86c13208 100755
> --- a/t/t1051-large-conversion.sh
> +++ b/t/t1051-large-conversion.sh
> @@ -83,4 +83,18 @@ test_expect_success 'ident converts on output' '
>  	test_cmp small.clean large.clean
>  '
>  
> +# This smudge filter prepends 5GB of zeros to the file it checks out. This
> +# ensures that smudging doesn't mangle large files on 64-bit Windows.
> +test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +		'files over 4GB convert on output' '
> +	test_commit test small "a small file" &&
> +	test_config filter.makelarge.smudge \
> +		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
> +	echo "small filter=makelarge" >.gitattributes &&
> +	rm small &&
> +	git checkout -- small &&
> +	size=$(test_file_size small) &&
> +	test "$size" -ge $((5 * 1024 * 1024 * 1024))
> +'

Why not exactly 5G, but anything that is at least 5G is OK?

Thanks.

>  test_done
