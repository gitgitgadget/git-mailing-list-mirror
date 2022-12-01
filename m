Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF838C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 20:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiLAUHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 15:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiLAUGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 15:06:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908FEA281C
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 12:06:50 -0800 (PST)
Received: (qmail 25934 invoked by uid 109); 1 Dec 2022 20:06:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Dec 2022 20:06:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28320 invoked by uid 111); 1 Dec 2022 20:06:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Dec 2022 15:06:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Dec 2022 15:06:48 -0500
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Ping Yin <pkufranky@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        mailinggit list <git@vger.kernel.org>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
Message-ID: <Y4kJWJObB5Er2CXZ@coredump.intra.peff.net>
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
 <221129.867czejabi.gmgdl@evledraar.gmail.com>
 <xmqqlenu2dxx.fsf@gitster.g>
 <Y4ZOHwwgtztwhbhr@coredump.intra.peff.net>
 <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
 <CACSwcnRDmiiJU8hL+ON6c+b4Q8UtLVbtku_rHSD+c+BwcNEX+Q@mail.gmail.com>
 <4dac768f-1104-a565-db4c-8a1b7eb2870d@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dac768f-1104-a565-db4c-8a1b7eb2870d@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2022 at 02:51:29PM +0000, Phillip Wood wrote:

> On 01/12/2022 07:33, Ping Yin wrote:
> > > > If the rule is "break on ascii whitespace",
> > 
> > Is there a way to achieve this: break english by word, and break
> > chinese by utf-8 character
> 
> You could extend your current regex so that it matches whole utf-8
> codepoints which is what git does for the builtin userdiff regexes. I've not
> tested it but I think
> 
> git config --global diff.wordregex "[[:alnum:]_]+|[^[:space:]]|$(printf
> '[\xc0-\xff][\x80-\xbf]+')"
> 
> should work. The downside is that you end up with a .gitconfig that is not
> valid utf-8. Perhaps someone else has a clever idea to get around that.

I think in more advanced regular expression engines you can do stuff
like matching "[\x{4e00}-\x{9fcc}]", or even "\p{Han}". But I don't know
that the stock libc regex is capable of anything like this, even with
EREs. That's the only option Git provides for matching word regexes, but
in theory we could support libpcre. We already can optionally build
against it; we would just need config/plumbing to get it into
diff.c:find_word_boundaries().

-Peff
