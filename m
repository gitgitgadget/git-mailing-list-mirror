Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F53EC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB36961433
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhD3AXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:23:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62232 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhD3AXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 20:23:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC2A4D7510;
        Thu, 29 Apr 2021 20:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WFttMf21suYsB7w6AKukJ0MsH9zT2/lQxDWSjI
        4ci/I=; b=lvcBRrZG1ftn8wvtQpVxt0Nm9q8uqSksU2vTcScPLo0AsZdQjngWEn
        0BzutmXwE1P8xgwlBu5RNo9lTEqEQSpuU6+nxo4+q1RsiY1OcUd7zPff0SxcuCel
        53WAgkEocpy3qVb//x736otpwOBxXjwYt5lC3FixnZCrPWV96Gtvg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E35B5D750F;
        Thu, 29 Apr 2021 20:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55CEDD750E;
        Thu, 29 Apr 2021 20:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Faith <jeremy.faith@jci.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
        <xmqqfszac25x.fsf@gitster.g>
        <CY4P132MB00885F00AAA46BCFAC76881B855F9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
Date:   Fri, 30 Apr 2021 09:22:20 +0900
In-Reply-To: <CY4P132MB00885F00AAA46BCFAC76881B855F9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
        (Jeremy Faith's message of "Thu, 29 Apr 2021 14:10:05 +0000")
Message-ID: <xmqq5z04fwoz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21255254-A94A-11EB-A6B6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Faith <jeremy.faith@jci.com> writes:

> man git-check-ignore states:-
> EXIT STATUS
> -----------
> 0::
> 	One or more of the provided paths is ignored.
> 1::
> 	None of the provided paths are ignored.
> 128::
> 	A fatal error was encountered.
>
> So my change matches what the manual states.

That is part of what I meant by "understandable, given the history".

The above description is _wrong_ ever since it was introduced, along
with check-ignore, at 368aa529 (add git-check-ignore sub-command,
2013-01-06).  It should have said "has/have entry that affects it in
the gitignore/exclude files" instead of "is/are ignored".  After
all, that is what the tool was written to do, i.e. to help debugging
the gitignore/exclude files.

    git-check-ignore(1)
    ===================

    NAME
    ----
    git-check-ignore - Debug gitignore / exclude files

Having said all that.

It is a misunderstanding that check-ignore is a tool to learn if a
path is or is not ignored, but the misunderstanding is so widespread.

I wonder if we can repurpose the command to "match" the
misunderstanding, without hurting existing users, by

 (1) updating the one-liner description of the command in the
     documentation;

 (2) keep the EXIT STATUS section as-is; and

 (3) adjust the code to exit with status that reflects if there was
     at least one path that was ignored (not "that had an entry in
     the gitignore/exclude files that affected its fate").

That certainly is a backward compatible change, but I suspect that
we may be able to sell it as a bugfix, taking advantage of the
documentation bug you quoted above.  Of course, people do not read
documentation, so scripts that used to use the command in the way it
was intended to be used (as opposed to "the way it was documented")
will still get broken with such a change, though.


