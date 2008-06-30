From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 13/13] Build in merge
Date: Mon, 30 Jun 2008 03:36:12 +0200
Message-ID: <20080630013612.GY2058@genesis.frugalware.org>
References: <20080628023355.GH2058@genesis.frugalware.org> <ed4b7f44474d6b9398fb0752740ede264bea25b2.1214620551.git.vmiklos@frugalware.org> <7vprq0fzum.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfjJTYUClXDJCnRl"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:37:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD8L2-0003Nb-7f
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 03:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbYF3BgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 21:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbYF3BgQ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 21:36:16 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42349 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbYF3BgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 21:36:15 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 44A1D1B24F0;
	Mon, 30 Jun 2008 03:36:13 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1E7FC44699;
	Mon, 30 Jun 2008 03:08:13 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B8EA611901EE; Mon, 30 Jun 2008 03:36:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vprq0fzum.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86859>


--WfjJTYUClXDJCnRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2008 at 12:46:09AM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > +/* Get the name for the merge commit's message. */
> > +static void merge_name(const char *remote, struct strbuf *msg)
> > +{
> > +	struct object *remote_head;
> > +	unsigned char branch_head[20], buf_sha[20];
> > +	struct strbuf buf;
> > +	char *ptr;
> > +	int len =3D 0;
> > +
> > +	memset(branch_head, 0, sizeof(branch_head));
> > +	remote_head =3D peel_to_type(remote, 0, NULL, OBJ_COMMIT);
> > +	if (!remote_head)
> > +		return;
>=20
> Hmm.  This is a faithful translation of scripted version, but I wonder
> what should happen when we got a non-commit here...

Hm, I think we do not consider that case normal, at least git fsck
(since commit 6232f62) checks for it.

I replaced the silent return with a die().

> > +
> > +	strbuf_init(&buf, 0);
> > +	strbuf_addstr(&buf, "refs/heads/");
> > +	strbuf_addstr(&buf, remote);
> > +	get_sha1(buf.buf, branch_head);
>=20
> This does not correspond to the computation of $bh in the scripted version
> that makes sure "remote" is actually a bare name of branch, e.g. "master",
> without any adornment like "master~5^3~8.  Your code would succeed and
> leave the same object name in branch_head[] as remote_head->sha1, wouldn't
> it?

I replaced it with a dwim_ref() call, to achieve the same behaviour.

> > +	if (!hashcmp(remote_head->sha1, branch_head)) {
> > +		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
> > +			sha1_to_hex(branch_head), remote);
> > +		return;
> > +	}
> > +	/* See if remote matches <name>~<number>, or <name>^ */
>=20
> The scripted version did not handle <name>^, so this is an extension.
> Don't you want also handle <name>^^^ if we are extending it?

I did so, now it accepts <name>^, <name>^^, <name>^^^, etc.

