From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history simplification with paths
Date: Sun, 10 Aug 2008 23:31:51 +0200
Message-ID: <200808102331.55385.trast@student.ethz.ch>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch> <7vabfk3cge.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3075356.E9tA7Nbpgx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 23:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSIWz-0007gj-Ro
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 23:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYHJVbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 17:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753684AbYHJVbs
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 17:31:48 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:40711 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbYHJVbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 17:31:47 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 23:31:46 +0200
Received: from [192.168.0.4] ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 23:31:45 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vabfk3cge.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 10 Aug 2008 21:31:46.0012 (UTC) FILETIME=[7D5A21C0:01C8FB30]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91888>

--nextPart3075356.E9tA7Nbpgx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> >   $ g rev-list --pretty=3Doneline --full-history HEAD -- dir
> > ...
> > But --parents --full-history magically revives the merge:
> > ...
>=20
> Personally I do not think --full-history without --parents is of much
> usefulness (I'd let Linus or somebody else defend this usage, or make it
> imply revs.rewrite_parents otherwise).

Well,

  --parents::
          Print the parents of the commit.

does not mention any change in behaviour.  I find it very surprising
that a simple commit formatting option changes the way commits are
_selected_.

> One thing I forgot to mention (but the code of course does not forget to
> do) in the series is that --simplify-merges implies revs.rewrite_parents
> which roughly translates to your experiments from the command line to
> always have --parents option.

Then it makes sense of course.

> >   $ git rev-list --pretty=3Doneline --sparse --parents --simplify-merge=
s HEAD -- dir
[...]
> I am not sure what one should expect from combination between these two
> options.  --sparse says do not drop commits that are of no interest with
> respect to the paths specified, while --simplify-merges tells it to
> simplify merges so that the remaining graph shows only the ones that have
> relevance to !TREESAME (iow "has some changes") nodes.

It makes sense assuming a one-pass (plus simplify-merges) model.  It
did not fit into my two-pass model that I tried to come up with for an
easier explanation.

So in my current (ahem, new) understanding, that means (assuming the
side effect of --parents):

The simplification follows commits backwards into history according to
the following rules:

=2D-dense:
	Non-merges are included if TREESAME[1], otherwise they are
	skipped.
=2D-sparse:
	Non-merges are always included.

default:
	Merges are included unless they are TREESAME with a parent, in
	which case they are skipped and only that parent is followed.
=2D-full-history:
	Merges are always included.

Conceptually, that builds a subset of the history, although it is
not kept in memory unless absolutely required.  Then:

=2D-simplify-commits:
	Implies --full-history, then applies your algorithm on the
	resulting subset.

Which probably means that --sparse --simplify-commits makes no sense,
but explains the results.

Note that --full-history makes no exceptions, not even for merges that
are TREESAME w.r.t. all parents, unlike current docs state.  (This is
empirically correct.)  If the above is correct, and you think that has
some merit, I'll rewrite my patch to reflect this (with examples) to
update the docs.

=2D Thomas


[1] I still think "touching" was a pretty neat idea ;-)

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart3075356.E9tA7Nbpgx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkifXksACgkQqUud07tmzP2GqwCgjkQHnYWH+mlekU85Z9zt63MJ
aBgAni4FN4rRdTk7KvmNyyyF647TB+6q
=vRQX
-----END PGP SIGNATURE-----

--nextPart3075356.E9tA7Nbpgx--
