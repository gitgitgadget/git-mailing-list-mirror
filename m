Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B95DC433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8C2076C
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F8YyJBv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgHATGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:06:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52415 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHATG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 15:06:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEE38D7A01;
        Sat,  1 Aug 2020 15:06:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aAB0Hdp8g+Cwn9c55jEff/igoRA=; b=F8YyJB
        v8/akW6XnJX7yIjW3hdJ9h+mcSp4EnLaVMJq4uop7dgGNJsNUZ3V7p49Y++n7bG0
        5kavcKakwWxOBPc8aFqgt+NEGiRcAd0h8XZhBrtokC0FIqyo4UIvBJOREDylQtmx
        hVa81Dnct6T1DMbBaCAmGtOgnmoZBaIPIEFjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YA+cU5zQZYCYEWrOQKh1rSEQw11KZEb8
        ATo8KRpOYqABGfWiG4X1iYDEhhTVIZpfWUoSQLYQoRa49nP8IWZTSET91rSqUwU3
        paonie8Vz1FNgTg18yzKEKyTKa7AOoTNBIKKogAofhc3rhwEoeFEfDsLLzK2n5rf
        EN7Aq+Lnd0A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8C05D79FF;
        Sat,  1 Aug 2020 15:06:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24594D79FC;
        Sat,  1 Aug 2020 15:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Introduce --first-parent flag for git bisect
References: <20200730002735.87655-1-alipman88@gmail.com>
        <20200801175840.1877-1-alipman88@gmail.com>
Date:   Sat, 01 Aug 2020 12:06:21 -0700
In-Reply-To: <20200801175840.1877-1-alipman88@gmail.com> (Aaron Lipman's
        message of "Sat, 1 Aug 2020 13:58:36 -0400")
Message-ID: <xmqq36562nki.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 173A07D0-D42A-11EA-9160-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

>> I suspect that you would ask the same question to whoever added
>> no_checkout to this thing, and I wouldn't be surprised if we end up
>> removing both of these parameters (and parsing of the options inside
>> cmd_bisect__helper()) after thinking about them, but anyway, let's
>> read on.
>
> Hmm. Is there a preferred way to to add a --first-parent line to the
> output of "git bisect start --help" via the parse-options API without
> removing the --first-parent option from argv in the process?

I'd rather not to see the code made ugly if the only reason why you
have duplicated command line parsing is to support "git bisect start
-h" while cmd_bisect__helper() still exists.  

That function is supposed to be a thin shim layer whose only reason
of its existence is to serve as an interface with the scripted
version of "git bisect".  When everything is migrated from the shell
script, cmd_bisect__helper() should disappear.

In its place, cmd_bisect() written in C would become a dispatcher
that only looks at the first token on the command line that comes
after ["git", "bisect"] and calls "bisect_start()", "bisect_next()",
etc. with the remainder of the command line with options such as
"--first-parent" and "--no-checkout", which will be parsed by
bisect_start() etc. parsing its argc/argv[] passed by cmd_bisect().
It is likely that cmd_bisect() would not have any call to
parse_options(); instead cmd_start() etc. would call parse_options()
with their own option[] table.

So I am not sure if the change between v2 and v3 is going in the
right direction.

> As long as we're capturing the --first-parent option in
> cmd_bisect__helper(), checking argv for a --first-parent flag in
> bisect_start() is pointless.

This is going backwards, as far as I can tell.  If anything, I'd
rather see cmd_bisect__helper() get fixed so that it does not parse
"--first-parent" (and similarly, "--no-checkout" that you imitated)
into first_parent_only (and no_checkout) variables and passed as
parameters to bisect_start().  cmd_bisect__helper() should instead
just let these flags (and there may be others) sit in argc/argv[]
and have bisect_start() parse them, together with all other options
bisect_start() already has its parser for.

Thanks.
