From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.2.0
Date: Thu, 27 Nov 2014 23:46:56 -0500
Message-ID: <20141128044656.GA19456@peff.net>
References: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com>
 <20141127213224.GA27443@dispater.uplinklabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Fri Nov 28 05:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuDSP-0001ou-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 05:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbaK1Eq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 23:46:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:45808 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbaK1Eq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 23:46:56 -0500
Received: (qmail 19925 invoked by uid 102); 28 Nov 2014 04:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Nov 2014 22:46:56 -0600
Received: (qmail 20317 invoked by uid 107); 28 Nov 2014 04:46:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Nov 2014 23:46:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Nov 2014 23:46:56 -0500
Content-Disposition: inline
In-Reply-To: <20141127213224.GA27443@dispater.uplinklabs.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260356>

[nit: when quoting in your replies, please trim quotes to a reasonable
 length]

On Thu, Nov 27, 2014 at 01:32:24PM -0800, Steven Noonan wrote:

> I'm sad to report that I'm getting test failures with this release.
> Built from git and did 'make -C t prove NO_SVN_TESTS=1' and got this
> result:
> [...]
> I suspect that gnupg v2.1 is to blame somehow (I've had similar bad behavior
> with my own projects using GPG in automation). Running through several of the
> git tests shows that gpg is failing to sign:

I can reproduce here on Debian by installing gnupg2 v2.1 from
experimental (this gets installed as /usr/bin/gpg2, so I had to tweak
the code to use "gpg2" by default). In my case, gpg2 repeatedly contacts
the gpg-agent and pops up X dialogs asking to unlock keyrings in the
test suite. Hitting "cancel" causes the tests to fail. Clicking "OK"
with an empty passphrase lets the test pass.

The good news is that it is similarly broken on git v2.1.0. So this
isn't something we broke; it's the new version of gnupg2.

It's not clear to me whether this is a regression in gnupg, or if
there's some magic configuration setting we need to get the old
behavior. It seems like the new version is more aggressive in trying to
use the agent to get a passphrase, even though the keyrings in the test
are unencrypted, and do not need any passphrase. Which sounds like a bug
to me.

You might have some luck talking with the gnupg folks about this
possible bug. As a simple reproduction, doing:

  cd git/t/lib-gpg
  export GNUPGHOME=$PWD
  echo foo | gpg --sign -a

works fine with gnupg1, or earlier versions of gnupg2. But with gnupg
2.1, it causes the agent to pop up a passphrase dialog.

-Peff
