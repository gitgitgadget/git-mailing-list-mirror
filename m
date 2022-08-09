Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83EC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiHINEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHINEb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:04:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E8A45D
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:04:29 -0700 (PDT)
Received: (qmail 30697 invoked by uid 109); 9 Aug 2022 13:04:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Aug 2022 13:04:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2071 invoked by uid 111); 9 Aug 2022 13:04:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Aug 2022 09:04:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Aug 2022 09:04:28 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YvJbXJyaKz5QPYdz@coredump.intra.peff.net>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
 <YulFTSTbVaTwuQtt@coredump.intra.peff.net>
 <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <q341oso8-1ps6-65n6-s394-n8q433q79nr2@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q341oso8-1ps6-65n6-s394-n8q433q79nr2@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 08, 2022 at 02:59:49PM +0200, Johannes Schindelin wrote:

> On Tue, 2 Aug 2022, Jeff King wrote:
> 
> > diff --git a/run-command.c b/run-command.c
> > index 14f17830f5..ed99503b22 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1438,6 +1439,15 @@ int pipe_command(struct child_process *cmd,
> >  		return -1;
> >
> >  	if (in) {
> > +		if (enable_nonblock(cmd->in) < 0) {
> > +			error_errno("unable to make pipe non-blocking");
> 
> It might be a bit heavy-handed to error out in this case, as it usually
> does not cause problems. At least that's what the fact suggests to me that
> I personally never encountered the dead-lock myself, and neither do I
> recall anybody piping more than two megabytes through `git checkout -p`.

That thought crossed my mind, as well, but I'm hesitant to leave a known
bug in place that can cause a deadlock. It would be one thing if we
could muddle through without nonblock in a slower way, but I don't think
we can easily detect this situation after the fact.

So maybe some options are:

  - don't bother with O_NONBLOCK unless the size of the input is over N
    bytes. The trouble there is that it's not clear what N should be.
    It's fcntl(F_GETPIPE_SZ) on Linux, but that's not portable. We could
    possibly come up with a conservative value if we had a ballpark for
    pipe size on Windows. It feels a bit hacky, though.

  - we could actually guess at a deadlock by putting a timeout on the
    poll(). That would also catch hanging or slow filter processes. I
    really hate putting clock-based limits on things, though, as it
    means the tool behaves differently under load. And keep in mind this
    is deep in the pipe_command() code. It happens to only trigger for
    diff filters now, but it may be used in other spots (in fact it
    already is, and it's only the size of current gpg payloads/responses
    that means it doesn't happen to trigger).

Stepping back, though, I think we should consider why we'd see an error
here. I wouldn't expect it to ever fail on a system where O_NONBLOCK was
supported. If we want to make it a silent noop on some platforms, then
we can stick that into the enable_nonblock() function (which is what I
did, but as René showed, that is probably not a good enough solution).

-Peff
