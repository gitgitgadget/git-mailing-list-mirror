Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04A6203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757859AbcG0SJe (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:09:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754410AbcG0SJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:09:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 065F530416;
	Wed, 27 Jul 2016 14:09:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0RVUCOqWcLbmulegQT8vR8HYDoE=; b=EBQLzJ
	GyjRkpMT1UKUIWck1N+m+iUk7oBr6yiGmWzHJ2vakqZZ7RFGYzmTybCSi9zJmcFo
	LkggcPLdLHxaHvsgIfbpLkfO/ZfXNdMIK1iggRmFIx5NDA6KPUnASsRdN0RmKqby
	+08j1pYCopUe2y5zn9PD6gF6hT8q1gvWR3lWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QHUaYc5CHt2iqngBsw2lNyHTPzaKN1U0
	l79S2L/nHBmuOpYABNjq3BeYraxqS6Z3zB4I8buBWUPtk8NFozLHWoqxQmKMcwIX
	ZwxKs/66mL426WRfDaPx67B8J5vH2Rdfr35tcADvFmr0HKZEBvKIA6rKv80UIV7a
	MOsn5y6tZGM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2C9630415;
	Wed, 27 Jul 2016 14:09:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6770F30414;
	Wed, 27 Jul 2016 14:09:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Phil Pennock <phil@pennock-tech.com>,
	Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
References: <20160727081414.GA21451@breadbox>
	<20160727135820.GC14928@sigill.intra.peff.net>
	<xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com>
	<20160727173915.GA32219@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 11:09:30 -0700
In-Reply-To: <20160727173915.GA32219@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Jul 2016 13:39:15 -0400")
Message-ID: <xmqqfuqvvtph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44B10CCE-5425-11E6-B94C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I actually think Phil's patch from today is a little cleaner for most of
> these, as it returns the values via out-parameters, and uses the return
> value for "did we get anything?".

True.  That part of the interface is indeed better done with the new
one.

I am still in favor of this suggestion you earlier made:

> So the final solution is more like:
> 
>   - a formatter for just the reflog time, respecting date
> 
>   - a formatter for just the reflog index (the "0" in HEAD@{0})
> 
>   - a formatter for the ref name (just the "HEAD" in HEAD@{0})

though.  After all we only need three short ones while we migrate
away to a longer %(reflog:<what>) format, right?

As to the unfortunate %gd that squats on the "date" other specifiers
use, I do not see a good/quick approach to migrate it.  If our ideal
short-term endgame before the longer format were to use %gd, %g# and
%gg for the above three, we first start warning people who use %gd
for the historical mistaken "reflog selector", while telling people
to use "%gg@{%g#}" instead if they truly want "reflog selector", and
then switch its meaning to "reflog date".  That would take a long
time.

As %r prefix is not taken, we can immediately deprecate %g-anything
format as a historical mistake and make sure we do not repeat the
mistake of giving "d" to "reflog selector", perhaps?
