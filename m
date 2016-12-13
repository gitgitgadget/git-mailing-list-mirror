Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC6B203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 16:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbcLMQJu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 11:09:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932602AbcLMQJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 11:09:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F09C5325C;
        Tue, 13 Dec 2016 11:09:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FyrbMK62XBDY6FVrfDOc7SExJ4U=; b=ZR565J
        +HjSzoHgn4d2gNkxBGD8aFlnNC98KTD2mb4LSjVhsmvkd6mIZYQLimsIEdhsVDlE
        ZVMA0D7xj7ztTXJ6lzRjA8zBDO7J4WXx0bJ1nWecHBZSitZhEI7FI3FW/nPrJrMC
        aros2ZtH0y7r/f1GM5TPhFqbXOmCnfgnBpj/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mK3XtRT91DnFAqwHGW2+Zf42KLO9G7nV
        ZPkfJKP+l77csLYqPSnVqLEMmbKAyFjlPIgtsI/YokuE+bPkKDthRD4OuDE5rlxZ
        YRiDM12HXvHE6mGVDWdqwuVW3z01WNczAKfQWCJxNc98obHUmuQSl7MYE9Qanwp7
        zOMmClwZCgo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 658C25325B;
        Tue, 13 Dec 2016 11:09:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEC5A53259;
        Tue, 13 Dec 2016 11:09:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612131638290.23160@virtualbox>
Date:   Tue, 13 Dec 2016 08:09:45 -0800
In-Reply-To: <alpine.DEB.2.20.1612131638290.23160@virtualbox> (Johannes
        Schindelin's message of "Tue, 13 Dec 2016 16:39:46 +0100 (CET)")
Message-ID: <xmqqmvfz6cae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 912CB4E0-C14E-11E6-A6C3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 12 Dec 2016, Junio C Hamano wrote:
>
>> * js/mingw-isatty (2016-12-11) 1 commit
>>   (merged to 'next' on 2016-12-12 at 60c1da6676)
>>  + mingw: intercept isatty() to handle /dev/null as Git expects it
>> 
>>  We often decide if a session is interactive by checking if the
>>  standard I/O streams are connected to a TTY, but isatty() emulation
>>  on Windows incorrectly returned true if it is used on NUL (i.e. an
>>  equivalent to /dev/null). This has been fixed.
>
> I'd like to suggest a reword: we did not use an isatty() emulation, but
> Windows' own _isatty() function that simply has different semantics than
> what Git expected. *Now* we have an isatty() emulation that wraps
> _isatty() and emulates the behavior expected by Git.

Thanks for a comment.

One of the things that the new code does with the fix is this:

+/* In this file, we actually want to use Windows' own isatty(). */
+#undef isatty
+

which undoes "#define isatty winansi_isatty" that other code uses,
so that the implementation of winansi_isatty() can say isatty() and
get what people usually get when they say "isatty()" on Windows.

Before or after that patch, there is no "#define isatty _isatty" in
our codebase.  I take all of the above to mean that Windows does
give us isatty() function (not a macro--as otherwise it won't become
available to us again by "#undef isatty"), that in turn internally
calls what it calls _isatty() that says true for NUL?

Following the above reasoning, I meant "whatever you get when you
write isatty() on Windows" by "isatty() emulation on Windows" in the
paragraph you are commenting on.  I didn't say "what was written by
Git for Windows folks to emulate isatty()" or "what was given by MS
development tools", as that distinction is immaterial and does not
change the value of the fix.