> > +	ptr =3D strrchr(remote, '^');
> > +	if (ptr && ptr[1] =3D=3D '\0')
> > +		len =3D ptr-remote;
> > +	else {
> > +		ptr =3D strrchr(remote, '~');
> > +		if (ptr && ptr[1] !=3D '0' && isdigit(ptr[1])) {
> > +			len =3D ptr-remote;
> > +			ptr++;
> > +			for (ptr++; *ptr; ptr++)
> > +				if (!isdigit(*ptr)) {
> > +					len =3D 0;
> > +					break;
> > +				}
> > +		}
> > +	}
> > +	if (len) {
> > +		struct strbuf truname =3D STRBUF_INIT;
> > +		strbuf_addstr(&truname, remote);
> > +		strbuf_setlen(&truname, len);
> > +		if (!get_sha1(truname.buf, buf_sha)) {
>=20
> Again, isn't this wrong?  You are not making sure truname is the name of
> existing local branch.  HEAD@{7}~23 will pass get_sha1() but you are not
> merging an early part of HEAD@{7} branch.

Now I'm using dwim_ref() here as well.

> > +			strbuf_addf(msg,
> > +				"%s\t\tbranch '%s' (early part) of .\n",
> > +				sha1_to_hex(remote_head->sha1), truname.buf);
> > +			return;
> > +		}
> > +	}
>=20
> > +int cmd_merge(int argc, const char **argv, const char *prefix)
> > +{
>=20
> This is an ultra-huge function.  I wonder if it can further split up to
> make it easier to maintain.

Yes, just like the scripted version. Hm no, that was even longer. (I
mean I already introduced a lot of static functions to make the C
equivalent of the "main" part of git-merge.sh shorter.) OK, it was 474
lines long today, but now I introduced 3 new static functions and that
made it "only" 410 lines long.

> > +	/*
> > +	 * This could be traditional "merge <msg> HEAD <commit>..."  and
> > +	 * the way we can tell it is to see if the second token is HEAD,
> > +	 * but some people might have misused the interface and used a
> > +	 * committish that is the same as HEAD there instead.
> > +	 * Traditional format never would have "-m" so it is an
> > +	 * additional safety measure to check for it.
> > +	 */
> > +	strbuf_init(&buf, 0);
> > +	strbuf_init(&head_arg, 0);
> > +	if (argc > 1)
> > +		second_token =3D peel_to_type(argv[1], 0, NULL, OBJ_COMMIT);
>=20
> If the second token was a string that could resolve to an object name that
> does not peel to commit (say "merge -m 'HEAD^{tree}' other"), you will get
> a complaint fro mpeel-to-type "I expected a commit but you gave something
> else".  You (or more likely Dscho) might have said "that won't matter in
> practice", but I think you should really do get_sha1() followed by
> lookup_commit_reference_gently() here to avoid the errors.

Fixed.

>=20
> > +	head_invalid =3D get_sha1("HEAD", head);
>=20
> You've already done this earlier with resolve_ref() haven't you?

Ah yes. I had the global 'head' and the local 'sha1' variable for the
same purpose, now I got rid of the local 'sha1' variable in cmd_merge()
so resolve_ref() writes now to the 'head' variable and then this line is
not necessary, as I can write head_invalid right after resolve_ref().

>=20
> > +	if (!have_message && second_token &&
> > +		!hashcmp(second_token->sha1, head)) {
>=20
> Isn't this wrong if head_invalid is true?

if head_invalid is true, then 'head' will be filled with 0s, hashcmp()
will never return 0 so the condition will be never true. That's what the
shell version:

        head_commit=3D$(git rev-parse --verify "HEAD" 2>/dev/null)

does as well.

> > +		strbuf_addstr(&merge_msg, argv[0]);
> > +		strbuf_addstr(&head_arg, argv[1]);
> > +		argv +=3D 2;
> > +		argc -=3D 2;
>=20
> I do not think there is any point using strbuf for head_arg.  Shouldn't it
> simply be a "const char *"?

Now it is.

> > +		if (!remote_head)
> > +			die("%s - not something we can merge", argv[0]);
> > +		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
> > +				DIE_ON_ERR);
> > +		reset_hard(remote_head->sha1, 0);
> > +		return 0;
>=20
> Makes one wonder reset_hard() (aka "read-tree --reset -u HEAD") ever fail
> and return here (iow, without calling die()).  The answer is luckily no
> in this case, but it is somewhat unnerving to reviewers.

Actually reset_hard does not return if an error occures:

        if (unpack_trees(1, &t, &opts))
                exit(128); /* We've already reported the error, finish dyin=
g */

That's exactly how we already have it in builtin-commit.

>=20
> > +	} else {
> > +		/* We are invoked directly as the first-class UI. */
> > +		strbuf_addstr(&head_arg, "HEAD");
> > +		/*
> > +		 * All the rest are the commits being merged;
> > +		 * prepare the standard merge summary message to
> > +		 * be appended to the given message.  If remote
> > +		 * is invalid we will die later in the common
> > +		 * codepath so we discard the error in this
> > +		 * loop.
> > +		 */
> > +		struct strbuf msg;
>=20
> Decl-after-statement.

You already fixed this. :-)

