Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDFB1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbcG2Qtj (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:49:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751808AbcG2Qti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:49:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6A532E8B2;
	Fri, 29 Jul 2016 12:49:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yG5KVOsshc4KHsjZDrtpAQga4Gs=; b=R2GbSP
	A3+58jYRrDfEHQF164T/dzQtDj+WGSbNOzCcptFsCwkHNR8AdVZC503PbcxDHgzP
	pd9OwBglu49EKHQNwfc5qG6vxLkbjkdArvO1qeBlGJxk3fV1s66Ab1JcVTJU+7uy
	5/RBFEMSIq8mUVniVie+XaGBTxtR87/cqM6nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oao1FAaoRLDEZl066zBVA9Jqr4nmLwNu
	b1I4Mv1Ln62tQrCBvZlglQi4LYnJZ7Tl3X5bEHcC0GN7/Azl7z140ZBjOPq24Fd1
	kyAdo9q68XZHckcsBbC3Zq5pGN3QQMqvaHUbIGeLyFIxfQEyhwR1Lgba0wpn63df
	dBcl0pSnEbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D0AC2E8B1;
	Fri, 29 Jul 2016 12:49:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D1502E8B0;
	Fri, 29 Jul 2016 12:49:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
	Edward Thomson <ethomson@edwardthomson.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] Fix failing test t3700-add.sh
References: <579b4ca1.18da2703.bm000@wupperonline.de>
	<20160729163937.GD29773@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 09:49:34 -0700
In-Reply-To: <20160729163937.GD29773@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 12:39:38 -0400")
Message-ID: <xmqqmvl0pext.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EB2A806-55AC-11E6-838D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was also puzzled why the test fails for you; it does not for me.
> Running the test script as root does make it fail. There are some
> earlier tests which are skipped in this case, which run "git reset
> --hard" with xfoo1 in the index, which cleans it up.
>
>> +	echo foo >xfoo &&
>> +	chmod 755 xfoo &&
>> +	git add --chmod=-x xfoo &&
>> +	case "$(git ls-files --stage xfoo)" in
>> +	100644" "*xfoo) echo pass;;
>> +	*) echo fail; git ls-files --stage xfoo; (exit 1);;
>
> Here you just pick another name, "xfoo", which does happen to work. But
> it seems like that has the same potential for flakiness if earlier tests
> get adjusted or skipped, since they also use that name.
>
> How about just:
>
>   rm -f xfoo1
>
> at the top of the test, which explicitly documents the state we are
> looking for?

That's much more sensible.

> I also wondered if this test, which calls "chmod 755 xfoo1", should be
> marked with the POSIXPERM prerequisite. But I guess since its goal is to
> strip the executable bit, it "works" even on systems where that chmod is
> a noop (the "git add --chmod" doesn't do anything, but one way or the
> other we end up at the end state we expect).

We could make sure --chmod=[-+]x works both ways, which would be
more robust on either type of underlying platform.  Something along
the lines of

	echo foo >xfoo1 &&
        git add --chmod=+x xfoo1 &&
        test_mode_in_index 100755 xfoo1 &&
        git add --chmod=-x xfoo1 &&
        test_mode_in_index 100644 xfoo1

with an obvious addition of a test_mode_in_index helper function as
the same "case $(ls-files -s) in ... esac" pattern appears number of
times.

