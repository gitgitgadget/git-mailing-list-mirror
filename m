From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] git-subtree: Add prune mode
Date: Sun,  1 Aug 2010 11:25:56 +0200
Message-ID: <1280654756-9039-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 11:26:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfUoA-0000xu-T1
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 11:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab0HAJ0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 05:26:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59713 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab0HAJ0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 05:26:06 -0400
Received: by wyb39 with SMTP id 39so2412803wyb.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 02:26:03 -0700 (PDT)
Received: by 10.216.180.200 with SMTP id j50mr1484540wem.36.1280654762982;
        Sun, 01 Aug 2010 02:26:02 -0700 (PDT)
Received: from localhost.localdomain (149.194.19.95.dynamic.jazztel.es [95.19.194.149])
        by mx.google.com with ESMTPS id w29sm2119395weq.18.2010.08.01.02.26.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Aug 2010 02:26:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.765.gb5868
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152373>

Add prune mode (flag --prune) with the following properties:

* The history must be as clean as possible
* The directory content must be equal to the external module,
  at least when you add/update it[b]
* The subproject should be able to switch back and forth between
  different versions.

[b] A consequence of this is that it loses all changes
    made in the subtree. If they are important you have to extract
    them, apply them and add the subproject back.

As all the history is lost and you never merge commits
'split' is not necessary, but it is basically:

$ git filter-branch --subdirectory-filter $prefix

And normally you will just want to extract the changes with format-patc=
h
and apply them with:

git am -p2

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Hi *,

   here it is a the same patch I send some days before but with documen=
tation.

Santi

 git-subtree.sh  |   29 +++++++++++++++++++++++++++--
 git-subtree.txt |   21 ++++++++++++++++++++-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/git-subtree.sh b/git-subtree.sh
index 781eef3..766b68b 100755
--- a/git-subtree.sh
+++ b/git-subtree.sh
@@ -27,6 +27,7 @@ onto=3D         try connecting new tree to an existin=
g one
 rejoin        merge the new branch back into HEAD
  options for 'add', 'merge', 'pull' and 'push'
 squash        merge subtree changes as a single commit
+prune         prune history
 "
 eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo ex=
it $?)
=20
@@ -44,6 +45,7 @@ rejoin=3D
 ignore_joins=3D
 annotate=3D
 squash=3D
+prune=3D
 message=3D
=20
 debug()
@@ -92,6 +94,8 @@ while [ $# -gt 0 ]; do
 		--no-ignore-joins) ignore_joins=3D ;;
 		--squash) squash=3D1 ;;
 		--no-squash) squash=3D ;;
+		--prune) prune=3D1;;
+		--no-prune) prune=3D;;
 		--) break ;;
 		*) die "Unexpected option: $opt" ;;
 	esac
@@ -110,12 +114,16 @@ if [ -z "$prefix" ]; then
 fi
=20
 case "$command" in
-	add) [ -e "$prefix" ] &&=20
+	add) [ -e "$prefix" -a -z "$prune" ] &&
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] ||=20
 		die "'$prefix' does not exist; use 'git subtree add'" ;;
 esac
=20
+if [ -n "$squash" -a -n "$prune" ] ; then
+	die "Flags --prune and --squash are incompatible"
+fi
+
 dir=3D"$(dirname "$prefix/.")"
=20
 if [ "$command" !=3D "pull" -a "$command" !=3D "add" -a "$command" !=3D=
 "push" ]; then
@@ -359,6 +367,17 @@ squash_msg()
 	echo "git-subtree-split: $newsub"
 }
=20
+prune_msg()
+{
+	dir=3D"$1"
+	newsub=3D"$2"
+=09
+	git show -s --pretty=3D"tformat:Subtree '$dir/': %h %s" $newsub
+	echo
+	echo "git-subtree-dir: $dir"
+	echo "git-subtree-split: $newsub"
+}
+
 toptree_for_commit()
 {
 	commit=3D"$1"
@@ -464,7 +483,7 @@ ensure_clean()
=20
 cmd_add()
 {
-	if [ -e "$dir" ]; then
+	if [ -e "$dir" -a -z "$prune" ]; then
 		die "'$dir' already exists.  Cannot add."
 	fi
=20
@@ -498,6 +517,9 @@ cmd_add_commit()
 	rev=3D"$1"
 =09
 	debug "Adding $dir as '$rev'..."
+	if [ -d "$dir" ]; then
+	    git rm -r -q $dir
+	fi
 	git read-tree --prefix=3D"$dir" $rev || exit $?
 	git checkout -- "$dir" || exit $?
 	tree=3D$(git write-tree) || exit $?
@@ -513,6 +535,9 @@ cmd_add_commit()
 		rev=3D$(new_squash_commit "" "" "$rev") || exit $?
 		commit=3D$(add_squashed_msg "$rev" "$dir" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
+	elif [ -n "$prune" ]; then
+		commit=3D$(prune_msg "$dir" "$rev" |
+			 git commit-tree $tree -p $headrev) || exit $?
 	else
 		commit=3D$(add_msg "$dir" "$headrev" "$rev" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
diff --git a/git-subtree.txt b/git-subtree.txt
index dbcba31..5a91147 100644
--- a/git-subtree.txt
+++ b/git-subtree.txt
@@ -66,7 +66,8 @@ add::
 	A new commit is created	automatically, joining the imported
 	project's history with your own.  With '--squash', imports
 	only a single commit from the subproject, rather than its
-	entire history.
+	entire history. With '--prune', imports only the contents of
+	the commit from the subproject without any history.
=20
 merge::
 	Merge recent changes up to <commit> into the <prefix>
@@ -165,6 +166,24 @@ OPTIONS FOR add, merge, AND pull
 	local repository remain intact and can be later split
 	and send upstream to the subproject.
=20
+--prune::
+	Instead of merging the history (full or squashed) from the
+	subtree project, produce only a single commit that
+	reproduce the exact content in the preffix as in the
+	subtree.
+
+	It has similar features as the --squash option, namely
+	reduces the clutter (althougth --prune reduce it even
+	more), helps avoiding problems when the same subproject is
+	include multiple time and can switch back and forth
+	between different version of a subtree.
+
+	The main difference is that with --prune the content of
+	the prefix always matches the content of the subproject,
+	while with --squash it merges you changes with the changes
+	from the subtree. If you want to keep your changes you
+	have to extract them, apply them in the external
+	repository and add the subproject back.
=20
 OPTIONS FOR split
 -----------------
--=20
1.7.1.765.gb5868
