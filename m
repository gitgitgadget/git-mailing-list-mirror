From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Instruct git-completion.bash that we are in test mode
Date: Mon, 21 Jan 2013 19:39:55 -0500
Message-ID: <20130122003954.GA23297@sigill.intra.peff.net>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:40:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxRuU-0001xi-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 01:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab3AVAj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 19:39:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41899 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab3AVAj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 19:39:57 -0500
Received: (qmail 21381 invoked by uid 107); 22 Jan 2013 00:41:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jan 2013 19:41:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2013 19:39:55 -0500
Content-Disposition: inline
In-Reply-To: <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214181>

On Mon, Jan 21, 2013 at 03:32:29PM -0800, Junio C Hamano wrote:

> "Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:
>=20
> > At least, "it works for me".
>=20
> I suspect that your approach will still not fix the case in which
> you build a branch with a new command git-check-ignore, and then
> check out another branch that does not yet have that command without
> first running "make clean".
>=20
> Does the following really pass with your patch?
>=20
> 	git checkout origin/next
>         make
>         git checkout origin/maint
> 	git apply your_patch.mbox
>         make
>         cd t && sh ./t9902-completion.sh

I really hate to suggest this, but should it be more like:

  if test -z "$FAKE_COMMAND_LIST"; then
          __git_cmdlist() {
                  git help -a | egrep '^  [a-zA-Z0-9]'
          }
  else
          __git_cmdlist() {
                  printf '%s' "$FAKE_COMMAND_LIST"
          }
  fi

That gives us a nice predictable starting point for actually testing th=
e
completion code. The downside is that it  doesn't let us test that we
remain compatible with the output of "help -a". But we could potentiall=
y
add a single, more liberal test (without $FAKE_COMMAND_LIST, but ready
to expect extra output) that checks that.

> > +	__git_cmdlist () { git help -a| egrep -m 1 -B1000 PATH | egrep '^=
  [a-zA-Z0-9]'; }
>=20
> 'egrep' is not even in POSIX in the first place but grep -E ought to
> be a replacement for it, so I'll let it pass, but "-m1 -B1000"?
> Please stay within portable options.

If I recall correctly, egrep is actually more portable than "grep -E"
(and it is already in use, so I think we are OK). I agree on the rest,
though. :)

-Peff
