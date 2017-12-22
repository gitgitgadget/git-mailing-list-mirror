Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5687F1F428
	for <e@80x24.org>; Fri, 22 Dec 2017 21:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756322AbdLVVsr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 16:48:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58065 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755458AbdLVVsq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 16:48:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A993BF718;
        Fri, 22 Dec 2017 16:48:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cgQr0NbU4a5hwo+RcNS7JKZH/VA=; b=rVzmDi
        sKMUZPqcsedbnVxZV/gdT6zny1PmiUQX4pHVICd5t5cHwvRASyA1zbFj9HES4/gN
        aCf1GtkhlSSH/+tqqFDIf5iNmvvWD+G2521VWA5McSlNwEf+igu+RWzWF9mgGMKT
        rsPVyXvdqSgIRt+INtoMukJg8sObgoAGn26UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XapZio9PJGg27Uef4stbJuzlsAgaMlvO
        sivELeMvuSHFuH4ozhgZ/VURCY7+QGjb4xT16SNTTYFfvQs1AdfGat6m3GNSbdoX
        Fk6YW7K5dEB7AKnyV+PMoMocl0TgPOYnqAP05P5S0ALaiaZGsM3f2wEV6OQCEJEz
        uAQSiBEzbDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01127BF717;
        Fri, 22 Dec 2017 16:48:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E99ABF715;
        Fri, 22 Dec 2017 16:48:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien Dusser <julien.dusser@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix urlencode format string on signed char.
References: <20171222172437.19505-1-julien.dusser@free.fr>
Date:   Fri, 22 Dec 2017 13:48:44 -0800
In-Reply-To: <20171222172437.19505-1-julien.dusser@free.fr> (Julien Dusser's
        message of "Fri, 22 Dec 2017 18:24:37 +0100")
Message-ID: <xmqqk1xeph6r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E26C70E0-E761-11E7-A2B8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Dusser <julien.dusser@free.fr> writes:

> Git credential fails with special char in password.
> remote: Invalid username or password.
> fatal: Authentication failed for
>
> File ~/.git-credential contains badly urlencoded characters
> %ffffffXX%ffffffYY instead of %XX%YY.
>
> Add a cast to an unsigned char to fix urlencode use of %02x
> on a char.
>
> Signed-off-by: Julien Dusser <julien.dusser@free.fr>
> ---
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 323c49ceb..4d5a9ce55 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -658,7 +658,7 @@ static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
>  		    (!reserved && is_rfc3986_reserved(ch)))
>  			strbuf_addch(sb, ch);
>  		else
> -			strbuf_addf(sb, "%%%02x", ch);
> +			strbuf_addf(sb, "%%%02x", (unsigned char)ch);
>  	}
>  }

The issue is not limited to credential but anywhere where we need to
show a byte with hi-bit set, and it is obvious and straight-forward.

I briefly wondered if the data type for the strings involved in the
codepaths that reach this place should all be "uchar*" but it feels
strange to have "unsigned char *username" etc., and the signeness
matters only here, so the patch smells like the best one among other
possibilities.

Thanks.
