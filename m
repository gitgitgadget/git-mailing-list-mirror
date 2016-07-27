Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793421F855
	for <e@80x24.org>; Wed, 27 Jul 2016 22:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163182AbcG0WUk (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 18:20:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162535AbcG0WUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 18:20:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A96B730850;
	Wed, 27 Jul 2016 18:20:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NPy1KKQZ+cSCL2++V7oQv/ULS3o=; b=tm4dJP
	FvShgIxrTbyaT8316LCYvNAmy5cORyXhePogg0PCxEwlBug8/KulrNjMEaF6qTuc
	EiAdNZEere6mjlU93AIut6UqmzC/LgZOWvCA7QHl11Cp+AeYZWbmx190fFBp29Db
	EH67WzCzrE9rCFhnCFeptc/BMzDzf+o2uoDx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sewTFG0D9PDQWwVGIIAFfSJEUjAP8GNq
	TLgi5XlzG/UXzl22u+00gI1/kpElpD1inA4kMAKOexubWQyXy1ziKs32sFKwjPXR
	+zeRrJGHAYBS9jRWCSMWCuip7x/cgAfrlmx4jOc8AOMcIxaNgUHgdjO6WzZp0ZJX
	VyAzLKybYCA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A06C63084F;
	Wed, 27 Jul 2016 18:20:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 199083084E;
	Wed, 27 Jul 2016 18:20:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 16/16] merge-recursive: flush output buffer even when erroring out
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<af195979d2c0cf9958b7811b4d2294deeea30b75.1469547160.git.johannes.schindelin@gmx.de>
Date:	Wed, 27 Jul 2016 15:20:33 -0700
In-Reply-To: <af195979d2c0cf9958b7811b4d2294deeea30b75.1469547160.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jul 2016 18:06:49 +0200
	(CEST)")
Message-ID: <xmqq4m7avi32.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 576232EE-5448-11E6-BCA1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index a16b150..66e93e0 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2069,6 +2069,7 @@ int merge_recursive(struct merge_options *o,
>  	o->ancestor = "merged common ancestors";
>  	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
>  			    &mrtree);
> +	flush_output(o);
>  	if (clean < 0)
>  		return clean;

This is of course a good change, but we need to assume that no
further output is made from the remainder of the function for the
change in the next hunk to remove the existing flush to be correct.

And once we assume that, then the "we no longer need this buffer, so
release it" added in 15/16 can also move here, right?

I am wondering if there is a low-impact way to make sure that
assumption will not be broken.

> @@ -2077,7 +2078,6 @@ int merge_recursive(struct merge_options *o,
>  		commit_list_insert(h1, &(*result)->parents);
>  		commit_list_insert(h2, &(*result)->parents->next);
>  	}
> -	flush_output(o);
>  	if (o->buffer_output < 2)
>  		strbuf_release(&o->obuf);
>  	if (show(o, 2))
