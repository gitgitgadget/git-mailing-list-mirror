From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Tue, 26 Mar 2013 12:55:53 -0400
Message-ID: <20130326165553.GA7282@sigill.intra.peff.net>
References: <20130324183133.GA11200@sigill.intra.peff.net>
 <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
 <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 17:57:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKXAq-0007DS-Q6
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 17:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab3CZQz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 12:55:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40386 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab3CZQz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 12:55:58 -0400
Received: (qmail 4874 invoked by uid 107); 26 Mar 2013 16:57:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 12:57:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 12:55:53 -0400
Content-Disposition: inline
In-Reply-To: <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219169>

On Tue, Mar 26, 2013 at 09:43:01AM -0400, Jeff Mitchell wrote:

> On Mon, Mar 25, 2013 at 4:07 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Mar 25, 2013 at 12:32:50PM -0400, Jeff Mitchell wrote:
> >> For commit corruptions, the --no-hardlinks, non --mirror case refused
> >> to create the new repository and exited with an error code of 128. The
> >> --no-hardlinks, --mirror case spewed errors to the console, yet
> >> *still* created the new clone *and* returned an error code of zero.
> >
> > I wasn't able to reproduce this; can you post a succint test case?
>
> [...link to tar.gz...]
> Once you extract that, you should be able to run a clone using paths
> (not file://) with --no-hardlinks --mirror and replicate the behavior
> I saw. FYI, I'm on Git 1.8.2.

Thanks for providing an example.

The difference is the same "--mirror implies --bare" issue; the non-bare
case dies during the checkout (even before my patches, as the corruption
is not in a blob, but rather in the HEAD commit object itself). You can
replace --mirror with --bare and see the same behavior.

The troubling part is that we see errors in the bare case, but do not
die. Those errors all come from upload-pack, the "sending" side of a
clone/fetch. Even though we do not transfer the objects via the git
protocol, we still invoke upload-pack to get the ref list (and then copy
the objects themselves out-of-band).

What happens is that upload-pack sees the errors while trying to see if
the object is a tag that can be peeled (the server advertises both tags
and the objects they point to). It does not distinguish between "errors
did not let me peel this object" and "this object is not a tag, and
therefore there is nothing to peel".

We could change that, but I'm not sure whether it is a good idea. I
think the intent is that upload-pack's ref advertisement would remain
resilient to corruption in the repository (e.g., even if that commit is
corrupt, you can still fetch the rest of the data). We should not worry
about advertising broken objects, because we will encounter the same
error when we actually do try to send the objects. Dying at the
advertisement phase would be premature, since we do not yet know what
the client will request.

The problem, of course, is that the --local optimization _skips_ the
part where we actually ask upload-pack for data, and instead blindly
copies it. So this is the same issue as usual, which is that the local
transport is not thorough enough to catch corruption. It seems like a
failing in this case, because upload-pack does notice the problem, but
that is only luck; if the corruption were in a non-tip object, it would
not notice it at all. So trying to die on errors in the ref
advertisement would just be a band-aid. Fundamentally the problem is
that the --local transport is not safe from propagating corruption, and
should not be used if that's a requirement.

-Peff
