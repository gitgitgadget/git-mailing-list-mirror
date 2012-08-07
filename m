From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 20:23:18 -0400
Message-ID: <20120807002318.GA17498@sigill.intra.peff.net>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
 <20120806193958.GA10039@sigill.intra.peff.net>
 <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
 <20120806213404.GA14320@sigill.intra.peff.net>
 <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
 <20120806223113.GA16298@sigill.intra.peff.net>
 <m2pq73zkmu.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Tay Ray Chuan <rctay89@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 02:24:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyXad-0000cL-3w
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 02:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab2HGAXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 20:23:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53912 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756486Ab2HGAXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 20:23:21 -0400
Received: (qmail 21725 invoked by uid 107); 7 Aug 2012 00:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 20:23:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 20:23:18 -0400
Content-Disposition: inline
In-Reply-To: <m2pq73zkmu.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203001>

On Tue, Aug 07, 2012 at 01:05:45AM +0200, Andreas Schwab wrote:

> > The stdio behavior on Solaris is weird. If I run this sample progra=
m:
> >
> >   #include <stdio.h>
> >   int main(void)
> >   {
> >     FILE *fh =3D fopen("/dev/tty", "w+");
> >     char buf[32] =3D {0};
> >     fgets(buf, sizeof(buf), fh);
> >     fprintf(fh, "got %s\n", buf);
> >     return 0;
> >   }
> >
> > on Linux, I get:
> >
> >   $ ./a.out
> >   foo        <-- me typing
> >   got foo    <-- program output
> >
> > On Solaris, I get:
> >
> >   $ ./a.out
> >   foo        <-- me typing
> >   foo        <-- ???
> >   got foo    <-- program output
>=20
> That's not a bug, you need to flush or seek when you want to switch
> between read to write.

Thanks. Inserting an fflush() before the fprintf does fix it, but I
think that a flush is disallowed by the standard in this case. From C99=
,
7.19.5.2 (fflush):

  If stream points to an output stream or an update stream in which the
  most recent operation was not input, the fflush function causes any
  unwritten data for that stream to be delivered to the host environmen=
t
  to be written to the =EF=AC=81le; otherwise, the behavior is unde=EF=AC=
=81ned.

And later, from 7.19.5.3 (fopen):

  When a file is opened with update mode ('+' as the second or third
  character in the above list of mode argument values), both input and
  output may be performed on the associated stream. However, output
  shall not be directly followed by input without an intervening call t=
o
  the fflush function or to a file positioning function (fseek, fsetpos=
,
  or rewind), and input shall not be directly followed by output withou=
t
  an intervening call to a file positioning function, unless the input
  operation encounters end-of-file.

I don't know if any implementation actually cares in practice, of
course, but probably the sane thing would be to call
"fseek(fh, SEEK_CUR, 0)" before the fprintf.

This is all moot if we end up ripping stdio out of this code for other
reasons, but it does give us another option for a fix.

Thanks for the pointer.

-Peff
