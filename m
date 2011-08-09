From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Tue, 9 Aug 2011 14:05:04 -0600
Message-ID: <20110809200504.GA31944@sigill.intra.peff.net>
References: <4E37202B.80208@lsrfire.ath.cx>
 <20110802040004.GC17494@sigill.intra.peff.net>
 <4E3829DC.8070802@lsrfire.ath.cx>
 <20110802181357.GA1861@sigill.intra.peff.net>
 <4E388A55.6080606@kdbg.org>
 <4E3D0C1D.9000807@lsrfire.ath.cx>
 <4E3EEF3B.80908@kdbg.org>
 <4E401869.8060702@lsrfire.ath.cx>
 <20110809050211.GA3588@sigill.intra.peff.net>
 <4E410B26.1080407@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 09 22:05:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqsYB-0004uk-QT
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 22:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1HIUFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 16:05:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59911
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582Ab1HIUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 16:05:10 -0400
Received: (qmail 8855 invoked by uid 107); 9 Aug 2011 20:05:46 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Aug 2011 16:05:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2011 14:05:04 -0600
Content-Disposition: inline
In-Reply-To: <4E410B26.1080407@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179046>

On Tue, Aug 09, 2011 at 12:25:42PM +0200, Ren=C3=A9 Scharfe wrote:

> > BTW, as nice as this "gzip -cn | cat" idea is, I think it needs to =
be
> > wrapped in a shell script. With the code above, we will generate "g=
zip
> > -cn | cat -9".
>=20
> Yes, the three added lines in the patch above would have to be moved
> down two lines, after the compression level is added.  D'oh!

Also, is adding "| cat" also sufficient for arbitrary shell code (i.e.,
whatever the user hands us via the config)? I couldn't think of an
example that wouldn't work.

> OK, that's one way to do it; another would be let gzip (and bzip2 etc=
=2E)
> do whatever cat does to avoid end of line conversions.  And yet anoth=
er
> is to take them from http://unxutils.sourceforge.net/.

Yeah, I like all of those solutions better than hacking an extra pipe
into git. I don't know enough to say how painful they are in practice,
though.

> > BTW, from what Johannes said, the issue is about a non-msys program
> > calling an msys one. Does that mean that having git run:
> >=20
> >   sh -c 'gzip -cn'
> >=20
> > would work? If so, then could the solution be as simple as turning =
off
> > the "don't bother with the shell" optimization that run-command use=
s?
> > Something like "gzip -cn" gets split by git and run via spawn now
> > (because it has no metacharacters). But we could easily make it alw=
ays
> > run through the shell.
>=20
> Just checked -- it doesn't work.  I assume that's because the shell i=
s
> also an MSYS program.

Too bad. I guess the first msys program to be run sets the mode of the
output descriptor, and then everybody else inherits that. If there were
a helper or shell builtin to switch to binary mode, we could put it at
the start of the shell pipeline.

If you write a C program that does:

  setmode(1, O_BINARY);

and call it like:

  ./setmode-helper; gzip -cn

does that work? I suspect not, as from my brief reading of the msys gzi=
p
source, it actually calls setmode() itself.

-Peff
