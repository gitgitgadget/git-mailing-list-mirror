Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BEEE1F855
	for <e@80x24.org>; Thu, 28 Jul 2016 00:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162820AbcG1ASA (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 20:18:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161875AbcG1AR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 20:17:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 586E93151D;
	Wed, 27 Jul 2016 20:17:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gKpNd1rj+zLnZMFlxrklPWMqmi0=; b=Cl0RDP
	eTeXria4iJKUEN1JtRgYJ+yBQXewiWbRYyaFIyCmQXqoZinLrZTOyH6Jkb3shalT
	+0vBf8+U9x2o6u4l2+yna+RdjJWZulxQfy0jz09A0m0Ncj4K3tDR6dcOrJDlmt2W
	Kjczttze8si1UNO2OTndxrU80vzPvT2zRRRII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EIeyjlYdWysigpLB7HvrCkmhKRhmGlj0
	a84MrXprrBTnZmLjnaGvM5xTkDTkBA4gvHhgsUunPf2UjSlvW8kWg67IFUIex4oi
	jTIr9xED8gCy4Yw8HDO1qvhkra9R/1Iy0EHsu+cfWgDsRJhN0Pvo/zwZMUBtS5RO
	hLBWaNlGWR0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FE6E3151C;
	Wed, 27 Jul 2016 20:17:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB6063151B;
	Wed, 27 Jul 2016 20:17:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 14/16] merge-recursive: offer an option to retain the output in 'obuf'
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de>
	<xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 27 Jul 2016 17:17:54 -0700
In-Reply-To: <xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Jul 2016 15:09:07 -0700")
Message-ID: <xmqqmvl2ty31.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBFBB670-5458-11E6-9DE6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not yet sure if it makes sense to mix both the regular output
> and an error into the same buffer for the callers to process (your
> "reason 1)" above), and this looks like a wrong way to allow a
> caller that wants no output (your "reason 2)" above).  A caller that
> wants to massage the output would want to know which ones are errors
> and which ones are not, I would imagine, and setting a knob to make
> both output() and err() a no-op would be a more suitable way to give
> a caller a total silence.

I actually now see how this would work well for "reason 2)".  If a
caller wants to run the function and wants to pretend as if it did
not run anything when it failed, for example, using this to spool
all output and error to a strbuf and discard it when the function
returns an error, and emit the spooled output to standard output and
standard error in the order the lines were collected when the
function returns a success, would be a good way to do so.

That however brings me back to the "reason 1" thing.  Shouldn't the
spooling be done not just with a single strbuf, but with an array of
<bool, const char *> tuples, where the bool says if it is for the
standard output, and the string holds the message?  output() would
mark its element in the array with true, while err() would do so
with false.
