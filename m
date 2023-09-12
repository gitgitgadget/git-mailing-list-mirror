Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A13CA0ED3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 04:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjILEdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjILEdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 00:33:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03757BC
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 21:33:46 -0700 (PDT)
Received: (qmail 13886 invoked by uid 109); 12 Sep 2023 04:33:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Sep 2023 04:33:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15293 invoked by uid 111); 12 Sep 2023 04:33:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Sep 2023 00:33:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Sep 2023 00:33:45 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     Max Amelchenko <maxamel2002@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
Message-ID: <20230912043345.GA1623696@coredump.intra.peff.net>
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
 <ZP2DaQMA_aFvjQiR@debian.me>
 <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
 <ZP4PO+HkbsbuKact@nand.local>
 <CAN47KsX5cpo5oD7PAwAQzjR4oocST6uSkJe2SzAYPxxqy7dGtg@mail.gmail.com>
 <20230912T004049Z.jiWw7xuK7fiT@pug.qqx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912T004049Z.jiWw7xuK7fiT@pug.qqx.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 08:40:49PM -0400, Aaron Schrab wrote:

> At 13:11 +0300 11 Sep 2023, Max Amelchenko <maxamel2002@gmail.com> wrote:
> > Maybe it's connected also to the underlying infrastructure? We are
> > getting this in AWS lambda jobs and we're hitting a system limit of
> > max processes because of it.
> 
> Running as a lambda, or in a container, could definitely be why you're
> seeing a difference. Normally when a process is orphaned it gets adopted by
> `init` (PID 1), and that will take care of cleaning up after orphaned zombie
> processes.
> 
> But most of the time containers just run the configured process directly,
> without an init process. That leaves nothing to clean orphan processes.

Yeah, that seems like the culprit. If the clone finishes successfully,
we do end up in finish_connect(), where we wait() for the process. But
if we exit early (in this case, ssh bails and we get EOF on the pipe
reading from it), then we may call die() and exit immediately.

We _could_ take special care to add every spawned process to a global
list, set up handlers via atexit() and signal(), and then reap the
processes. But traditionally it's not a big deal to exit with un-reaped
children, and this is the responsibility of init. I'm not sure it makes
sense for Git to basically reimplement that catch-all (and of course we
cannot even do it reliably if we are killed by certain signals).

> Although for that to really be a problem, would require hitting that max
> process limit inside a single container invocation. Of course since
> containers usually aren't meant to be spawning a lot of processes, that
> limit might be a lot lower than on a normal system.
> 
> I know that Docker provides a way to include an init process in the started
> container (`docker run --init`), but I don't think that AWS Lambda does.

I don't know anything about Lambda, but if you are running arbitrary
commands, then it seems like you could insert something like this:

  https://github.com/krallin/tini

into the mix. I much prefer that to teaching Git to try to do the same
thing in-process.

-Peff
