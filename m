Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518F6EDE99E
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 09:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbjINJ4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjINJ4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 05:56:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99CE0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 02:56:03 -0700 (PDT)
Received: (qmail 27362 invoked by uid 109); 14 Sep 2023 09:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 09:56:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21437 invoked by uid 111); 14 Sep 2023 09:56:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Sep 2023 05:56:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Sep 2023 05:56:01 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Message-ID: <20230914095601.GE2254894@coredump.intra.peff.net>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
 <20230907210638.GB941945@coredump.intra.peff.net>
 <9ba22d4b-3cbe-4d4a-8dba-bc3781e82222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ba22d4b-3cbe-4d4a-8dba-bc3781e82222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2023 at 10:59:06AM +0100, Phillip Wood wrote:

> Do we want a whole new session? As I understand it to launch a foreground
> job shells put the child in its own process group and then call tcsetpgrp()
> to change the foreground process group of the controlling terminal to that
> of the child. I agree that would be a better way of doing things on unix.

One thing I am not clear on is the convention on who does the process
group and controlling terminal setup. Should Git do it to say "I am
handing off control of the terminal to the editor that I am spawning"?
Or should the editor say "I am an editor which has a user interface that
takes over the terminal; I will control it while I am running".

The latter makes much more sense to me, as Git cannot know how the
editor plans to behave. But as I understand it, this kind of job control
stuff is implemented by the calling shell, which does the tcsetpgrp()
call.

So I dunno. It sounds to me like the "right" thing here is making Git
more shell-like in handing control to a program (like the editor) that
we expect to be in the foreground of the terminal. As opposed to the
"ignore SIGINT temporarily" thing which feels more like band-aid. But
I'm wary of getting into a rabbit hole of portability headaches and
weird corners of Unix terminal-handling conventions.

-Peff
