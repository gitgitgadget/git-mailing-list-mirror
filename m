Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59911F859
	for <e@80x24.org>; Mon, 15 Aug 2016 16:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbcHOQVc (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 12:21:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752801AbcHOQUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 12:20:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C79433384B;
	Mon, 15 Aug 2016 12:20:10 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6OdIAki51wueoIHIeaLz4JNoN+o=; b=dEkAfx
	UWSJiSrItLt/4BRvP0GPcErGpM0CmrZ3padOV2lkTicdKmFN+OjXBq70apZKUWiB
	RwQZM5smq1G2PtZWS0plB9BWqlKmTo8ZUpSHgun1oH2Zbn8JJlPDtmNNTA0NvwNt
	tA5gB4QrzZbCfbZ232J5IK53WB6bwLPw3FiyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9rSxVm+6E+Lc+5czTMUYtTkfJQlUf1r
	wFQgDJMT6xMQypVhDLWlhyiFNZlrbpg4arL0ctURuPxw8IRHdTmIskHMfB2oDI0o
	ApzMRjHMBB8+X3V9K2zIyLBdD2OkFP1Gspv/qWYe3TAVAk6hi2/8sW+qe63r2s1W
	jtOg2JrQ7Fo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BFC0A3384A;
	Mon, 15 Aug 2016 12:20:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BFCD33849;
	Mon, 15 Aug 2016 12:20:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] squash! diff: add --diff-line-prefix option for passing in a prefix
References: <5ca415f99718b1792cd0a9c31606b45d27befc48.1471164824.git.johannes.schindelin@gmx.de>
	<xmqqinv3krpe.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608151519480.4924@virtualbox>
Date:	Mon, 15 Aug 2016 09:20:08 -0700
In-Reply-To: <alpine.DEB.2.20.1608151519480.4924@virtualbox> (Johannes
	Schindelin's message of "Mon, 15 Aug 2016 16:07:21 +0200 (CEST)")
Message-ID: <xmqqfuq6humf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 233728A6-6304-11E6-A111-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 14 Aug 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > -	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
>> > +	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g' -e 'y/>/_/')
>> ...
> I know that this is so because my first iteration of the patch did exactly
> what you suggested.

You probably should have stepped back and taken a deep breath before
writing the second round.  Doing so after writing it before sending
would also have been OK.

Among three characters that are special cased here, the problem "if
we squish a run of problematic characters into one underscore, we
risk making the result ambiguous" is NOT limited to '>'; it is not a
new problem with '>', either.  I can think of two other possible
solutions offhand:

 (1) drop "squishing a run", i.e. [/ ]*, from the regexp, and rename
     existing test vectors that would be affected;

 (2) change the string used in the offending test so that squishing
     will not make the result ambiguous.

before special casing "y/>/_/"; as there is nothing in ">" that
inherently causes the ambiguity that won't be caused by "/" or " ",
adding second clause to the sed expression that does things
differently only for ">" is simply wrong.  After all, you only
wanted to affect the "prefix=-->" test and not the whole set of the
tests in the script.

Obviously (1) is a lot of impact with little gain, and as Jacob
already offered to do, I think (2) is a lot more sensible solution
and it also is more in line with your "If it isn't broken, do not
fix it", I would say.


