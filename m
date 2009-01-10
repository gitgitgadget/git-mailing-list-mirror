From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 12:25:06 +0100
Message-ID: <200901101225.10719.trast@student.ethz.ch>
References: <87wsd48wam.fsf@iki.fi> <1231549039-5236-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901101146230.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1491055.UYLxHlXcN7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 12:26:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLbyu-00088v-JP
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbZAJLY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbZAJLYz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:24:55 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52393 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbZAJLYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:24:55 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 10 Jan 2009 12:24:53 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 10 Jan 2009 12:24:53 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901101146230.30769@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 10 Jan 2009 11:24:53.0513 (UTC) FILETIME=[0F037790:01C97316]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105092>

--nextPart1491055.UYLxHlXcN7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> BTW I did not really think about the issue you raised about the newlines,=
=20
> as I seemed to remember that the idea was to substitute all non-word=20
> characters with newlines, so that the offsets in the substituted text are=
=20
> the same as in the original text.

Ok, so here's a very simple example: Suppose you have the word regex
'x+|y+' and compare these two lines:

A: xxyyxy
B: xyxyy

There are *no* non-word characters between consecutive words in this
case, so you *cannot* replace them with newlines.  You cannot replace
some word character either, as should be obvious from the case of
one-letter words, as you would lose actual content.  My counterexample
to your illustration patch exploited a similar border case: suppose
you decide to overwrite the first (instead of last) character of each
word, then you won't be able to tell "foo" from "\noo" in the input.

Unfortunately the space adjustement makes things even worse.  The
existing method has the side-effect that it only inserts a single
newline between words separated by exactly one space, which runs them
together in the resulting line diff, for example

A: foo bar
B: baz quux

would result in

  -foo
  -bar
  +baz
  +quux

instead of (as my original attempts did) the arguably more correct,
but less readable

  -foo
  +bar
   =20
  -baz
  +quux

where the middle line is a context line for the space.  So in addition
to the word-ending adjustments for the inserted newlines, I also have
to track the status of the space right after the word.

> So I still find your patch way too large

I can't think of a simpler way to do it, and yours unfortunately
doesn't work.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart1491055.UYLxHlXcN7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklohZYACgkQqUud07tmzP17oACdE+qdWolMcTZcVRGs4S85Fh0d
aq4AmwWBwcJhPBlpWzJDbeSZnlnnvX5t
=2Ooe
-----END PGP SIGNATURE-----

--nextPart1491055.UYLxHlXcN7--
