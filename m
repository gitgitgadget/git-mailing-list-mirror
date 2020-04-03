Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B35C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4994A206F5
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgDCS6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:58:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:60944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727842AbgDCS6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 14:58:05 -0400
Received: (qmail 29639 invoked by uid 109); 3 Apr 2020 18:58:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 18:58:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21901 invoked by uid 111); 3 Apr 2020 19:08:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 15:08:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 14:58:04 -0400
From:   Jeff King <peff@peff.net>
To:     Josep Torra <n770galaxy@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible regression in git 2.26.0
Message-ID: <20200403185804.GA659704@coredump.intra.peff.net>
References: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 07:13:25PM +0200, Josep Torra wrote:

> Today I'd noticed a failure in some custom automation that seems to
> came as a side effect after of a git client update.
> 
> The issue issue I'd spotted is the following:
> 
> $ git clone git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic
> linux/bionic
> Cloning into 'linux/bionic'...
> fatal: remote error: Parameters must have values

I can reproduce here, and it's definitely related to using protocol v2.
Running:

  GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote \
    git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic \
    >/dev/null

yields:

  [...]git> git-upload-pack ~ubuntu-kernel/ubuntu/+source/linux/+git/bionic\0host=git.launchpad.net\0\0version=2\0
  [...]git< ERR Parameters must have values

So it's complaining at that initial contact probing for v2. The behavior
is the same with v1 (which was an interim step between v0 and v1 to do
this probing and check for compatibility).

We checked that the probe works sensibly against old versions of Git, as
well as a few others (JGit, and I can't remember the rest).

Do you know what software powers git.launchpad.net? That "Parameters
must have values" message has never appeared in any Git version, though
the server claims to be v2.17.1:

  $ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote \
     git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic \
     2>&1 >/dev/null | grep agent=
  [...]git< a78d21bd8bb58c158f73108eb7d7402619fcae3d HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed symref=HEAD:refs/heads/master agent=git/2.17.1

My guess is that it may be v2.17.1 with some kind of load-balancing or
proxy layer in it. It's rather unfortunate that nobody noticed the
problem during the year and a half testing phase. But at this point, I
think the best path forward is probably to try to fix that server side
(preferably to speak v2, but if not, to at least ignore the v2 probe
marker and continue to speak v0; the client will gracefully handle
that).

By the way, swapping out git:// for https:// in the URL works just fine
for this server. In git-over-http, the v2 probe goes in an HTTP request
header, and they seem to ignore that and speak v0 (which is an expected
and fine outcome for pre-v2-aware servers). That may be why nobody
noticed before.

-Peff
