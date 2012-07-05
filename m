From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Thu, 05 Jul 2012 18:34:25 +0200
Message-ID: <1341506065.10752.19.camel@flaca.cmartin.tk>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
	 <20120705094213.GA29740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 05 18:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smp12-0000Ez-VR
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 18:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab2GEQe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 12:34:28 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:58828 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000Ab2GEQe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 12:34:27 -0400
Received: from [141.23.102.101] (unknown [141.23.102.101])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 9923446057;
	Thu,  5 Jul 2012 18:34:24 +0200 (CEST)
In-Reply-To: <20120705094213.GA29740@sigill.intra.peff.net>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201049>

On Thu, 2012-07-05 at 05:42 -0400, Jeff King wrote:
> On Thu, Jul 05, 2012 at 11:29:49AM +0200, Carlos Mart=C3=ADn Nieto wr=
ote:
>=20
> > The branch command assumes HEAD as the starting point if none is
> > specified. This causes --set-upstream to behave unexpectedly if the
> > user types
> >=20
> >     git branch --set-upstream origin/master
> >=20
> > git-branch will assume a second argument of HEAD and create config
> > entries for a local branch origin/master to track the current
> > branch. This is rarely, if ever, what the user wants to do.
> >=20
> > Catch invocations with --set-upstream and only one branch so the
> > command above sets up the current branch to track origin's master
> > branch.
>=20
> I have been tempted to write this patch several times but was afraid
> that somebody was relying on the existing behavior. I think the behav=
ior
> you propose is much saner.

Those two people who rely on the current behaviour will just have to
make a sacrifice for the good of the rest of the user community. I gues=
s
we could introduce it in steps by first warning, but I doubt it would b=
e
worth the effort.

>=20
> > +# The unsets at the end is to leave the master config as we found =
it,
> > +# so later tests don't get confused
> > +
> > +test_expect_success 'set upstream with implicit HEAD as branch to =
modify' \
> > +    'git config remote.local.url . &&
> > +     git config remote.local.fetch refs/heads/master:refs/remotes/=
local/master &&
> > +     (git show-ref -q refs/remotes/local/master || git fetch local=
) &&
> > +     git branch --set-upstream local/master &&
> > +     test $(git config branch.master.remote) =3D local &&
> > +     test $(git config branch.master.merge) =3D refs/heads/master
> > +     git config --unset branch.master.remote &&
> > +     git config --unset branch.master.merge
> > +'
>=20
> The unsets will not run if the test fails. Use test_when_finished to
> insert cleanup, or better yet use test_config which handles this case
> automagically (you are not setting them initially, but perhaps you
> should set them to some known value initially to make sure that your
> command changes them as expected).

Considering that the unset is there only because a later test does 'git
fetch' instead of specifying which remote we should fetch from, and thi=
s
setting confuses it (expecting to fetch from origin, but instead
fetching from local), I wonder if it wouldn't be better to simply make
the fetch explicit in line 712 so it reads 'git fetch origin'. This way
we can forget about undoing the configuration, because we're overriding
it anyway.
>=20
> I don't understand the point of the show-ref call, though. Isn't the
> fetch idempotent, and you can just run it always?

That is a good point. I just copied what the --track tests are doing a
few tests up. Looking at more tests, it seems to be what most do. Maybe
something like this:

---8<---

Subject: branch: make --set-upstream saner without an explicit
 starting point

The branch command assumes HEAD as the starting point if none is
specified. This causes --set-upstream to behave unexpectedly if the
user types

    git branch --set-upstream origin/master

git-branch will assume a second argument of HEAD and create config
entries for a local branch origin/master to track the current
branch. This is rarely, if ever, what the user wants to do.

Catch invocations with --set-upstream and only one branch so the
command above sets up the current branch to track origin's master
branch.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/branch.c  | 16 ++++++++++++++--
 t/t3200-branch.sh | 20 +++++++++++++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..6bbabda 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -853,10 +853,22 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 		else
 			usage_with_options(builtin_branch_usage, options);
 	} else if (argc > 0 && argc <=3D 2) {
+		const char *branch, *upstream;
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
-		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
-			      force_create, reflog, 0, quiet, track);
+
+		/* The usual way, make the branch point be HEAD of none is specified=
 */
+		branch =3D argv[0];
+		upstream =3D (argc =3D=3D 2) ? argv[1] : head;
+
+		/* If the command was 'git branch --set-upstream origin/master',
+		   make HEAD track origin/master, not the other way around */
+		if (track =3D=3D BRANCH_TRACK_OVERRIDE && argc =3D=3D 1) {
+			branch =3D head;
+			upstream =3D argv[0];
+		}
+
+		create_branch(head, branch, upstream, force_create, reflog, 0, quiet=
, track);
 	} else
 		usage_with_options(builtin_branch_usage, options);
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a17f8b2..1b0a73c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -369,6 +369,24 @@ test_expect_success \
     'git tag foobar &&
      test_must_fail git branch --track my11 foobar'
=20
+test_expect_success 'set upstream with both branches explicit' \
+    'git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/master:refs/remotes/loca=
l/master &&
+     git fetch local &&
+     git branch --no-track my12 &&
+     git branch --set-upstream my12 local/master &&
+     test $(git config branch.my12.remote) =3D local &&
+     test $(git config branch.my12.merge) =3D refs/heads/master'
+
+test_expect_success 'set upstream with implicit HEAD as branch to modi=
fy' \
+    'git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/master:refs/remotes/loca=
l/master &&
+     git fetch local &&
+     git branch --set-upstream local/master &&
+     test $(git config branch.master.remote) =3D local &&
+     test $(git config branch.master.merge) =3D refs/heads/master
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from master
@@ -686,7 +704,7 @@ test_expect_success 'use set-upstream on the curren=
t branch' '
 	git --bare init myupstream.git &&
 	git push myupstream.git master:refs/heads/frotz &&
 	git remote add origin myupstream.git &&
-	git fetch &&
+	git fetch origin &&
 	git branch --set-upstream master origin/frotz &&
=20
 	test "z$(git config branch.master.remote)" =3D "zorigin" &&
--=20
1.7.11.1.104.ge7b44f1
