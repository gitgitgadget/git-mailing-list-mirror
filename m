From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git describe weird behaviour
Date: Wed, 10 Nov 2010 15:03:34 +0100
Message-ID: <20101110140334.GJ22105@genesis.frugalware.org>
References: <20101110010016.GC22105@genesis.frugalware.org>
 <20101110041428.GA8955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TMqw4kqxV3vZXvfs"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 15:03:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGBH5-00008q-OY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 15:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab0KJODh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 09:03:37 -0500
Received: from virgo.iok.hu ([212.40.97.103]:34837 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816Ab0KJODh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 09:03:37 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 60426580C3;
	Wed, 10 Nov 2010 15:03:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 266A644659;
	Wed, 10 Nov 2010 15:03:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F0B4E132C041; Wed, 10 Nov 2010 15:03:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101110041428.GA8955@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161151>


--TMqw4kqxV3vZXvfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 09, 2010 at 11:14:28PM -0500, Jeff King <peff@peff.net> wrote:
> we had to travel to get here. Looking at the frugalware history in gitk,
> you might be triggering this; you have a history with just a few merges,
> but extremely long chains of commits on each branch. Repos like linux or
> git.git are a bit bushier in the shape of the graph.

Agreed.

Actually I thought git describe is just a C version of something like:

- run git log, find the first reachable tag (1.4pre1 in this case)
- git rev-list 1.4pre1..|wc -l (880 in this case)
- append "-g<hash>" to make it still unique

Then it turned out it's a bit more complicated, so I mailed the list. :)

> The patch below implements that in a very rough-and-dirty way. It does
> find the 1.4 tag in your repository that you expect. However:

Yes, works here as well:

$ ~/git/git/git describe
1.4pre1-210-g48b67cd

>   2. I am getting nonsensical results when trying it in git.git. It
>      really wants to point me to gitgui tags, which makes no sense. So
>      clearly there is a bug, or my idea is flawed somehow. But it's too
>      late to think about anymore tonight. :)
>=20
> -Peff
>=20
> PS This would be a much simpler algorithm to write in a depth-first way.
>    But that would also involve traversing the entire graph down to the
>    roots, which we try to avoid.  Which reminds me of my "tag
>    --contains" depth first algorithm, and gives me some ideas on how to
>    make it work in a breadth-first way. So even if my idea here is
>    flawed, this thinking hasn't been completely fruitless. :)

Hm, but can't we way git describe does history walk in a --first-parent
way? It might not be efficient, but what may work is to:

- traverse the history by using the first parrents only to find the
  first reachable tag (this way you will never hit git-gui tags)
- count the commits from the first tag till HEAD by traversing the other
  parents as well

To sum up, I think your patch is great about it picks up the right tag
for me, though:

$ git rev-list 1.4pre1..|wc -l
880 <- this is what I would expect in the git describe output
$ git rev-list --first-parent 1.4pre1..|wc -l
569 <- this is less informative, though probably is faster to produce
(we may have this info already when searching for the first tag)
$ ~/git/git/git describe
1.4pre1-210-g48b67cd <- an even smaller number you give. :)

Thanks!

--TMqw4kqxV3vZXvfs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzapjYACgkQe81tAgORUJYl+wCfXC9ug2/HBPKkKu8hR5GFhejd
hlMAniDCZYRwGlp2G7mAyrVfHBEp80nR
=8b/4
-----END PGP SIGNATURE-----

--TMqw4kqxV3vZXvfs--
