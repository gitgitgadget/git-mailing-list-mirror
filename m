From: Jeff King <peff@github.com>
Subject: Re: [PATCH 5/7] archive: refactor format-guessing from filename
Date: Wed, 15 Jun 2011 20:34:00 -0400
Message-ID: <20110616003400.GB20355@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
 <20110615223407.GE16807@sigill.intra.peff.net>
 <7vmxhiirlb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 02:34:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX0XB-0007hc-Uv
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 02:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab1FPAeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 20:34:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50886
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab1FPAeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 20:34:03 -0400
Received: (qmail 8820 invoked by uid 107); 16 Jun 2011 00:34:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 20:34:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 20:34:00 -0400
Content-Disposition: inline
In-Reply-To: <7vmxhiirlb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175876>

On Wed, Jun 15, 2011 at 04:48:32PM -0700, Junio C Hamano wrote:

> > will produce a gzip'd file. If we make the mapping decision
> > locally, then running:
> >
> >   git archive --remote=3Dorigin -o file.tar.gz HEAD
> >
> > will send "--format=3Dtgz" to the remote side. The server will
> > complain, saying that it doesn't know about the tgz format.
>=20
> As long as that complaint is clearly marked as coming from the remote
> side, the user now knows that tgz is not supported, and can fall back=
 to a
> plain tar.

It is. You can simulate with:

  $ git archive --format=3Dfoobar --remote=3D. HEAD
  remote: fatal: Unknown archive format 'foobar'
  remote: git upload-archive: archiver died with error
  fatal: sent error to the client: git upload-archive: archiver died wi=
th error

Or if you want to be really thorough and you have an old git lying
around, you can see the format auto-selection triggers the same code:

  $ git archive -o foo.tar.gz --remote=3D. --exec=3D'git.v1.7.5 upload-=
archive' HEAD
  remote: fatal: Unknown archive format 'tgz'
  fatal: sent error to the client: git upload-archive: archiver died wi=
th error
  remote: git upload-archive: archiver died with error

> Am I being na=C3=AFve thinking that barfing (and assuming that the us=
er
> understands why the remote end barfed) actually is a good thing?

No, I think barfing is totally fine there. I worry more about the cases
where we silently produce a format the user was not expecting (the way
mine is coded, it is "the server knows about .tar.gz, but the client
does not; I expect gzip, but I get regular tar").

-Peff
