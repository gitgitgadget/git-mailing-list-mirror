Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC16C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0781761165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhDIFUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 01:20:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63897 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhDIFUo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 01:20:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 882C91322B6;
        Fri,  9 Apr 2021 01:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+HHD29jx/bZK9BYsqVXnoqZQWpk=; b=xvat7G
        OFbZfHfNw+IgfTZdVW820WM6/yhoXHrii5gh2ffnWWQIEGtAm21tpsDEN0+4B5Z7
        AFdGbyJKgcbfpXOhzRWi2SZy38WaOutBNjm0rmkBBGQR4/rjQMjcmslMW6nFRkTW
        bZvduQMo3AwL5SKU7uF2sHsNDHb5oqVidLHmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cI5qBRTdNeKhn5yG37upqpGJinjCiqH5
        fY5BTCigQnDOo7ggwo+09Py4HI/bdljk3LwB46u4wWnEN/UpSq0N5bpWRZVZKsQT
        D/3yQfc8nHC0+YFyIBJEPKWfjSbfbxK1MOqHmiU3NZouifrwXOTgX/QTUxMaKmuI
        GqPD1Ml9LM0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F4231322B5;
        Fri,  9 Apr 2021 01:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 712781322B4;
        Fri,  9 Apr 2021 01:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] fetch-pack: refactor add_haves()
References: <cover.1617929278.git.jonathantanmy@google.com>
        <b07e52ec18f46fb85d49ba0e1e6e8ad22845af9e.1617929278.git.jonathantanmy@google.com>
Date:   Thu, 08 Apr 2021 22:20:27 -0700
In-Reply-To: <b07e52ec18f46fb85d49ba0e1e6e8ad22845af9e.1617929278.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 8 Apr 2021 18:10:00 -0700")
Message-ID: <xmqqlf9sniec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C9D38AA-98F3-11EB-A478-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A subsequent commit will need part, but not all, of the functionality in
> add_haves(), so move some of its functionality to its sole caller
> send_fetch_request().
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 9f3901cdba..128ad47d2a 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1195,11 +1195,9 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
>  }
>  
>  static int add_haves(struct fetch_negotiator *negotiator,
> -		     int seen_ack,
>  		     struct strbuf *req_buf,
> -		     int *haves_to_send, int *in_vain)
> +		     int *haves_to_send)
>  {
> -	int ret = 0;
>  	int haves_added = 0;
>  	const struct object_id *oid;
>  
> @@ -1209,17 +1207,10 @@ static int add_haves(struct fetch_negotiator *negotiator,
>  			break;
>  	}
>  
> -	*in_vain += haves_added;
> -	if (!haves_added || (seen_ack && *in_vain >= MAX_IN_VAIN)) {
> -		/* Send Done */
> -		packet_buf_write(req_buf, "done\n");
> -		ret = 1;
> -	}
> -
>  	/* Increase haves to send on next round */
>  	*haves_to_send = next_flush(1, *haves_to_send);
>  
> -	return ret;
> +	return haves_added;
>  }

OK, so the helper used to

 - send out have's
 - increment *in_vain with the number of have's sent out
 - decide when to send done and send it
 - increase haves-to-send for the next round.

But the new version skips the second and third step, and let the
caller be responsible for in_vain management.  The only piece of
information the caller needs to do so from this function is the
number of have's we send out, so that is what we return from the
function.

> -	/* Add initial haves */
> -	ret = add_haves(negotiator, seen_ack, &req_buf,
> -			haves_to_send, in_vain);
> +	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
> +	*in_vain += haves_added;
> +	if (!haves_added || (seen_ack && *in_vain >= MAX_IN_VAIN)) {
> +		/* Send Done */
> +		packet_buf_write(&req_buf, "done\n");
> +		done_sent = 1;
> +	}

And indeed, this caller does the *in_vain management add_haves()
used to do and give "done" as needed.

> @@ -1322,7 +1318,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  		die_errno(_("unable to write request to remote"));
>  
>  	strbuf_release(&req_buf);
> -	return ret;
> +	return done_sent;

And of course, the value returned by this function is if we sent
"done", which is far easier to see with the new variable name.

Again, very nicely done.

