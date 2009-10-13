From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: quote in help code example
Date: Tue, 13 Oct 2009 22:15:44 +0200
Message-ID: <200910132215.46840.trast@student.ethz.ch>
References: <20091012102926.GA3937@debian.b2j> <20091013140622.GA3927@debian.b2j> <20091013153031.GX23777@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1504809.SdtmqF2jbu";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxnwd-0006OW-3L
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760941AbZJMURc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934039AbZJMURb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:17:31 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:18108 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754385AbZJMURa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:17:30 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 13 Oct
 2009 22:16:43 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 13 Oct
 2009 22:16:39 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091013153031.GX23777@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130202>

--nextPart1504809.SdtmqF2jbu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Miklos Vajna wrote:
> On Tue, Oct 13, 2009 at 10:06:23PM +0800, bill lam <cbill.lam@gmail.com> =
wrote:
> > 2. now the .ft pair fixed but it still displayed incorrect quote.
> >=20
> >  git filter-branch --tree-filter =C2=B4rm filename=C2=B4 HEAD
> >=20
> > it should be 'rm filename' not =C2=B4rm filename=C2=B4
>=20
> I can reproduce that here as well, that's how it is in the official
> manpages as well (see the man branch), so that's not specific to your
> system.

Same here.  The patch below is a band-aid fix that works for me, but
I'd rather have it tested on various docbook/asciidoc combinations if
anyone still runs them.

My findings so far were that asciidoc correctly turns the apostrophe
into an &apos; entity in the .xml output, and xmlto then turns it into
\' instead of just ' in the troff output.  Then, if the terminal
appears to support Unicode (this can be disabled with LC_ALL=3DC or
such) the formatter turns it into a "real" apostrophe that, of course,
is not understood by any ASCII-based tool.

So far so good, and sounded like an easy debugging job, right?  Not
so.  The buzzword-compliance people apparently felt it would be nice
to wrap a bad joke of a language in the bad joke of a language that
XML already is, and thus was XSL invented.  Deep in the horrors of
these XSL files, in my case in

  /usr/share/xml/docbook/stylesheet/nwalsh/1.75.2/manpages/other.xsl

there's a template that, according to the comment near it, maltreats
our apostrophes:

  * The backslash, dot, dash, and apostrophe (\, ., -, ') characters
  * have special meaning for roff, so before we do any other
  * processing, we must escape those characters where they appear in
  * the source content.

The patch below just replaces said template with a no-op for git's
manpage creation.  I have not been able to substantiate the claim that
apostrophes are special, and in fact with the patch my manpages look
fine.  Then again I don't know anything about roff syntax either, and
manuals seem a bit hard to come by.

Grrr.

diff --git i/Documentation/manpage-base.xsl w/Documentation/manpage-base.xsl
index a264fa6..7c14469 100644
=2D-- i/Documentation/manpage-base.xsl
+++ w/Documentation/manpage-base.xsl
@@ -7,6 +7,11 @@
 <xsl:param name=3D"man.output.quietly" select=3D"1"/>
 <xsl:param name=3D"refentry.meta.get.quietly" select=3D"1"/>
=20
+<xsl:template name=3D"escape.apostrophe">
+  <xsl:param name=3D"content"/>
+  <xsl:value-of select=3D"$content"/>
+</xsl:template>
+
 <!-- convert asciidoc callouts to man page format;
      git.docbook.backslash and git.docbook.dot params
      must be supplied by another XSL file or other means -->

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1504809.SdtmqF2jbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkrU3/IACgkQqUud07tmzP3fXgCeLspYxW4EXw5pcaFbgJGfeif/
R3IAnAxjhEC7Xnuq9VvPJu9oH3Eqz8af
=+Pko
-----END PGP SIGNATURE-----

--nextPart1504809.SdtmqF2jbu--
