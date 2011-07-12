From: Jeff King <peff@peff.net>
Subject: Re: [RFC] control, what refs are honored by core.logAllRefUpdates
Date: Tue, 12 Jul 2011 14:25:17 -0400
Message-ID: <20110712182517.GA17787@sigill.intra.peff.net>
References: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com>
 <7vaacj8jq7.fsf@alter.siamese.dyndns.org>
 <CAKPyHN0+BaPtrRMVrWCZQ2mbJQz_vxsOOsG4Z=Ksqc1RJvF1Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qghe8-0000UP-NU
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 20:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778Ab1GLSZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 14:25:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44603
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704Ab1GLSZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 14:25:19 -0400
Received: (qmail 14930 invoked by uid 107); 12 Jul 2011 18:25:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 14:25:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 14:25:17 -0400
Content-Disposition: inline
In-Reply-To: <CAKPyHN0+BaPtrRMVrWCZQ2mbJQz_vxsOOsG4Z=Ksqc1RJvF1Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176964>

On Tue, Jul 12, 2011 at 08:15:21PM +0200, Bert Wesarg wrote:

> >> Setting core.autoLogRef to the empty value, will reset the list.
> >
> > It is unclear what it is reset to. =C2=A0Do you mean it clears, e.g=
=2E
> >
> > =C2=A0 =C2=A0[core]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D heads
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D remotes
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D notes
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D heads
> >
> > would first create a list of three elements, clears it and then the=
 final
> > result has only refs/heads/ in the list?
> >
> Exactly. I think the --notes option does have a similar semantics. (I
> added Jeff to the Cc). There is --no-notes, which resets the notes
> list and than subsequent --notes=3D options populate the list again.

Yeah, --notes versus --no-notes is as you say. This topic came up
recently when discussing config for the user-defined archive filters,
too. This is a fairly natural solution, as it lets you say "append to
what's there" versus "replace what's there", which is what you really
want[1].

I think I'd rather see something more syntactically explicit for
resetting, though, like:

  [core]
    autoLogRef =3D heads
    autoLogRef =3D remotes
    autoLogRef =3D notes
    !autoLogRef
    autoLogref =3D heads

(for that matter, I have often wished that "!autoLogRef" was boolean
false, just as "autoLogRef" is boolean true). But it may not be worth
changing the config syntax for.

-Peff

[1] If we were starting from scratch, you could make that distinction
with a new operator, like:

  [core]
    autoLogRef =3D heads
    autoLogRef +=3D remotes
    autoLogRef +=3D notes
    autoLogRef =3D heads

which would be equivalent to what you wrote above. But because it
switches the semantics of "=3D" to "replace" instead of "append" for
multi-value keys, it would break all current config that uses multiple
"fetch" lines (for example).
