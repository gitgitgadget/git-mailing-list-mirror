X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 12:17:23 +0100
Message-ID: <20061217111723.GF12411@admingilde.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
NNTP-Posting-Date: Sun, 17 Dec 2006 11:17:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34684>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvu1K-0000Ux-Cr for gcvg-git@gmane.org; Sun, 17 Dec
 2006 12:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752444AbWLQLR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 06:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbWLQLR0
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 06:17:26 -0500
Received: from mail.admingilde.org ([213.95.32.147]:36749 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752444AbWLQLRZ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 06:17:25 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gvu1D-0002yQ-Vr; Sun, 17 Dec 2006 12:17:23 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 16, 2006 at 10:32:36AM -0800, Junio C Hamano wrote:
> Because I am primarily a plumber, I was thinking about the
> changes that need to be done at the plumbing level.  I only
> looked at the prototype when it was announced, and I do not know
> the progress you made since then.  Could you tell us the current
> status?

Most of the things you described are already implemented in
http://git.admingilde.org/tali/git.git/module2

If there is interest in it, I can generate some nice patches out of it.
However with Linus concerns about scalability I'm not sure it is ready
yet.  But if you prefer patches for discussion I'll send them here.

> I am assuming that the overall design is based on what Linus
> proposed long time ago with his "gitlink" object.  That is,
>=20
>  * the index and the tree object for the superproject has a
>    "link" object that tells there is a directory and the
>    corresponding commit object name from the subproject.  Unlike
>    my previous "bind commit" based prototype, index does not
>    have any blobs nor trees from the subproject.

In contrast to your description, my implementation does not
introduce a new "link" type but instead adds the reference to the
submodule commit directly to the parent tree object and to its
index.

>  * the subproject is on its own, and can exist unaware of the
>    existence of its superproject (there is no back-link at the
>    object layer).

yes, this is essential.
There may be links in this particular instance of the submodule, i.e.
the repository/working directory which are checked out by the
supermodule may be coupled to the supermodule, but it must always
be possible to clone/push/pull the submodule alone.

>  * the subproject and the superproject are loosely coupled.  An
>    act of committing in one does not automatically make a
>    corresponding commit in the other at the plumbing level.

this is essential, too.

> With the index, in addition to the mode bits and "link" object's
> SHA-1, you would need to decide what to do with ce_match_stat(),
> to keep track of the information "update-index --refresh" updates.
> My recommendation is to:
>=20
>  (1) Look at the directory the "link" is at, and find .git/
>      subdirectory (that is the $GIT_DIR for the subproject) and
>      its .git/HEAD;
>=20
>  (2) If that points at a loose ref, use the file's stat()
>      information (e.g stat("$sub/.git/refs/heads/master"));
>=20
>  (3) Otherwise, use the packed-ref file's stat() information
>      (e.g stat("$sub/.git/packed-refs")).
>=20
> Then ce_match_stat() for a "link" entry can do the same
> computation and tell if the subproject has changed its HEAD.

yes.
However I decicided not to read in HEAD but some specific branch.
This may sound arbitrary and I did not really like to make
"master" (the branch I chose) even more special, but you will
understand it when looking at the checkout below.

> Another issue with the index is what to put in the cache_tree
> structure; I think "link" can be treated just like blob (both
> files and symlinks).

Hmm, I never cared about cache_tree up to now.  I guess I should learn
about it to understand the influence on submodules.

> Then read-tree (bulk of it is in unpack-trees.c) needs to be
> taught to read in "link" and put that into the index -- this
> should be straightforward.
>=20
> After you have a working index, you should be able to do
> write-tree (writes the new "link" entry as is, without
> descending into the subproject) trivially.

Where do you want to write the link to?
What I do here is update one branch ("master") of the submodule to
the new commit which was stored in the parent index.
If this branch is currently checked out, the working directory will
be updated, too.  If there is no working directory for the submodule
yet, it will be created.

Updating one special branch instead of HEAD is because the submodule
commits which are stored in the supermodule really can be considered
as a special branch which happens to not be stored in an ordinary ref.
In order to make it visible to the user the commit is copied to a
normal ref.
This approach also integrates better with branches in the submodule.
When you want to start parallel development in a branch you eigther
want to do this in the complete supermodule scope -- then you have
to branch the supermodule --, or you want to do it independent to the
version stored in the supermodule -- then you don't want a supermodule
checkout to mess with your branch.
So it makes sense to have one branch which is tracked by the parent
and other branches which are independent from the parent.


> It is debatable what 'checkout-index -f' should do when the
> subproject is already checked out and its HEAD points at a
> different commit.  I am tempted to say that it should go there
> and run "reset --hard", but I feel uneasy about that because it
> is a blatant layering violation.  Maybe it should simply ignore
> link entries and let the Porcelain layer take care of them.

Where exactly do you see the layering violation?
Well I think it makes sense to use read-tree -m <old> <new> in the
submodule instead of a hard reset, but when the supermodule is checked
out the submodule really should move to its new version.
(At least the branch which is tracked by the parent should do so.)


> Then there are three diff- brothers at the plumbing level.

All the diff stuff is what is still missing in my implementation.
If you ask for a diff in the parent, it will happily diff the
submodules commit objects ;-)


> I suspect the hardest part is "rev-list --objects" (now most of
> it is found in revision.c).  Theoretically, if the code can
> handle "tag"s, it should be able to handle "link"s, but I have a
> feeling that the ancestry traversal code that walks commits is
> not prepared to see "commit" object to appear from somewhere in
> the middle of traversal.  A commit so far can be wrapped only by
> tags zero or more times, and a tag never appears inside anything
> but another tag, so the code can just keep peeling the tag until
> it sees a non-tag and after that it will be living in the world
> that has only commit->tree->blob hierarchy, and can afford to do
> the ancestry based solely on "commit" and can treat reachability
> for "tree" and "blob" as afterthought.  But I think the updated
> code needs to know that "link" needs to be unwrapped and
> contained "commit" needs to be injected back to the ancestry
> walking machinery.

Well, a simple and dump version (i.e. my current implementation) can
just do the same for commits as it does for trees: just recursively
descend.  Of course this is prohibitive in anything but toy projects.

A better approach is to put all the submodule commits on the pending
list and do the normal ancestry walk for them again.  But this would
also need all reachable objects from all modules to be known to one
process.

This could be solved by having one pending list per submodule and
then flush all objects before moving to the next submodule, or
just processing the submodule in a different process.
But when the SEEN information is not shared between submodules then
rev-list could output the same object twice if a blob or tree is
used by several submodules.  This may not be a problem if all the
code which processes rev-list output is idempotent, but I haven't
looked into this in detail.

Of course, when rev-list for submodules is already split out there
is the valid question if it really makes sense to descend into
submodules when doing rev-list.
Not doing so would natually decouple sub- from supermodule but then
a lot of operations that depend on rev-list (clone, push, pull)
have to be heavily modified.

Getting this straight in an efficient way is the next challenge.

--=20
Martin Waitz

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFhSdDj/Eaxd/oD7IRAnrLAJ9pgeNZvUArxggJO5xlADQJTVbNVACfVTmK
W427KZOhCt5O+m6Ct5uJP5g=
=FmWG
-----END PGP SIGNATURE-----

