Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDE52047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbdHGSgh (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:36:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57855 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751429AbdHGSgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:36:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C9679D2DF;
        Mon,  7 Aug 2017 14:36:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7rJNq7XoElKJ7nrUKqsmvrTswkM=; b=gLOd4f
        N35MPIiAh7fkxrvLT4rPlQi72e5p5wP+0/C7GvS4Y6qHyVroX6HjprX0tSpwN8kn
        Nj6cLrwxYBr3jlD5mgPiukND7X+47Vs02IqfJ3TqcVZWjPo4SkDp0HVg3MvP1NFn
        YdCmMebdqPMsn98x9sz2RXdQreeoH+mt+QVkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y6ZrSpX6hVDTqMjjOezvDODH2qaMxmUC
        k//e0L7xRYEQ5SijeBsc02/rUd3gwWXHvaI1WfjJo7K8yXbRJNIIbSVbYR9vuE5h
        G+GnWouGEjuWEjFH43KyhO9pnbEsEHo7ka08ink2rdJuffloXjTREAw6uq7w79Rd
        vwN9M39XmTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 154319D2DE;
        Mon,  7 Aug 2017 14:36:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 783C59D2DD;
        Mon,  7 Aug 2017 14:36:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
Date:   Mon, 07 Aug 2017 11:36:29 -0700
In-Reply-To: <1502129437-31226-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Mon, 7 Aug 2017 20:10:37 +0200")
Message-ID: <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54752DC8-7B9F-11E7-9ABF-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> The current delta code produces incorrect pack objects for files > 4GB.
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  diff-delta.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> Just pass any file > 4 GB to the delta-compression [by increasing the delta limits].
> As file size, a truncated 32bit value will be encoded, leading to broken pack files.

The patch obviously makes the code better and self consistent in
that "struct delta_index" has src_size as ulong, and this function
takes trg_size as ulong, and it was plain wrong for the code to
assume that "i", which is uint, can receive it safely.

In the longer term we might want to move to size_t or even
uintmax_t, as the ulong on a platform may not be long enough in
order to express the largest file size the platform can have, but
this patch (1) is good even without such a change, and (2) gives a
good foundation to build on if we want such a change on top.

Thanks.  Will queue.

>
> diff --git a/diff-delta.c b/diff-delta.c
> index 3797ce6..13e5a01 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -319,7 +319,8 @@ create_delta(const struct delta_index *index,
>  	     const void *trg_buf, unsigned long trg_size,
>  	     unsigned long *delta_size, unsigned long max_size)
>  {
> -	unsigned int i, outpos, outsize, moff, msize, val;
> +	unsigned int i, val;
> +	unsigned long l, outpos, outsize, moff, msize;
>  	int inscnt;
>  	const unsigned char *ref_data, *ref_top, *data, *top;
>  	unsigned char *out;
> @@ -336,20 +337,20 @@ create_delta(const struct delta_index *index,
>  		return NULL;
>  
>  	/* store reference buffer size */
> -	i = index->src_size;
> -	while (i >= 0x80) {
> -		out[outpos++] = i | 0x80;
> -		i >>= 7;
> +	l = index->src_size;
> +	while (l >= 0x80) {
> +		out[outpos++] = l | 0x80;
> +		l >>= 7;
>  	}
> -	out[outpos++] = i;
> +	out[outpos++] = l;
>  
>  	/* store target buffer size */
> -	i = trg_size;
> -	while (i >= 0x80) {
> -		out[outpos++] = i | 0x80;
> -		i >>= 7;
> +	l = trg_size;
> +	while (l >= 0x80) {
> +		out[outpos++] = l | 0x80;
> +		l >>= 7;
>  	}
> -	out[outpos++] = i;
> +	out[outpos++] = l;
>  
>  	ref_data = index->src_buf;
>  	ref_top = ref_data + index->src_size;
