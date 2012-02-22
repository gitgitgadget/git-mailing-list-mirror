From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Wed, 22 Feb 2012 15:40:50 -0500
Message-ID: <20120222204050.GB6781@sigill.intra.peff.net>
References: <8739bacpql.fsf@thomas.inf.ethz.ch>
 <1327079011-24788-1-git-send-email-spearce@spearce.org>
 <20120222101302.GA11606@sigill.intra.peff.net>
 <CAJo=hJsFDrt4rsxVAnx86bxZDY3yfWc1=GDd8opUU+9z7esLnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:41:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Izj-0007ny-Ih
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab2BVUkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 15:40:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47344
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784Ab2BVUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:40:52 -0500
Received: (qmail 31430 invoked by uid 107); 22 Feb 2012 20:40:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 15:40:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 15:40:50 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJsFDrt4rsxVAnx86bxZDY3yfWc1=GDd8opUU+9z7esLnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191283>

On Wed, Feb 22, 2012 at 07:22:10AM -0800, Shawn O. Pearce wrote:

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* Ignore write errors; there's nothing we can do,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* since we're about to close the pipe anyway. And the
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* most likely error is EPIPE due to the helper dying
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* to report an error itself.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sigchain_push(SIGPIPE, SIG_IGN);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 xwrite(data->helper->in, "\n", 1);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sigchain_pop(SIGPIPE);
> [...]
>=20
> This sounds right to me. Its unfortunate that we missed the error
> status output when we built the remote helper protocol, but your patc=
h
> above might be the best we can do now.
>=20
> Eh, well, actually we could have the helper advertise a new capabilit=
y
> that can be enabled to return exit status. That is a much bigger
> change, and even if we do it for remote-curl (since that is in tree
> and easy to update) we still need your patch for the same race
> condition for out of tree helpers (which Google actually has so I car=
e
> about out of tree helpers too).

I don't think it's worth a new capability. This is one of those "it
would be nice if it were designed that way from day one" cases, but it
wasn't. And while this is a minor hack, I don't think it has any
functional downsides. So adding a new capability on top of the hack jus=
t
makes things more complex.

I'll re-send the patch with a stand-alone commit message.

-Peff
