Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6773C1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbcHJV2b (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:28:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751226AbcHJV2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 17:28:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF5A733589;
	Wed, 10 Aug 2016 17:28:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a6++1CcjevGfUQ9da7FXr4xCTas=; b=fz1EYg
	bMvKtYfo6IUX92urto5KoRfWUQWjGVWcnS3fn/Py11TDkCMrc4WQvacFOqlqKKhI
	x4m+KJ6PppU9bj09nUkmqXYB61SYPez2WFZFjteQWNJJgGGA31OiSVCYYSgNbEhu
	+piFKgk9AijVKtqSB7op8J2vFmdpFF/UTZhxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g3/WD6zNm8LLINbP8DL2RIfmAgabSGor
	xd7E2Io2xgqqLJ83V46YImVX++NR5KRDKDDlMXzGva4IhTGfpj/jmBpT02Vh2Eo0
	W73OYG1QGVwzTw0nBez+aR0K/sBcJa5ykxS25L1z6k5jk5WkhLK0ZZ9V1NbfDt8s
	E3EZVuCjEAw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C761433588;
	Wed, 10 Aug 2016 17:28:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42A5233586;
	Wed, 10 Aug 2016 17:28:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
	<CA+P7+xo6q0pveVQdt1mynfsWq75DzBXsbPcgVYdd5s8rpO+97A@mail.gmail.com>
	<f7f35993-39a8-b788-d2a7-d030ac442b9b@alum.mit.edu>
	<xmqqd1lo2uj1.fsf@gitster.mtv.corp.google.com>
	<5fe0edbc-3659-058f-3328-639d1343fa05@alum.mit.edu>
Date:	Wed, 10 Aug 2016 14:28:26 -0700
In-Reply-To: <5fe0edbc-3659-058f-3328-639d1343fa05@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 10 Aug 2016 21:01:06 +0200")
Message-ID: <xmqq8tw448lh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60D5C210-5F41-11E6-BEB1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> After
>> all, somebody in this file is already scanning each and every line
>> to see where it ends to split the input into records, so perhaps a
>> "right" (if the "theoretical correctness" of the return value from
>> this function mattered, which you wave-away below) optimization
>> could be to precompute it while the lines are broken into records
>> and store it in the "rec" structure?
>
> That would certainly be possible, and would help in cases where there
> are a lot of lines with lots of leading whitespace. You could get nearly
> the same benefit by recording a single bit in struct rec, indicating
> whether the line is blank or not.
>
> But it wouldn't help the worst case described above, where each call to
> `git_indent()` is already very cheap. And I didn't think it was worth
> allocating the extra memory to optimize this heuristic

True.

> I don't know. It seems like a pretty contrived justification for what is
> basically, "your input is too weird for us. We're not going to break our
> necks trying to give you the best possible slider positioning."

True again.
