Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D0C49EAB
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323BB6128B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFOC0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:26:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53269 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhFOCZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:25:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CDBE6124DDE;
        Mon, 14 Jun 2021 22:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=arD1G/i6JvFBSWNz8TNMla8Hxrz1vMKUEC2pwH
        T5nSk=; b=aWwOhxh4spMVD9tyi4xAD++UybI6j8lub+9Ky2OCYGX/d0nO51luVa
        CYfurKDD1xLJkP98KXlMh2Qjk6qWzipc9uET5cKt8RPCSrdBrvBhQjky3vbFbmhH
        qehUX+CCWg3EWuOuuppSlTcJ+1acY7aBYxLSUmL6tg5Cebj1yO5t0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5E72124DDD;
        Mon, 14 Jun 2021 22:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17A1B124DDB;
        Mon, 14 Jun 2021 22:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
        <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
        <60c647c1d9b5c_41f452089@natae.notmuch>
        <60c677a2c2d24_f5651208cf@natae.notmuch>
Date:   Tue, 15 Jun 2021 11:07:04 +0900
In-Reply-To: <60c677a2c2d24_f5651208cf@natae.notmuch> (Felipe Contreras's
        message of "Sun, 13 Jun 2021 16:24:50 -0500")
Message-ID: <xmqq7divzxrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6225B390-CD7E-11EB-9A54-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I found the problem, m->chg0 was not initialized in xdl_refine_conflicts.
>
> I'm not familiar with the area so I don't know if the following makes
> sense, but it fixes the crash:

Unlike the remainder of the xdiff/ directory, xdiff/xmerge.c was
Dscho's brainchild if I am not mistaken, so I'm CCing him for
input.



> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -333,7 +333,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>                 mmfile_t t1, t2;
>                 xdfenv_t xe;
>                 xdchange_t *xscr, *x;
> -               int i1 = m->i1, i2 = m->i2;
> +               int i0 = m->i0, i1 = m->i1, i2 = m->i2;
>  
>                 /* let's handle just the conflicts */
>                 if (m->mode)
> @@ -384,6 +384,8 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>                         m->next = m2;
>                         m = m2;
>                         m->mode = 0;
> +                       m->i0 = i0;
> +                       m->chg0 = 0;
>                         m->i1 = xscr->i1 + i1;
>                         m->chg1 = xscr->chg1;
>                         m->i2 = xscr->i2 + i2;
