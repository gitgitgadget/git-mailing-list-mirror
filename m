Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DD41F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGBTGP (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:06:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63143 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBTGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:06:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E75B1153D60;
        Tue,  2 Jul 2019 15:06:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kYYFUlAcWqjBWWnTOsh6ksZTurw=; b=FuHB0b
        Jyc9tJEseWrravJA3Xleya+FkYVbSYM4b5eJxiTCtSDNBsBydApBfY4MRVk5Or/e
        OjYaOtJo2ixr7jkBA2GtqnNBVHnHLm9S06Gy5/KT7F4dNe44s2aoRJcvyXqeh7WV
        Ei7IrWGeTmWie0qzlu1HuhyN8J9kBdbtpataQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dQnpdSTJRqbXGd+HCmLz2IlDp1QP/N6G
        MPGJUH1Cj8Q8HQSYl90Lq9ELFg3u3FMrfFeArzzPgN3yTPbf/8gTVDWhA8JjRNk1
        8eBDqpijReaXgnjOR+pKGRpiDqP+giWItWX73fGswzZxZx1e2HsJLb5tLQbddQpX
        ZDemXNzsIkU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF714153D5F;
        Tue,  2 Jul 2019 15:06:09 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19990153D5E;
        Tue,  2 Jul 2019 15:06:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
Date:   Tue, 02 Jul 2019 12:06:07 -0700
In-Reply-To: <20190702005340.66615-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Mon, 1 Jul 2019 17:53:40 -0700")
Message-ID: <xmqq1rz845pc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73466B6A-9CFC-11E9-9E4A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/transport-helper.c b/transport-helper.c
> index c7e17ec9cb..6b05a88faf 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -853,6 +853,7 @@ static int push_refs_with_push(struct transport *transport,
>  {
>  	int force_all = flags & TRANSPORT_PUSH_FORCE;
>  	int mirror = flags & TRANSPORT_PUSH_MIRROR;
> +	int atomic = flags & TRANSPORT_PUSH_ATOMIC;
>  	struct helper_data *data = transport->data;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct ref *ref;
> @@ -872,6 +873,11 @@ static int push_refs_with_push(struct transport *transport,
>  		case REF_STATUS_REJECT_NONFASTFORWARD:
>  		case REF_STATUS_REJECT_STALE:
>  		case REF_STATUS_REJECT_ALREADY_EXISTS:
> +			if (atomic) {
> +				string_list_clear(&cas_options, 0);
> +				return 0;
> +			} else
> +				continue;

Ah, this looks vaguely familiar.  Thanks for resurrecting the topic.

The clearing is merely to avoid leaks, and the primary change to the
function is to immediately return 0.

>  		case REF_STATUS_UPTODATE:
>  			continue;
>  		default:
> diff --git a/transport.c b/transport.c
> index f1fcd2c4b0..f4d6b38f9d 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1226,10 +1226,23 @@ int transport_push(struct repository *r,
>  		err = push_had_errors(remote_refs);
>  		ret = push_ret | err;

Here, before reporting the push result, when we are doing ATOMIC,
we tweak the result we are going to report to atomic-push-failed.

> +		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
> +			for (struct ref *it = remote_refs; it; it = it->next)
> +				switch (it->status) {
> +				case REF_STATUS_NONE:
> +				case REF_STATUS_UPTODATE:
> +				case REF_STATUS_OK:
> +					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> +				default:
> +					continue;
> +				}
> +		}

This roughly corresponds to what send-pack.c::atomic_push_failure()
does.  Here, we avoid overwriting a status that already signals a
failure.  The list of "good" statuses used here match what is used
at the end of send_pack.c::send_pack(), which decides the final
outcome of "git push" for the native transport.

Looks good.

By the way, I rearranged the patch as I happen to agree with Dscho
that the additional {} was unwarranted and made it harder to review.
It is clear that we need to tweak the status before reporting.

>
> 		if (!quiet || err)
>  			transport_print_push_status(transport->url, remote_refs,
>  					verbose | porcelain, porcelain,
>  					reject_reasons);
>  
>  		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
>  			set_upstreams(transport, remote_refs, pretend);
