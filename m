Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C186C54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C931206D9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD0OnP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Apr 2020 10:43:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54694 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgD0OnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 10:43:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id h4so6560932wmb.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=60wdmHThWDabvs8WNpe4J8U4d/xnb7/Ddr2XhghVAGY=;
        b=V1Aqoi+UVGfHrsuTbyeBbA6HDzz9Pqre1eUHuLFyO4DdCl5lSYZmthYY8W/2GXFymt
         ZSy0VMQQQ2Va/ruwGVeKPQGKc7ee8l73UnFWEFY2fB+tf5czd6ewPw+v4OQQXmIlVd6y
         XKOprfIqM+zvX9iPhOEToYdhzy+2n/KTh6Y7yVRjMPxB8lOjPK2w7+6ZgFyn1xhA+/ho
         H1Dzim1GLfd4Dg49r8kqLBEzWy+nUDU64xqukNTHs1jhCCI8Poj1KLgdPKr07gsbsqVp
         9l6ZgMUQ+F9QrLZo+Nd2pUH4d0BcVEkZ2xotfGLLJ2SvbQFbK+JTPr9TXxg/q3kYa8If
         qouw==
X-Gm-Message-State: AGi0PuZ3dW574tz3wU3GOqa6SL3uw8Naxss+6Jq58nC4tLjFvJ/+MQb6
        aRWPVLegVADqUha7MRj0RQa+3cdZpRJ2Hm2/cjW6wglY
X-Google-Smtp-Source: APiQypLaef7sEAluw5hL04+TUNR/eUq380BcfzRxgn1D28OC6Tb862svUB1Bbib4Bp76tYiZGDt+z/+79Mhs1iaxc1I=
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr26147441wmh.11.1587998592904;
 Mon, 27 Apr 2020 07:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200426234750.40418-1-carenas@gmail.com> <20200427084235.60798-1-carenas@gmail.com>
 <20200427115223.GA1718141@coredump.intra.peff.net> <20200427122520.GA61348@Carlos-MBP>
In-Reply-To: <20200427122520.GA61348@Carlos-MBP>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Apr 2020 10:43:01 -0400
Message-ID: <CAPig+cRy9T43yXsuj-_vPJoROe8xYRMExxnCxRmG6kij+ykxKg@mail.gmail.com>
Subject: Re: [PATCH v2] git-credential-store: skip empty lines and comments
 from store
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Dirk <dirk@ed4u.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 8:25 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 07:52:23AM -0400, Jeff King wrote:
> > On Mon, Apr 27, 2020 at 01:42:35AM -0700, Carlo Marcelo Arenas Belón wrote:
> > > +test_expect_success 'get: allow for empty lines or comments in store file' '
> > > +   q_to_cr >"$HOME/.git-credentials" <<-\EOF &&
> > > +   #this is a comment and the next line contains leading spaces
> > > +       Q
> > > +   https://user:pass@example.com
> > > +   Q
> > > +   EOF
> >
> > q_to_cr is a little weird here, as we wouldn't expect there to be CRs in
> > the file. They do get removed by strbuf_trim(), even in non-comment
> > lines. But perhaps "sed s/Q//" would accomplish the same thing (making
> > the whitespace more visible) without making anyone wonder whether the CR
> > is an important part of the test?
>
> I know, but commiting a line with 1 tab and 4 empty spaces instead of
> using Q seemed even worst and q_to_cr almost fits the bill and might
> even make this test "windows compatible" for once ;)

Hmm? In the proposal[1], q_to_tab() was used, not q_to_cr(), and
q_to_tab() seemed to fit quite well as a replacement for the original
'echo' chain[2] which emitted one whitespace-only line. Substituting
that whitespace-only line with "Q" (which gets translated into a TAB)
seems to fit much better than q_to_cr().

> will rewrite then using test_write_lines and I hope it is still as
> readable without having to resort to the originl ugly chain of echo

test_write_lines() doesn't do a very good job of representing -- at a
glance -- what the "expected" output should be. The q_to_tab() block
made it much  more clear.

(Having said that, it's probably not worth another re-roll just to change that.)

[1]: https://lore.kernel.org/git/CAPig+cR8HKcbNxxw65ERz0iHvnO5aC6RXvF9NjvFTySXpcHCSQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/20200426234750.40418-1-carenas@gmail.com/
