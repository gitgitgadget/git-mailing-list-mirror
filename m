X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 22:51:16 +0100
Message-ID: <20061120215116.GA20736@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
NNTP-Posting-Date: Mon, 20 Nov 2006 21:52:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31941>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmH2v-0003ch-N4 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 22:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966353AbWKTVvS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966723AbWKTVvS
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 16:51:18 -0500
Received: from agent.admingilde.org ([213.95.21.5]:31113 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S966353AbWKTVvR (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 16:51:17 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmH2q-00033S-IC for git@vger.kernel.org; Mon, 20 Nov 2006 22:51:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am currently working on adding submodule support to GIT.
Here I am presenting some prototyping work to show how submodules could
be implemented in GIT.


What is a submodule
-------------------

A submodule in a GIT repository which is managed by another higher-layer
parent repository.  Both the submodule and the parent repository can be
used as a normal GIT repository but there are links between them.  That
means that you can merge, push and pull both on the parent and on
individual submodule level.

The parent repository is special in that it does not only hold individual
files but also complete submodule trees, complete with their own history.
The history of the parent and the submodule are independent, but each
version of the parent is linked to exactly one version of the submodule.

The submodule is special in that it has one special branch which is tracked
by the parent.  Each time something is commited to this branch, this
automatically changes the parent, just like modifying normal files.  Each
time the parent gets updated, this submodule branch gets updated
automatically.

As a submodule has all the properties of a normal GIT repository,
it can also contain submodules itself.


Previous submodule proposal
---------------------------

My first experiment in implementing submodules was a very simple one: Store
the submodule refs in the working directory of the parent repository and
include them in the version control.

This way the most important properties of submodules are easily to obtain.
Each version of the parent stores the exact version of all submodules and
with the help of some shell scripts it is easily possible to update the
submodule when there are updates to the parent repository.


However, this easy approach has several drawbacks.  The most important one
is that the GIT core does not know about submodules, they are only built on
top of them.  For this reason it is difficult to support fsck-objects and
prune in such a setup.

In order to permanently keep all previous stages of the parent, there is
the need to also keep all versions of the submodules which have been linked
to the parent.  All operations which have to walk the entire object database
have to know all possible references of the submodule.  This is easy if the
submodule is only fast-forwarded, without switching branches and without
removing the submodule.  Under these conditions it is enough to walk the
current reference of the submodule which is stored in its parent.  But if
there are past versions of the submodule which are not reachable by the
current submodule commit then it is difficult to keep them in the database
when the submodule is handled by a standard GIT core.  This could only be
solved by creating fake references for all possible versions of the
submodule.


New approach
------------

In order to make the GIT core know about all possible versions of the
submodule it is not enough to store one reference in the parent working
directory.  The GIT core has to be changed so that it knows about all
submodule references while traversing the parent repository.  This means
that both the submodule and the parent repository have to use the same
object database.  (I already did this for my first experiment, but it was
not really neccessary at that time.)

A submodule really is part of the parent tree, so it is very natural to
add the link to the submodule commit into the GIT tree data structure.
In addition to links to blobs and other trees, they can now also hold
a link to a commit, which in turn has the pointers to the submodule tree
and its history.  In order to differenciate a submodule entry with
normal file or directory entries, they get a special file mode.

Directly including the submodules in the object database allows the
traversal of the entire repository, together with the parent and all
submodules.  In this way it is possible to support fsck-objects and prune
when they are executed in the parent repository.  However, submodules can
contain branches which are independent from the one stored in the parent.
So all references and the working directory index of the submodules have
to be made available to the parent, too.

When a parent containing submodules is checked out, the submodul entry is
stored in the index, just like it is done for all normal files.  But instead
of writing one file to the working directory, a complete GIT repository is
created (with the object database linked to the parent one).  This submodule
gets a reference "refs/heads/module" from the parent's index entry.
The index entry in the parent can be updated with update-index just
like other entries.

When a merge in the parent has to resolve changes in the submodule,
then it does exactly the same as for files: at first it is tried to resolve
it in the index and if this is not possible it will have store stages 1-3
in the index and tries a content merge.  The only difference with submodules
is that the content merge is not possible with a simple diff3 call, but
that the GIT merge machinery has to recurse into the submodule.


Implementation
--------------

Obviously, all the tree traversal routines have to be modified to recognize
a submodule and to correctly traverse it.  The submodule entry gets
a special S_IFSOCK file mode to distinguish it from other entries.
This special file mode is used for both the tree entries in the object
database and for the index entries of the submodule in the parent index.

Some basic low-level commands now (more or less) cope with submodules.
Merging of submodules has not yet been implemented.

The current status can be viewed in
http://git.admingilde.org/tali/git.git/module2
(on top of next)

The code now passes the small test-script so at least a little bit of
it must be working ;-).  Please feel free to give it a try and complain
that it does not work the way you expect it.


What's next?
------------

The most important next step is to commit to some object database format
for submodules.  So please, do give feedback about the proposed changes
to the tree object.

The second most important step is to make it possible to merge submodules.

After that, for sure there are enough bugs to fix to keep me busy for some
time... ;-)

--=20
Martin Waitz

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYiNUj/Eaxd/oD7IRAjAWAJ96BhOyvIqU3yVyKmvpgzzH3IBk7wCeMyMI
3PVvTh/cLebe5VSW2TQAze8=
=1jAc
-----END PGP SIGNATURE-----

