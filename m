From: Jeff King <peff@peff.net>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 12:05:10 -0400
Message-ID: <20090911160510.GA10848@coredump.intra.peff.net>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
 <20090911102329.GA13044@sigill.intra.peff.net>
 <20090911135110.GA30860@coredump.intra.peff.net>
 <9e0f31700909110846h54959ae6u466ceda40799ba37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aloisio <aloisiojr@gmail.com>, git@vger.kernel.org,
	support@gitorious.org
To: Johan =?utf-8?B?U8O4cmVuc2Vu?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:05:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm8d6-0005ZR-08
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 18:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbZIKQFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 12:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbZIKQFM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 12:05:12 -0400
Received: from peff.net ([208.65.91.99]:49051 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbZIKQFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 12:05:11 -0400
Received: (qmail 7951 invoked by uid 107); 11 Sep 2009 16:05:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 12:05:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 12:05:10 -0400
Content-Disposition: inline
In-Reply-To: <9e0f31700909110846h54959ae6u466ceda40799ba37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128203>

On Fri, Sep 11, 2009 at 05:46:23PM +0200, Johan S=C3=B8rensen wrote:

> Some quick tests seem to indicate it's related to the fact that our
> wonderful little fork+exec git-daemon[1] (which is different from the
> one distributed with git) exec's to "git-upload-pack --strict
> --timeout=3D30 /path/to/repo". Now, why exactly that'll trigger when =
the
> no-progress flag is given I'm not sure of. The daemon itself execs as
> soon as it figures out what repo the client requested, so apart from
> the timeout the only thing it reacts to is the header (the
> "${headersize}git-upload-pack project/repo.git\0host=3Dgitorious.org\=
0"
> part).
>=20
> We also do redirect stderr to /dev/null for reasons I cannot remember
> (so probably not good ones), that may be related as well. Well run
> some more tests...

Ah. I have a theory. If I do a clone of git://gitorious.org/qt/qt.git,
the counting/compressing stages take a long time (I timed it at 1m40
before it actually sends any data). And looking at upload-pack.c, we
leave the 30-second alarm set while creating the pack. Meaning we die 3=
0
seconds into creating the pack.

When progress is being displayed, however, the progress timer actually
uses SIGALRM, as well. So we are constantly resetting the timer and it
never goes off.

And we should be able to test this theory. How long does it take for th=
e
failure case to fail:

  $ time git clone -n git://gitorious.org/qt/qt.git repo >log
  fatal: The remote end hung up unexpectedly
  fatal: early EOF
  fatal: index-pack failed

  real    0m31.106s
  user    0m0.000s
  sys     0m0.012s

Hmm. Suspicious. :)

So that implies to me a few things:

  1. You guys should really pack your repos, as you are wasting over a
     minute of CPU time every time somebody clones this repo.

  2. Upload-pack has what I consider a bug. The --timeout should be
     suspended while we are actually crunching numbers to create the
     pack. We probably don't want it when sending the pack, either, as
     people with slow connections (or big repos) will get timed out
     during the send. Probably we just want to apply it to times when w=
e
     are waiting to get the list of refs from the client.

  3. Upload-pack and the progress code are both using the global alarm
     timer and signal, and that is papering over the bug in (2) when
     progress is enabled. I'm not sure of the simplest way of having
     those interact. But maybe we can just ignore it, because we
     probably don't want to using the --timeout alarm during the packin=
g
     phase, anyway.

-Peff
