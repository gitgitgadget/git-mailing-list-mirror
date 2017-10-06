Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56E51FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 01:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdJFBjy (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 21:39:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50432 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751395AbdJFBjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 21:39:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65CA798ADD;
        Thu,  5 Oct 2017 21:39:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W7vsSsSlZDqK
        CVQ3Koby35mx/jk=; b=n0gQd61dlsEftuLiYpdJsa2WDaApke3/jIsOJTtmQ+da
        Uiq/bCS2Kwtlr7Hxj+NLCV+doP2xIyl+L+69EiLlkFmGvsXpRHsvcVOgvYND6h+2
        UXbgCoY4EtccRafWAcn9eTHovPsF31Z1udExuy6uWmFvoukMJIJskgSe0bMFqX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A6aM6Y
        7ZSApwIVxyEi1blcQoJN0Pe066sY1e7zItD45fgcvnbk2C6KD55UOexDHhHr00lo
        x8VQ46L4ne+cHyCt+8rMCQP49RWCcXwfE0sqGQetR/mkh8NMn0X7ofjAhQX9P2Hl
        UNeRbfV8yfw4eFLbfPuJ+5JAj2eBcDuOTF5Ec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CA8D98ADC;
        Thu,  5 Oct 2017 21:39:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9D7398ADB;
        Thu,  5 Oct 2017 21:39:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 10/12] read-cache: drop explicit `CLOSE_LOCK`-flag
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
        <cover.1507228170.git.martin.agren@gmail.com>
        <db82bb7dc0828a415e48e654031b3b0d0ed763a5.1507228170.git.martin.agren@gmail.com>
Date:   Fri, 06 Oct 2017 10:39:51 +0900
In-Reply-To: <db82bb7dc0828a415e48e654031b3b0d0ed763a5.1507228170.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 5 Oct 2017 22:32:12
 +0200")
Message-ID: <xmqqinftyryw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3FCD0302-AA37-11E7-871A-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 65f4fe837..1c917eba9 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2343,14 +2343,13 @@ static int do_write_locked_index(struct index_s=
tate *istate, struct lock_file *l
>  	int ret =3D do_write_index(istate, lock->tempfile, 0);
>  	if (ret)
>  		return ret;
> -	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=3D
> -	       (COMMIT_LOCK | CLOSE_LOCK));
>  	if (flags & COMMIT_LOCK)
>  		return commit_locked_index(lock);
> -	else if (flags & CLOSE_LOCK)
> -		return close_lock_file_gently(lock);
> -	else
> -		return ret;
> +	/*
> +	 * The lockfile already happens to have
> +	 * been closed, but let's be specific.
> +	 */
> +	return close_lock_file_gently(lock);

"already happens to have been" is quite a mouthful, and is not quite
truthful, as we do not foresee ever wanting to change that (because
of that stat(2) issue you mentioned).  It might be better to declare
that do_write_index() closes the lockfile after successfully writing
the data out to it.  I dunno if that reasoning is strong enough to
remove this (extra) close, though.

When any of the ce_write() calls in do_write_index() fails, the
function returns -1 without hitting the close/stat (obviously).
Somebody very high in the callchain (e.g. write_locked_index())
would clean it up by calling rollback_lock_file() eventually, so
that would not be a problem ;-)



