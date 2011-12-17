From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] use struct sha1_array in diff_tree_combined()
Date: Sat, 17 Dec 2011 05:53:15 -0500
Message-ID: <20111217105315.GA23935@sigill.intra.peff.net>
References: <4EEC6BD4.4040302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Dec 17 11:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrtL-0004Od-Av
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab1LQKxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 05:53:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44793
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab1LQKxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:53:18 -0500
Received: (qmail 12166 invoked by uid 107); 17 Dec 2011 11:00:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 06:00:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 05:53:15 -0500
Content-Disposition: inline
In-Reply-To: <4EEC6BD4.4040302@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187375>

On Sat, Dec 17, 2011 at 11:15:48AM +0100, Ren=C3=A9 Scharfe wrote:

> Maintaining an array of hashes is easier using sha1_array than
> open-coding it.  This patch also fixes a leak of the SHA1 array
> in  diff_tree_combined_merge().
>=20
> ---
>  builtin/diff.c |   12 ++++++------
>  combine-diff.c |   34 +++++++++++++---------------------
>  diff.h         |    3 ++-
>  submodule.c    |   14 +++++---------
>  4 files changed, 26 insertions(+), 37 deletions(-)

Yay. When I refactored sha1_array, I hoped there would be other users,
but I hadn't actually converted any yet. Good to know it is paying off.

> -	parent =3D xmalloc(ents * sizeof(*parent));
> -	for (i =3D 0; i < ents; i++)
> -		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
> -	diff_tree_combined(parent[0], parent + 1, ents - 1,
> +	for (i =3D 1; i < ents; i++)
> +		sha1_array_append(&parents, ent[i].item->sha1);
> +	diff_tree_combined(ent[0].item->sha1, &parents,
>  			   revs->dense_combined_merges, revs);
> -	free((void *)parent);
> +	sha1_array_clear(&parents);

The original code is slightly more efficient, as it is able to use a
single malloc (because it knows the number of entries ahead of time).
It probably doesn't make a difference, but we could also add a
sha1_array_grow() for this case.

I think it could be used in all three spots you converted in this patch=
=2E

-Peff
