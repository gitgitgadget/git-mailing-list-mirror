Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48520207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 19:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760478AbcIWTkS (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 15:40:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54278 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760391AbcIWTkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 15:40:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E48A3FB5C;
        Fri, 23 Sep 2016 15:40:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gcUYdSJgdKaGx+zOwNxmR9ZhG4k=; b=eig7Ej
        DhbGjRpgkjYf9vsEvqryCzCqIZQNUcee0DkPUvRymCW1e74S5qtwQJ9+rbxrdaDo
        5lQdC8CWDccZyiuszpP2PMQdMQitGuHgLqt0A5vp0sFEwvkPRTnyc2nByDvm1ZNf
        sf04DfkN11XPljQgLKejS/6TfRW+X1pfdnKFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mneJEi6Z1mcUwpwko+W++hMOuQuqiU5i
        NG+eKRwBcq32neo+9keE8w05zIgm13dzHY0IVNVTIvRkw37RKMfZz83TYWvdn+xH
        IgdGcBwu0yhaX/wPPQhAieSh6DB6wSqzRXp5mfsizjopg4+vXjEb0oOIcmEvCw7S
        ooh1sk9YiEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4602D3FB5B;
        Fri, 23 Sep 2016 15:40:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB6433FB5A;
        Fri, 23 Sep 2016 15:40:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch-pack: do not reset in_vain on non-novel acks
References: <xmqqfuor4s4z.fsf@gitster.mtv.corp.google.com>
        <1474652495-26051-1-git-send-email-jonathantanmy@google.com>
Date:   Fri, 23 Sep 2016 12:40:12 -0700
In-Reply-To: <1474652495-26051-1-git-send-email-jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 23 Sep 2016 10:41:35 -0700")
Message-ID: <xmqq1t0a1k2r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C8B0E0A-81C5-11E6-9EB8-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I tried looking at creating a helper function to reduce both the size
> and the nesting level of the loop, but it seems to me that a helper
> function can't be extracted so easily because the logic is quite
> intertwined with the rest of the function. For example, the "if
> (args->stateless_rpc..." block uses 6 variables from the outer scope:
> args, ack, commit, result_sha1, req_buf, and state_len (and in_vain, but
> this can be the return value of the function). Expanding it wider would
> allow us to make some of those 6 local, but also introduce new ones from
> the outer scope.

Yup, I suspected that much when I wrote the message you are
responding to, but was sort-of hoping that you might come up with a
more clever way to restructure the code.  It is OK to leave it
as-is, and let others try making it cleaner ;-).

Thanks.

>
>  fetch-pack.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 85e77af..413937e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -428,10 +428,17 @@ static int find_common(struct fetch_pack_args *args,
>  						const char *hex = sha1_to_hex(result_sha1);
>  						packet_buf_write(&req_buf, "have %s\n", hex);
>  						state_len = req_buf.len;
> -					}
> +						/*
> +						 * Reset in_vain because an ack
> +						 * for this commit has not been
> +						 * seen.
> +						 */
> +						in_vain = 0;
> +					} else if (!args->stateless_rpc
> +						   || ack != ACK_common)
> +						in_vain = 0;
>  					mark_common(commit, 0, 1);
>  					retval = 0;
> -					in_vain = 0;
>  					got_continue = 1;
>  					if (ack == ACK_ready) {
>  						clear_prio_queue(&rev_list);
