From: Jeff King <peff@peff.net>
Subject: Re: Branches & directories
Date: Mon, 3 Oct 2011 03:30:59 -0400
Message-ID: <20111003073059.GA9455@sigill.intra.peff.net>
References: <CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
 <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
 <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
 <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
 <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
 <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
 <4E889813.8070205@gmail.com>
 <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
 <20111003030723.GA24523@sigill.intra.peff.net>
 <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAczf-0007sJ-NP
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab1JCHbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:31:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51433
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab1JCHbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:31:02 -0400
Received: (qmail 24403 invoked by uid 107); 3 Oct 2011 07:36:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 03:36:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 03:30:59 -0400
Content-Disposition: inline
In-Reply-To: <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182630>

On Mon, Oct 03, 2011 at 12:15:33AM -0700, Hilco Wijbenga wrote:

> On 2 October 2011 20:07, Jeff King <peff@peff.net> wrote:
> <snip/>
> > Or did you really mean your example literally, as in you run two
> > checkouts back to back, without running anything in between, and the
> > second checkout restores the state before the first one. In that case,
> > yes, it would be correct to keep the old timestamps. But this is an
> > optimization that can only apply in a few very specific cases. And
> > moreoever, how can git know when it is OK to apply that optimization? It
> > has no idea what commands you might have run since the last time we were
> > at "master".
> 
> Yes, I meant it literally. And, no, Git could not possibly know so it
> would have to be optional behaviour. But it's probably a lot of work
> for (for most people) little gain.

If you really want the human to trigger it, then you can do something
like this:

  cat >git-checkout-timestamp <<\EOF
  #!/bin/sh

  old=`git rev-parse HEAD`
  git checkout "$@" || exit 1
  time=`git log -1 --format=%at`
  git diff-tree --name-only -z "$old" HEAD |
    perl -0ne "utime($time, $time, \$_)";
  EOF

Drop that somewhere in your $PATH, and use it instead of regular
checkout. It restores the timestamps on any changed files, but not on
those that were not touched. So your:

  git checkout branch
  git checkout master

example would end up with timestamps set for "master" on the changed
files. Two caveats:

  1. This can still break makefiles! For example, like this:

       make foo.o ;# now foo.o is recent
       vi foo.c   ;# but foo.c is _more_ recent
       git checkout branch ;# now it's even newer
       git checkout-timestamp master ;# now we've restored it to some
                                     ;# old timestamp, and make will
                                     ;# think it's older than foo.o

  2. In general, I'm not sure it makes any sense if there are local
     worktree modifications to the files in question. But I didn't think
     about it too hard. That ways madness lies.

-Peff
