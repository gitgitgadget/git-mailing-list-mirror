X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 14:48:48 +0100
Message-ID: <20061217134848.GH12411@admingilde.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612170101.09615.Josef.Weidendorfer@gmx.de> <20061217114546.GG12411@admingilde.org> <200612171401.10585.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
NNTP-Posting-Date: Sun, 17 Dec 2006 13:48:59 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612171401.10585.jnareb@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34688>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvwNp-0004pU-Vb for gcvg-git@gmane.org; Sun, 17 Dec
 2006 14:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752619AbWLQNsu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 08:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbWLQNsu
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 08:48:50 -0500
Received: from mail.admingilde.org ([213.95.32.147]:33551 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752619AbWLQNsu (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 08:48:50 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GvwNk-0004WT-De; Sun, 17 Dec 2006 14:48:48 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Dec 17, 2006 at 02:01:09PM +0100, Jakub Narebski wrote:
> Well, in the .gitlink proposal you could specify GIT_DIR for checkout,
> or separately: GIT_OBJECT_DIRECTORY, GIT_INDEX_FILE, GIT_REFS_DIRECTORY
> (does not exist yet), GIT_HEAD_FILE (does not exist yet, and I suppose
> it wouldn't be easy to implement it). By the way, that's why I'm for
> .gitlink name for the file, not .git -- this way .gitlink can "shadow"
> what's in .git, for example specifying in a smart way where to search
> (where to find) object database, but HEAD and index would be stored
> together with the checked out directory in .git

What about .git/link or something?
(Obviously without the capability to change GIT_DIR)

> By the way, I'm rather partial to supermodule following HEAD in submodule,
> not specified branch. First, I think it is easier from implementation
> point of view: you don't have to remember which branch supermodule should
> take submodule commits from; and this cannot be fixed branch name like
> 'master'. For example 'maint' branch of supermodule could track 'maint'
> branch of submodule, 'master' branch of supermodule track 'master'
> branch of submodule, 'next' branch of supermodule tranck 'master' (!)
> branch of submodule, 'pu' branch of supermodule track 'next' (!) branch
> of submodule.=20

The version tracked by the supermodule is completely independent from
any branches you define in your submodule.
It is of course possible to use different versions of your submodule in
different branches of your supermodule.  But the supermodule does not
know the name of these branches.

In the setup you described a git-checkout in the supermodule would have
to switch to a different branch in the submodule, depending on the
branchname which would have to be stored in the supermodule.
This a lot more complex.

Your scenario can also be solved in this way:

	cd supermodule
	(cd sub && git-reset --hard origin/master)
	git add sub && git commit -m "track master of sub"
	git checkout next
	(cd sub && git-reset --hard origin/master)
	git add sub && git commit -m "track master of sub"
	git checkout pu
	(cd sub && git-reset --hard origin/next)
	git add sub && git commit -m "track next of sub"
	git checkout maint
	(cd sub && git-reset --hard origin/maint)
	git add sub && git commit -m "track maint of sub"

You only store a link to the commit of the current submodule version,
just like a normal ref.  The reference stored in the supermodule really
is equivalent to a normal ref, just that it is stored and updated
slightly different to a normal one.

So whenever you checkout a different version of the supermodule, the
submodule ref automatically gets the correct version.  In the example
above, when you checkout supermodules pu, your submodules branch will be
reset to its origin/next (to be more precise: to the commit which was at
the tip of origin/next at the time it was stored in the supermodule).

The fact that the reference to the current submodule commit does not
only exist in the supermodule tree but also as a physical ref in the
submodule is very similiar to normal files: you have one version stored
in the object database, one in the index and one as a real file in the
working directory (and this working file is the equivalent of the
submodule ref which is stored in submodule/.git/refs/whatever)

The reference in the submodule is just a way to be able to work on
the submodule.  Because well, refs are the kind of thing that is changed
by a commit.  And these submodule commits are exactly the kind of work
you want to store in the supermodule.  So the equivalent to a working
file is not the HEAD of the submodule, but the ref which gets all
changes which are intended for the supermodule.

The fact that the submodule repository still supports other branches has
nothing to do with submodule support.  These branches are totally
independent from the supermodule.

> Second, if you want to do some independent work on the module not related
> to work on submodule you should really clone (clone -l -s) submodule
> and work in separate checkout;

Yes.
But I really like the possibility to switch one module to a branch which
is not tracked by the parent, because it perhaps contains some debugging
code which is needed to debug some other submodule.  You can't move it
out because you need the common build infrastructure but you don't want
to branch the entire toplevel project because you don't want your
debugging changes to ever become visible at that level.

So by switching to a different branch you can effectivly say: this is
temporary, not meant for the superproject.
If you change your mind later you can always merge the submodule branch
back to master.

> the complaint that with tracking HEAD you can check-in wrong version
> of submodule to supermodule commit doesn't hold, because you still
> would have problem that _tree_ of supermodule would have wrong version
> of submodule.

Sorry, I don't understand you here.

> And moving to using single defined branch of submodule brings
> multitude of other problems: for example you might usually track
> 'master' version of submodule, but for a short time need to track
> 'next' branch because it has functionality you need; and another time
> you need to move to 'maint' branch or even your own branch because
> 'master' version breaks something in supermodule.

That is no problem.
The supermodule can track whatever _version_ it wants.  You can set
it to any version which is available in the repository, including all
those well known external branches.
But the supermodule itself does not know (and should not know) about
"maint" / "next" / whatever branch names in the submodule.

> Hmmm... I wonder how planned allowing to checking out tags, non-head
> branches (e.g. tracking/remote branches) and arbitrary commits but
> forbidding committing when HEAD is not a refs/heads/ branch would
> affect submodules / subprojects...

It only affects submodules if you really track HEAD directly.

--=20
Martin Waitz

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFhUrAj/Eaxd/oD7IRAiuJAJ9pEfM2CFzQzwP1QLUr/4OMOd0oCwCfZ5Xs
SRNejnVoBusAHAq43lng32o=
=59pj
-----END PGP SIGNATURE-----

