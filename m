Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0441FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdBGA1t (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:27:49 -0500
Received: from havoc.proulx.com ([96.88.95.61]:42955 "EHLO havoc.proulx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbdBGA1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:27:48 -0500
Received: from joseki.proulx.com (localhost [127.0.0.1])
        by havoc.proulx.com (Postfix) with ESMTP id 7326B72F
        for <git@vger.kernel.org>; Mon,  6 Feb 2017 17:27:47 -0700 (MST)
Received: from hysteria.proulx.com (hysteria.proulx.com [192.168.230.119])
        by joseki.proulx.com (Postfix) with ESMTP id 3E55D21243
        for <git@vger.kernel.org>; Mon,  6 Feb 2017 17:27:47 -0700 (MST)
Received: by hysteria.proulx.com (Postfix, from userid 1000)
        id 3786D2DC5F; Mon,  6 Feb 2017 17:27:47 -0700 (MST)
Date:   Mon, 6 Feb 2017 17:27:47 -0700
From:   Bob Proulx <bob@proulx.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git-daemon shallow checkout fail
Message-ID: <20170206171225215133282@bob.proulx.com>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
References: <20170129002932.GA19359@dismay.proulx.com>
 <20170130172730.x5guphyqf5fsfi7m@sigill.intra.peff.net>
 <CACsJy8DED9WRr_T6g43bxHUGQYVnfaTx15hqSGiiajvi0TxtuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DED9WRr_T6g43bxHUGQYVnfaTx15hqSGiiajvi0TxtuA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen wrote:
> Jeff King wrote:
> > It depends on the git version on the server. The interesting code is in
> > upload-pack.c, which is spawned by git-daemon to serve a fetch or clone
> > request.
> >
> > See commit b790e0f67 (upload-pack: send shallow info over stdin to
> > pack-objects, 2014-03-11), which lays out the history. Since that commit
> > (in git v2.0.0), there should be no tmpfile needed.
> 
> It must be it. There's nowhere else that upload-pack can create
> shallow_XXXXXX. (receive-pack and fetch-pack can).

I am sure the file creation is there.  Because it isn't being done
anywhere.  But the problem is before that time period.  By then the
paths are already set.

> >Bob Proulx wrote:
> >>   git --version  # from today's git clone build
> >>   git version 2.11.0.485.g4e59582
> >
> > This shouldn't be happening with git v2.11. Are you sure that the "git
> > daemon" invocation is running that same version? I notice you set up a
> > restricted PATH. Is it possible that /usr/local/bin or /usr/bin has an
> > older version of git?

I have been starting it with PATH set to my directory.  But given this
question I start it with a full path.

  PATH=~/src/git-stuff/git:$PATH ~/src/git-stuff/git/git-daemon --export-all --base-path=/srv/git --verbose

But then I worry about the package installed binary still getting
invoked with the fork somehow.  Therefore I disable it.  There should
be no possibility of it invoking the packaged daemon.  I moved it out
of the way.

  mv /usr/lib/git-core/git-daemon /usr/lib/git-core/git-daemon.disabled

I can't trivially remove the packaged version because other things
depend upon it.  I could get more agressive about disabling it in a
non-destructive and reversible way though.

> One easy way to verify is clone or fetch again with GIT_TRACE_PACKET=1
> since we send the server's version as a capability since 1.8.0

And here is the interesting part.  If I read this right the client is
reporting 1.9.1 from the server!  But how?  

  $ GIT_TRACE_PACKET=1 git clone --depth 1 git://git0.savannah.gnu.org/test-project.git
  Cloning into 'test-project'...
  17:20:40.482970 pkt-line.c:46           packet:        clone> git-upload-pack /test-project.git\0host=git0.savannah.gnu.org\0
  17:20:40.590177 pkt-line.c:46           packet:        clone< 34e7202270c381f4e5734180dc19426ce69f2e1e HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag multi_ack_detailed symref=HEAD:refs/heads/master agent=git/1.9.1
  17:20:40.662623 pkt-line.c:46           packet:        clone< 34e7202270c381f4e5734180dc19426ce69f2e1e refs/heads/master
  17:20:40.662653 pkt-line.c:46           packet:        clone< 0000
  17:20:40.663682 pkt-line.c:46           packet:        clone> want 34e7202270c381f4e5734180dc19426ce69f2e1e multi_ack_detailed side-band-64k thin-pack include-tag ofs-delta agent=git/2.1.4
  17:20:40.663701 pkt-line.c:46           packet:        clone> want 34e7202270c381f4e5734180dc19426ce69f2e1e
  17:20:40.663713 pkt-line.c:46           packet:        clone> deepen 1
  17:20:40.663724 pkt-line.c:46           packet:        clone> 0000
  17:20:40.739502 pkt-line.c:46           packet:        clone< shallow 34e7202270c381f4e5734180dc19426ce69f2e1e
  17:20:40.854338 pkt-line.c:46           packet:        clone< 0000
  17:20:40.854360 pkt-line.c:46           packet:        clone> done
  17:20:40.929349 pkt-line.c:46           packet:        clone< NAK
  fatal: The remote end hung up unexpectedly
  fatal: early EOF
  fatal: index-pack failed

I am assuming that the "agent=git/1.9.1" is the evidence that it isn't
running the code that I am trying to make it run?  Of course the
packaged installed git version is 1.9.1 (from Trisquel 7, an Ubuntu
14.04 fork) so that matches.  My client is "agent=git/2.1.4" (from
Debian Jessie) so that matches my client end.

Therefore it looks like it is invoking some other command by a hard
coded path and avoiding PATH to my development bits.  It must be
invoking some other binary.  I will get more agressive about disabling
the packaged version and hopefully find out which one.

Thank you very much for the good hints here.  They are very helpful.

Bob
