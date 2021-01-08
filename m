Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF626C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935C6233EE
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAHHTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:19:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60990 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbhAHHTS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:19:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE84DAE62E;
        Fri,  8 Jan 2021 02:18:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AZSfze1ORnJyQZxYi7cCIqDN+t4=; b=k9507c
        ohN/NwGTtA75cPd7HBbJCSv1bfnmu7hU/6TuuRuf7DA/a5sUjh3XoXNmLriLt9wG
        4TpN3EwrU1ifaWTHctEdkJ2V/EbVQh4f9K1pHQKF1tOeqxX5J1Pg5AqrotdeJr5m
        2LZXhEpfjOPB3kG7erhZMS/jJRLQ3HXG5ypzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BHM/9LaVFs0nUkoENfg3539BIA/5tF67
        J63FXpgnItchagLJRtaDUPzkKrIO+9pqf2t5nD1PS5bDxp5ldfXHZsTLnD2c+h99
        t3VPxrhzSdq75BUMOh5FUvp5nLqwmlfnEBkedSkwuT+HOed1AHamnXEIf8JhyfN0
        deEIKaCDHWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3B4FAE62D;
        Fri,  8 Jan 2021 02:18:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F716AE62B;
        Fri,  8 Jan 2021 02:18:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] fetch: allow passing a transaction to `s_update_ref()`
References: <cover.1610027375.git.ps@pks.im>
        <e627e729e5cd14c94dcf819f4f87b1412b9a9e9b.1610027375.git.ps@pks.im>
        <xmqqtursjqva.fsf@gitster.c.googlers.com>
        <CAP8UFD1YxHGHLEHd_Bx1awSskjM6fHgM52nPWpTG2UHOmaOT9A@mail.gmail.com>
Date:   Thu, 07 Jan 2021 23:18:35 -0800
In-Reply-To: <CAP8UFD1YxHGHLEHd_Bx1awSskjM6fHgM52nPWpTG2UHOmaOT9A@mail.gmail.com>
        (Christian Couder's message of "Fri, 8 Jan 2021 01:45:47 +0100")
Message-ID: <xmqqsg7bj3qs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B915A51C-5181-11EB-AF8A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Yeah, I think we also don't need the df_conflict variable, and I don't
> like the duplication of the following clean up code:
>
>         ref_transaction_free(transaction_to_free);
>         strbuf_release(&err);
>         free(msg);
>
> Patrick's patch didn't introduce them, but we might still want to get
> rid of them (see below).



> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ecf8537605..8017fc19da 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -581,6 +581,22 @@ static struct ref *get_ref_map(struct remote *remote,
> #define STORE_REF_ERROR_OTHER 1
> #define STORE_REF_ERROR_DF_CONFLICT 2
>
> +static int do_s_update_ref(struct ref_transaction *transaction,
> ...
> }
>
> static int refcol_width = 10;
> -------------------------------------------------------------------------
>
> After the above patch, Patrick's patch would become:

OK, I think the above as a preliminary clean-up would not hurt, but
the "if the caller gave us NULL as the transaction, we are
responsible for handling that bogosity" bit feels a bit too magical
to my taste.  I do understand that your intention is that it
releaves the caller ...

> @@ -613,9 +615,16 @@ static int s_update_ref(const char *action,
>                rla = default_rla.buf;
>        msg = xstrfmt("%s: %s", rla, action);
>
> -       transaction = ref_transaction_begin(&err);
> +       /*
> +        * If no transaction was passed to us, we manage the
> +        * transaction ourselves. Otherwise, we trust the caller to
> +        * handle the transaction lifecycle.
> +        */
> +       if (!transaction)
> +               transaction = our_transaction = ref_transaction_begin(&err);

... here from having to deal with NULL from ref_transaction_begin(),
but I somehow do not see it as a code structure with a good taste.

I dunno.

Without that "if (!transaction ||" bit, I think your do_s_update_ref()
is a good clean-up, though.

Thanks.

> -       ret = do_s_update_ref(transaction, ref, check_old, &err, msg);
> +       ret = do_s_update_ref(transaction, ref, check_old, !!our_transaction,
> +                             &err, msg);
>        if (ret) {
>                error("%s", err.buf);
>                ret = (ret == TRANSACTION_NAME_CONFLICT)
> @@ -623,7 +632,7 @@ static int s_update_ref(const char *action,
>                        : STORE_REF_ERROR_OTHER;
>        }
>
> -       ref_transaction_free(transaction);
> +       ref_transaction_free(our_transaction);
>        strbuf_release(&err);
>        free(msg);
>        return ret;
> ...
> -------------------------------------------------------------------------
>
> You can find these patches, with Patrick as the author, there:
>
> https://gitlab.com/gitlab-org/gitlab-git/-/commits/cc-improve-s-update-ref/
