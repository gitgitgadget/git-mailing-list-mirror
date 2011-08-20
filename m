From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v3 0/4] git-p4: Improve branch support
Date: Sat, 20 Aug 2011 15:14:07 -0400
Message-ID: <20110820191407.GD7135@arf.padd.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
 <20110819115310.GC15639@padd.com>
 <CAOpHH-WeLWyEZaktYRzVN+dfgqu3==o4bgrfzpvS-QUCQboPgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 21:14:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quqzq-0002cz-OV
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1HTTOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 15:14:14 -0400
Received: from honk.padd.com ([74.3.171.149]:38363 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754718Ab1HTTON (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:14:13 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 3A4252C27;
	Sat, 20 Aug 2011 12:14:12 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 96E6331447; Sat, 20 Aug 2011 15:14:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAOpHH-WeLWyEZaktYRzVN+dfgqu3==o4bgrfzpvS-QUCQboPgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179779>

vitor.hda@gmail.com wrote on Fri, 19 Aug 2011 15:30 +0100:
> On Fri, Aug 19, 2011 at 12:53 PM, Pete Wyckoff <pw@padd.com> wrote:
> > Patches 1 and 2 are great. =A0We should have gotten those in way
> > back when you first submitted them. =A0I happily ack those.
> >
> > I'm still a bit hung up on #3, mainly because I don't get branch
> > support. =A0Let me play around with your test. =A0Having this
> > playbook of how it is supposed to work will help to educate me.
>=20
> (I am probably going in too much detail here. Please skip any
> redundant information.)
>=20
> In general, you can see branches in P4 as you do in SVN. They are
> simple copies from one directory to another. For example:
>=20
>     p4 integrate //depot/big/directory/path/myproj/version_A \
>                  //depot/big/directory/path/myproj/version_B
>=20
> Now the history of "version_B" is tied to "version_A". If you want to
> integrate (merge, in this case) new updates from one of the
> directories to the other you can just rerun the above command
> (version_A and version_B order may change depending on the direction
> of the merge).
>=20
> P4 also allows you to define "branch specs" that you can use as a
> short hand instead of having to type in the full directory paths. So,
> assuming that you have a branch named "myproj_B" with the following
> view defined:
>=20
>     //depot/big/directory/path/myproj/version_A \
>         //depot/big/directory/path/myproj/version_B
>=20
> When you want to integrate it again you can simply type:
>=20
>     p4 integrate -b myproj_B
>=20
> or, if you want to integrate from version_B into version_A instead:
>=20
>     p4 integrate -b myproj_B -r
>=20
> git-p4 is using these branch specs to identify branches. Without this
> extra information it is nearly impossible for it to identify branches
> because an integrate can be done of a single file.
>=20
> But since P4 does not strictly require branch specs and because most
> of the time integrations are done through P4V, then most of the time
> no branch specs are created. Now, if this happens git-p4 will not be
> able to detect branches! And creating branches in P4 just for git-p4
> does not make much sense, right? This is the main reason behind the
> third patch... :)

Thank you for these useful comments.  I have taken a first stab
at documenting the bevy of confusing branch flags and settings
in git-p4.  Please correct my errors and add other information
that is missing.

In particular, a clear case of how to set up the branches for
the branchList example would be good.  My minimal test did not
exactly work.


		-- Pete

--------------8<----------------------

=46rom 36608a6e195041e8738bab24b84fadd0bf386865 Mon Sep 17 00:00:00 200=
1
=46rom: Pete Wyckoff <pw@padd.com>
Date: Sat, 20 Aug 2011 15:04:09 -0400
Subject: [PATCH 4/4] git-p4: branch detection documentation start

Initial stab at documentation for --detect-branches and the
new branchList config setting.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4.txt |   48 ++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p=
4.txt
index 52003ae..6d21557 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -265,11 +265,57 @@ Only use branch specifications defined by the sel=
ected username.
=20
 git-p4.branchList
=20
-List of branches to be imported when branch detection is enabled.
+List of branches to be imported when branch detection is enabled.  Thi=
s
+example shows that branchA and branchB are both created off branch mai=
n.
=20
   git config [--global] git-p4.branchList main:branchA
   git config [--global] --add git-p4.branchList main:branchB
=20
+Branch Detection
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+There are a few options that try to automatically create branches in g=
it
+corresponding to branches in p4.
+
+Unfortunately, the concept of branch in p4 is quite different:  a p4
+branch is a mapping from one area of the repository to another.  It is
+used as input to "p4 integrate" to specify the source and destination =
of
+an integration.
+
+If you have a repository where all the branches are below a single
+directory, you can use "--detect-branches" when cloning or syncing to
+have git-p4 automatically look up the p4 branches and use these to
+generate branches in git.  Example:
+
+    P4 repository structure:
+
+	//depot/main/...
+	//depot/branch1/...
+   =20
+    View section from "p4 branch -o branch1"
+
+	//depot/main/... //depot/branch1/...
+   =20
+    Git clone command:
+
+	git-p4 clone --detect-branches //depot@all
+
+    Produces a separate branch in remotes/p4 for
+    //depot/main (called "master"), and one for //depot/branch1
+    (called "depot/branch1").
+
+However, it is not necessary to create branches in p4 to be able to
+use them like branches.  It is quite difficult to detect this
+automatically, but a git configuration setting "git-p4.branchList" can=
 be
+used to explicitly identify branch relationships.  It is a list of
+"source":"destination" pairs, like a simple p4 branch specification,
+where the "source" and "destination" are the path elements in the
+p4 repository.  The example above relied on the presence of the p4
+branch.  Without that, you can get the same results by setting:
+
+  git config git-p4.branchList main:branch1
+
+
 Implementation Details...
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
--=20
1.7.5.4
