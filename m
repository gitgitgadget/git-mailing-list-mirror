Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7784BC63798
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45236221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgK1Vtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:44948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387570AbgK1T5b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:57:31 -0500
Received: (qmail 26275 invoked by uid 109); 28 Nov 2020 06:30:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Nov 2020 06:30:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30667 invoked by uid 111); 28 Nov 2020 06:30:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Nov 2020 01:30:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Nov 2020 01:30:07 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
Message-ID: <X8Hub2OeFy3V6MhV@coredump.intra.peff.net>
References: <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
 <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
 <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
 <X778eIAr3uzdh0H0@coredump.intra.peff.net>
 <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
 <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
 <X8B9589XMlCQEltA@coredump.intra.peff.net>
 <d0fcfa7f-9835-a9e6-c4a4-af4de177ff8c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0fcfa7f-9835-a9e6-c4a4-af4de177ff8c@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 27, 2020 at 09:43:06PM +0100, René Scharfe wrote:

> > [...zombie processes...]
> OK, so overall the situation sounds a bit messy to me and perhaps
> there's room for improvement, but I agree now that we can leave the
> specialists (init, tini) to deal with our zombies.

Keep in mind we are not changing anything here, either. clean_on_exit is
kicking in when we already would be exiting without calling wait(). We
could _also_ instruct run-command to wait, but nobody seems to be
complaining about it.

> With the debug patch above and GIT_DEBUG_ABANDON_CHILD=git-upload-pack I
> need the following patch get rid of the spawned process:

I don't think that is an interesting case, though. We've been discussing
the spawn between upload-pack and its child pack-objects, but here
you're running a bogus infinite loop instead of upload-pack. It will
spin forever, because the client is expecting it to say something.

In a normal setup, a severing of the connection between the client and
upload-pack will be noticed quickly, because each one is always either
trying to read from or write to the other (the exception is while
pack-objects is processing without progress meters, but there we send a
keep-alive every 5 seconds).

If one of them were to spin in a true infinite loop due to a bug (but
not break the connection), we would wait forever. But the solution there
is a timeout on inactivity.

So...

> --- >8 ---
> 
> diff --git a/connect.c b/connect.c
> index 8b8f56cf6d..e1b1b73ef5 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -1369,6 +1369,7 @@ struct child_process *git_connect(int fd[2], const char *url,
> 
>  		conn->use_shell = 1;
>  		conn->in = conn->out = -1;
> +		conn->clean_on_exit = 1;
>  		if (protocol == PROTO_SSH) {
>  			char *ssh_host = hostandport;
>  			const char *port = NULL;
> 
> --- 8< ---

I don't think there's much point here. If the client side dies, it will
close the socket, and upload-pack would notice anyway. It's only your
fake "spin without doing any I/O" patch that misbehaves.

Moreover, this wouldn't do _anything_ in many cases, because upload-pack
is going to be on the far side of a network socket. So really you'd be
killing ssh here for those cases (which then likewise would close the
socket, but this isn't necessary because ssh will also exit when it sees
us close _our_ end). And it would do nothing at all for git-over-http,
git://, etc.

> So is there a downside to clean_on_exit?  It doesn't make sense when we
> start browsers or pagers, but for hooks and helpers (which are probably
> the majority of started processes) cascading program termination makes
> sense, no?

In general, no, I suspect clean_on_exit wouldn't be hurting anything if
we used it more. But generally we get a natural cascade of termination
because exiting processes close the input and output pipes going to the
other sub-processes.

-Peff
