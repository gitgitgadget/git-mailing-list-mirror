X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 12:00:32 +0100
Message-ID: <20061201110032.GL18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
NNTP-Posting-Date: Fri, 1 Dec 2006 11:01:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612010902.51264.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32891>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq68K-0001Vs-Hc for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936383AbWLALAf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936403AbWLALAf
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:00:35 -0500
Received: from agent.admingilde.org ([213.95.21.5]:23750 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S936383AbWLALAe (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:00:34 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq688-0004p6-SA; Fri, 01 Dec 2006 12:00:32 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 09:02:48AM +0000, Andy Parkins wrote:
> On Thursday 2006 November 30 17:06, Martin Waitz wrote:
>=20
> > You can easily have several topic-branches and merge updates from the
> > master branch.
> > otherwise you always have to remember which branch holds your current
> > contents from the supermodule.
>=20
> WHAT?  I've got to make merges (that I don't necessarily want) in
> order to commit in the supermodule?  This completely negates any
> useful functioning of branches in the submodule.  I want to be able to
> make a quick development branch in the submodule and NOT merge that
> code into master and then be able to still commit that in the
> supermodule.

exactly!

Please think about it.

If you track HEAD, then this means that you track HEAD.
In _both_ directions!

So you not only store your submodule HEAD commit in the supermodule when you
do commit to the supermodule, it also means that your submodule HEAD
will be updated when you update your supermodule.
And what happens if you already commited something to HEAD in the mean
time? Exactly: a merge is needed.

And you are right: you might not want to do this now, because you
branched off, because you _wanted_ to have some development which is
_independent_ to the current supermodule work.

So tracking HEAD really makes branching in the submodule hard to work
with.

What does the supermodule provide to the submodule? It stores one
reference to a commit sha1. Just like a reference inside refs/heads
inside the submodule. There really is not much difference between the
sha1 stored inside the supermodules tree and one stored inside refs/.
So from the submodules point of view, the supermodule is not much more
then one special branch.
But it is not possible to use the supermodule index directly as one
"magic" branch for several reasons.
So we need synchronization methods between the index entry for the
submodule which is stored in the supermodule and the references in the
submodule. These are git-update-index/git-commit and git-checkout, both
called explicitly or implicitly in the supermodule.
And I really think it makes sense to have a one-to-one relationship
between the submodule "branch" stored in the supermodule and the
branchname used in the submodule.

> I think you're imagining the binding between the super and sub is very mu=
ch=20
> tighter than it should be.  What if I'm working on a development version =
of=20
> the supermodule, which includes a stable version of the submodule?  Vice=
=20
> versa?

I don't see your problem here.

> > When viewed from the supermodule, you are storing one branch per
> > submodule in your tree.
>=20
> That prevents me "trying something out" on a topic branch in the submodul=
e. =20
> Here's a scenario using my suggested "supermodule tracks submodule HEAD"=
=20
> method.
>=20
>  * You're developerA
>  * Make a development branch in the supermodule
>  * In the submodule, make a whole load of topic branches
>  * Make a development branch in the submodule
>  * Merge the topic branches into the development branch of the submodule
>  * Commit in the supermodule.  This capture
>  * Tag that commit "my-tested-arrangement-of-submodule-features"
>  * Push that tag to the central repository - tell the world.
>  * DeveloperB checks out that tag and tries it.  Great stuff.

This is still supposed to be a distributed system.
DeveloperB does not only check out the whole project including several
modules. He is also supposed to _work_ with it.

What if DeveloperB also has several topic branches?
When he checks out the new supermodule, only his current HEAD in the
submodule will be updated.
So he first has to change to some supermodule-tracking branch inside the
submodule, then pull the supermodule updates, then eventually merge the
new contents of his supermodule-tracking branch into his topic branches.
So why not make this "let's update one supermodule-tracking-branch"
automatic?

> Now: here's the secret fact that I didn't tell you that will break
> your "supermodule tracks submodule branch" method.  DeveloperB has
> decided to have this in his remote:
>   Pull: refs/heads/master:refs/heads/upstream/master
> Oops. The supermodule, which has been told to track the "master"
> branch in the submodule is tracking different things in developerA's
> repository from developerB's repository.

So what? He can do to the repository whatever he wants?
He wants to change one submodule to a different branch?
He can do so!
But please do not expect the system to magically be able to resolve
problems. If you _by intent_ changed the submodule to another branch
which is incompatible to the one used in the submodule you can't expect
that this is magically merged.
This is the same as with normal files.
Sure you can replace one file with new contents that are different to
the one used by someone else.  Don't expect this can be merged
automatically. So now you have two forks/branches of the project.
So what?

Same for a system including submodules:
If you change one submodule to a totally different branch, then you
effectivley forked/branched the entire project.
(Nomenclature is a bit difficult here: what I mean by totally different
branch is: the submodule commit tracked by the supermodule is not
directly connected to the one tracked by an old version of the
supermodule).

So whenever you introduce conflicting changes somewhere in the project
(be it in a submodule or in a file) you _always_ fork/branch the entire
project (i.e. the topmost supermodule).
You can't circumvent that.

So what are submodule branches good for then?
To store other lines of development which are not yet / not any more
tracked by the supermodule.  Perhaps you store references to branches
stored in another supermodule, or another standalone repository.
Or a temporary branch which is only used for testing.
There are really many possiblilities.
But they all have one thing in common: they are not meant to be tracked
by the supermodule.

> Branches are completely arbitrary per-repository.

Yes, but a submodule is special here: it really has one special branch.
The module is not independent any more.  That is the _nature_ of a
submodule.

> You cannot rely on them being consistent between different
> repositories.

Sure, we are in a distributed system.
But the supermodule always has to know which branch in the submodule has
to be tracked.  The easiest thing is to always use the default
refs/heads/master.  Surely this could be changed if there is a need.

--=20
Martin Waitz

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcAtQj/Eaxd/oD7IRApj3AJ9YEnkyh5Co8mauUmvksJXqBqjbeACeItnm
HqrEPzqSnvfGLgv5HSGs2R8=
=FJ7q
-----END PGP SIGNATURE-----

