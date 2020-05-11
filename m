Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9F7C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A1F206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgEKTtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:49:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:43654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727873AbgEKTtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:49:32 -0400
Received: (qmail 18635 invoked by uid 109); 11 May 2020 19:49:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 May 2020 19:49:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31034 invoked by uid 111); 11 May 2020 19:49:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2020 15:49:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 May 2020 15:49:30 -0400
From:   Jeff King <peff@peff.net>
To:     Arno Gourdol <arno.gourdol@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Issue with commit a2b26ff "fsck: convert gitmodules url to URL
 passed to curl"
Message-ID: <20200511194930.GA10545@coredump.intra.peff.net>
References: <8F92F354-BBDD-4629-98D4-A67E0A865397@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8F92F354-BBDD-4629-98D4-A67E0A865397@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 11:02:24AM -0700, Arno Gourdol wrote:

> This change introduced stricter validation and checking of the .gitmodules file.
> 
> The problem is that I had an invalid URL in my .gitmodules file (an extra "/" in "http://“):
> 
> ```
> [submodule "packages/website/assets/tecendil-js"]
>     path = packages/website/assets/tecendil-js
>     url = https:///github.com/arnog/tecendil-js.git
>     branch = master
> ```

Yeah, I agree that would be blocked by the recent fsck changes you
found.

> However, I cannot commit a fix to this, as it gets rejected because
> the current .gitmodules is invalid. As a result I can no longer push
> commits to my repo.

Was the broken .gitmodules already pushed up? If so, then the push
fixing it shouldn't need to send the bad object, and should be allowed.
Though you need to make sure you aren't pushing up any intermediate
trees with the broken state, either (i.e., you can't push up the fix on
top of some other changes; the fix has to come first).

If it wasn't already pushed up, then you should be able to fix via "git
rebase -i" or similar. That will rewrite history, but the history hasn't
been shared with anyone else by pushing, it shouldn't be a big deal.

> (PS: I have attempted to contact GitHub about this, but haven’t heard back)

Hopefully one of the suggestions above should lead to a resolution. But
in the worst case they can relax the fsck restrictions temporarily to
get a fix pushed up.

-Peff
