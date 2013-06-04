From: Jeff King <peff@peff.net>
Subject: Re: *** glibc detected *** git: double free or corruption (fasttop):
 0x0000000001fab820 ***
Date: Tue, 4 Jun 2013 12:26:15 -0400
Message-ID: <20130604162614.GC15953@sigill.intra.peff.net>
References: <CAKObCardgmTiuuE_LbzjD2fCmqwMHXbN-6-xZV_uUV=fjcBs3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Gross <jasongross9@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 18:26:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uju42-0006rc-4r
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 18:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab3FDQ0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 12:26:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:42306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab3FDQ0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 12:26:18 -0400
Received: (qmail 26950 invoked by uid 102); 4 Jun 2013 16:27:03 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 11:27:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 12:26:15 -0400
Content-Disposition: inline
In-Reply-To: <CAKObCardgmTiuuE_LbzjD2fCmqwMHXbN-6-xZV_uUV=fjcBs3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226375>

On Tue, Jun 04, 2013 at 11:46:55AM -0400, Jason Gross wrote:

> I get "*** glibc detected *** git: double free or corruption
> (fasttop): 0x0000000001fab820 ***" reliably on the following set of
> commands.  I'm working on a remote machine where I don't have
> administrative privileges, so I can't update from git 1.7.2.5 to a
> newer version.  I figured I'd report it, even though I haven't checked
> to see if it still happens in a newer version of git.

Yes, it's fixed. You can test such things even without administrative
access. For example:

  # get git
  git clone git://git.kernel.org/pub/scm/git/git.git
  cd git

  # set up our test case
  git clone git://github.com/JasonGross/barnowl.git
  (cd barnowl && git checkout git-bug)

  # now make an easy-to-run test we can run on each commit; make sure
  # to use bin-wrappers, as it sets up everything to run git out of the
  # current build, overriding anything in your $PATH
  cat >test <<\EOF
  #!/bin/sh
  make -j16 &&
  cd barnowl &&
  ../bin-wrappers/git shortlog >/dev/null &&
  echo OK
  EOF
  chmod +x test

  # now confirm our old version is broken
  git checkout v1.7.2.5
  ./test

  # and check that a new version works
  git checkout v1.8.3
  ./test

You can even use git-bisect to find out which commit fixed it. We have
to "reverse" our test, though, since bisect is usually about finding
regressions, not fixes.

  # create reverse test
  cat >revtest <<\EOF
  #!/bin/sh
  ./test && exit 1
  exit 0
  EOF
  chmod +x revtest

  # set up our bisect; again, our good/bad are reversed because we are
  # treating the fix as a "bug"
  git bisect start
  git bisect good v1.7.2.5
  git bisect bad v1.8.3

  # and now we can let "bisect run" do all the hard work while we drink
  # an ice-cold beverage
  git bisect run ./revtest

If we did everything right, this should yield the commit with the fix.
And it turns up d8d2eb7 (mailmap: fix use of freed memory, 2010-10-11),
which seems likely (and reading the full commit message, details the
exact case you have).

And then we can use "git tag --contains" to find out which releases have
it:

  $ git tag --contains d8d2eb7 | grep ^v | grep -v -- -rc | head -1
  v1.7.10

So you'd need to go to v1.7.10 to fix it.

-Peff
