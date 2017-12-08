Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263341FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbdLHSoS (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:44:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55762 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751268AbdLHSoS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:44:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D2B8D29E1;
        Fri,  8 Dec 2017 13:44:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zC+jWRzEHD+T
        HUBcDJiB8yEvtGk=; b=TZzr+Mc+eqpHP4kZhN/DiA4k3xrEKi3iumwQkMm05/Go
        +Glc3AJeGmQhhMLahQnyZQvxoXFXVduhgo7UW8OUDekSoY3Ln1j18CG/YC369Cd5
        idSpM8ZHl1sHY3Saw2CIWeruQrjJwsjzjbjKfHOjJJ+zNHKQQ0CqhHoTJqboM6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pvPFeR
        aiwQU4bXhUUu8+TNO0MKOCnQL1KOe17iJZdvEG6198QcfhkbN0lcBrOhgXdpQ1cy
        3Rq4OW4lz29k201N1tIJv7nrp9Mufyt04vQ/6XuoYa4O2fFcllJWiyMIEXbmJ1qd
        vc4LxaPh9JRHB02wrEnwmpV86ZEOzlvPyBiN8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65599D29E0;
        Fri,  8 Dec 2017 13:44:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAAF7D29DF;
        Fri,  8 Dec 2017 13:44:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
        <20171207212735.GD12850@sigill.intra.peff.net>
        <e1daa2b6-004b-ad66-b84d-84fa70a44baf@web.de>
Date:   Fri, 08 Dec 2017 10:44:15 -0800
In-Reply-To: <e1daa2b6-004b-ad66-b84d-84fa70a44baf@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 8 Dec 2017 18:29:31 +0100")
Message-ID: <xmqq609h83gg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB44066E-DC47-11E7-B811-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 07.12.2017 um 22:27 schrieb Jeff King:
>> Grepping for "list_append.*detach" shows a few other possible cases in
>> transport-helper.c, which I think are leaks.
>
> -- >8 --
> Subject: [PATCH] transport-helper: plug strbuf and string_list leaks
>
> Transfer ownership of detached strbufs to string_lists of the
> duplicating variety by calling string_list_append_nodup() instead of
> string_list_append() to avoid duplicating and then leaking the buffer.
>
> While at it make sure to release the string_list when done;
> push_refs_with_export() already does that.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  transport-helper.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index bf05a2dcf1..f682e7c534 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -882,7 +882,8 @@ static int push_refs_with_push(struct transport *tr=
ansport,
>  			struct strbuf cas =3D STRBUF_INIT;
>  			strbuf_addf(&cas, "%s:%s",
>  				    ref->name, oid_to_hex(&ref->old_oid_expect));
> -			string_list_append(&cas_options, strbuf_detach(&cas, NULL));
> +			string_list_append_nodup(&cas_options,
> +						 strbuf_detach(&cas, NULL));
>  		}
>  	}
>  	if (buf.len =3D=3D 0) {
> @@ -897,6 +898,7 @@ static int push_refs_with_push(struct transport *tr=
ansport,
>  	strbuf_addch(&buf, '\n');
>  	sendline(data, &buf);
>  	strbuf_release(&buf);
> +	string_list_release(&cas_options, 0);

There is no such function; you meant _clear() perhaps?
