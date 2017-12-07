Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E3820954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdLGVrR (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:47:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55255 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750862AbdLGVrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:47:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 014BCC559F;
        Thu,  7 Dec 2017 16:47:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RxNCkR4bvldW
        H7aW10fwaiQGNL8=; b=anc1oXh5YvcNIU5MRJK7r5RDgVy0zxUfvazHvtcn3qc3
        8d9m47fs0KXPl95fbZh6zGjVmvgYFzr6LvB+zrD7qKqdAbt1gUMQunTu5fbpcuab
        JMgwGOMx929j9Mw0D930a08wgbZXR2A0cK8WxV9y9NyhM6+PE/fAkvxEkzLOzIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dHl0AX
        1uJjmfxrjvKoE4sTC88ws2Wl5k5rn2XNKd3p+8Fo3FBxyCYxOEkgt6B2Y7zPLzaC
        6Wfmr20ubrJd9ZF0fxCrGMTHXjcK/W8lKf31X8CDOUn/tVQiT+btj68AMOb7b5S5
        FJAWtUQBL81TcWTUYO4xteA0HIdN2wEb+5x7E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECDBEC559E;
        Thu,  7 Dec 2017 16:47:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60D00C559C;
        Thu,  7 Dec 2017 16:47:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
Date:   Thu, 07 Dec 2017 13:47:14 -0800
In-Reply-To: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 7 Dec 2017 21:22:49 +0100")
Message-ID: <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 308C5996-DB98-11E7-A033-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Use string_list_append_nodup() instead of string_list_append() to hand
> over ownership of a detached strbuf and thus avoid leaking its memory.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/fmt-merge-msg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index 22034f87e7..8e8a15ea4a 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -377,7 +377,8 @@ static void shortlog(const char *name,
>  			string_list_append(&subjects,
>  					   oid_to_hex(&commit->object.oid));
>  		else
> -			string_list_append(&subjects, strbuf_detach(&sb, NULL));
> +			string_list_append_nodup(&subjects,
> +						 strbuf_detach(&sb, NULL));
>  	}
> =20
>  	if (opts->credit_people)

What is leaked comes from strbuf, so the title is not a lie, but I
tend to think that this leak is caused by a somewhat strange
string_list API.  The subjects string-list is initialized as a "dup"
kind, but a caller that wants to avoid leaking can (and should) use
_nodup() call to add a string without duping.  It all feels a bit
too convoluted.

The patch looks good.
