From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 13/13] Build in merge
Date: Tue, 1 Jul 2008 04:13:17 +0200
Message-ID: <20080701021317.GS4729@genesis.frugalware.org>
References: <20080630013612.GY2058@genesis.frugalware.org> <e8d1385cc49a06ca3fae28231ebc66a333ce4ffb.1214789764.git.vmiklos@frugalware.org> <7vd4lz4gtw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 04:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVNv-0008Ge-7Z
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbYGACNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755974AbYGACNZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:13:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45150 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbYGACNY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:13:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F1BF31B2540;
	Tue,  1 Jul 2008 04:13:19 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B2A334465E;
	Tue,  1 Jul 2008 03:44:42 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2AC9E11901EE; Tue,  1 Jul 2008 04:13:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4lz4gtw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86978>


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2008 at 10:44:43PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > +static void save_state(void)
> > +{
> > +	int fd;
> > +	struct child_process stash;
> > +	const char *argv[] =3D {"stash", "create", NULL};
> > +
> > +	fd =3D open(git_path("MERGE_STASH"), O_WRONLY | O_CREAT, 0666);
> > +	if (fd < 0)
> > +		die("Could not write to %s", git_path("MERGE_STASH"));
> > +	memset(&stash, 0, sizeof(stash));
> > +	stash.argv =3D argv;
> > +	stash.out =3D fd;
> > +	stash.git_cmd =3D 1;
> > +	run_command(&stash);
> > +}
>=20
> I first thought "heh, that's clever" until I noticed that we use "stash
> create" with "stash apply" these days instead of cpio for this.  I suspect
> that we can do away without leaving the stash in this temporary file, but
> that comment applies to the scripted version as well.

We can. I just did it. ;-)

> By the way, it would be consistent to name counterpart to dropsave in the
> scripted version as "drop_save" if you use "save_state" and "restore_stat=
e".

OK, renamed.

>=20
> > +static void reset_hard(unsigned const char *sha1, int verbose)
> > +{
> > +	struct tree *tree;
> > +	struct unpack_trees_options opts;
> > +	struct tree_desc t;
> > +
> > +	memset(&opts, 0, sizeof(opts));
> > +	opts.head_idx =3D -1;
> > +	opts.src_index =3D &the_index;
> > +	opts.dst_index =3D &the_index;
> > +	opts.update =3D 1;
> > +	opts.reset =3D 1;
> > +	if (verbose)
> > +		opts.verbose_update =3D 1;
> > +
> > +	tree =3D parse_tree_indirect(sha1);
> > +	if (!tree)
> > +		die("failed to unpack %s tree object", sha1_to_hex(sha1));
> > +	parse_tree(tree);
> > +	init_tree_desc(&t, tree->buffer, tree->size);
> > +	if (unpack_trees(1, &t, &opts))
> > +		exit(128); /* We've already reported the error, finish dying */
> > +}
>=20
> Isn't this trashing all the cached stat info from the index?  If this is
> emulating "reset --hard", it also should set opts.merge and do
> oneway_merge, after reading the current index in, I think.  Resetting the
> index and the working tree is not particularly performance critical part,
> but trashing the cached stat info would hurt the performance of everything
> that reads the index after this function returns quite badly.  I suspect
> that you might be better off forking the real thing (reset --hard) if you
> cannot get it right here.

I just realized that builtin-reset forks read-tree as well, so I did
almost the same.

> > +/* Get the name for the merge commit's message. */
> > +static void merge_name(const char *remote, struct strbuf *msg)
> > ...
> > +	strbuf_init(&buf, 0);
> > +	strbuf_addstr(&buf, "refs/heads/");
> > +	strbuf_addstr(&buf, remote);
> > +	dwim_ref(buf.buf, buf.len, branch_head, &ref);
> > +	if (!hashcmp(remote_head->sha1, branch_head)) {
> > +		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
> > +			sha1_to_hex(branch_head), remote);
> > +		return;
> > +	}
>=20
> Hmm, why not resolve_ref() so that it does not dwim at all?  The point of
> the code is so that you can be confident that 'blah' *is* a local branch
> when you say "branch 'blah'".

Yes. I'm now using resolve_ref().

