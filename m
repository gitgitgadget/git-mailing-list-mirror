From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and  --prune-empty.
Date: Mon, 03 Nov 2008 16:18:26 +0100
Message-ID: <20081103151826.GJ13930@artemis.corp>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <7viqr5wgl7.fsf@gitster.siamese.dyndns.org> <20081103092729.GE13930@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="xQR6quUbZ63TTuTU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, pasky@suse.cz, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 16:20:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx1Du-0003TY-IR
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 16:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbYKCPSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 10:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYKCPSc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 10:18:32 -0500
Received: from pan.madism.org ([88.191.52.104]:45328 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbYKCPSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 10:18:31 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1A3AA3BC85;
	Mon,  3 Nov 2008 16:18:27 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CB6B755AC1C; Mon,  3 Nov 2008 16:18:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081103092729.GE13930@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99952>


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2008 at 09:27:29AM +0000, Pierre Habouzit wrote:
> On Mon, Nov 03, 2008 at 04:58:44AM +0000, Junio C Hamano wrote:
> > > diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> > > index b0a9d7d..352b56b 100755
> > > --- a/t/t7003-filter-branch.sh
> > > +++ b/t/t7003-filter-branch.sh
> > > @@ -262,4 +262,12 @@ test_expect_success 'Tag name filtering allows s=
lashes in tag names' '
> > >  	test_cmp expect actual
> > >  '
> > > =20
> > > +test_expect_success 'Prune empty commits' '
> > > +	make_commit to_remove &&
> > > +	(git rev-list HEAD | grep -v $(git rev-parse HEAD)) > expect &&
> >=20
> > I am not sure what this one is doing.
> >=20
> >  - Isn't this the same as "git rev-list HEAD^"?
> >  - Do you need a subshell?
>=20
> The filter-branch is supposed to prune the last commit done (current
> HEAD) from the revision list. So I build the rev-list we're supposed to
> have in the end, and remove the matching ref from it. I don't see how to
> avoid the subshell though, but if someone knows better please do :)

Actually one can write the test this way:

test_expect_success 'Prune empty commits' '
       git rev-list HEAD > expect &&
       make_commit to_remove &&
       git filter-branch -f --index-filter "git update-index --remove to_re=
move" --prune-empty HEAD &&
       git rev-list HEAD > actual &&
       test_cmp expect actual
'

Which basically:
  - remembers the current list of revisions,
  - makes a commit,
  - runs an index-filter that makes that last commit void,
  - checks the last commit has been removed.

below is the updated patch with your comment and this fix
---8<---
=46rom: Pierre Habouzit <madcoder@debian.org>
Date: Fri, 31 Oct 2008 10:12:21 +0100
Subject: [PATCH] filter-branch: add git_commit_non_empty_tree and --prune-e=
mpty.

git_commit_non_empty_tree is added to the functions that can be run from
commit filters. Its effect is to commit only commits actually touching the
tree and that are not merge points either.

The option --prune-empty is added. It defaults the commit-filter to
'git_commit_non_empty_tree "$@"', and can be used with any other
combination of filters, except --commit-hook that must used
'git_commit_non_empty_tree "$@"' where one puts 'git commit-tree "$@"'
usually to achieve the same result.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-filter-branch.txt |   14 ++++++++++++++
 git-filter-branch.sh                |   29 ++++++++++++++++++++++++++++-
 t/t7003-filter-branch.sh            |    8 ++++++++
 3 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter=
-branch.txt
index fed6de6..451950b 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -122,6 +122,10 @@ You can use the 'map' convenience function in this fil=
ter, and other
 convenience functions, too.  For example, calling 'skip_commit "$@"'
 will leave out the current commit (but not its changes! If you want
 that, use 'git-rebase' instead).
++
+You can also use the 'git_commit_non_empty_tree "$@"' instead of
+'git commit-tree "$@"' if you don't wish to keep commits with a single par=
ent
+and that makes no change to the tree.
=20
 --tag-name-filter <command>::
 	This is the filter for rewriting tag names. When passed,
@@ -151,6 +155,16 @@ to other tags will be rewritten to point to the underl=
ying commit.
 	The result will contain that directory (and only that) as its
 	project root.
=20
+--prune-empty::
+	Some kind of filters will generate empty commits, that left the tree
+	untouched.  This switch allow git-filter-branch to ignore such
+	commits.  Though, this switch only applies for commits that have one
+	and only one parent, it will hence keep merges points. Also, this
+	option is not compatible with the use of '--commit-filter'. Though you
+	just need to use the function 'git_commit_non_empty_tree "$@"' instead
+	of the 'git commit-tree "$@"' idiom in your commit filter to make that
+	happen.
+
 --original <namespace>::
 	Use this option to set the namespace where the original commits
 	will be stored. The default value is 'refs/original'.
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 81392ad..331724d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -40,6 +40,16 @@ skip_commit()
 	done;
 }
=20
+# if you run 'git_commit_non_empty_tree "$@"' in a commit filter,
+# it will skip commits that leave the tree untouched, commit the other.
+git_commit_non_empty_tree()
+{
+	if test $# =3D 3 && test "$1" =3D $(git rev-parse "$3^{tree}"); then
+		map "$3"
+	else
+		git commit-tree "$@"
+	fi
+}
 # override die(): this version puts in an extra line break, so that
 # the progress is still visible
=20
@@ -109,11 +119,12 @@ filter_tree=3D
 filter_index=3D
 filter_parent=3D
 filter_msg=3Dcat
-filter_commit=3D'git commit-tree "$@"'
+filter_commit=3D
 filter_tag_name=3D
 filter_subdir=3D
 orig_namespace=3Drefs/original/
 force=3D
+prune_empty=3D
 while :
 do
 	case "$1" in
@@ -126,6 +137,11 @@ do
 		force=3Dt
 		continue
 		;;
+	--prune-empty)
+		shift
+		prune_empty=3Dt
+		continue
+		;;
 	-*)
 		;;
 	*)
@@ -176,6 +192,17 @@ do
 	esac
 done
=20
+case "$prune_empty,$filter_commit" in
+,)
+	filter_commit=3D'git commit-tree "$@"';;
+t,)
+	filter_commit=3D"$functions;"' git_commit_non_empty_tree "$@"';;
+,*)
+	;;
+*)
+	die "Cannot set --prune-empty and --filter-commit at the same time"
+esac
+
 case "$force" in
 t)
 	rm -rf "$tempdir"
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index b0a9d7d..8537bf9 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -262,4 +262,12 @@ test_expect_success 'Tag name filtering allows slashes=
 in tag names' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'Prune empty commits' '
+	git rev-list HEAD > expect &&
+	make_commit to_remove &&
+	git filter-branch -f --index-filter "git update-index --remove to_remove"=
 --prune-empty HEAD &&
+	git rev-list HEAD > actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.6.0.3.795.g892be


--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkPFkIACgkQvGr7W6HudhwVHACdGykOdIq0ooAZqiXBS0wDflBx
zI0AniaaOzMihJMJ8PWvyAYXo0VPIYE4
=PMcH
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
