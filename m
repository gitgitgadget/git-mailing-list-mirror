Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B45C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 15:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiHEPhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiHEPhA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 11:37:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D81260A
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 08:36:59 -0700 (PDT)
Received: (qmail 15169 invoked by uid 109); 5 Aug 2022 15:36:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Aug 2022 15:36:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32365 invoked by uid 111); 5 Aug 2022 15:36:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Aug 2022 11:36:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Aug 2022 11:36:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <Yu05GjncDaGRTgce@coredump.intra.peff.net>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
 <YulFTSTbVaTwuQtt@coredump.intra.peff.net>
 <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 03, 2022 at 11:56:13PM +0200, René Scharfe wrote:

> Without that line the added test hangs for me on the Git for Windows
> SDK on Windows 11.

Hmph. Interesting that it passes in CI, but not on your local setup.
I wonder why pipes would behave differently. Or perhaps there is even
some configuration different that means we are still running the perl
add--interactive there, though I kind of doubt it (and couldn't find
anything pointing there).

Still, if it fails in at least one spot, it's something we need to deal
with. On the plus side, once we figure out how to fix it, the
hand-grenade of "enable_nonblock() does nothing on Windows" will not be
present anymore. ;)

> With the patch below it fails and reports basically nothing:
> [...]
>    not ok 57 - handle very large filtered diff
>    #
>    #               git reset --hard &&
>    #               # The specific number here is not important, but it must
>    #               # be large enough that the output of "git diff --color"
>    #               # fills up the pipe buffer. 10,000 results in ~200k of
>    #               # colored output.
>    #               test_seq 10000 >test &&
>    #               test_config interactive.diffFilter cat &&
>    #               printf y >y &&
>    #               force_color git add -p >output 2>&1 <y &&
>    #               git diff-files --exit-code -- test
>    #
>    1..57
> 
> The file "output" contains "error: failed to run 'cat'".  This is
> add-patch.c::parse_diff() reporting that pipe_command() failed.  So
> that's not it, yet.  (I don't actually know what I'm doing here.)

That implies that your call to enable_nonblock() succeeded, or
pipe_command() itself would have complained, too. Maybe instrument
it like this:

diff --git a/run-command.c b/run-command.c
index 8ea609d4ae..27e79c928a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1473,11 +1473,17 @@ int pipe_command(struct child_process *cmd,
 	}
 
 	if (pump_io(io, nr) < 0) {
+		error_errno("pumping io failed");
 		finish_command(cmd); /* throw away exit code */
 		return -1;
 	}
 
-	return finish_command(cmd);
+	{
+		int ret = finish_command(cmd);
+		if (ret)
+			error("child returned failure %d", ret);
+		return ret;
+	}
 }
 
 enum child_state {

Normally we stay pretty quiet there and let the caller report any
problems, but it lacks enough context to make a more specific error
report.

>  int enable_nonblock(int fd)
>  {
> +	DWORD mode;
> +	HANDLE handle = winansi_get_osfhandle(fd);
> +	if (!handle)
> +		return -1;
> +	if (!GetNamedPipeHandleState(handle, &mode, NULL, NULL, NULL, NULL, 0))
> +		return -1;
> +	if (mode & PIPE_NOWAIT)
> +		return 0;
> +	mode |= PIPE_NOWAIT;
> +	if (!SetNamedPipeHandleState(handle, &mode, NULL, NULL))
> +		return -1;
>  	return 0;
>  }

This looks plausibly correct to me. ;) We might want to change the name
of the compat layer to enable_pipe_nonblock(), since one assumes from
the function names this only works for pipes.

Thanks for poking at this.

-Peff
