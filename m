Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD03C001DF
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 23:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGaXOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjGaXON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 19:14:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E74E49
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:14:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 362801C88F;
        Mon, 31 Jul 2023 19:14:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PYxuXz7wqJM3twtfG8Rt/DVfK+EH5iMCS9mQqs
        4Xipc=; b=kW7Md8Ndp57La16NJZOGcGtsgaep3KjTgEmXwUlytMA2oT3t0w3GW7
        AAdQCgZ8BkN1+xUzbnfsIzqraHXMsBYwFibn5rEgxyoUFrs1Zp7jEiGTWb4IPIer
        CFxlCeLp1HK7QoTF30FmXEUQ+bWFYHSFLwi9aDznrgzyDkVWVLArM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21CBD1C88E;
        Mon, 31 Jul 2023 19:14:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3B611C88D;
        Mon, 31 Jul 2023 19:14:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] update-index: use unmerge_index_entry() to support
 removal
References: <20230731224409.4181277-1-gitster@pobox.com>
        <20230731224409.4181277-4-gitster@pobox.com>
Date:   Mon, 31 Jul 2023 16:14:06 -0700
In-Reply-To: <20230731224409.4181277-4-gitster@pobox.com> (Junio C. Hamano's
        message of "Mon, 31 Jul 2023 15:44:05 -0700")
Message-ID: <xmqqleev3c8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F320B09C-2FF7-11EE-BD7F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> @@ -122,6 +128,8 @@ test_expect_success 'add records checkout -m undoes' '
>  test_expect_success 'unmerge with plumbing' '
>  	prime_resolve_undo &&
>  	git update-index --unresolve fi/le &&
> +	git ls-files --resolve-undo fi/le >actual &&
> +	test_must_be_empty actual &&
>  	git ls-files -u >actual &&
>  	test_line_count = 3 actual
>  '

This addition, and matching invocations of "ls-files --resolve-undo"
in the next tests, are not explained in the proposed log message.

The reason for the addition is because "update-index --unresolve"
tests did not make sure that resolve-undo records that are used to
recreate conflicted states are removed from the index, like simiar
tests for "checkout --merge".  As we are changing the implementation
to unmerge index entries, we do not want to regress and these are
filling the gap of the test coverage.

I've clarified it in the draft for the next iteration.

	Side note: careful audience may have noticed this already,
	but yes, this is setting an example of the recent update to
	"my patch was sent, now what?" document, where we discourage
	sending rerolls without giving readers enough time to digest
	the first iteration, and instead tell them to note what will
	change in their next iteration.

> @@ -130,6 +138,27 @@ test_expect_success 'unmerge can be done even after committing' '
>  	prime_resolve_undo &&
>  	git commit -m "record to nuke MERGE_HEAD" &&
>  	git update-index --unresolve fi/le &&
> +	git ls-files --resolve-undo fi/le >actual &&
> +	test_must_be_empty actual &&
> +	git ls-files -u >actual &&
> +	test_line_count = 3 actual
> +'
> +
> +test_expect_success 'unmerge removal' '
> +	prime_resolve_undo remove &&
> +	git update-index --unresolve fi/le &&
> +	git ls-files --resolve-undo fi/le >actual &&
> +	test_must_be_empty actual &&
> +	git ls-files -u >actual &&
> +	test_line_count = 3 actual
> +'
> +
> +test_expect_success 'unmerge removal after committing' '
> +	prime_resolve_undo remove &&
> +	git commit -m "record to nuke MERGE_HEAD" &&
> +	git update-index --unresolve fi/le &&
> +	git ls-files --resolve-undo fi/le >actual &&
> +	test_must_be_empty actual &&
>  	git ls-files -u >actual &&
>  	test_line_count = 3 actual
>  '
