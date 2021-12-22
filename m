Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4DCC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 20:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345377AbhLVULN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:11:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64075 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbhLVULM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 15:11:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 594D3150C74;
        Wed, 22 Dec 2021 15:11:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YCvZANrvR/hwmSJRBTHxku+mAnK9ZuIQ03gUx9
        PHY5w=; b=vs3UTRdQ5amawvweQtufIJjEb00zMfRtCIGNZFoHddKfF4b8BQtUuB
        1oxBLpiw2GgfdJyPJqJ8k1PzwN1yIowptl6ohkOrr9E9/pQoooJFIQcPsxfhE2oG
        os5eux75x2VbmfwjOnWOW2q2W0vKPo7nyDuJ2/Zr0iumrGx5tUYKU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 513E1150C72;
        Wed, 22 Dec 2021 15:11:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85B5D150C71;
        Wed, 22 Dec 2021 15:11:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/4] t7004: create separate tags for different tests
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
        <854bd15787618978b2da3941b5b749dadc1a186f.1640170784.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 12:11:07 -0800
In-Reply-To: <854bd15787618978b2da3941b5b749dadc1a186f.1640170784.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 22 Dec 2021
        10:59:43 +0000")
Message-ID: <xmqqo858ien8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CF46A54-6363-11EC-98D5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Reftable intentionally keeps reflog data for deleted refs.
>
> This breaks tests that delete and recreate "refs/tags/tag_with_reflog" as traces
> of the deletion are left in reflog. To resolve this, use a differently named ref
> for each test case.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---

Makes sense.  

These tests are *not* trying to see if a ref is recreated, its logs
will reflect only the events after the last such recreation event.

The only thing they care about is that the logs record the events
after the ref was created the last time.

Hmmm, is it?  After spelling it out like the above to make sure I
understand the argument, I am not so sure.  If these tests are
surprised to see reflog entries from the previous life, it will
certainly surprise users and their tools if we suddenly start
showing them without being told.  Their expectation is that a
deletion and recreation is a life resetting event for a ref.

It feels as if we would need a new option in reflog traversal to
take advantage of the new capability reftable offers (i.e. "git
reflog --show-previous-life"), which, use of it is an error if the
backend does not support it.  An alternative is to document it, when
reftable integration happens, as a limitation of files-backend that
it cannot store or show the logs of the ref from its previous life.

I do not care too deeply about it either way right now, because this
patch allows us sidestep the design issue altogether in this test
script.  But we need to think about it when integrating the reftable
backend into refs API.

Thanks.

>  t/t7004-tag.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 082be85dffc..301d1190482 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -94,10 +94,10 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
>  	git log -1 \
>  		--format="format:tag: tagging %h (%s, %cd)%n" \
>  		--date=format:%Y-%m-%d >expected &&
> -	test_when_finished "git tag -d tag_with_reflog" &&
> -	git tag --create-reflog tag_with_reflog &&
> -	git reflog exists refs/tags/tag_with_reflog &&
> -	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
> +	test_when_finished "git tag -d tag_with_reflog1" &&
> +	git tag --create-reflog tag_with_reflog1 &&
> +	git reflog exists refs/tags/tag_with_reflog1 &&
> +	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog1 >actual &&
>  	test_cmp expected actual
>  '
>  
> @@ -105,10 +105,10 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
>  	git log -1 \
>  		--format="format:tag: tagging %h (%s, %cd)%n" \
>  		--date=format:%Y-%m-%d >expected &&
> -	test_when_finished "git tag -d tag_with_reflog" &&
> -	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
> -	git reflog exists refs/tags/tag_with_reflog &&
> -	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
> +	test_when_finished "git tag -d tag_with_reflog2" &&
> +	git tag -m "annotated tag" --create-reflog tag_with_reflog2 &&
> +	git reflog exists refs/tags/tag_with_reflog2 &&
> +	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog2 >actual &&
>  	test_cmp expected actual
>  '
>  
> @@ -118,10 +118,10 @@ test_expect_success '--create-reflog does not create reflog on failure' '
>  '
>  
>  test_expect_success 'option core.logAllRefUpdates=always creates reflog' '
> -	test_when_finished "git tag -d tag_with_reflog" &&
> +	test_when_finished "git tag -d tag_with_reflog3" &&
>  	test_config core.logAllRefUpdates always &&
> -	git tag tag_with_reflog &&
> -	git reflog exists refs/tags/tag_with_reflog
> +	git tag tag_with_reflog3 &&
> +	git reflog exists refs/tags/tag_with_reflog3
>  '
>  
>  test_expect_success 'listing all tags if one exists should succeed' '
