Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79651F855
	for <e@80x24.org>; Wed, 27 Jul 2016 22:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163589AbcG0WlM (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 18:41:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162965AbcG0WlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 18:41:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D51F316B1;
	Wed, 27 Jul 2016 18:41:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FPYrK8kmxPLHW+qsl9koA6g4X/M=; b=h1zvFi
	yalva6H50MpWkIcB7Qo39tlAy4KfA0iG3ZroFSO5KGfvMO/xpGs2lMDtiTLncU2W
	oBVrFxNx/VdHPcUAmTVyw6sF4FOy37kr16Asz9WnrtqhSbcP5D/e7i1jL8EUhEmA
	Pwy1ohHtFXt2xb5RuTTMUzGp0a9ZLjrhl9oJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cNVfW+sngXX1mXtfSMcvzvTAxKNxJHrz
	NBp9OS1aL7KOKTCD7v80JlXnAUpvx616mzvqpm8W2XFnQjwZhtayHk72Mase0X6P
	4tfcQIbcv4ScCro5e9oO3QnBxH748QV8rMPJyWJ+0t4efGHaYiH3exzJ7awljMoW
	r5lFORYeylc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04963316B0;
	Wed, 27 Jul 2016 18:41:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F0CC316AF;
	Wed, 27 Jul 2016 18:41:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] i18n: config: unfold error messages marked for translation
References: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Wed, 27 Jul 2016 15:41:05 -0700
In-Reply-To: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Wed, 27 Jul 2016 17:59:35 +0000")
Message-ID: <xmqqvazqu2ke.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35536AB2-544B-11E6-9F44-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> +	default:
> +		error_msg = xstrfmt(_("bad config line %d in %s"),
> +				      cf->linenr, cf->name);
> +	}
> +
>  	if (cf->die_on_error)
> -		die(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
> +		die(error_msg);

As error_msg is a result of xstrfmt() and there is no further
interpolation needed, you would want to say

	die("%s", error_msg);

here.  It triggers 

config.c:541:3: error: format not a string literal and no format arguments [-Werror=format-security]

Similarly for error() below.

>  	else
> -		return error(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
> +		error_return =  error(error_msg);

