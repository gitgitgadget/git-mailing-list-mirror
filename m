Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16020C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 19:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiK2TCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiK2TCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 14:02:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD1D48
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 11:02:32 -0800 (PST)
Received: (qmail 14562 invoked by uid 109); 29 Nov 2022 19:02:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Nov 2022 19:02:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22386 invoked by uid 111); 29 Nov 2022 19:02:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Nov 2022 14:02:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Nov 2022 14:02:31 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git port to Debian SH4 may have trouble
Message-ID: <Y4ZXRx4mf0UMk4H6@coredump.intra.peff.net>
References: <CAH8yC8niurChnXPrZSeBa7g1z5AF3PqYdf1X0Rm03rDanec6Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8niurChnXPrZSeBa7g1z5AF3PqYdf1X0Rm03rDanec6Gw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 12:01:01PM -0500, Jeffrey Walton wrote:

> This is a crummy bug report... I am  testing on Debian Unstable within
> a SH4 Chroot. I'm seeing a hang during a git pull. Eventually I have
> to CTRL+C, which results in "fatal: fetch-pack: invalid index-pack
> output."

The message is probably a red herring. Once you terminate index-pack,
the fetch-pack process reading from it will see EOF before reading the
expected "pack ..." line, and generate that message.

So the hang is probably the only interesting part.

> (sh4) debian-chroot:~# git clone -vv https://github.com/weidai11/cryptopp
> Cloning into 'cryptopp'...
> POST git-upload-pack (175 bytes)
> want e9cbc4698a6b3ed067910862ad1355069f348d2b (HEAD)
> want e9cbc4698a6b3ed067910862ad1355069f348d2b (refs/heads/master)
> ...
> want 511806c0eba8ba5b5cedd4b4a814e96df92864a6 (refs/tags/CRYPTOPP_8_7_0)
> POST git-upload-pack (gzip 1602 to 825 bytes)
> remote: Enumerating objects: 28448, done.
> remote: Counting objects: 100% (68/68), done.
> remote: Compressing objects: 100% (50/50), done.
> remote: Total 28448 (delta 29), reused 49 (delta 18), pack-reused 28380
> Receiving objects: 100% (28448/28448), 27.01 MiB | 4.30 MiB/s, done.
> Resolving deltas:   0% (0/20757)
> ^Cfatal: fetch-pack: invalid index-pack output

If we're in the "resolving deltas" section, then that means we're
probably not hanging on receiving input from the remote side. At this
point we should have gotten all of the data and would be CPU-bound
reassembling deltas and computing their hashes.

Just a hunch, but does:

  git config --global pack.threads 1

help? The delta resolution is multi-threaded, but nothing else in the
clone should be.

-Peff
