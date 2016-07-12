Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE5C1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 14:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbcGLOe0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 10:34:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751711AbcGLOeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 10:34:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DE54D28B5B;
	Tue, 12 Jul 2016 10:34:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Czh6ml8YrR3KPgP4ywhQJw6Z+tw=; b=jbC+Th
	ESozS9Ry1b4glLigFcpVrzEKmCfalTJ/KsFpITP0hWe5OzDhMZFA8zcgi4e+lNBo
	TVGOJSub2c14w/3w2wag2MSJtMDMUwO04FqDMaWNrFzTmnXSykjdChW6iapWkMnc
	ICBPlDV5sXs/1mxNb0TLPYq4KuDQ98jcnnFZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jd/R+Ls1d2jiSkjK8BMfCdrHyoV/6e4w
	bK57U+tvAoxij9dIt5cFM8NZy2SYL6nFa4Fk8Mm3m8qSHKHp5KRu4hnitivqRBzH
	gA0ppj/6CC0f3sP/uRLFkE0p//3E6rXRFZmwNdmxHdaGgesCiT5RZjAE5YIpUx0y
	NyinY4ixpBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D6A3328B5A;
	Tue, 12 Jul 2016 10:34:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63B6A28B58;
	Tue, 12 Jul 2016 10:34:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
Date:	Tue, 12 Jul 2016 07:34:14 -0700
In-Reply-To: <alpine.DEB.2.20.1607120927410.6426@virtualbox> (Johannes
	Schindelin's message of "Tue, 12 Jul 2016 09:30:28 +0200 (CEST)")
Message-ID: <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5F31B5A-483D-11E6-BC03-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Git's source code assumes that unsigned long is at least as precise as
> time_t. Well, Git's source code is wrong.
> ...

That is correct.  As people mentioned downthread already, "unsigned
long" has two problems, it may not be wide enough, and it cannot
represent time before the epoch.

But moving the internal time representation used in various fields
like commit->date to time_t is likely to be a wrong thing to do,
because the first problem with "unsigned long", i.e. "may not be
wide enough", is not limited to "not wide enough to hold time_t".
It also includes "it may not be wide enough to hold time somebody
else recorded in existing objects".

Since some platforms have time_t that is not wide enough, but still
have intmax_t that is wider, I think we would be better off to pick
an integral type to use for the internal representation that is the
widest throughout the API, and use time_t only at places that we
interact with the system libraries (e.g. when we ask "what is the
time now?" to time(2), when we ask "break down this timestamp" to
gmtime(3)).

Thanks for starting this, and from a brief read, the hotfix to skip
the test downthread looked good.  The places this "starting point"
patch covers look like a good set that interacts with time obtained
locally (e.g. prune that compares with filesystem timestamp); just
make sure you don't go too far and end up shoving timestamps from
other people into time_t, which may not fit.

Thanks.




