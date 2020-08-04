Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D9C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3907D207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZusa0LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHDWTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:19:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53943 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHDWTO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:19:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 823D282521;
        Tue,  4 Aug 2020 18:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BDSekBIeetmOUV90OzyuZLlCPeU=; b=hZusa0
        LRpQTjQ+icJAFIb5DMjdpXyc8Lzg3mUpVnsWTefT7bapNuSjirnZKN1MWg8kouW3
        HjH7i0Qgfa2o5CXIpNVONJMFenc/mcdaOqsHMLGLSlQNfhFdeYqfioLZvMsOFn8j
        safK1xubWlGaEZ3XB0zg810WxzNBZIFgjI+9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vkh80DNJtZmQXkbffH4/mUHnx8iwvdd5
        KmluQJ0xQk++zai4UBKw1LAX1cZSmKCVVFdqCxrAxDjjuwxcU1K2/pb3ZELlOw7N
        5auGzyQ8XzTSx/ED1yB9V8J3WK5PJcTm39dTq/Fua+Ipp5mkCPV1Q0R/OBdiJxHC
        d1V5KIFM6ow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AA6082520;
        Tue,  4 Aug 2020 18:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 024058251D;
        Tue,  4 Aug 2020 18:19:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
References: <20200801175840.1877-1-alipman88@gmail.com>
        <20200804220113.5909-1-alipman88@gmail.com>
Date:   Tue, 04 Aug 2020 15:19:11 -0700
In-Reply-To: <20200804220113.5909-1-alipman88@gmail.com> (Aaron Lipman's
        message of "Tue, 4 Aug 2020 18:01:08 -0400")
Message-ID: <xmqqtuxiqckg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 860BD918-D6A0-11EA-B6ED-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> OK, here's take 4! Responding to Junio's feedback, first:
>
>> That function [cmd_bisect__helper()] is supposed to be a thin shim
>> layer whose only reason of its existence is to serve as an interface
>> with the scripted version of "git bisect".  When everything is
>> migrated from the shell script, cmd_bisect__helper() should disappear.
>> ...
>> This is going backwards, as far as I can tell.  If anything, I'd
>> rather see cmd_bisect__helper() get fixed so that it does not parse
>> "--first-parent" (and similarly, "--no-checkout" that you imitated)
>> into first_parent_only (and no_checkout) variables and passed as
>> parameters to bisect_start().
>
> Thanks for the explanation, Junio. (And for bearing with me while I
> gain familiarity with git's codebase.) Now that I've taken some time
> to examine how git-bisect.sh and cmd_bisect__helper() fit together,
> the correct approach is much more clear.

I did notice that no_checkout variable in the top-level
cmd_bisect__helper() was convenient to have in the current code
structure, and I didn't think how it should be fixed deeply enough,
so for the purpose of this series, I do not mind if it is left
untouched.  It's just that it was disturbing to see that addition of
"--first-parent" wanted to add yet another variable to the
top-level, and that the new variable was totally unneeded.

> As no_checkout was also passed to bisect_next_all() [via implicitly
> checking for the existence of .git/BISECT_HEAD when calling
> bisect_next() in git-bisect.sh], I've removed that parameter and
> instead check for .git/BISECT_HEAD in bisect_next_all() to determine
> whether no-checkout mode is on.
>
> This means no-checkout mode can no longer be enabled by "git
> bisect--helper --next-all --no-checkout"

Unlike "start", "next-all" is not really a command in the end-user's
mind ("git bisect next" is, though).  It merely is just an interim
"convenience" interface for the remaining part of the scripted "git
bisect" to call into.  As long as the caller can do the same thing
as before, it should be OK, I would think.
