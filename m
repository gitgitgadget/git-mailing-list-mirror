Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC55C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 21:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiEIVID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiEIVH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 17:07:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5E2618CF
        for <git@vger.kernel.org>; Mon,  9 May 2022 14:04:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1B5A1828B4;
        Mon,  9 May 2022 17:04:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tRsE5r5Cy43TrLBQnEe1p7QiBp7/jIhsxFNjTO
        JuYSk=; b=uZ7sq0/9k0LzpMDYPPzbAEztgrHagsUGay9Wq2Tbiwnf+rhoxWoNNe
        fZNQjNaWiG2C2SFbsmCsBcoUB8SfgYVciyh6L6G+jwg7VgRuAoxs5eJIfAzQKQid
        7cvgBjY3iacQgYskPrWdXguCu2mn2sS4fOK4j1o/8Tt7+fymTu/io=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA4FB1828B3;
        Mon,  9 May 2022 17:04:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73EBE1828B1;
        Mon,  9 May 2022 17:03:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 04/15] test-dir-iterator: consistently return
 EXIT_FAILURE or EXIT_SUCCESS
References: <20220509175159.2948802-1-kioplato@gmail.com>
        <20220509175159.2948802-5-kioplato@gmail.com>
Date:   Mon, 09 May 2022 14:03:57 -0700
In-Reply-To: <20220509175159.2948802-5-kioplato@gmail.com> (Plato
        Kiorpelidis's message of "Mon, 9 May 2022 20:51:48 +0300")
Message-ID: <xmqq35hictaa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B621B44-CFDB-11EC-BF5F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plato Kiorpelidis <kioplato@gmail.com> writes:

> Throughout test-dir-iterator.c we were returning/exiting with either
> integers or EXIT_FAILURE. Improve readability and reduce mental load
> by being consistent with what test-dir-iterator returns through the
> test-tool. Returning mixed constants and integers could indicate that
> it matters for some reason e.g. architecture of test-tool and cmd__*
> functions.
>
> EXIT_SUCCESS and EXIT_FAILURE are specified by the C standard.
> That makes the code more portable and standardized.

And less portable for the invoking process of "git".  The invoking
process used to be able to depend ou getting WEXITSTATUS() from our
exit status to obtain "1" when we exited with 1; if we start exiting
with EXIT_FAILURE, there is no guarantee what non-zero value is used.

So, I am not sure if this is a good direction to go in.

> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>  t/helper/test-dir-iterator.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Especially given that this is a helper for testing, we may want to
return/exit with different non-zero value at different places to
make it easier for the test script to tell where in the program we
decided to exit a failure.  IOW, if we return not EXIT_FAILURE but 2
(or whatever value that is not used elsewhere) in the first hunk,
and let the second hunk continue to return 1, then the calling test
script can tell which one decided to fail.

As to EXIT_SUCCESS, I do not have a strong opinion against it, but
because EXIT_FAILURE is a bad idea, we probably should avoid it for
consistency.

Thanks.

> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index 659b6bfa81..81e931673e 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -39,7 +39,7 @@ int cmd__dir_iterator(int argc, const char **argv)
>  
>  	if (!diter) {
>  		printf("dir_iterator_begin failure: %s\n", error_name(errno));
> -		exit(EXIT_FAILURE);
> +		return EXIT_FAILURE;
>  	}
>  
>  	while ((iter_status = dir_iterator_advance(diter)) == ITER_OK) {
> @@ -58,8 +58,8 @@ int cmd__dir_iterator(int argc, const char **argv)
>  
>  	if (iter_status != ITER_DONE) {
>  		printf("dir_iterator_advance failure\n");
> -		return 1;
> +		return EXIT_FAILURE;
>  	}
>  
> -	return 0;
> +	return EXIT_SUCCESS;
>  }
