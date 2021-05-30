Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03976C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C72610A0
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhE3VqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:46:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:41526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhE3VqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:46:10 -0400
Received: (qmail 18952 invoked by uid 109); 30 May 2021 21:44:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 May 2021 21:44:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22132 invoked by uid 111); 30 May 2021 21:44:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 May 2021 17:44:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 30 May 2021 17:44:30 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Yuri <yuri@rawbw.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
Message-ID: <YLQHPu0bIy4qHEWP@coredump.intra.peff.net>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g>
 <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
 <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
 <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
 <50e2780a-21f3-499f-7960-76bf24f550f0@gmail.com>
 <6fef4b1e-1ec7-b697-c311-59caf6408b29@rawbw.com>
 <20210529092752.kifzqt3haddzgsob@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210529092752.kifzqt3haddzgsob@tb-raspi4>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 29, 2021 at 11:27:52AM +0200, Torsten Bögershausen wrote:

> I am not sure that there is a reliable way for Git to detect, if the
> terminal is capable of handling UTF-8.
> This should work reliable under Linux, Windows, Mac and all the supported
> Unix-ish platforms.

Yeah, I'm not sure how such a check would be done. On most Linux systems
I've seen, $LANG will mention "en_US.UTF-8" or similar. But I've no idea
how portable that convention is, not to mention that people may have
more complex setups anyway (e.g., not setting $LANG but setting some of
LC_*).

But more importantly, this is not even a UTF-8 problem. It is "can your
terminal do something sensible with high-bit characters in filenames of
your repositories". We don't know the encoding of those filenames (and
you may even have a mix).

(And likewise "terminal" here is really "whatever consumes Git's output,
be it the terminal or some program you've piped to).

> Having said that, the default could be switched some day in the future.
> Before that is "save", there may be a transition phase,
> where users are warned that the default may change.
> Scripts calling git need to use `git -c core.quotepath=yes`, or no,
> whatever input they expect.

Yes. If we're going to do anything, I think it would be to say "most
terminals and programs deal with high-bit characters OK these days, so
switching the default is more likely to fix things than break them".

I suspect most scripts would be OK either way. They need to handle
maybe-quoted filenames already, so it is really just a question of
whether the consuming program is OK with the high bits. If so, we could
probably get away with just a mention in the release notes, rather than
an annoying transition phase (which is likely to simply confuse most
users, who are unaware of the issue entirely).

But I'd feel more confident if whoever proposes such a change does some
research on how piping such names into common tools and scripting
languages works (both for utf8 and non-utf8 names).

-Peff
