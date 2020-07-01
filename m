Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4021C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE5020781
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbgGAQVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:21:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:47408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgGAQVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 12:21:12 -0400
Received: (qmail 24830 invoked by uid 109); 1 Jul 2020 16:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2020 16:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6629 invoked by uid 111); 1 Jul 2020 16:21:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2020 12:21:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Jul 2020 12:21:11 -0400
From:   Jeff King <peff@peff.net>
To:     "R. Diez" <rdiez@neanderfunk.de>
Cc:     git@vger.kernel.org
Subject: Re: Interrupted system call
Message-ID: <20200701162111.GA934052@coredump.intra.peff.net>
References: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
 <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 11:43:15AM +0200, R. Diez wrote:

> After a 3-month pause, I recently updated my Ubuntu 18.04.4. I am
> using a PPA to keep Git more up to date, so I have now "git version
> 2.27.0".
> 
> I am now getting this kind of errors:
> 
> fatal: failed to read object cf965547a433493caa80e84d7a2b78b32a26ee35: Interrupted system call
> 
> error: unable to mmap /home/rdiez/[blah blah]/SrcRepo.git/objects/2e/f96ffba4c0d60f36c8779758f82752be380689: Interrupted system call
> 
> I am using a mount point for a network share. Keep in mind that Git thinks
> it is working on a local directory, so there should be no sockets or
> non-blocking I/O involved.

Looking at the code, that message is slightly deceptive. It's reporting
a failure from map_loose_object_1(), which calls both open() and mmap(),
as well as fstat().  It would be interesting to know which syscall is
actually failing. Running the failure case under "strace" would be
interesting (likewise to see which signal is causing the interruption).

> The problem is probably caused by using SMB to connect to an outdated
> Windows server. It has been working for years, but at some point in time it
> is bound to fail. The Linux kernel itself seems to introduce bugs in the
> SMB/CIFS code every now and then.
> 
> Nevertheless, I am surprised to get such an "Interrupted system call" from
> Git. A long time ago I learnt that it is OK for many syscalls to get
> interrupted, so you have to loop around them. See here for more information:

We do check for signals and re-start read() and write() calls as
appropriate. We don't for open(), and nobody has ever complained (though
it definitely is documented to result in EINTR, I'd imagine it's
relatively rare). I'm not excited about the prospect of adding retry
code to every open(), though perhaps doing it with our git_open()
wrapper would be sufficient (it's unclear how stdio fopen() behaves).

> How can I pin-point this problem? I would like to know where Git is
> encountering this error, so that I can troubleshoot it, and maybe report yet
> another bug to the Linux SMB/CIFS maintainer.

I think the first step is using strace to record the system call
returning EINTR (and the signal that interrupted it). I suspect it's in
open(), though, and probably not a bug: opening network files may take a
while and need to be interruptable.

-Peff
