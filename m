Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4262203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbcGYWVV (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:21:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756496AbcGYWVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:21:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EB932FB8D;
	Mon, 25 Jul 2016 18:21:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1DJsq83QoO9bAKOJ6ZLGRHBjkoU=; b=grmc5N
	rXc8/pP2aqSrUGNz3CM+frPpA9RtLHzqBaLhmNJu5dhCm7i+6nrRvzp9ryCKjmXe
	JTyV3Sad0NPczwaVEZEZfkRJs/ouVZFXwbaPqb2dDk6sJ8PD3MVz6NizIwjcVF4f
	vN4vXf0s2fs5ec2GTqpLG25oE78wO+w7UWg0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JuAEnTqCMy4kqpYeIYh6LU8Fs+YOSplt
	CdthukCXIZo3qIAho6QMF6he4JGroRxO0vMG2YqoplA21VXWvRLY6DSBpw9FcwVv
	GXFd36myabdIJwT5oAGyiJ44zM1yRWrcTd+lHi6f2CiKCvKB6EZdjKdiq4Qx3qfN
	YvId/xhTgbw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 373F52FB8C;
	Mon, 25 Jul 2016 18:21:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A58D62FB8B;
	Mon, 25 Jul 2016 18:21:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] push: allow pushing new branches with --force-with-lease
References: <xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com>
	<cover.1469483499.git.john@keeping.me.uk>
Date:	Mon, 25 Jul 2016 15:21:14 -0700
In-Reply-To: <cover.1469483499.git.john@keeping.me.uk> (John Keeping's message
	of "Mon, 25 Jul 2016 22:59:54 +0100")
Message-ID: <xmqqtwfd2wbp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AB3E7CC-52B6-11E6-B6BE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> On Mon, Jul 25, 2016 at 10:28:01AM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > If there is no upstream information for a branch, it is likely that it
>> > is newly created and can safely be pushed under the normal fast-forward
>> > rules.  Relax the --force-with-lease check so that we do not reject
>> > these branches immediately but rather attempt to push them as new
>> > branches, using the null SHA-1 as the expected value.
>> >
>> > In fact, it is already possible to push new branches using the explicit
>> > --force-with-lease=<branch>:<expect> syntax, so all we do here is make
>> > this behaviour the default if no explicit "expect" value is specified.
>> 
>> I like the loss of an extra field from "struct ref".
>> 
>> I suspect that the if/else cascade in the loop in apply_cas() can
>> also be taught that ':' followed by an empty string asks to check
>> that the target ref does not exist, in order to make it a bit more
>> useful for folks who do not rely on the "use the last observed
>> status of the tracking branch".
>> 
>> That would make the "explicit" test much less cumbersome to read.
>
> Yes, that's nicer and it mirrors the syntax for deleting a remote
> branch.
>
> I've pulled it out as a preparatory step because I like the fact that
> the "explicit" test passes even before the patch that is the main point
> of the series.

Ah, our mails crossed ;-)

Thanks, I'll read these three patches.
