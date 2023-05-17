Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CDCC7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEQQxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEQQxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:53:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B09ECB
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:53:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40E33204E1D;
        Wed, 17 May 2023 12:53:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R2yMRGQO/6ghpI3BpeNlM6JRc0vquXHI7M8U+q
        Mc9lE=; b=LVADBEZtAmzz4+aGQ5rvEzKKa02tUsGJjjRqaV35zEN1sWxK69gPNj
        u64pKr4BsaQb7FF6E/YJwitF+DUS0fxcaj4V0dRj9s5SP94w8UoRsukNHdv1RqTh
        5fIg4k8bhkerBCI+DodqMnCCYC33ojK0cYPEXRdJ7XoveN/PM3j3g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 396D5204E1C;
        Wed, 17 May 2023 12:53:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69BF7204E1B;
        Wed, 17 May 2023 12:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
        <ZGT/eK6+IKlCM6Sg@nand.local>
Date:   Wed, 17 May 2023 09:53:09 -0700
In-Reply-To: <ZGT/eK6+IKlCM6Sg@nand.local> (Taylor Blau's message of "Wed, 17
        May 2023 12:23:20 -0400")
Message-ID: <xmqqcz2yrjbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E222B66-F4D3-11ED-BA9E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here's the (gross) script I wrote up to check:
>
>     git grep -l -e '[^_]xstrdup(' -e 'strbuf_[a-z0-9A-Z_]*(' \*.c |
>     while read f
>     do
>         if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
>         then
>             echo "==> $f NOT OK";
>         fi
>     done

I am a bit puzzled.

What does the above prove, more than what your regular compilation
that does not fail, tells us?  Doesn't -E expand recursively, so for
the case of imap-send.c, with your usual configuration, wouldn't it
have grabbed "struct strbuf" via inclusion of <http.h> indirectly
anyway?

> Here's the list:
>
>   ==> compat/fsmonitor/fsm-listen-darwin.c NOT OK
>   ==> compat/mingw.c NOT OK
>   ==> contrib/credential/osxkeychain/git-credential-osxkeychain.c NOT OK
>   ==> pager.c NOT OK
>   ==> refs/iterator.c NOT OK
>   ==> refs/ref-cache.c NOT OK
>   ==> string-list.c NOT OK
>   ==> t/helper/test-mktemp.c NOT OK
>
> The ones in compat are OK to ignore since they both fail to compile on
> my non-Windows machine (I am missing the `<dispatch/dispatch.h>` and
> `<windows.h>` headers, respectively).
>
> The one in contrib is fine to ignore, since it has its own definition of
> xstrdup().
>
> pager.c is OK, since it only needs xstrdup(), not any other parts of the
> strbuf API. It gets a declaration of xstrdup() from git-compat-util.h
> refs/iterator.c, refs/ref-cache.c, string-list.c, and
> t/helper/test-mktemp.c are all OK for the same reason.
>
> So I think that this is the only spot we need to worry about.