> > +	/* See if remote matches <name>~<number>, or <name>^ */
> > +	ptr =3D strrchr(remote, '^');
> > +	if (ptr && ptr[1] =3D=3D '\0') {
> > +		len =3D strlen(remote);
> > +		while ((ptr =3D (char *)memrchr(remote, '^', len)))
> > +			if (ptr && ptr[1] =3D=3D '\0')
> > +				len =3D ptr - remote - 1;
> > +			else
> > +				break;
>=20
> That's a funny way to say:
>=20
> 	for (len =3D 0, ptr =3D remote + strlen(remote);
>              remote < ptr && ptr[-1] =3D=3D '^';
>              ptr--)
> 		len++;

Ah, and this way I don't need memrchr(), which was pointed out to be
problemtic on Cygwin.

>=20
> > +	if (len) {
> > +		struct strbuf truname =3D STRBUF_INIT;
> > +		strbuf_addstr(&truname, remote);
> > +		strbuf_setlen(&truname, len);
> > +		if (dwim_ref(truname.buf, truname.len, buf_sha, &ref)) {
> > +			strbuf_addf(msg,
> > +				"%s\t\tbranch '%s' (early part) of .\n",
> > +				sha1_to_hex(remote_head->sha1), truname.buf);
> > +			return;
>=20
> Isn't this wrong?  Giving "v1.5.6~20" to this code will strip ~20 and make
> remote =3D "v1.5.6", to which dwim_ref() will happily say Ok, and you end=
 up
> saying "branch 'v1.5.6' (early part)", don't you?

Right. Now I do

        strbuf_addstr(&truname, "refs/heads/");

Before appending the remote name to truname, so that should exclude
tags.

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
> > +	opts.head_idx =3D -1;
>=20
> Is this the correct head_idx value for this three-way merge?  I think it
> should be 2 but please double check.

Yes, you are right. I just checked builtin-read-tree and it's 2, not -1.

> > +static int commit_tree_trivial(const char *msg, unsigned const char *t=
ree,
> > +		struct commit_list *parents, unsigned char *ret)
> > +{
> >  ...
> > +}
>=20
> We may want to have another patch before this one to abstract most of
> cmd_commit_tree() out, perhaps?

Done. And now builtin-merge uses commit_tree() as well.

> > +int cmd_merge(int argc, const char **argv, const char *prefix)
> > ...
> > +	/*
> > +	 * This could be traditional "merge <msg> HEAD <commit>..."  and
> > +	 * the way we can tell it is to see if the second token is HEAD,
> > +	 * but some people might have misused the interface and used a
> > +	 * committish that is the same as HEAD there instead.
> > +	 * Traditional format never would have "-m" so it is an
> > +	 * additional safety measure to check for it.
> > +	 */
> > +	strbuf_init(&buf, 0);
> > +	if (argc > 1) {
> > +		unsigned char second_sha1[20];
> > +
> > +		if (get_sha1(argv[1], second_sha1))
> > +			die("Not a valid ref: %s", argv[1]);
> > +		second_token =3D lookup_commit_reference_gently(second_sha1, 0);
> > +		if (!second_token)
> > +			die("'%s' is not a commit", argv[1]);
>=20
> Interesting.
>=20
> This _superficially_ is quite wrong, because the purpose of this part of
> the code is to tell if we got old-style invocation, and we should not
> barfing merely because what we got is _not_ old-style.  If it is not
> old-style, then it would be new-style, and the logic to tell if it is
> old-style should ideally not have much knowledge about the new-style
> invocation to say "hey, that's an incocrrect new-style invocation".  By
> the way, this part should probably be in a separate function:
>=20
> 	static int is_old_style_invocation(int ac, const char **gv);

OK, I broke out is_old_style_invocation() from cmd_merge().

> Old-style invocation of "git merge" (primarily by "git pull") was
> to call it as:
>=20
> 	git merge "message here" HEAD $commit1 $commit2...
>=20
> and it checks the second token ("HEAD" in the above, but people can misuse
> the interface to name the current branch name).  If the second token is
> not a ref that resolves to a commit, all you know is that this is _not_ an
> old-style invocation, and calling the program with new-style is not a
> crime.
>=20
> The only reason this is wrong only superficially is because new style
> invocation would always be:
>=20
> 	git merge [options] $commit1 $commit2...
>=20
> after stripping the options, and these seemingly wrong die() will complain
> when you try to create an Octopus with the new-style syntax and the
> parameter given as the second remote parent is not a commit.  So the logic
> is wrong, the fact that the user gets the same error message for incorrect
> old-style invocation (perhaps "git merge <msg> HAED $commit") and
> incorrect new-style invocation "git merge $commit1 $nonsense" is just an
> accident, and the end result does not hurt, but asks for a "Huh? why does
> it check and complain only the second parent here but not the first one?".
>=20
> It is interesting, but feels quite dirty.

Now if the second token is a valid SHA1 then I die() if it's not a
commit, but otherwise I just assume it's a new-style invocation.

> > +	if (!have_message && second_token &&
> > +		!hashcmp(second_token->object.sha1, head)) {
>=20
> You need to know that resolve_ref() cleared head[] when head_invalid is
> true when reading this code to notice that, unlike the previous round of
> this patch, it is Ok not to check head_invalid is fine here.  I somehow
> feel it is an unnecessary optimization/obfuscation.
>=20
> But once you have "is_old_style_invocation" suggested earlier, this part
> would look much cleaner and the above comment would become unnecessary.

Yes, now it's just:

       if (!have_message && is_old_style_invocation(argc, argv)) {

>=20
> > +	for (i =3D 0; i < argc; i++) {
> > +		struct object *o;
> > +
> > +		o =3D peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
> > +		if (!o)
> > +			die("%s - not something we can merge", argv[i]);
> > +		remotes =3D &commit_list_insert(lookup_commit(o->sha1),
> > +			remotes)->next;
> > +
> > +		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
> > +		setenv(buf.buf, argv[i], 1);
> > +		strbuf_reset(&buf);
> > +	}
> > +
> > +		o =3D peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
> > +			0, NULL, OBJ_COMMIT);
> > +		if (!o)
> > +			return 0;
> > +
> > +		if (checkout_fast_forward(head, remoteheads->item->object.sha1))
> > +			return 0;
>=20
> When o does not peel well, or checkout_fast_forward() returns failure,
> that would be a failure case, wouldn't it?  Why return 0?
>=20
> Maybe you misread "exit" in shell scripts?  It does not mean exit(0); it
> means "exit with the same exit status as the last command".  So
>=20
> 	new_head=3D$(git rev-parse ...) &&
>         git read-tree -m -u ... &&
>         finish || exit
>=20
> will exit non-zero if any of the commands chained by && fails.

Thanks, that was the case. I thought "false || exit" exits with status
code 0.

> > +	/*
> > +	 * At this point, we need a real merge.  No matter what strategy
> > +	 * we use, it would operate on the index, possibly affecting the
> > +	 * working tree, and when resolved cleanly, have the desired
> > +	 * tree in the index -- this means that the index must be in
> > +	 * sync with the head commit.  The strategies are responsible
> > +	 * to ensure this.
> > +	 */
> > +	if (use_strategies.nr !=3D 1) {
> > +		/*
> > +		 * Stash away the local changes so that we can try more
> > +		 * than one.
> > +		 */
> > +		save_state();
> > +		single_strategy =3D 0;
> > +	} else {
> > +		unlink(git_path("MERGE_STASH"));
> > +		single_strategy =3D 1;
>=20
> I think s/single_strategy/(use_strategies.nr =3D=3D 1)/ in the remainder =
of the
> code would be taking advantage of working in C ;-)

I dropped single_strategy.

>=20
> > +		if (ret) {
> > +			/*
> > +			 * The backend exits with 1 when conflicts are
> > +			 * left to be resolved, with 2 when it does not
> > +			 * handle the given merge at all.
> > +			 */
> > +			if (ret =3D=3D 1) {
>=20
> Probably from here til ...
>=20
> > +				int cnt =3D 0;
> > ...
> > +				cnt +=3D count_unmerged_entries();
>=20
> ... here should be a separate "evaluate_result()" function.

Done.

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhpkr0ACgkQe81tAgORUJY+pQCfQlj8q2ScwfMNsUlPqQB+SDoI
EuAAoIKpKsuu1hPLS0JSs3T7n4uQ6Yev
=CSH7
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--
