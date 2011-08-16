From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Tue, 16 Aug 2011 15:22:12 -0700
Message-ID: <20110816222212.GA19471@sigill.intra.peff.net>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
 <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 00:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtS1d-0000fz-Mg
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 00:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1HPWWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 18:22:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46704
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581Ab1HPWWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 18:22:16 -0400
Received: (qmail 6705 invoked by uid 107); 16 Aug 2011 22:22:55 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 18:22:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 15:22:12 -0700
Content-Disposition: inline
In-Reply-To: <7vbovpggva.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179480>

On Tue, Aug 16, 2011 at 02:56:41PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   # add some content with an error
> >   echo 'printf("hello word!\n")' >hello.c
> >   git add hello.c
> >
> >   # work on it more, realizing the error
> >   echo 'printf("goodbye world!\n") >hello.c
> >
> >   # now what? you want to stage the s/word/world/ fixup,
> >   # but you want to keep the hello/goodbye thing as a separate change.
> >   # Using anything line-based is going to conflate the two.
> >   # The change is simple, though, so you can just as easily edit the
> >   # index file, if only you could get to it. So you do:
> >   git update-index --swap hello.c
> >   sed -i s/word/world/ hello.c
> >   git update-index --swap hello.c
> >
> > So the swap really functions as a toggle of "I would like to work on
> > the index version for a minute", and then you toggle back when you're
> > done.
> 
> And you have to redo what you did to the index version in the working tree
> after the second "swap", no?

No. The point is that I _already_ did it in the working tree version
while doing my s/hello/goodbye/ change (let's call this the "new
change"). And ideally I would just use "git add -p" to stage only the
s/word/world/ change (let's call this the "fixup"). But they're tangled
in a single hunk, and I need some way of splitting them.

You could also use "add -e" to solve this situation. In this case, you
end up removing the "new change" from the patch, leaving only the fixup.
In this toy case, it would be pretty easy. But in more complex cases,
the fixup is a one-liner, but the "new change" is many lines. So rather
than edit out the new changes, it is simpler to recreate the fixup on
top of the index version.

-Peff
