Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C30C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 20:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBD1610D0
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 20:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhJVUzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 16:55:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:44734 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234398AbhJVUze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 16:55:34 -0400
Received: (qmail 23206 invoked by uid 109); 22 Oct 2021 20:53:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Oct 2021 20:53:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23063 invoked by uid 111); 22 Oct 2021 20:53:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Oct 2021 16:53:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Oct 2021 16:53:15 -0400
From:   Jeff King <peff@peff.net>
To:     Sven Strickroth <sven@cs-ware.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        bwilliams.eng@gmail.com
Subject: Re: Git silently broke push-options over ssh?
Message-ID: <YXMku8V9cdHLfXt6@coredump.intra.peff.net>
References: <4aef40f2-43f8-eab3-a840-6e76c8b4afbb@cs-ware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aef40f2-43f8-eab3-a840-6e76c8b4afbb@cs-ware.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 07:27:14PM +0200, Sven Strickroth wrote:

> If I understood <https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html>
> correctly I have to enable the Git protocol version 2 and then the push
> options should work.

I don't think that is true. There is no v2 push protocol yet, so the
push options must work over v0.

> Now, when I try to use push options on Windows it does not work. I tried to
> debug it:
> 
> D:\TortoiseGit>set GIT_TRACE=2
> D:\TortoiseGit>set GIT_SSH=ssh.exe
> D:\TortoiseGit>set GIT_SSH_VARIANT=ssh
> D:\TortoiseGit>set GIT_PROTOCOL=version=2
> D:\TortoiseGit>git -c protocol.version=2 -c ssh.variant=ssh -c
> ssh.command=ssh push -v -o ci.skip origin master~23:testing
> 17:36:06.285346 exec-cmd.c:237          trace: resolved executable dir:
> C:/Program Files/Git/mingw64/bin
> 17:36:06.285346 git.c:455               trace: built-in: git push -v -o
> ci.skip origin 'master~23:testing'
> Pushing to gitlab.com:tortoisegit/tortoisegit.git
> 17:36:06.295270 run-command.c:666       trace: run_command: unset
> GIT_CONFIG_PARAMETERS GIT_PREFIX; ssh.exe git@gitlab.com 'git-receive-pack
> '\''tortoisegit/tortoisegit.git'\'''
> 
> As you can see, the "-o SendEnv" parameter not passed to ssh.exe and,
> therefore, I think the push option is not transferred to the server.

Push options don't go through the environment. The GIT_PROTOCOL magic
for enabling v2 does, but push options themselves happen over the Git
protocol. Try GIT_TRACE_PACKET for seeing the actual conversation. E.g.:

  $ GIT_TRACE_PACKET=1 GIT_TRACE=1 git push -o foo git.peff.net:foo.git
  16:49:19.236448 git.c:455               trace: built-in: git push -o foo git.peff.net:foo.git
  16:49:19.237409 run-command.c:666       trace: run_command: unset GIT_PREFIX; ssh git.peff.net 'git-receive-pack '\''foo.git'\'''
  16:49:19.423323 pkt-line.c:80           packet:         push< b2f0a7f47f5f2aebe1e7fceff19a57de20a78c06 refs/heads/master\0report-status report-status-v2 delete-refs side-band-64k quiet atomic ofs-delta push-options object-format=sha1 agent=git/2.30.2
  16:49:19.423399 pkt-line.c:80           packet:         push< 0000
  16:49:19.431385 pkt-line.c:80           packet:         push> 0000
  16:49:19.431421 pkt-line.c:80           packet:         push> foo
  16:49:19.431442 pkt-line.c:80           packet:         push> 0000
  Everything up-to-date

On the server side, receive-pack will stick them in the environment to
communicate them to hooks, etc, but you wouldn't be able to see that
from the client.

Do note that I had to set receive.advertisePushOptions on the server to
make it work (though if it's not set, the client should complain
loudly). If you're pushing to gitlab.com they've presumably set up the
server side appropriately.

-Peff
