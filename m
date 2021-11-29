Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E55C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhK2XZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:25:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59137 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhK2XZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:25:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1930E7BAC;
        Mon, 29 Nov 2021 18:22:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qeARW6aUx06CVp5hHq0CMxokzZWJz6wc0KnDIy
        LIajI=; b=Gbkvehh3j24J+gmY1zD1ym/9ke1hlTnMRLNw6pbTLan/uN6amzViTf
        +iJB3q/BMAMKKzfOPbYZz4lX6of+BApasUtcHHRMPN0MstCC/a2WwMpPeZ9n8dM8
        CPChnRj2Rier1TX1KTVVrYr3vFUiLYQySmqheVbwyX8o+M75rbIC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C84C0E7BAB;
        Mon, 29 Nov 2021 18:22:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BB5DE7BAA;
        Mon, 29 Nov 2021 18:22:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:22:23 -0800
In-Reply-To: <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 29 Nov 2021
        18:49:44 +0000")
Message-ID: <xmqqk0gq4keo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3580EDC0-516B-11EC-9CF7-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Use this flag with the test-helper in t1430, to avoid direct writes to the ref
> database.

OK, this is similar to 3/6 where invalid object names are allowed.
This is about allowing invalid refnames.  Makes sense.



> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c                  |  7 ++---
>  refs.h                  | 10 +++++--
>  t/t1430-bad-ref-name.sh | 59 ++++++++++++++++++++++-------------------
>  3 files changed, 44 insertions(+), 32 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d7cc0a23a3b..086b1341d2a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1078,9 +1078,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  {
>  	assert(err);
>  
> -	if ((new_oid && !is_null_oid(new_oid)) ?
> -	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
> -	    !refname_is_safe(refname)) {
> +	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
> +	    ((new_oid && !is_null_oid(new_oid)) ?
> +		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
> +			   !refname_is_safe(refname))) {

OK.  Initially my eyes went "Huh?", but it was just re-indentation
that fooled them.

> @@ -617,12 +617,18 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>   */
>  #define REF_SKIP_OID_VERIFICATION (1 << 10)
>  
> +/*
> + * Skip verifying refname. This is useful for testing data corruption scenarios.
> + */
> +#define REF_SKIP_REFNAME_VERIFICATION (1 << 11)

OK.
