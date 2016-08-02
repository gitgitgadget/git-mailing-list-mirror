Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F55920220
	for <e@80x24.org>; Tue,  2 Aug 2016 21:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbcHBVTy (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 17:19:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750705AbcHBVTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 17:19:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C13EF33C72;
	Tue,  2 Aug 2016 17:19:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TE+CExW00IEoymSsDGB91aFWpK8=; b=AexSzM
	SP0u04CYTbe4rvqKjPGJIbZebSrXXh4HiyLOTzdMebtQb3sQtJhxAtgNwizCYPgI
	7RsYy0KT/oa4TxNQP+2R8Xe9ozmoEGW1I1scX5iJQ1fp2rjftsbaOgmacfus0uZ4
	TEivxFJzR8S+zp3wHO+N6g7u7yMI/Dmj2DJ+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZNEg9lLojRgy4zik1EXIFkUScungKEH
	WqPleS7y6eqMqpnRX9/XtqGLi616+zcoBtzEFCwqM9O57wJsoQhGGNerwhA0kb73
	Wc9/23X0AIZcKME11LnDIt/Cl0RKYMQj1VIs8mQhx8zsLwmFniffGH82ql0+aAhr
	+43y5a48YoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B952833C71;
	Tue,  2 Aug 2016 17:19:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DC7333C70;
	Tue,  2 Aug 2016 17:19:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 14/16] merge-recursive: offer an option to retain the output in 'obuf'
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de>
	<xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com>
	<xmqqmvl2ty31.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608011124440.149069@virtualbox>
	<xmqqbn1cjogd.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608020948220.79248@virtualbox>
Date:	Tue, 02 Aug 2016 14:19:45 -0700
In-Reply-To: <alpine.DEB.2.20.1608020948220.79248@virtualbox> (Johannes
	Schindelin's message of "Tue, 2 Aug 2016 10:01:42 +0200 (CEST)")
Message-ID: <xmqq60ridg26.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6F01082-58F6-11E6-8983-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But in that case, there would be both messages meant for the
>> standard output and also meant for the standard error, and we need
>> some way to make sure they go to the right channel.
>
> Not necessarily. Let's have a look at our existing code in
> git-rebase.sh:
>
> 	output () {
> 		case "$verbose" in
> 		'')
> 			output=$("$@" 2>&1 )
> 			status=$?
> 			test $status != 0 && printf "%s\n" "$output"
> 			return $status
> 			;;
> 		*)
> 			"$@"
> 			;;
> 		esac
> 	}
>
> This incredibly well-named function (</sarcasm>, my fault: dfa49f3 (Shut "git
> rebase -i" up when no --verbose was given, 2007-07-23)) accumulates all
> output, both stdout and stderr, and shows it only in case of an error.
>
> Crucially, *all* output goes to stdout. No distinction is being made
> between stdout and stderr.

> ...
> This is the existing behavior of rebase -i.
> ...
> As such, it would be a serious mistake to implement that mode and use it
> in the rebase--helper: it would very likely cause regressions in existing
> scripts, probably even my own.

Sounds like we are desperately trying to find an excuse to do a
wrong thing by finding an existing piece of code that did a wrong
thing already.

That leaves a bad taste in my mouth, but as "rebase -i" is meant to
be an "interactive" command, I would imagine that nobody would have
expected to run it as "git rebase -i >/dev/null" in order to view
only the error messages (or vice versa with "2>errs").

So OK then, at least for now.

