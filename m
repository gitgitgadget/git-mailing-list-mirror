Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3982C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52F761108
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhJVTnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:43:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:44690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234228AbhJVTnA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:43:00 -0400
Received: (qmail 23111 invoked by uid 109); 22 Oct 2021 19:40:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Oct 2021 19:40:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22135 invoked by uid 111); 22 Oct 2021 19:40:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Oct 2021 15:40:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Oct 2021 15:40:40 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philipp Eib <philipp.w.eib@gmail.com>, git@vger.kernel.org
Subject: Re: Error in 'git clone' via SSH in v2.33.0 (related to commit
 ae1a7ee)
Message-ID: <YXMTuMGWQD4Swwt4@coredump.intra.peff.net>
References: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2110221723430.62@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2110221723430.62@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 05:29:37PM +0200, Johannes Schindelin wrote:

> The `--pretty=reference` format: ae1a7eefffe6 (fetch-pack: signal v2
> server that we are done making requests, 2021-05-19). The idea of this
> patch is apparently to "do a half-duplex shutdown to indicate that they
> can hang up as soon as the pack is sent".
> 
> Peff, any ideas what could go wrong here?

As Ævar noted, the symptoms here are reminiscent of issues people have
had using socat via core.gitproxy. But in those cases, the problem is
that "socat" is quite eager to close the reading side of the socket
after it has learned that there is nothing left to write (when it gets
EOF on its stdin). And ssh should be much more robust to this.

E.g., if I run:

  echo input | strace -tt ssh some_server 'cat; sleep 5; echo foo'

then it will robustly wait to get that "foo" back from the server. In
this snippet of trace we can see:

     66204 15:19:58.274859 read(4, "input\n", 16384) = 6
     66204 15:19:58.275249 select(7, [3 4], [3], NULL, NULL) = 1 (out [3])
     66204 15:19:58.275278 write(3, "\332\323M\300\213Pz\242\3334\25\314A.I\374\3736+&\373\33m\\x\364`\243\234\206\335\260"..., 44) = 44

This is it relaying its stdin to the server. And then:

     66204 15:19:58.275316 select(7, [3 4], [], NULL, NULL) = 1 (in [3])
     66204 15:19:58.279969 read(3, "/\263\330\373\266\255\34~\340\3216\1|\35Y\254L.y\321\227E\264j\342\315\355\357\223E\252\27"..., 8192) = 44
     66204 15:19:58.279987 select(7, [3 4], [5], NULL, NULL) = 1 (out [5])
     66204 15:19:58.280003 write(5, "input\n", 6) = 6

Here's the server responding back to us. And then:

     66204 15:19:58.280019 select(7, [3 4], [], NULL, NULL) = 1 (in [4])
     66204 15:19:58.907748 read(4, "", 16384) = 0
     66204 15:19:58.908094 close(4)          = 0

We see EOF on stdin (which would be the new thing Git is doing in
ae1a7eefffe6). And then:

     66204 15:19:58.908430 getpid()          = 66204
     66204 15:19:58.908681 select(7, [3], [3], NULL, NULL) = 1 (out [3])
     66204 15:19:58.908812 write(3, "\17,$\226\211\177\n\220hW\"\240L\nC#\233\24~\323\247\206y'\217\34_=r\204n("..., 36) = 36

We pass that along to the server, which presumably closes the pipe to
cat. In a socket tool like socat, this would be a shutdown(SHUT_WR). And
then:

     66204 15:19:58.908958 select(7, [3], [], NULL, NULL) = 1 (in [3])
     66204 15:20:04.027161 read(3, "\315\22\314\245\225Y>\321\362\360zB \234\320\26470}+\306\341\376Phw?\344\336\246\245\345"..., 8192) = 168
     66204 15:20:04.027612 select(7, [3], [5], NULL, NULL) = 1 (out [5])
     66204 15:20:04.027990 write(5, "foo\n", 4) = 4

We do wait 5 seconds to get the response. The notable difference here
from something like socat is that there's no timeout in our select().
We'll wait until the server closes the connection to tell us it has
nothing left to send.

Now obviously this is kind of weird made-up command to demonstrate this.
But from ssh's perspective, this is roughly what it should be seeing
from Git.

I wonder if it's possible to get some kind of equivalent trace
for the version of ssh in use here. Even if not strace, I think "ssh
-vv" details some of this (but do make sure you're not using a
ControlMaster, as that hides a lot of it in a separate process).

My understanding is that GfW just ships with openssh, but I wonder if it
could somehow behave differently here because of some platform-specific
issue. Another question is whether there might be any other programs in
use (an alternate version of ssh, or something wrapping ssh, etc).

Another possibility is that ssh is behaving just fine, but something on
the server is not happy with this half-duplex state. openssh-server
connected directly to git-upload-pack should be fine, but the OP
mentioned Gitlab. I'm not sure what's between the ssh session and Git
there, or if there are any logs to examine what it sees. (On GitHub
there is most definitely an extra proxy that terminates the ssh session
and talks to an actual git-upload-pack on another server, but it handles
this case).

-Peff
