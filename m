Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7787C203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbcGZTlp (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:41:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754198AbcGZTlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:41:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 32E1F2FAB3;
	Tue, 26 Jul 2016 15:41:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lxPfY6fEBO8ZFUuJM1EjFrOi+vo=; b=VEak/F
	8b3o1aO9SP/DO9C9sb88uhuq0o9i/ta4f8lXhn3K7W1CtWTgD5Y0NIbgT9YbNrTP
	eOT4ZO4VTNccTBBuCtSgEEfMzTkqteiWNjHrXOY9HQf0RXYAx4kTGDLVrRK0CeCq
	zkwLLqQxPLnW4R812Du8r/7LmgHJNHYLhub2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3zy/nkj9XYKQkCoMpnrwnDChGV3Ownl
	XuyRfc+W36kzYFPfu1ZwM1RS02lV6xoFyxRhOBYeZRYezC19yOE/W7/fXvAZgjUC
	XjbwGxI6GnVcC1M9zIXA6+2nq1u/gTgtsm9wcL+CVsrQtZuQ7mv+qJqsUmzuAn5D
	fV370MII3b0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 29AE72FAB2;
	Tue, 26 Jul 2016 15:41:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FEEB2FAB0;
	Tue, 26 Jul 2016 15:41:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 36/41] apply: don't print on stdout when be_silent is set
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<20160627182429.31550-37-chriscool@tuxfamily.org>
Date:	Tue, 26 Jul 2016 12:41:40 -0700
In-Reply-To: <20160627182429.31550-37-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 27 Jun 2016 20:24:24 +0200")
Message-ID: <xmqq60rs191n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA8DAA7E-5368-11E6-B1F0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This variable should prevent anything to be printed on both stderr
> and stdout.

You have to mention that skipping the entire callchain, not just the
"printing" part, is safe.  I can see numstat_patch_list() is
probably safe as it does not do any computation other than calling
printf() and write_name_quoted(), but other two are not immediately
obvious that what they compute are only used for their own printing
and there is no other side effects left to affect what happens after
this function returns.


> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 1435f85..e2acc18 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4698,13 +4698,13 @@ static int apply_patch(struct apply_state *state,
>  		goto end;
>  	}
>  
> -	if (state->diffstat)
> +	if (state->diffstat && !state->be_silent)
>  		stat_patch_list(state, list);
>  
> -	if (state->numstat)
> +	if (state->numstat && !state->be_silent)
>  		numstat_patch_list(state, list);
>  
> -	if (state->summary)
> +	if (state->summary && !state->be_silent)
>  		summary_patch_list(list);
>  
>  end:
