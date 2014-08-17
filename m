From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailsplit.c: remove dead code
Date: Sun, 17 Aug 2014 04:14:45 -0400
Message-ID: <20140817081444.GI23808@peff.net>
References: <1407791481-17410-1-git-send-email-stefanbeller@gmail.com>
 <53EA430E.8050905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 10:15:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIvcC-00036h-SP
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 10:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbaHQIOs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2014 04:14:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:53580 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751128AbaHQIOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 04:14:46 -0400
Received: (qmail 9607 invoked by uid 102); 17 Aug 2014 08:14:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 03:14:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 04:14:45 -0400
Content-Disposition: inline
In-Reply-To: <53EA430E.8050905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255358>

On Tue, Aug 12, 2014 at 06:38:38PM +0200, Ren=C3=A9 Scharfe wrote:

> Am 11.08.2014 um 23:11 schrieb Stefan Beller:
> >This was found by coverity. (Id: 290001)
> >
> >the variable 'output' is only assigned to a value inequal to NUL,
> >after all gotos to the corrupt label.
> >Therefore we can conclude the two removed lines are actually dead co=
de.
>=20
> After reading the above for the first time I thought it meant the opp=
osite
> of what's actually going on.  Perhaps it's the placement of "only", t=
he
> comma or a flawed understanding of grammar on my part?
>=20
> In any case, there is only one way to reach the label named corrupt, =
and the
> variable named output is always NULL if that branch is taken.  That m=
eans
> the removed code was a no-op.  With those two lines gone you also don=
't need
> to initialize output anymore, by the way.
>=20
> And since there is only a single goto, you could move the three remai=
ning
> error handling lines up to the if statement.  Keeping condition and
> dependent code together would be an improvement, I think.

I think that would be a correct refactoring of the current code, but I
have to wonder why the other die cases are not using "goto corrupt" in
the first place.

The other thing this code path does is unlink the file "name". In the
current code, this is _also_ a noop. We "goto corrupt" before we
actually open the output file. So like the fclose(output), it is
cleaning up an operation that was never started. It can just go away.

But the bigger question is: should the other code paths be cleaning up
the file?  It probably doesn't matter, as mailsplit is typically run in
a temporary directory in the first place, so it is up to the caller to
clean up any half-formed cruft. And if we did want to clean up cruft, w=
e
should probably do it with an atexit/signal handler to catch more cases=
=2E

Given that we are not cleaning up now and nobody has complained, I'd be
inclined to say we should not. And the unlink can just go away, and all
errors can just call die().

-Peff
