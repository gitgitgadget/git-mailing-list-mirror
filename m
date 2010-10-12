From: Jeff King <peff@peff.net>
Subject: Re: Push not writing to standard error
Date: Tue, 12 Oct 2010 15:32:04 -0400
Message-ID: <20101012193204.GA8620@sigill.intra.peff.net>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
 <20101012192117.GD16237@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chase Brammer <cbrammer@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 21:31:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5kZm-0000X8-JI
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 21:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757700Ab0JLTbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 15:31:51 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50532 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757628Ab0JLTbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 15:31:49 -0400
Received: (qmail 24428 invoked by uid 111); 12 Oct 2010 19:31:48 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 12 Oct 2010 19:31:48 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Oct 2010 15:32:04 -0400
Content-Disposition: inline
In-Reply-To: <20101012192117.GD16237@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158871>

On Tue, Oct 12, 2010 at 02:21:17PM -0500, Jonathan Nieder wrote:

> Chase Brammer wrote:
>=20
> >                                    saving the standard error from b=
ash
> > to a file during a push doesn't seem to be working. =C2=A0I am only=
 able to
> > get standard output, which doesn't give the progress of the push
> > (counting, delta, compressing, and writing status).
> [...]
> > git push origin master --progress > ~/push_error_output.txt 2>&1
> [...]
> > Idea's on work arounds or upcoming patches to fix this?
>=20
> None from me.  But some hints for a patch:
>=20
>  - As the man page says,
>=20
>    --progress
>=20
> 	Progress status is reported on the standard error stream
> 	by default when it is attached to a terminal, unless -q is
> 	specified. This flag forces progress status even if the
> 	standard error stream is not directed to a terminal.
>=20
>    It looks like this facility is not working.
>=20
>  - Terminals are distinguished from nonterminals with isatty()
>=20
>  - The "Counting objects..." output comes from pack-objects.
>    Running with GIT_TRACE=3D1 reveals that the --progress option is
>    not being passed to pack-objects as it should be.
>=20
>  - Is this a regression?  If so, narrowing the regression window
>    with a few rounds of "git bisect" could be helpful.

It looks like transport_set_verbosity gets called correctly, and then
sets the "progress" flag for the transport. But for the push side, I
don't see any transports actually looking at that flag. I think there
needs to be code in git_transport_push to handle the progress flag, and
it just isn't there.

-Peff
