Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95821F855
	for <e@80x24.org>; Wed, 27 Jul 2016 22:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163078AbcG0WPw (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 18:15:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163081AbcG0WPq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 18:15:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F5E8307D3;
	Wed, 27 Jul 2016 18:15:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LH0fyvEIM+ePGu8RIskHyUCqN/0=; b=JIuQnu
	EILosi0gM1wDaNd+6ka7K3LYUqyxk5g2AX8ouIOtO+UB5OMpEDyBAkOHGGB+4yUd
	Hb2F89c70l9xo4Dpors68v6CGgk2H6/nYqvDmyntFJAn7sRIA1bidnnUKRP77UEl
	7PDe3xn5aBrehlpCRlmgqFmMHC/lAqT70w24c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DIjPV6ro1REG7k43kZOtp7KY8bXfzHHS
	yaxaIJtDbCl1uQ6OjH045zuvhAlSmeGuJfJVz8gZ/hEP58spyMoSxORT1G1+pSl7
	1WyQ96BRdKLhzW7A0ambqSe85puoMlNe22bpmm4K6a4ohQfZ8x2H50miGJItUUaL
	b2dlbk8b+Kg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36C78307D1;
	Wed, 27 Jul 2016 18:15:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0BF2307CF;
	Wed, 27 Jul 2016 18:15:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 15/16] Ensure that the output buffer is released after calling merge_trees()
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<a2af8827e4df9f1555821111aac92606496006be.1469547160.git.johannes.schindelin@gmx.de>
Date:	Wed, 27 Jul 2016 15:15:42 -0700
In-Reply-To: <a2af8827e4df9f1555821111aac92606496006be.1469547160.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jul 2016 18:06:45 +0200
	(CEST)")
Message-ID: <xmqq8twmvib5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9B4DDEA-5447-11E6-8A40-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 311cfa4..a16b150 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2078,6 +2078,8 @@ int merge_recursive(struct merge_options *o,
>  		commit_list_insert(h2, &(*result)->parents->next);
>  	}
>  	flush_output(o);
> +	if (o->buffer_output < 2)
> +		strbuf_release(&o->obuf);
>  	if (show(o, 2))
>  		diff_warn_rename_limit("merge.renamelimit",
>  				       o->needed_rename_limit, 0);

Other two hunks looked good, but this one I am not sure what is
going on.  It this were "if call-depth says we are called by another
merge_recursive, do not discard the buffer", I would understand, but
why does this have to be tied to o->buffer_output being "we buffer
the output but not errors"?
