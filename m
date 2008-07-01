From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 14/14] Build in merge
Date: Tue, 1 Jul 2008 14:50:23 +0200
Message-ID: <20080701125023.GW4729@genesis.frugalware.org>
References: <cover.1214879690.git.vmiklos@frugalware.org> <9201d4e13e574c10b1674cf1f6da23a44a73f8b2.1214879690.git.vmiklos@frugalware.org> <1b74bb93e518a906b0067d182fb29279baff3b25.1214879690.git.vmiklos@frugalware.org> <5e65b37998d1fdd9d314e48cea2cf67fd73ba8cd.1214879690.git.vmiklos@frugalware.org> <7vtzfaqg16.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MOeiELSuYwpLEKvX"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 14:52:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfKq-0007VZ-Bi
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 14:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbYGAMu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 08:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbYGAMu3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 08:50:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47094 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756763AbYGAMuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 08:50:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 195991B2545;
	Tue,  1 Jul 2008 14:50:24 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1EDCC44668;
	Tue,  1 Jul 2008 14:21:34 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 66C7811901F0; Tue,  1 Jul 2008 14:50:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzfaqg16.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87033>


--MOeiELSuYwpLEKvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2008 at 11:23:17PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > +static int read_tree_trivial(unsigned char *common, unsigned char *hea=
d,
> > +	unsigned char *one)
> > +{
> > +	int i, nr_trees =3D 0;
> > +	struct tree *trees[MAX_UNPACK_TREES];
> > +	struct tree_desc t[MAX_UNPACK_TREES];
> > +	struct unpack_trees_options opts;
> > +
> > +	memset(&opts, 0, sizeof(opts));
> > +	opts.head_idx =3D 2;
>=20
> Do you still need this assignment here?

No, it was duplicated.

> > +int cmd_merge(int argc, const char **argv, const char *prefix)
> > +{
> > +	unsigned char result_tree[20];
> > +	struct strbuf buf;
> > +	const char *head_arg;
> > +	int flag, head_invalid =3D 0, i;
> > +	int best_cnt =3D -1, merge_was_ok =3D 0, automerge_was_ok =3D 0;
> > +	struct commit_list *common =3D NULL;
> > +	struct path_list_item *best_strategy =3D NULL, *wt_strategy =3D NULL;
> > +	struct commit_list **remotes =3D &remoteheads;
> > +
> > +	setup_work_tree();
> > +	if (unmerged_cache())
> > +		die("You are in the middle of a conflicted merge.");
> > +
> > +	/*
> > +	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
> > +	 * current branch.
> > +	 */
> > +	branch =3D resolve_ref("HEAD", head, 0, &flag);
> > +	if (branch && flag & REF_ISSYMREF) {
> > +		const char *ptr =3D skip_prefix(branch, "refs/heads/");
> > +		if (ptr)
> > +			branch =3D ptr;
> > +	} else
> > +		head_invalid =3D 1;
>=20
> Wait a minute...  Are you calling a detached HEAD as head_invalid here?  I
> am not too much worried about variable naming, but you later do ...
>=20
> > +	if (!have_message && is_old_style_invocation(argc, argv)) {
> > ...
> > +	} else if (head_invalid) {
> > +		struct object *remote_head;
> > +		/*
> > +		 * If the merged head is a valid one there is no reason
> > +		 * to forbid "git merge" into a branch yet to be born.
> > +		 * We do the same for "git pull".
> > +		 */
> > +		if (argc !=3D 1)
> > +			die("Can merge only exactly one commit into "
> > +				"empty head");
>=20
> Which is about HEAD pointing at a branch that isn't born yet.  They are
> two very different concepts.
>=20
> Either the above "else if (head_invalid)" is wrong, or more likely the
> setting of head_invalid we saw earlier is wrong.
>=20
> Probably what you meant was:
>=20
> 	- "char *branch" points at either "HEAD" (when detached) or
>           the name of the branch (e.g. "master" when "refs/heads/master");
>=20
> 	- "unsigned char head[]" stores the commit object name of the
>           current HEAD (or 0{40} if the current branch is unborn);
>=20
>         - set head_invalid to true only when the current branch is unborn.
>=20
> So perhaps...
>=20
> 	branch =3D resolve_ref("HEAD", head, 0, &flag);
>         if (branch && (flag & REF_ISSYMREF) && !prefixcmp(branch, "refs/h=
eads/"))
> 		branch +=3D 11;
>         head_invalid =3D is_null_sha1(head);
>=20
> And probably we can even drop (flag & REF_ISSYMREF) from the above safely.
> Do we even care if the head is detached in this program?  I doubt it.

You are right. I though we care about it, but now I realized such a
comment was only in git-merge.annotated (in Dscho's fork), not in
git-merge.sh. And yes, I mixed up head_invalid for two purposes. Thanks
for clearing the situation.

> > +		strbuf_init(&msg, 0);
> > +		strbuf_addstr(&msg, "Fast forward");
> > +		if (have_message)
> > +			strbuf_addstr(&msg,
> > +				" (no commit created; -m option ignored)");
> > +		o =3D peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
> > +			0, NULL, OBJ_COMMIT);
> > +		if (!o)
> > +			return 1;
> > +
> > +		if (checkout_fast_forward(head, remoteheads->item->object.sha1))
> > +			return 1;
>=20
> Not exiting with 0 status from around here upon error is an improvement,
> but does the user see sensible error messages in addition to the exit
> status?

Now he/she does. :-)

(I updated my working branch on repo.or.cz, will send a patch soon, as
well.)

--MOeiELSuYwpLEKvX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhqKA8ACgkQe81tAgORUJZltQCgqsXRjRRqrXB/b0a1vGNQOzzl
S/YAn33x63U/S4fP57jcnTpcfVocxqhz
=2loa
-----END PGP SIGNATURE-----

--MOeiELSuYwpLEKvX--
