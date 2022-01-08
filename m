Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479CC433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 02:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiAHCBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 21:01:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50601 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAHCBI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 21:01:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 550661716D4;
        Fri,  7 Jan 2022 21:01:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MaJvaNZYGE8gUuB6P8cCyrYbzoqVE6htBxDsHhrqQAk=; b=NKsZ
        uUm8WTqmMbMPngym58uMh85Ph8R8mCH1iiBnRf2vmFJ6LDUxmQkANyD3+/5/MwRZ
        c26NYO1AWcGlhLEErIaj3jhKk3Bp+B99c9RMcvO7C4ld/D1grF5VRhtvGCp3R43W
        FNtRjZD3eOvN9z3At/lWPxHBLH3OwQXTJFW/6jc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D67B1716D3;
        Fri,  7 Jan 2022 21:01:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BBE121716D1;
        Fri,  7 Jan 2022 21:01:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 6/6] refs: skip hooks when deleting uncovered packed
 refs
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
        <0fbf68dbf434986aa971961e20598675b2194d51.1641556319.git.ps@pks.im>
Date:   Fri, 07 Jan 2022 18:01:04 -0800
Message-ID: <xmqq1r1j3s0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6E212F0-7026-11EC-A38C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When deleting refs from the loose-files refs backend, then we need to be
> careful to also delete the same ref from the packed refs backend, if it
> exists. If we don't, then deleting the loose ref would "uncover" the
> packed ref. We thus always have to queue up deletions of refs for both
> the loose and the packed refs backend. This is done in two separate
> transactions, where the end result is that the reference-transaction
> hook is executed twice for the deleted refs.
>
> This behaviour is quite misleading: it's exposing implementation details
> of how the files backend works to the user, in contrast to the logical
> updates that we'd really want to expose via the hook. Worse yet, whether
> the hook gets executed once or twice depends on how well-packed the
> repository is: if the ref only exists as a loose ref, then we execute it
> once, otherwise if it is also packed then we execute it twice.

If the ref only exists as a packed ref, what happens? ...

> Fix this behaviour and don't execute the reference-transaction hook at
> all when refs in the packed-refs backend if it's driven by the files
> backend.

... We try to remove from the loose backend, which would say "nah,
it did not exist in my store".  I am not sure if it should execute
the delete hook in such a case for the ref.  But if it does not, not
running the hook in the ref transaction for packed backend driven by
the loose backend would mean nobody notifies the deletion of the
ref, no?

To me, it seems that the only case this strategy would work
correctly is when the files backend calls deletion hook for a
request to delete nonexistent ref, which by itself sounds like a
problem.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c             | 9 ++++++---
>  t/t1416-ref-transaction-hooks.sh | 7 +------
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3c0f3027fe..9a20cb8fa8 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1261,7 +1261,8 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
>  		goto error;
>  
> -	transaction = ref_store_transaction_begin(refs->packed_ref_store, 0, &err);
> +	transaction = ref_store_transaction_begin(refs->packed_ref_store,
> +						  REF_TRANSACTION_SKIP_HOOK, &err);
>  	if (!transaction)
>  		goto error;
>  
> @@ -2775,7 +2776,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  			 */
>  			if (!packed_transaction) {
>  				packed_transaction = ref_store_transaction_begin(
> -						refs->packed_ref_store, 0, err);
> +						refs->packed_ref_store,
> +						REF_TRANSACTION_SKIP_HOOK, err);
>  				if (!packed_transaction) {
>  					ret = TRANSACTION_GENERIC_ERROR;
>  					goto cleanup;
> @@ -3046,7 +3048,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
>  				 &affected_refnames))
>  		BUG("initial ref transaction called with existing refs");
>  
> -	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store, 0, err);
> +	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
> +							 REF_TRANSACTION_SKIP_HOOK, err);
>  	if (!packed_transaction) {
>  		ret = TRANSACTION_GENERIC_ERROR;
>  		goto cleanup;
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index f9d3d5213f..4e1e84a91f 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -175,16 +175,11 @@ test_expect_success 'deleting packed ref calls hook once' '
>  	git update-ref -d refs/heads/to-be-deleted $POST_OID &&
>  
>  	# We only expect a single hook invocation, which is the logical
> -	# deletion. But currently, we see two interleaving transactions, once
> -	# for deleting the loose refs and once for deleting the packed ref.
> +	# deletion.
>  	cat >expect <<-EOF &&
> -		prepared
> -		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
>  		prepared
>  		$POST_OID $ZERO_OID refs/heads/to-be-deleted
>  		committed
> -		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
> -		committed
>  		$POST_OID $ZERO_OID refs/heads/to-be-deleted
>  	EOF
