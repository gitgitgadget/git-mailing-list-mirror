Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C0620193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933959AbcHDSOg (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:14:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754182AbcHDSOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:14:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F52232420;
	Thu,  4 Aug 2016 14:14:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qvQriY3zBSwVcsP6V3ccifT4qss=; b=sO9T5l
	zcujaJSWZ3jv/VzTvQPl1yyRDUq+WxUjWE2X/AuL+2CdbBYjLbKFSevGg8BwMlNu
	fn23L5YD/GSOzIbWAqJsGCwF2cNz0CP7x6XTFpaPNE/k4qYFwH1UrsVjayBHfUvR
	i6owof8a5O7IxjsjikCvMbaoxBHBDJv8ENN3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VK6+VoalMrHz5FjXgpiAiXAU1eFeVzHK
	0QBY3YEdBTaKi4cK+0eZUwVyhvMtr3TJcwLaZOa0DE7e8zT4WvfcQkmMWMYfzyw7
	VsntMHhjntLAOGoKlcm02PmA9EyLfs7pVti1tq/4pya6jA5UAnVDMuNWS24ZwsgB
	A5ygG468yAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 171303241F;
	Thu,  4 Aug 2016 14:14:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85A453241D;
	Thu,  4 Aug 2016 14:14:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 08/16] merge-recursive: allow write_tree_from_memory() to error out
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<b20cdc35797d5ed97a738e85928819088e31a01a.1470051326.git.johannes.schindelin@gmx.de>
Date:	Thu, 04 Aug 2016 11:14:01 -0700
In-Reply-To: <b20cdc35797d5ed97a738e85928819088e31a01a.1470051326.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 1 Aug 2016 13:44:23 +0200
	(CEST)")
Message-ID: <xmqqfuqk4d1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39A30648-5A6F-11E6-A050-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is possible that a tree cannot be written (think: disk full). We
> will want to give the caller a chance to clean up instead of letting
> the program die() in such a case.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-recursive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 2be1e17..1f86338 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1888,8 +1888,8 @@ int merge_trees(struct merge_options *o,
>  	else
>  		clean = 1;
>  
> -	if (o->call_depth)
> -		*result = write_tree_from_memory(o);
> +	if (o->call_depth && !(*result = write_tree_from_memory(o)))
> +		return -1;

I'll let it pass, but we avoid assignment in a conditional part for
a good reason: it can become unreadable pretty quickly.  Writing it
in a long-hand, e.g.

	if (o->call_depth) {
        	*result = write_tree_from_memory(o);
                if (!*result)
                	return -1;
	}

future-proofs against the "o->call_depth" condition part and
"write_tree_from_memory(o)" operation part becoming longer, possibly
needing multiple statements.

The change itself is correct.
