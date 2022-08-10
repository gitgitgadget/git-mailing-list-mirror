Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55134C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 20:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiHJUCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHJUCn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 16:02:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DA82753
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 13:02:42 -0700 (PDT)
Received: (qmail 6744 invoked by uid 109); 10 Aug 2022 20:02:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 20:02:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15224 invoked by uid 111); 10 Aug 2022 20:02:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 16:02:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 16:02:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
Message-ID: <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
References: <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 07:39:40AM +0200, René Scharfe wrote:

> write() on Windows reports ENOSPC when writing to a non-blocking pipe
> whose buffer is full and rejects writes bigger than the buffer outright.
> Change the error code to EAGAIN and try a buffer-sized partial write to
> comply with POSIX and the expections of our Git-internal callers.

Bearing in mind that I have no qualifications for reviewing
Windows-specific patches, this seems like the right thing to be doing
from the behavior you saw.

One question:

> +	if (result < 0 && errno == ENOSPC) {
> +		/* check if fd is a non-blocking pipe */
> +		HANDLE h = (HANDLE) _get_osfhandle(fd);
> +		DWORD s;
> +		if (GetFileType(h) == FILE_TYPE_PIPE &&
> +		    GetNamedPipeHandleState(h, &s, NULL, NULL, NULL, NULL, 0) &&
> +		    (s & PIPE_NOWAIT)) {
> +			DWORD obuflen;
> +			if (!GetNamedPipeInfo(h, NULL, &obuflen, NULL, NULL))
> +				obuflen = PIPE_BUFFER_SIZE;
> +			if (len > obuflen)
> +				return mingw_write(fd, buf, obuflen);
> +			errno = EAGAIN;
> +		}

OK, so we call GetNamedPipeInfo() to find the size of the pipe buffer.
It's unclear to me from Microsoft's docs if that is the _total_ size, or
if it's the remaining available size. Hopefully the latter, since none
of this works otherwise. ;)

But two corner cases:

  - If we fail to get the size, we guess that it's the maximum. Is this
    dangerous? I'm not sure why the call would fail, but if for some
    reason it did fail and we can't make forward progress, would we
    enter an infinite recursion of mingw_write()? Would it be safer to
    bail with EAGAIN in such a case (through granted, that probably just
    puts us into an infinite loop in xwrite())?

  - According to the docs:

      If the buffer size is zero, the buffer is allocated as needed.

    If we see this case, we'd then call mingw_write() with 0 bytes,
    which I imagine also makes no forward progress (though maybe we
    eventually return a successful 0-byte write?).

-Peff
