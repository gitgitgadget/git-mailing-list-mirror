Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A857EC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8461761396
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEMWhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 18:37:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEMWhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 18:37:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25488D6DA2;
        Thu, 13 May 2021 18:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J8fkDhlp/OzK3t4hTtbSuGiJpE0a155o74fiXj
        Pm8TQ=; b=e+929QmguGb9D5XYKtPJk9ky/wlwDybUVtijBB/MdBc2Ni+r9AM6n2
        iz1uBZdfarky9hraoAEpmNJZWLrrYFh/HFa8c2EDIZF2N59cR5XmhvM6pCoG/5IE
        ZLmXxhi4cjWeS/9LBXwHEkcCdcF8E4vr3uUiUQ5jJbUlTk9+k0GGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BFB3D6DA1;
        Thu, 13 May 2021 18:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24D4DD6DA0;
        Thu, 13 May 2021 18:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] prompt.h: clarify the non-use of git_prompt
References: <20210513214152.34792-1-firminmartin24@gmail.com>
        <20210513214152.34792-2-firminmartin24@gmail.com>
Date:   Fri, 14 May 2021 07:36:03 +0900
In-Reply-To: <20210513214152.34792-2-firminmartin24@gmail.com> (Firmin
        Martin's message of "Thu, 13 May 2021 23:41:51 +0200")
Message-ID: <xmqqv97m8dnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A6BB9AE-B43B-11EB-B5E0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

> +/*
> + * This function should not be used for regular prompts (i.e., asking user for
> + * confirmation or picking an option from an interactive menu) as it only
> + * accepts input from /dev/tty, thus making it impossible to test with the
> + * current test suite.  Please instead use git_read_line_interactively for that
> + * purpose.  See 97387c8bdd (am: read interactive input from stdin, 2019-05-20)
> + * for historical context.
> + *
> + */

I have a strong objection against the above phrasing.

If we are asking user for interactive input, this SHOULD be used,
especially if we might be reading the data to work on from the
standard input and we may need to ask the user to interactively
instruct us what to do to that data.  The only plausible reason that
we may want to avoid it and instead prefer the (misnamed)
read_line_interactively() to read whatever from the standard input
(which may not be "interactive" at all, which is why I said
"misnamed") is because our test framework does not use setsid (and
setsid(1) may not be universally available) with pty to emulate tty
input, isn't it?

>  char *git_prompt(const char *prompt, int flags);
>  
>  int git_read_line_interactively(struct strbuf *line);
