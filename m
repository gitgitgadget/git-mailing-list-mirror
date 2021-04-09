Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA46C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7204F61168
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhDIGPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 02:15:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53506 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhDIGPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 02:15:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFDEAB7476;
        Fri,  9 Apr 2021 02:15:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XlQSPLLjwQUECpc3nNNpYoqP/5M=; b=lMef8R
        roWqOE6kbzxXEcjjT738Cw/y2bYDKhvM6m3q8JtVQTg7Hos/wVh+f94gVJYZ1IqG
        u/IR8v8sbnf3mnlhNYTh7lA4xgLTVn6k6xD0GDUbjMeV9TWhhu0wdSfMV+l3e9SN
        RELw3P/TMh/VjeW/OXR8r60UNHmZS06EaS8K0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PPg2VvhJxOlp5ZQlhFdABiu1wXv2bYpm
        Id7igdD98bQwmDZ6VJjqa+9PgOk7D3xO39KeFPL7ve/vyWOqNEvjESA6FFBpRihy
        3Ja/sILJPmHESd4qTnnMxs0a0J9StLQ77XQ1WBODM7qCD6jKjA09DTJi3aMl7Fht
        17uzL5WrytU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ACB4B7474;
        Fri,  9 Apr 2021 02:15:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1C96B7473;
        Fri,  9 Apr 2021 02:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
References: <20210407173334.68222-1-mirucam@gmail.com>
        <20210407173334.68222-4-mirucam@gmail.com>
Date:   Thu, 08 Apr 2021 23:15:07 -0700
In-Reply-To: <20210407173334.68222-4-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 7 Apr 2021 19:33:32 +0200")
Message-ID: <xmqq8s5snfv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEC84406-98FA-11EB-933A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> +static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
> +{
> ...
> +	while (1) {
> +		strvec_clear(&args);
> +
> +		printf(_("running %s"), command.buf);
> +		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
> +
> +		if (res < 0 && res >= 128) {

Sorry for not noticing this total nonsense during my earlier review,
but this condition will never trigger.

I would have noticed it if the style consistently used "order
quantities from left to right, as if on a number line" convention,
i.e.

		if (res < 0 && 128 <= res) {

Because there are only two valid range notation around a single
variable, which are:

    (res < 0 || 128 <= res) - meaning 'res' is outside a span, or
    (0 <= res && res < 128) - meaning 'res' is inside a span.

and the above rewriten form is neither, it would have stood out
as an error immediately.


