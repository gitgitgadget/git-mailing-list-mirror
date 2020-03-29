Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D003C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B0F206DB
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 03:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l873MaEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgC2DFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 23:05:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57271 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgC2DFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 23:05:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCC3145B1B;
        Sat, 28 Mar 2020 23:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e0HekLXb2gDpD30rLDGJuQrN400=; b=l873Ma
        EZXJBOvZ/f99zSyEcmAbszw6FRkD1sTCs4UlyiYKH4qn6yOU8uFJSsXib9XgVt/e
        yH5mK6X0WcNZk/pNETVrC770E1wDJ9HnUG16pUbWcRfl88Q9fuQ63NltIHDXp1g5
        jf/f5ZRZSG1xtV5moBhudelNxjrGOStKmNKv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YMbW2j7zJOb7D3+QUNzdPPVFTDSaz/m9
        TuOGfbFAaOFtpUy9gG6/TyMbgAVvVBN/18OssdeUsE/HbsrBud5HMbIVnRJeJaLb
        Y1clVJxvxrFVD1qMrIGGtL7RshSEiIz3eF3xpfoBjzuyJM1BGjUZI7blqrnq0wGq
        jPclBPi6YkY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D49A845B1A;
        Sat, 28 Mar 2020 23:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB13845B19;
        Sat, 28 Mar 2020 23:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
References: <20200327080210.GA604725@coredump.intra.peff.net>
        <20200327080300.GA605934@coredump.intra.peff.net>
        <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
        <20200328112010.GC639140@coredump.intra.peff.net>
        <xmqqh7y8c94g.fsf@gitster.c.googlers.com>
Date:   Sat, 28 Mar 2020 20:05:10 -0700
In-Reply-To: <xmqqh7y8c94g.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 28 Mar 2020 17:11:59 -0700")
Message-ID: <xmqq8sjjdfo9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A4AA1FA-716A-11EA-B268-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

I guess I didn't give an explicit conclusion in my message.

>>  - it's in POSIX, at least as far back as 2004 (I couldn't find an easy
>>    copy of the 2001 version). That doesn't prove there aren't
>>    problematic systems, of course, but it at least passes the bar of
>>    "not even in POSIX".
>
> Yeah, IIRC the list was written in response to a request for _some_
> guidance, so it largely came from in-house rules of my previous
> life, back when I had to deal with various flavours of UNIXen.

I strongly suspect that most of these historical curiosity systems
died out or learned ${#posix}; I wouldn't at all be surprised if
/bin/sh on Solaris back then was one of the motivating systems that
led to the forbidding of the use of ${#parameter} in our in-house
rules, but luckily, we have written it off as unsalvageable in this
project ;-)

It has been in POSIX long enough, and it is useful at times, so
let's drop it from the list of guidelines (patch?).

>>  - it's not in check-non-portable-shell.pl. :) That doesn't mean
>>    CodingGuidelines is wrong, but we should probably reconcile them.
>
> That checker came much much later than the guidelines so it is not
> surprising at all for it to be "buggy", in the sense that it does
> not check everything the guidelines ask.  Yes, we may need bugfixes
> and there may be other bugs, too.

This still gives us something to keep an eye on.

-- >8 --
Subject: CodingGuidelines: allow ${#posix} == strlen($posix)

The construct has been in POSIX for the past 10+ years, and we have
used in t9xxx (subversion) series of the tests, so we know it is at
least portable across systems that subversion Perl bindings have
been ported to.

Let's loosen the rule; luckily, the check-non-portable-shell script
does not have any rule to find its use, so the only change needed is
a removal of one paragraph from the documentation.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/CodingGuidelines | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ed4e443a3c..390ceece52 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -91,8 +91,6 @@ For shell scripts specifically (not exhaustive):
 
    - No shell arrays.
 
-   - No strlen ${#parameter}.
-
    - No pattern replacement ${parameter/pattern/string}.
 
  - We use Arithmetic Expansion $(( ... )).
