Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88DE920193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934140AbcHDTuS (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:50:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758977AbcHDTuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BDF4431372;
	Thu,  4 Aug 2016 15:47:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vClJPW3v1mECrisIfpTjR3RLQjQ=; b=afXTqu
	XjPLZWzz2MUL1hPR7pEOi01lmFVJ/iPBN+KtwIuXbv3aNgHwO7es5k1YSVl2yqAA
	R92oFrr/oDyfsq2qTqwqEFx0DiHtjRf9mXwaod7bIiIqGFhAioHManZfP/7FNKV4
	Tu1SKP3BbGrR0LIwjUlUssRghfMvfwqOjQkak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ez1S4paVp7WDVY/daoTVOrGWb6hJXOnP
	CP7pZUT+huxfzmd0oV8DozUZbrkm4kNJ3O4eXeqdZBDT5nmRt8Xm8xwtOT/573Ok
	4lDcbdFb22aDB0cdTXPJj0UKTOU/cARINNtbRA9mPRyEvIhUVhHv5zxIu10k7mKR
	Dnt1uthQCCM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5DFE31371;
	Thu,  4 Aug 2016 15:47:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 405F831370;
	Thu,  4 Aug 2016 15:47:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jakub =?utf-8?Q?Nar=C4=99?= =?utf-8?Q?bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
	<20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
	<CAGZ79kYCwoo6sYefu++KyCdgHfKvRsUp98ZAur+E7E4o_FLtEw@mail.gmail.com>
Date:	Thu, 04 Aug 2016 12:47:24 -0700
In-Reply-To: <CAGZ79kYCwoo6sYefu++KyCdgHfKvRsUp98ZAur+E7E4o_FLtEw@mail.gmail.com>
	(Stefan Beller's message of "Thu, 4 Aug 2016 09:55:39 -0700")
Message-ID: <xmqq8twc2u5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 451D8F22-5A7C-11E6-A204-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I have just reread the scoring function and I think you could pull out the
> `score=indent` assignment (it is always assigned except for indent <0)
>
>         if (indent == -1)
>                score = 0;
>         else
>                score = indent;
>         ... lots of bonus computation below, which in its current implementation
>         have lots of "score = indent;" lines as well.

Yup.  If each part in this if/else if/... cascade independently sets
complete information (i.e. both "bonus" and "score") necessary for
the final result, then I do not mind the same "score = indent" in
many of them (these case happen to get the same score), but that is
not what we have in this code (i.e. "bonus" has a shared component
that is not affected by thie if/else if/ cascade), so setting score
to indent upfront and reset it to 0 only on a blank line would make
sense.
