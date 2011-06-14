From: Jeff King <peff@github.com>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 16:14:33 -0400
Message-ID: <20110614201433.GB1567@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <4DF7B90B.9050802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 14 22:14:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWa0W-0006SF-BQ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 22:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab1FNUOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 16:14:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34543
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094Ab1FNUOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 16:14:35 -0400
Received: (qmail 30576 invoked by uid 107); 14 Jun 2011 20:14:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 16:14:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 16:14:33 -0400
Content-Disposition: inline
In-Reply-To: <4DF7B90B.9050802@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175797>

On Tue, Jun 14, 2011 at 09:39:55PM +0200, Ren=C3=A9 Scharfe wrote:

> > However, when running git-archive against a remote site,
> > having the remote side do the compression can save
> > considerable bandwidth. Service providers could always wrap
> > git-archive to provide that functionality, but this makes it
> > much simpler.
>=20
> That's a good point and one that was overlooked when this topic came =
up
> earlier (see http://kerneltrap.org/mailarchive/git/2009/9/10/11507 an=
d
> http://kerneltrap.org/mailarchive/git/2009/9/11/11577).

Hmph, I should have done my homework better. I totally missed that
thread.

Yeah, I am unsurprised that doing it in a single process is actually
slower. I do think because of the remote issue that we should provide
something like this. But we could implement it by piping to an external
gzip. That would make us just slightly less portable, but would give us
the multi-processor speedup, or even allow using something like pigz.

> > +static void output_gz(const char *buf, unsigned long len)
> > +{
> > +	if (!gzwrite(gz_file, buf, len))
> > +		die("unable to write compressed stream: %s",
> > +		    gzerror(gz_file, NULL));
> > +}
>=20
> Does this do the right things when faced with interrupted writes or
> truncated pipes? I ask because the earlier attempt had a
> gzwrite_or_die() which did that, but I don't know anymore if that is
> strictly needed.

No, I blindly assumed that gzwrite was a little bit smart, but looking
at the zlib code, it really is just propagating whatever it got from
fwrite. I need to handle both errors and short writes myself. So we do
need gzwrite_or_die.

> Oh, and bridging the gap between unsigned long and int
> was certainly another reason for the existence of this function.

Ugh. I correctly saw that it took an unsigned long, but it actually
returns the number of bytes written as an int! Nice interface.

All of this can go away, though, if we switch to an external process.
It's tempting.

-Peff
