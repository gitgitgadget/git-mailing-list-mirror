Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A7A1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 19:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbcHATPZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:15:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754747AbcHATPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:15:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1527F31B23;
	Mon,  1 Aug 2016 15:09:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d2L/6uzr40asTW44Wzfzt2JVDEE=; b=fq3U/l
	YpQ7Vq7yngjDpBdx/WG4zLMc0H7IGw9V9zP6neD+dQDfq4nK5EYBswvH3r/D51W3
	RAISPZpjf3C9Amqf+x1BT+EehD+IIsZhbD24mwtGo7udH408mTDjuP2wwRRJrXqi
	aCQjKwONI6IFY/aGcAjldmcIX/0sPrjOg8Fug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eUfMxZfc7ccIdoCcNAhkQx8KDgutjbVx
	sSgqHxMqFjgTSCBotccfMJPRzbujr8z1gqe4b24pk/7Dk4g3ya1XvgYjwXjXJw3B
	vUAVeDX+kbzAZXIFVbnD2HQ0UnLCQO3IKXgcy7t56RkGcsoqjxRGjTAZ6Emcl86f
	Sj7lCAGDclE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DB0D31B21;
	Mon,  1 Aug 2016 15:09:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8689F31B20;
	Mon,  1 Aug 2016 15:09:40 -0400 (EDT)
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
Date:	Mon, 01 Aug 2016 12:09:38 -0700
In-Reply-To: <alpine.DEB.2.20.1608011124440.149069@virtualbox> (Johannes
	Schindelin's message of "Mon, 1 Aug 2016 11:34:49 +0200 (CEST)")
Message-ID: <xmqqbn1cjogd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F685A94-581B-11E6-8609-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I actually now see how this would work well for "reason 2)".  If a
>> caller wants to run the function and wants to pretend as if it did
>> not run anything when it failed, for example, using this to spool
>> all output and error to a strbuf and discard it when the function
>> returns an error, and emit the spooled output to standard output and
>> standard error in the order the lines were collected when the
>> function returns a success, would be a good way to do so.
>
> That is actually the exact opposite of the intended usage: when any `pick`
> in an interactive rebase succeeds, its output is discarded so as not to
> bother the user. We show the complete output only when it fails.

Oh, it makes sense, too, to show the output only when there is an
error.

But in that case, there would be both messages meant for the
standard output and also meant for the standard error, and we need
some way to make sure they go to the right channel.

I however do not think an array of <bool, const char *> is the only
way to achieve that.  We can get away by a single strbuf that
accumulates all output() that we have seen so far, i.e. "we only
accumulate output() and ignore flush() as long as what we see are
only from output()" mode.

Then the err() routine operating under this new mode can show what
has been accumulated to the standard output (because with this tweak
I am outlining here, by definition, the strbuf will only keep the
output() material and not err() things), show the err() message, and
switch back to the normal "we accumulate output() and honor flush()"
mode.  Of course, when we are doing multiple rounds, the mode must
be reset to "accumulate output and ignore flush" mode at the
beginning of each rouhd.

That would give us "silence if there is no error, but if we are
showing error, show them to the standard error, while giving
non-error message to the standard output".
