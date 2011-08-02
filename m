From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 1 Aug 2011 22:00:04 -0600
Message-ID: <20110802040004.GC17494@sigill.intra.peff.net>
References: <20110728160845.GA14337@sigill.intra.peff.net>
 <20110728164758.GA15931@sigill.intra.peff.net>
 <20110728170222.GB15931@sigill.intra.peff.net>
 <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com>
 <20110801174603.GB10302@sigill.intra.peff.net>
 <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com>
 <20110801182516.GC10302@sigill.intra.peff.net>
 <4E371109.7050500@lsrfire.ath.cx>
 <4E3718B4.6090803@kdbg.org>
 <4E37202B.80208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 02 06:00:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo69O-0007rW-1L
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 06:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759Ab1HBEAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 00:00:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44643
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722Ab1HBEAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 00:00:07 -0400
Received: (qmail 25793 invoked by uid 107); 2 Aug 2011 04:00:40 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Aug 2011 00:00:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 22:00:04 -0600
Content-Disposition: inline
In-Reply-To: <4E37202B.80208@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178438>

On Mon, Aug 01, 2011 at 11:52:43PM +0200, Ren=C3=A9 Scharfe wrote:

> Am 01.08.2011 23:20, schrieb Johannes Sixt:
> > Am 01.08.2011 22:48, schrieb Ren=C3=A9 Scharfe:
> >> So git archive gives the right results when writing to a pipe, but
> >> always the same wrong result when writing directly to a file.
> >=20
> > This could indeed be a CRLF issue. archive-tar.c runs gzip to let i=
t
> > write to the original fd 1 (stdout). gzip is an MSYS program, and M=
SYS
> > is "clever" and sets up the channel in text mode (CRLF conversion) =
if it
> > is a regular file, but in binary mode if it is a pipe.
> >=20
> > Without the gzip filter, git-archive writes to stdout itself. Since=
 we
> > have set up all our channels in binary mode, we do not suffer from =
the
> > same problem for plain tar format.
> >=20
> > So, I don't think we can do a lot about it, short of patching MSYS =
again...
>=20
> Or we could pipe the output through us, i.e. attach a builtin version=
 of
> cat at the output end of the called command.  Only on Windows, of
> course.  Better ugly and limping then wrong, right?

Yeah, that would work. But I am confused. If what Johannes says is true=
,
isn't MSYS gzip totally broken for:

  # works
  echo foo | gzip -c | cat >foo.gz

  # broken; introduces CR
  echo foo | gzip -c >foo.gz

? (The "works" and "broken" there are my guesses; I don't have a Window=
s
box to test on). IOW, is it simply gzip that is broken, and any fix we
do is simply working around a bug in gzip? And therefore the right
solution is for MSYS people to fix gzip?

-Peff
