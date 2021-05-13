Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A69CC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F01461433
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhEMXEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 19:04:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58362 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEMXEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 19:04:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7825AB72CA;
        Thu, 13 May 2021 19:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=no6jeSCTckUGd+fTXMEDiCLzVf+tS6/pO4ZA28
        kM9ZE=; b=MKHO8uutxIKUrgKOGr2wnOqrIZ91IvFkfX3MGP4VSTnAL76ZCQ0cno
        IQnSnmS5Rmv+m6BNKQnyWnL+4Ts7uE7nO+cDHkKg7AqmhOdfzaG5GaPLLfirSpfV
        XYuB0Gcdfs+2/oRlauo6Bysz8uE6Qq1cFQ+Fw04drmsFrJKlBtXbA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6984EB72C9;
        Thu, 13 May 2021 19:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7B41B72C8;
        Thu, 13 May 2021 19:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] prompt.h: clarify the non-use of git_prompt
References: <20210513214152.34792-1-firminmartin24@gmail.com>
        <20210513214152.34792-2-firminmartin24@gmail.com>
        <xmqqv97m8dnw.fsf@gitster.g>
Date:   Fri, 14 May 2021 08:03:42 +0900
In-Reply-To: <xmqqv97m8dnw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 May 2021 07:36:03 +0900")
Message-ID: <xmqqmtsy8cdt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7676E0F6-B43F-11EB-9EB5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I have a strong objection against the above phrasing.
>
> If we are asking user for interactive input, this SHOULD be used,
> especially if we might be reading the data to work on from the
> standard input and we may need to ask the user to interactively
> instruct us what to do to that data.  The only plausible reason that
> we may want to avoid it and instead prefer the (misnamed)
> read_line_interactively() to read whatever from the standard input
> (which may not be "interactive" at all, which is why I said
> "misnamed") is because our test framework does not use setsid (and
> setsid(1) may not be universally available) with pty to emulate tty
> input, isn't it?
>
>>  char *git_prompt(const char *prompt, int flags);
>>  
>>  int git_read_line_interactively(struct strbuf *line);

So, here is an alternative that nudges users away from this helper,
but with honesty.  I also suggest a better name for that misnamed
"interactively" function in the comment, but will leave it as an
exercise to readers to come up with a patch to rename the function.

/*
 * Give prompt to the user and accept interactive input from the
 * controlling terminal (/dev/tty).  This function can be used even
 * when the standard input is being used to feed us real data to
 * operate on, as we open /dev/tty ourselves for user interaction.
 *
 * In a codepath that never uses the standard input for real data,
 * consider using git_read_line_from_standard_input() instead, as it
 * is easier to write tests for (our test framework currently does not
 * make it easy to simulate end-user input coming from /dev/tty).
 */

