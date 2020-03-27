Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19434C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E114A20714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 19:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a0ulaLDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0T7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:59:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59304 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0T7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 15:59:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10CC6BBF20;
        Fri, 27 Mar 2020 15:59:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D17LdkwUdR0fRDUvVj9NfQFCPqU=; b=a0ulaL
        DFUrqQaGXLgVARfUzJ19/IK5SkCHNKCuZsYJmIu/2XamFBU6GdlgCEiJLMIo4U+g
        QOMoXMv4JWW5x5bcdo0oh6LF3o/2cqzP5tQyijd3mh7jq4cocEmywX4N0hy/1DOy
        qywaXHZZDBCoX2UcJeWK2DddvCFI0Q7DFxTCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fEmo0Jxs1QuA7a5jndz4enEwaEawHUDF
        pfBCZEf69j+BRzIIIH/FP3CJxWtaiAOUPsa+Q3kmmdwdD/qSnOI0SaeWuQ99JVFQ
        bIFOTbQ+GZdNqqQB5UZCc6orLxW7z/96HHykIXESCjgNCowuEUgXO+n9Es9A1rJP
        y9bctRAXdkY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 074A8BBF1F;
        Fri, 27 Mar 2020 15:59:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49BECBBF1C;
        Fri, 27 Mar 2020 15:59:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/9] refs: fix segfault when aborting empty transaction
References: <cover.1585129842.git.ps@pks.im>
        <3c7f8c47f361c46751629b44570657ef811d94d0.1585129842.git.ps@pks.im>
Date:   Fri, 27 Mar 2020 12:59:25 -0700
In-Reply-To: <3c7f8c47f361c46751629b44570657ef811d94d0.1585129842.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 25 Mar 2020 10:53:28 +0100")
Message-ID: <xmqqwo75fu1u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76AB5D8C-7065-11EA-876A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When cleaning up a transaction that has no updates queued, then the
> transaction's backend data will not have been allocated. We correctly
> handle this for the packed backend, where the cleanup function checks
> whether the backend data has been allocated at all -- if not, then there
> is nothing to clean up. For the files backend we do not check this and
> as a result will hit a segfault due to dereferencing a `NULL` pointer
> when cleaning up such a transaction.
>
> Fix the issue by checking whether `backend_data` is set in the files
> backend, too.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Makes sense.  Will queue.  Thanks.

>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 561c33ac8a..6516c7bc8c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2565,17 +2565,19 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
>  		}
>  	}
>  
> -	if (backend_data->packed_transaction &&
> -	    ref_transaction_abort(backend_data->packed_transaction, &err)) {
> -		error("error aborting transaction: %s", err.buf);
> -		strbuf_release(&err);
> +	if (backend_data) {
> +		if (backend_data->packed_transaction &&
> +		    ref_transaction_abort(backend_data->packed_transaction, &err)) {
> +			error("error aborting transaction: %s", err.buf);
> +			strbuf_release(&err);
> +		}
> +
> +		if (backend_data->packed_refs_locked)
> +			packed_refs_unlock(refs->packed_ref_store);
> +
> +		free(backend_data);
>  	}
>  
> -	if (backend_data->packed_refs_locked)
> -		packed_refs_unlock(refs->packed_ref_store);
> -
> -	free(backend_data);
> -
>  	transaction->state = REF_TRANSACTION_CLOSED;
>  }