> > +	for (i =3D 0; i < use_strategies.nr; i++) {
> > +		if ((unsigned int)use_strategies.items[i].util &
> > +			NO_FAST_FORWARD)
> > +			allow_fast_forward =3D 0;
> > +		if ((unsigned int)use_strategies.items[i].util & NO_TRIVIAL)
> > +			allow_trivial =3D 0;
>=20
> Can we abstract out these ugly casts?  Any code that use path_list to
> store anything but list of paths (i.e. some value keyed with string) tends
> to have this readability issue.

If you don't cast, you can't use the & operator. If I change the
path_list_item's util to be an unsigned number then I break fast-export.
I think if we _really_ want to get rid of those casts, we could have
something like:

diff --git a/path-list.h b/path-list.h
index ca2cbba..1f57e81 100644
--- a/path-list.h
+++ b/path-list.h
@@ -4,6 +4,7 @@
 struct path_list_item {
        char *path;
        void *util;
+       unsigned int flags;
 };
 struct path_list
 {

But I'm not sure if that's a good idea. Also, fast-export will still
have casts after such a change.

> > +	if (!common)
> > +		; /* No common ancestors found. We need a real merge. */
> > +	else if (!remoteheads->next &&
> > +		!hashcmp(common->item->object.sha1,
> > +		remoteheads->item->object.sha1)) {
>=20
> Wouldn't the latter be "common->item =3D=3D remoteheads->item" simply?

Right, changed.

> You do not have the check to make sure there is only one common ancestor
> (scripted version compares $common and $1 textually to achieve this), and
> checking only the first one of them.  Is this correct?

Yes. I changed it to:

        else if (!remoteheads->next && !common->next &&
                        common->item =3D=3D remoteheads->item) {

And now I have the check.

>=20
> > +		/*
> > +		 * If head can reach all the remote heads then we are up
> > +		 * to date.
> > +		 */
>=20
> The comment is wrong --- you are doing "... but first the most common case
> of merging one remote" here.

I changed it to match the shell version:

/*
 * If head can reach all the merge then we are up to
 * date.
 * but first the most common case of merging one remote.
 */

> > +		finish_up_to_date("Already up-to-date.");
> > +		return 0;
> > +	} else if (allow_fast_forward && !remoteheads->next &&
> > +		!hashcmp(common->item->object.sha1, head)) {
> > +		/* Again the most common case of merging one remote. */
>=20
> Here again you are not checking there is only one common, and checking
> only the first one of them.

Changed to:

        } else if (allow_fast_forward && !remoteheads->next &&
                        !common->next &&
                        !hashcmp(common->item->object.sha1, head)) {

Which should add the proper check.

> > +		if (merge_one_remote(head, remoteheads->item->object.sha1))
> > +			return 0;
>=20
> Isn't "merge_one_remote()" just a "git checkout" after fast-forward?  The
> function feels misnamed.

Thanks. I'm terribly bad at naming. Renamed to checkout_fast_forward().

> > +		finish(o->sha1, msg.buf);
> > +		dropsave();
> > +		return 0;
> > +	} else if (!remoteheads->next && common->next)
> > +		;
>=20
> Here you are checking common->next but earlier if/elseif chain didn't so
> it is too late.

Now, that I do, I think the condition is OK.

> > +	else if (!remoteheads->next && option_commit) {
> > +		/*
> > +		 * We are not doing octopus, not fast forward, and have
> > +		 * only one common.
>=20
> Here again you did not check "have only one common" did you?

Actually the shell version did not check here, either, but yes, I would
have to. Now I do.

> > +			printf("Trying really trivial in-index merge...\n");
> > +			if (!read_tree_trivial(common->item->object.sha1,
> > +					head, remoteheads->item->object.sha1)) {
> > +				unsigned char result_tree[20],
> > +					result_commit[20];
> > +				struct commit_list parent;
> > +
> > +				write_tree_trivial(result_tree);
> > +				printf("Wonderful.\n");
> > +				parent.item =3D remoteheads->item;
> > +				parent.next =3D NULL;
> > +				commit_tree_trivial(merge_msg.buf,
> > +					result_tree, &parent,
> > +					result_commit);
> > +				finish(result_commit, "In-index merge");
> > +				dropsave();
> > +				return 0;
> > +			}
> > +			printf("Nope.\n");
> > +		}
>=20
> There weren't any good way to squelch error messages selectively from the
> trivial one in the scripted version and that is the only reason we
> surround read-tree with "Trying..." and "Wonderful/Nope.".  Literal
> translation to make sure you get identical output in the first round of
> this series is good, but after the code stabilizes, we may want to squelch
> these messages.  Something to keep in mind but not now.

OK.

--WfjJTYUClXDJCnRl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhoOIwACgkQe81tAgORUJbrfwCfWxqh5I/MjgSEGqxjNGbRPIj6
DNgAn0kYIENbnR6WPcCzNLqc+8WX0UuI
=JPoK
-----END PGP SIGNATURE-----

--WfjJTYUClXDJCnRl--
