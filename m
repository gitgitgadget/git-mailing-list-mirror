From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source
 tree
Date: Thu, 2 Jun 2016 21:07:17 -0400
Message-ID: <20160603010717.GA16311@sigill.intra.peff.net>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
 <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
 <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
 <20160602213920.GA13356@sigill.intra.peff.net>
 <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
 <20160602231619.GA11277@sigill.intra.peff.net>
 <CAGZ79kY1ygqd4VmwMj4AGTxo2bO6HFKoShzv6S2MxFq6QNjM1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 03:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8daA-0007Ox-5J
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 03:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbcFCBHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 21:07:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:48166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750884AbcFCBHU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 21:07:20 -0400
Received: (qmail 14299 invoked by uid 102); 3 Jun 2016 01:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 21:07:20 -0400
Received: (qmail 16045 invoked by uid 107); 3 Jun 2016 01:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 21:07:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 21:07:17 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kY1ygqd4VmwMj4AGTxo2bO6HFKoShzv6S2MxFq6QNjM1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296264>

On Thu, Jun 02, 2016 at 04:23:00PM -0700, Stefan Beller wrote:

> > To prevent this in the future, I switched my default --root= to point to
> > a symlink. I wonder if we could do something in the test suite, though,
> > as we did long ago by introducing "trash directory" with a space to
> > catch corner cases.
> >
> > I guess it would be something like:
> >
> >   if test_have_prereq SYMLINKS
> 
> IIUC this would need each test to be marked with SYMLINKS
> when testing with symlinks is desired. Marking a test with that
> is easily forgotten, so I'd rather do it by default as:
> 
> if (system supports symlinks):
> >   then
> >         mkdir "$TRASH_DIRECTORY.real" &&
> >         ln -s "$TRASH_DIRECTORY.real" "$TRASH_DIRECTORY"
> >   else
> >         mkdir "$TRASH_DIRECTORY"
> >   fi

I'm not sure I understand. My intent was to say "does the system support
symlinks" in test-lib.sh when setting up the trash directory. The
test_have_prereq function asks that, AFAIK (the "test_" prefix is not
"does _this_ test require it" but just "this function is in the test
namespace").

> I like the idea of testing with symlinks. (Does it have performance issues
> when everything goes through symlinks?)

I didn't notice any on my system (running with --root pointed at a
directory, and at a symlink to that directory). It would be extra work
whenever we determine a canonical absolute path, but I suspect that is
drowned out in the noise of the rest of the test suite. Plus some minor
extra work in the `ln` and `rm` calls during test setup/teardown, but
likewise that should be a small part of the total cost.

> On the other hand if we do tests by default in a symlinked path, we could
> introduce errors more easily in non-symlinked path, but that is what developers
> use for developing (I guess), so it's not as likely?

True, but I'd be surprised if there are bugs that show up in a
non-symlinked path that _do_ show up in a symlinked one.

I'm not sure if we've seen a case where this would find an actual bug in
git, though. The cases I remember were mostly about the test suite being
picky (i.e., git canonicalizes but the expected output doesn't, or vice
versa).

-Peff
