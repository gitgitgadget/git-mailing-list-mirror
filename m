From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Build in merge
Date: Tue, 8 Jul 2008 03:00:07 +0200
Message-ID: <20080708010007.GA10347@genesis.frugalware.org>
References: <7vhcb14l3m.fsf@gitster.siamese.dyndns.org> <1215474140-11220-1-git-send-email-vmiklos@frugalware.org> <7v63rhz03x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:01:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1Zs-00020c-FD
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYGHBAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbYGHBAL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:00:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38537 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015AbYGHBAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:00:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CE24A1B2520;
	Tue,  8 Jul 2008 03:00:07 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3BC2E44698;
	Tue,  8 Jul 2008 02:27:37 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3F5A611901B3; Tue,  8 Jul 2008 03:00:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v63rhz03x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87676>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2008 at 05:32:50PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > So here is a version, this time without the use_strategies list.
>=20
> That is not what I meant.  I am afraid perhaps I misunderstood what you
> were talking about.
>=20
> When/if you allow user defined new strategies, then you have a choice:
>=20
>  (1) find "git-merge-*" in path, add them to the single all_strategies[]
>      list (but you will do the ALLOC_GROW() business so you would need to
>      use the one you currently have as static form to prime the real list=
),
>      and look for "foo" strategy when "-s foo" is given from that single
>      list, or
>=20
>  (2) find "git-merge-*" in path, add them to a separate user_strategies[]
>      list, and look for "foo" strategy when "-s foo" is given from the
>      user_strategies[] list and all_strategies[] list (all_strategies[]
>      should perhaps be renamed to builtin_strategies[] if you go that
>      route).

OK, I see now. Actually I think the primary problem with a custom
strategy is that we do not know its flags, IOW if it handles an octopus,
etc. So I think there are two questions here:

1) How to tell git-merge the flags of a custom strategy? Or: is it
necessary at all?

I could imagine the following situations:

1) A project has code in a repo, some documentation and po files.

The first two can be merged with builtin strategies, the later probably
needs a custom merge driver.

So, in most cases recursive is fine, but sometimes the maintainer wants
to say 'git pull -s po'.

In this case the flags of 'po' does not really matter.

2) Someone is not happy with the current recursive strategy and writes
=66rom scratch a new one. He/she puts it to pull.twohead, so it will be
tried before recursive.

To sum up: I am not sure what would be the benefit of being able to
specify flags for strategies. However, if we want so, it would be good
to discuss how it should be done.

> The part that records which strategies were specified from the command
> line *in what order* via "-s foo" switches should remain list of pointers
> into "struct strategy", which is called "struct strategy **use_strategies"
> in the code and corresponds to the $use_strategies variable in the
> scripted version.  The order of these is important, as that defines in
> which order the strategies are tried [*1*].  If you go route (1), these
> pointers will all be pointing at elements in all_strategies[]; with route
> (2) they may be pointing at either all_strageties[] element or
> user_strategies[] element.

I see the problem, I lost the order at the moment.

> If you are never going to say "available strategies are these" after you
> start supporting user-defined strategy, then you do not necessarily need
> to do the "find 'git-merge-*' in path, add them to ..." step above, in
> which case it would be Ok not to scan the path and add them to
> all_strategies[] (in route (1)) nor user_strategies[] (in route (2)).
> Instead, you would just create a new "struct strategy" instance lazily
> when the user gave "-s foo" and "foo" is not one of the built-in strategy.
> You would put that at the tail of "struct strategy **use_strategy" array,
> and iterate over use_strategy in the order they are given on the command
> line.

I guess it would be nice to adjust the error message and scanning path,
but that's something - I guess - that should be done after the rewrite
is complete and there are no more issues with it.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyvBYACgkQe81tAgORUJbdwwCeJVPFfB8UVacTXy9UwoegcRKV
t/4AnjamzgGTpbDRjQV9or/1pAPrk2A5
=DCTE
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
