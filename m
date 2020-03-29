Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F6C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 00:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547FC206F2
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="edp0saQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgC2AMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 20:12:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53263 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgC2AMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 20:12:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23ACAC66AF;
        Sat, 28 Mar 2020 20:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FbyCJhWroZywBH1yTJREhkXO4Ms=; b=edp0sa
        QanlMvpaXW592y6umSsSPPuLRBiyZBKW5ac1HH1Qisc4iDsGuDqKAvMGhJJTEQXf
        700JGg3jUrSFEnfXbtXIlyOWjgC40+KqIJNJ5Tm9ADHbqn4tIk9w3irxaCne2+5+
        CmkXT/RDK1OfvxZLfrmGgMydF69kkGwD4h8Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dzeSGY1NAEfT6b+Vn2JVkz17bw71YloC
        WEnYzlfzAhLybWvW+LOrx7f8vosUGT/mLWpftBc8RGhcw8SjRJeYOgwARZZFRoG6
        hcZPxvQWzvXcFsQEYaflm4a8dLCeXwX3x4C3a6SYEHDBTTTUwO6ICLfsBfdm4R7g
        qOQA4nI7OJ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B94FC66AE;
        Sat, 28 Mar 2020 20:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69D7DC66AC;
        Sat, 28 Mar 2020 20:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
References: <20200327080210.GA604725@coredump.intra.peff.net>
        <20200327080300.GA605934@coredump.intra.peff.net>
        <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
        <20200328112010.GC639140@coredump.intra.peff.net>
Date:   Sat, 28 Mar 2020 17:11:59 -0700
In-Reply-To: <20200328112010.GC639140@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 28 Mar 2020 07:20:10 -0400")
Message-ID: <xmqqh7y8c94g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9A62816-7151-11EA-82CF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Documentation/CodingGuidelines forbids ${#parameter} in the first
>> place and we seem to use it only when we know we are using bash.
>> 
>> Perhaps we should start considering to lift it.  I dunno.
>
> Hmph. I had a vague recollection there but checked beforehand:
>
>  - we do use it in t9010, which is /bin/sh (and have since 2010). I
>    thought it might not be run on obscure platforms because it's
>    svn-related, but I think it doesn't actually require svn.

I do not think I ran git-svn stuff myself for the past 10 years,
though, after a few projects that matter to me migrated away from
svn ;-)

>  - it's in POSIX, at least as far back as 2004 (I couldn't find an easy
>    copy of the 2001 version). That doesn't prove there aren't
>    problematic systems, of course, but it at least passes the bar of
>    "not even in POSIX".

Yeah, IIRC the list was written in response to a request for _some_
guidance, so it largely came from in-house rules of my previous
life, back when I had to deal with various flavours of UNIXen.

>  - it's not in check-non-portable-shell.pl. :) That doesn't mean
>    CodingGuidelines is wrong, but we should probably reconcile them.

That checker came much much later than the guidelines so it is not
surprising at all for it to be "buggy", in the sense that it does
not check everything the guidelines ask.  Yes, we may need bugfixes
and there may be other bugs, too.

> Yeah, I was tempted to do that, but ${#packet} is even one process
> shorter. :) It might be worth simplifying the stdin path above, but it's
> much less important if most of those call-sites go away.

The largest issue (which is not that large, though) I felt with the
approach when I saw the patch for the first time was that we need
the big warning comment before the helper, i.e.

> +# Note that data containing NULs must be given on stdin,...

But after thinking about it a bit more, I think it is probably OK.
I do not think you can assign a string with NUL in it to a variable
and you can use "$(command substitution)" as an argument to the
helper to pass such a string, either (not portably anyway).  If such
a string cannot be made into "$*", ${#packet} won't have to worry
about counting bytes in a string with NUL in it to begin with, so
the above note won't even be necessary (it would have to say "you
cannot pass data containing NULs as arguments---you are welcome to
try, but you won't be able to do so, not portably anyway"), anyway
;-).
