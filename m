Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9492A1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 23:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbeJ3Hw7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 03:52:59 -0400
Received: from 0x63.nu ([109.74.10.199]:33020 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbeJ3Hw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 03:52:59 -0400
Received: from localhost ([127.0.0.1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gHGXs-0002YL-89; Tue, 30 Oct 2018 00:02:04 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     peff@peff.net
Cc:     Anders Waldenborg <anders@0x63.nu>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] pretty: Add %(trailer:X) to display single trailer
In-Reply-To: <20181029141402.GA17668@sigill.intra.peff.net>
Date:   Mon, 29 Oct 2018 18:05:34 +0100
Message-ID: <CADsOX3Cbn7jjqFERptxMm59mn0qYnkf9bmFvJS20VBPedZHwqQ@mail.gmail.com>
References: <20181028125025.30952-1-anders@0x63.nu> <20181029141402.GA17668@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 29, 2018 at 3:14 PM Jeff King <peff@peff.net> wrote:
> Junio's review already covered my biggest question, which is why not
> something like "%(trailers:key=ticket)". And likewise making things like
> comma-separation options.

Jeff, Junio,

thanks!

Your questions pretty much matches what I (and a colleague I discussed
this with before posting) was concerned about.

My first try actually had it as an option to "trailers". But it got a
bit messy with the argument parsing, and the fact that there was a
fast path making it work when only specified. I did not want to spend
lot of time reworking fixing that before I had some feedback, so I
went for a smallest possible patch to float the idea with (a patch is
worth a 1000 words).

I'll start by reworking my patch to handle %(trailers:key=X)  (I'll
assume keys never contain ')' or ','), and ignore any formatting until
the way forward there is decided (see below).

> But my second question is whether we want to provide something more
> flexible than the always-parentheses that "%d" provides. That has been a
> problem in the past when people want to format the decoration in some
> other way.

Maybe just like +/-/space can be used directly after %, a () pair can
be allowed..   E.g "%d" would just be an alias for "%()D",  and for
trailers it would be something like "%()(trailers:key=foo)"

There is another special cased placeholder %f (sanitized subject line,
suitable for a filename). Which also could be changed to be a format
specifiier, allowing sanitize any thing, e.g "%!an" for sanitized
author name.

Is even the linebreak to commaseparation a generic thing?
"% ,()(trailers:key=Ticket)"   it starts go look a bit silly.

Then there are the padding modifiers. %<() %<|(). They operate on next
placeholder. "%<(10)%s" Is that a better syntax?
"%()%(trailers:key=Ticket,comma)"

I can also imagine moving all these modifiers into a generic modifier
syntax in brackets (and keeping old for backwards compat)
%[lpad=10,ltrunc=10]s ==  %<(10,trunc)%s
%[nonempty-prefix="%n"]GS ==  %+GS
%[nonempty-prefix=" (",nonempty-suffix=")"]D ==  %d
Which would mean something like this for tickets thing:
%[nonempty-prefix=" (Tickets:",nonempty-suffix=")",commaseparatelines](trailers:key=Ticket,nokey)
which is kinda verbose.

> We have formatting magic for "if this thing is non-empty, then show this
> prefix" in the for-each-ref formatter, but I'm not sure that we do in
> the commit pretty-printer beyond "% ". I wonder if we could/should add a
> a placeholder for "if this thing is non-empty, put in a space and
> enclose it in parentheses".

Would there be any interest in consolidating those formatters? Even
though they are totally separate beasts today. I think having all
attributes available on long form (e.g "%(authorname)") in addition to
existing short forms in pretty-formatter would make sense.

 anders
