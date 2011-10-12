From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 3/4] fetch: honor the user-provided refspecs when
 pruning refs
Date: Thu, 13 Oct 2011 01:18:39 +0200
Message-ID: <1318461519.4484.26.camel@centaur.lab.cmartin.tk>
References: <1318027869-4037-1-git-send-email-cmn@elego.de>
	 <1318027869-4037-4-git-send-email-cmn@elego.de>
	 <7vsjmx7uur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7BDEHwSFLOU0xcUXuZHb"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, mathstuf@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 01:19:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE84i-0006sV-4v
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 01:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab1JLXSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 19:18:55 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:41572 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab1JLXSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 19:18:54 -0400
Received: from [192.168.1.17] (brln-4db9c121.pool.mediaWays.net [77.185.193.33])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id D1305460FE;
	Thu, 13 Oct 2011 01:18:26 +0200 (CEST)
In-Reply-To: <7vsjmx7uur.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183430>


--=-7BDEHwSFLOU0xcUXuZHb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-10-12 at 14:39 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > -static int prune_refs(struct transport *transport, struct ref *ref_map=
)
> > +static int prune_refs(struct refspec *refs, int ref_count, struct ref =
*ref_map)
> >  {
> >  	int result =3D 0;
> > -	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote, r=
ef_map);
> > +	struct ref *ref, *stale_refs =3D get_stale_heads(ref_map, refs, ref_c=
ount);
>=20
> So in short, get_state_heads() used to take a ref_map and a remote. The
> ref_map is what we actually observed from the remote after talking
> ls-remote with it. It tried to see if any existing ref in our refspace ma=
y
> have come from that remote by inspecting the fetch refspec associated wit=
h
> that remote (and the ones that does not exist anymore are queued in the
> stale ref list).
>=20
> Now get_state_heads() takes a ref_map and <refs, ref_count> (you made the
> patch unnecessarily harder to read by swapping the order of parameters).
> The latter "pair" roughly corresponds to what the "remote" parameter used
> to mean, but instead of using the refspec associated with that remote, we
> would use the refspec used for this particular fetch to determine which
> refs we have are stale.

Right. The only reason that the remote was passed was in order to use
its refspec. The order reversal wasn't on purpose, I'll change that.

>=20
> > @@ -699,8 +699,12 @@ static int do_fetch(struct transport *transport,
> >  		free_refs(ref_map);
> >  		return 1;
> >  	}
> > -	if (prune)
> > -		prune_refs(transport, ref_map);
> > +	if (prune) {
> > +		if (ref_count)
> > +			prune_refs(refs, ref_count, ref_map);
> > +		else
> > +			prune_refs(transport->remote->fetch, transport->remote->fetch_refsp=
ec_nr, ref_map);
> > +	}
>=20
> And this is consistent to my two paragraph commentary above.
>=20
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index f2a9c26..79d898b 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -349,7 +349,8 @@ static int get_ref_states(const struct ref *remote_=
refs, struct ref_states *stat
> >  		else
> >  			string_list_append(&states->tracked, abbrev_branch(ref->name));
> >  	}
> > -	stale_refs =3D get_stale_heads(states->remote, fetch_map);
> > +	stale_refs =3D get_stale_heads(fetch_map, states->remote->fetch,
> > +				     states->remote->fetch_refspec_nr);
>=20
> So is this.
>=20
> > diff --git a/remote.c b/remote.c
> > index b8ecfa5..13c9153 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1681,36 +1681,84 @@ struct ref *guess_remote_head(const struct ref =
*head,
> >  }
> > =20
> >  struct stale_heads_info {
> > -	struct remote *remote;
> >  	struct string_list *ref_names;
> >  	struct ref **stale_refs_tail;
> > +	struct refspec *refs;
> > +	int ref_count;
> >  };
> > =20
> > +/* Returns 0 on success, -1 if it couldn't find a match in the refspec=
s. */
> > +static int find_in_refs(struct refspec *refs, int ref_count, struct re=
fspec *query)
> > +{
> > +	int i;
> > +	struct refspec *refspec;
>=20
> This function replaces the role remote_find_tracking() used to play in th=
e
> old code and the difference in the behaviour (except the obvious lack of
> "find_src/find_dst") feels gratuitous.

remote_find_tracking wants a remote, and that's what we don't have
anymore. The main reason was that it does "too much". The previous
versions had the callback doing more by itself, so I overlooked the
possibilities of remote_find_tracking when rewriting it. Looking at the
code again, it does look like what we want.

>=20
> The original code in remote_find_tracking() uses "->pattern" to see if a
> pattern match is necessary, but this scans the refspec for an asterisk,
> assuring a breakage when the refspec language is updated to understand
> other glob magic in the future. Why isn't refspec->pattern used here?

Trees, forest etc. I noticed that a bit late. I have a patch on top of
this one that does use ->pattern, which I was going to ask you to squash
in, but it's moot now, as I need to rewrite the patch anyway.

>=20
> Can't these two functions share more logic?  It appears to me that by
> enhancing the logic here a little bit, it may be possible to implement
> remote_find_tracking() ed in terms of this function as a helper.

Yes, remote_find_tracking should use a version of this function; or
probably better, its loop should become the next version of
find_in_refs, so remote_find_tracking is just a wrapper for when we want
to use the remote's fetch refspec.


I'll resend the series with these changes.

   cmn


--=-7BDEHwSFLOU0xcUXuZHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOliBQAAoJEHKRP1jG7ZzTvUYH/17ziIBLTtcBTmggGrc+itqN
Fl3OB5fOzrh+BxpVo0imHSCDBcHn13gGwtUehY1puQGt2gL69u5axp8IGp3TsQ97
kF9VumAmKW/BrGFLaneHlXdjA/W069ibYySlW2IlAysqneK5SHBLY5FU3ll4qJ6f
6MysRO4fkO4yvibRAsnrCLdEDzrG+aR7ImL2j6su9C2wzJYyWrjioikdhW3W3gIp
zO+mmDvraqGIXraaZEiQmhzS5VS64sWuetqXuyjOAEvZvin5UD7zxlYZ2KiVfbd1
d8wuVjQwG51+RREz0ci1njNiyQyed6xsf1abVGrP34BpgxpklxeOC3NcIuXf/PQ=
=FD0h
-----END PGP SIGNATURE-----

--=-7BDEHwSFLOU0xcUXuZHb--
