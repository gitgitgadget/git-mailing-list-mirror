From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Thu, 27 Feb 2014 20:29:03 +0100
Message-ID: <1393529343.5277.3.camel@centaur.cmartin.tk>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
	 <1393491610-19476-2-git-send-email-cmn@elego.de>
	 <530F11C1.7040407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:36:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6lJ-0004Ay-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbaB0Tgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 14:36:45 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:42471 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbaB0Tgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:36:44 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 14:36:43 EST
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id F1720DE06A;
	Thu, 27 Feb 2014 20:29:10 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WCchFt6rk8s; Thu, 27 Feb 2014 20:29:10 +0100 (CET)
Received: from [192.168.1.4] (p57A96170.dip0.t-ipconnect.de [87.169.97.112])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id C0923DE068;
	Thu, 27 Feb 2014 20:29:10 +0100 (CET)
In-Reply-To: <530F11C1.7040407@alum.mit.edu>
X-Mailer: Evolution 3.8.5-2+b2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242842>

On Thu, 2014-02-27 at 11:21 +0100, Michael Haggerty wrote:
> On 02/27/2014 10:00 AM, Carlos Mart=C3=ADn Nieto wrote:
> > From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> >=20
> > We need to consider that a remote-tracking branch may match more th=
an
> > one rhs of a fetch refspec. In such a case, it is not enough to sto=
p at
> > the first match but look at all of the matches in order to determin=
e
> > whether a head is stale.
> >=20
> > To this goal, introduce a variant of query_refspecs which returns a=
ll of
> > the matching refspecs and loop over those answers to check for
> > staleness.
> >=20
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> > ---
> >=20
> > There is an unfortunate duplication of code here, as
> > query_refspecs_multiple is mostly query_refspecs but we only care
> > about the other side of matching refspecs and disregard the 'force'
> > information which query_refspecs does want.
> >=20
> > I thought about putting both together via callbacks and having
> > query_refspecs stop at the first one, but I'm not sure that it woul=
d
> > make it easier to read or manage.
> >=20
> >  remote.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++=
+++-----
> >  t/t5510-fetch.sh |  2 +-
> >  2 files changed, 48 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/remote.c b/remote.c
> > index 9f1a8aa..26140c7 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -821,6 +821,33 @@ static int match_name_with_pattern(const char =
*key, const char *name,
> >  	return ret;
> >  }
> > =20
> > +static void query_refspecs_multiple(struct refspec *refs, int ref_=
count, struct refspec *query, struct string_list *results)
> > +{
> > +	int i;
> > +	int find_src =3D !query->src;
> > +
> > +	if (find_src && !query->dst)
> > +		error("query_refspecs_multiple: need either src or dst");
> > +
> > +	for (i =3D 0; i < ref_count; i++) {
> > +		struct refspec *refspec =3D &refs[i];
> > +		const char *key =3D find_src ? refspec->dst : refspec->src;
> > +		const char *value =3D find_src ? refspec->src : refspec->dst;
> > +		const char *needle =3D find_src ? query->dst : query->src;
> > +		char **result =3D find_src ? &query->src : &query->dst;
> > +
> > +		if (!refspec->dst)
> > +			continue;
> > +		if (refspec->pattern) {
> > +			if (match_name_with_pattern(key, needle, value, result)) {
> > +				string_list_append_nodup(results, *result);
> > +			}
> > +		} else if (!strcmp(needle, key)) {
> > +			string_list_append(results, value);
> > +		}
> > +	}
> > +}
> > +
> >  static int query_refspecs(struct refspec *refs, int ref_count, str=
uct refspec *query)
> >  {
> >  	int i;
> > @@ -1954,25 +1981,40 @@ static int get_stale_heads_cb(const char *r=
efname,
> >  	const unsigned char *sha1, int flags, void *cb_data)
> >  {
> >  	struct stale_heads_info *info =3D cb_data;
> > +	struct string_list matches =3D STRING_LIST_INIT_DUP;
> >  	struct refspec query;
> > +	int i, stale =3D 1;
> >  	memset(&query, 0, sizeof(struct refspec));
> >  	query.dst =3D (char *)refname;
> > =20
> > -	if (query_refspecs(info->refs, info->ref_count, &query))
> > +	query_refspecs_multiple(info->refs, info->ref_count, &query, &mat=
ches);
> > +	if (matches.nr =3D=3D 0)
> >  		return 0; /* No matches */
> > =20
> >  	/*
> >  	 * If we did find a suitable refspec and it's not a symref and
> >  	 * it's not in the list of refs that currently exist in that
> > -	 * remote we consider it to be stale.
> > +	 * remote we consider it to be stale. In order to deal with
> > +	 * overlapping refspecs, we need to go over all of the
> > +	 * matching refs.
> >  	 */
> > -	if (!((flags & REF_ISSYMREF) ||
> > -	      string_list_has_string(info->ref_names, query.src))) {
> > +	if (flags & REF_ISSYMREF)
> > +		return 0;
> > +
> > +	for (i =3D 0; i < matches.nr; i++) {
> > +		if (string_list_has_string(info->ref_names, matches.items[i].str=
ing)) {
> > +			stale =3D 0;
> > +			break;
> > +		}
> > +	}
> > +
> > +	string_list_clear(&matches, 0);
> > +
> > +	if (stale) {
> >  		struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_t=
ail);
> >  		hashcpy(ref->new_sha1, sha1);
> >  	}
> > =20
> > -	free(query.src);
> >  	return 0;
> >  }
>=20
> I didn't have time to review this fully, but I think you are missing
> calls to string_list_clear(&matches) on a couple of code paths.

Yep, you're right. I'll fix this and hold off new version for a bit to
see if there's more input.=20

   cmn
