Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05133C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDAC2072D
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgDMRSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:18:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:52294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732592AbgDMRSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 13:18:14 -0400
Received: (qmail 31768 invoked by uid 109); 13 Apr 2020 17:18:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Apr 2020 17:18:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19751 invoked by uid 111); 13 Apr 2020 17:28:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Apr 2020 13:28:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Apr 2020 13:18:12 -0400
From:   Jeff King <peff@peff.net>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org, Jeff.Hostetler@microsoft.com
Subject: Re: Git pull stuck when Trace2 target set to Unix Stream Socket
Message-ID: <20200413171812.GA8183@coredump.intra.peff.net>
References: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 02:05:00PM +0200, Son Luong Ngoc wrote:

> I am trying to write a simple git trace2 event collector and I notice
> that when git doing git pull with trace events being sent to a unix
> stream socket, the entire operation halted.
> 
> Reproduce as follow:
> ```
> cd git/git
> git config trace2.eventTarget af_unix:stream:/tmp/git_trace.sock
> git config trace2.eventBrief false
> (rm /tmp/git_trace.sock | ) &&  nc -lkU /tmp/git_trace.sock
> 
> # In a different terminal
> git pull # Pull stuck and never complete
> ```

I think the issue is the use of netcat as the server side.

Your git-pull involves multiple simultaneously-running Git processes.
But "nc -k" will only accept() a new client once the old one has
disconnected. So we'd deadlock any time we have this situation:

  - process A opens a stream to the socket, and keeps it open

  - process A spawns process B and waits for it to finish

  - process B tries to open a stream to the socket, which will block
    waiting for netcat to accept()

Now A cannot make forward progress until B finishes, but B will not make
forward progress until A closes the socket.

I was able to reproduce the issue locally, and process "A" was git-pull
and process "B" was git-merge.

Switching to using datagrams ("nc -u" and "af_unix:dgram") makes the
problem go away, because the connections are able to interleave their
packets.

> This does not happen when you set eventBrief to true
> ```
> git config trace2.eventBrief true
> ```

I don't know why this would matter (and it didn't seem to in my tests).

> Worth to note that if eventTarget is a file instead of a socket,
> everything works fine.

That makes sense, since their file writes can be interleaved.

-Peff
