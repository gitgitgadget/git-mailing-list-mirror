Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE84C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 10:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhLEKRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 05:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhLEKRB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 05:17:01 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835BC061714
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 02:13:34 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id AB73458730218; Sun,  5 Dec 2021 11:13:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id A775060C28B14;
        Sun,  5 Dec 2021 11:13:32 +0100 (CET)
Date:   Sun, 5 Dec 2021 11:13:32 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-backend: give a hint that web browser access is
 not supported
In-Reply-To: <xmqqtufnonor.fsf@gitster.g>
Message-ID: <34pqs81o-36p6-s416-s791-1onsqo1734oo@vanv.qr>
References: <xmqqee6vwj67.fsf@gitster.g> <20211202102855.23907-1-jengelh@inai.de> <xmqqee6spz9s.fsf@gitster.g> <7r23s082-o3q0-479o-srqn-r45q778s5nq7@vanv.qr> <xmqqtufnonor.fsf@gitster.g>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sunday 2021-12-05 02:17, Junio C Hamano wrote:
>>>What is in "pathinfo" parameter?
>> It is getenv("PATH_INFO").
>
>That part I know.  The question was what would a typical value of
>that parameter look like in the context of somebody mistakenly
>visiting Git smart HTTP endpoint via their browser.

As far as I can tell, it contains the request URI plus index.html resolution;
https://git.inai.de/ reports /index.html while
https://git.inai.de/foo reports /foo (since foo does not exist in the fs).

>I am basically wondering if it is helping the user enough, or if it
>is sufficient to give just the "err" and "hint", and nothing else.

I felt that, because ls(1) reports the filename again, e.g.

$ ls x
ls: cannot access 'x': No such file or directory

that git-http-backend could do the same, especially since
pathinfo isn't just $ENV{REQUEST_URI} again at all times.

>> Yes, that seems more like it. I was not aware of send_strbuf.
>
>Heh, I wasn't either.  The review of this topic was the first time I
>seriously read any part of that file, and I think I still only read
>just about 20% of it ;-)
>
>Also, will the real Git clients, which are the primary intended
>audiences this program is trying to talk to, be OK if we suddenly
>start giving a non-empty 404 page?

I am confident enough to say yes. It's not like git-http-backend
returned anything previously in the 404 case (like JSON or so),
therefore clients could not possibly depend on content.

>If any implementations of Git HTTP client this program is serving
>(1) uses a 404 response as a cue to decide its next request
>(e.g. there may be some "try this URL and if it fails, do another
>one" fallback logic)

Not sure if they heed Location: headers, but I am not changing
that :-)
