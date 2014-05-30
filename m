From: Keval Patel <patel.keval88@gmail.com>
Subject: [PATCH 1/2] contrib/subtree: Store subtree metadata in .gittrees file
Date: Fri, 30 May 2014 13:45:14 -0400
Message-ID: <1401471915-47195-1-git-send-email-kapatel@lutron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Keval Patel <patel.keval88@gmail.com>,
	Keval Patel <kapatel@lutron.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 30 19:45:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQs3-0007AZ-Le
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbaE3Rpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2014 13:45:32 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:38276 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaE3Rpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:45:31 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so6210224qgd.37
        for <git@vger.kernel.org>; Fri, 30 May 2014 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=2T7BkuZltx502KP80KOor1An8XvRiInvQnyVQonz7HU=;
        b=Cvc/EUZ2JKhO1leg2M4PsHJ1WQFybeH04RfUMcuNT82SHDuQHVtLvPrqD1pLB8jc54
         4cwhUtxcYeCIKIz0ae6s3y195c/b7PLsHpLzEKixORIWXCc3z0W5hli4LyDgaFLn/Mo1
         OcR+Q0oxL1Vybc1BDN0mpBrsAj6WLWBfT+K3rlMzlyqAyuDIlKehfwUSaK6XjYTpfn66
         RLmQuS1ZRF2oBhNBjT5dPtnhWRZDArwPbsRHyW59TAkuF5yPZeKW7kC5+meXMbRnwdpG
         38rtazyX+OdM82aTaKfMkT2/QHt0V9sYPxXDgTetqmzaDyo7KTLLeAHzqaO4crbzQKzq
         8K2g==
X-Received: by 10.224.130.196 with SMTP id u4mr23986988qas.13.1401471930114;
        Fri, 30 May 2014 10:45:30 -0700 (PDT)
Received: from dangoudesiphone.intra.lutron.com.com (lutron48.lutron.com. [8.14.172.48])
        by mx.google.com with ESMTPSA id 6sm7186512qam.44.2014.05.30.10.45.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 10:45:29 -0700 (PDT)
X-Google-Original-From: Keval Patel <kapatel@lutron.com>
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250453>

- Most of the changes are taken from helmo=E2=80=99s repository from fo=
llowing
URL:
https://github.com/helmo/git-subtree/blob/master/git-subtree.sh
- Add code to create a file named .gittrees which can store information
on the subtree that is getting merged to the super-repository. The
advantage is =E2=80=98subtree push=E2=80=99 and =E2=80=98subtree pull=E2=
=80=99 subcommands can be
called with only the =E2=80=94prefix option and no need to provide remo=
te url
- Add tests for new feature additions. All existing and new tests pass
successfully
=46iles changed in this commit:
1. git/contrib/subtree/git-subtree.sh
2. git/contrib/subtree/t/t7900-subtree.sh

Signed-off-by: Keval Patel <kapatel@lutron.com>
---
A selection of updates to git-subtree were offered to the list by coupl=
e of people
($gmane/196667) by Herman van Rink and ($gmane/217820) by Paul Campbell
=46or various reasons the work stalled and I would like to pick it up f=
rom there

The following patches take a selection of these commits and rebase them=
=20
against the tip of master.
The make test works and I have added more tests to cover the new comman=
ds and=20
use of .gittrees file for storing the subtree metadata

Thanks-to and Based-on-patch-by:
- Herman van Rink
- Matt Hoffman
- Michael Hart
- Nate Jones
- Paul Campbell
- Paul Cartwright
- Peter Jaros
- bibendi

 contrib/subtree/git-subtree.sh     |   98 +++++++++++++++++++++-------=
-----
 contrib/subtree/t/t7900-subtree.sh |  106 ++++++++++++++++++++++++++++=
++++++++
 2 files changed, 168 insertions(+), 36 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtr=
ee.sh
index db925ca..7d01b4b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -8,8 +8,7 @@ if [ $# -eq 0 ]; then
     set -- -h
 fi
 OPTS_SPEC=3D"\
-git subtree add   --prefix=3D<prefix> <commit>
-git subtree add   --prefix=3D<prefix> <repository> <ref>
+git subtree add   --prefix=3D<prefix> <repository> <refspec>
 git subtree merge --prefix=3D<prefix> <commit>
 git subtree pull  --prefix=3D<prefix> <repository> <ref>
 git subtree push  --prefix=3D<prefix> <repository> <ref>
@@ -490,12 +489,6 @@ ensure_clean()
 	fi
 }
=20
-ensure_valid_ref_format()
-{
-	git check-ref-format "refs/heads/$1" ||
-	    die "'$1' does not look like a ref"
-}
-
 cmd_add()
 {
 	if [ -e "$dir" ]; then
@@ -505,22 +498,12 @@ cmd_add()
 	ensure_clean
 =09
 	if [ $# -eq 1 ]; then
-	    git rev-parse -q --verify "$1^{commit}" >/dev/null ||
-	    die "'$1' does not refer to a commit"
-
-	    "cmd_add_commit" "$@"
+		"cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
-	    # Technically we could accept a refspec here but we're
-	    # just going to turn around and add FETCH_HEAD under the
-	    # specified directory.  Allowing a refspec might be
-	    # misleading because we won't do anything with any other
-	    # branches fetched via the refspec.
-	    ensure_valid_ref_format "$2"
-
-	    "cmd_add_repository" "$@"
+		"cmd_add_repository" "$@"
 	else
-	    say "error: parameters were '$@'"
-	    die "Provide either a commit or a repository and commit."
+		say "error: parameters were '$@'"
+		die "Provide either a refspec or a repository and refspec."
 	fi
 }
=20
@@ -533,6 +516,24 @@ cmd_add_repository()
 	revs=3DFETCH_HEAD
 	set -- $revs
 	cmd_add_commit "$@"
+=09
+	revs=3D$(git rev-parse $default --revs-only "$@") || exit $?
+	set -- $revs
+	rev=3D"$1"
+=09
+	subtree_mainline_merge=3D$(git rev-parse HEAD) || exit $?
+=09
+	# now add it to our list of repos=20
+	git config -f .gittrees --unset subtree.$dir.url
+	git config -f .gittrees --add subtree.$dir.url $repository
+	git config -f .gittrees --unset subtree.$dir.path
+	git config -f .gittrees --add subtree.$dir.path $dir
+	git config -f .gittrees --unset subtree.$dir.branch
+	git config -f .gittrees --add subtree.$dir.branch $refspec
+	git config -f .gittrees --unset subtree.$dir.subtreeCommit
+	git config -f .gittrees --add subtree.$dir.subtreeCommit $rev
+	git config -f .gittrees --unset subtree.$dir.subtreeMergeCommit
+	git config -f .gittrees --add subtree.$dir.subtreeMergeCommit $subtre=
e_mainline_merge
 }
=20
 cmd_add_commit()
@@ -598,7 +599,7 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=3D$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		say -n "$revcount/$revmax ($createcount)"
 		debug "Processing commit: $rev"
 		exists=3D$(cache_get $rev)
 		if [ -n "$exists" ]; then
@@ -705,31 +706,56 @@ cmd_merge()
=20
 cmd_pull()
 {
-	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <ref>"
+	if [ $# -gt 2 ]; then
+		die "You should provide either <refspec> or <repository> <refspec>"
 	fi
+	if [ -e "$dir" ]; then
 	ensure_clean
-	ensure_valid_ref_format "$2"
-	git fetch "$@" || exit $?
+		if [ $# -eq 1 ]; then=20
+			repository=3D$(git config -f .gittrees subtree.$prefix.url)
+			refspec=3D$1
+		elif [ $# -eq 2 ]; then=20
+			repository=3D$1
+			refspec=3D$2
+		else=20
+			repository=3D$(git config -f .gittrees subtree.$prefix.url)
+			refspec=3D$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+		git fetch $repository $refspec || exit $?
+		echo "git fetch using: " $repository $refspec
 	revs=3DFETCH_HEAD
 	set -- $revs
 	cmd_merge "$@"
+	else
+		die "'$dir' must already exist. Try 'git subtree add'."
+	fi
 }
=20
 cmd_push()
 {
-	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <ref>"
+	if [ $# -gt 2 ]; then
+		die "You should provide either <refspec> or <repository> <refspec>"
 	fi
-	ensure_valid_ref_format "$2"
 	if [ -e "$dir" ]; then
-	    repository=3D$1
-	    refspec=3D$2
-	    echo "git push using: " $repository $refspec
-	    localrev=3D$(git subtree split --prefix=3D"$prefix") || die
-	    git push $repository $localrev:refs/heads/$refspec
+		if [ $# -eq 1 ]; then=20
+			repository=3D$(git config -f .gittrees subtree.$prefix.url)
+			refspec=3D$1
+		elif [ $# -eq 2 ]; then=20
+		repository=3D$1
+		refspec=3D$2
+		else
+			repository=3D$(git config -f .gittrees subtree.$prefix.url)
+			refspec=3D$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+		echo "git push using: " $repository $refspec
+		rev=3D$(git subtree split --prefix=3D$prefix)
+		if [ -n "$rev" ]; then
+			git push $repository $rev:refs/heads/$refspec
+		else
+			die "Couldn't push, 'git subtree split' failed."
+		fi
 	else
-	    die "'$dir' must already exist. Try 'git subtree add'."
+		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
 }
=20
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t79=
00-subtree.sh
index 66ce4b0..05110f7 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -60,6 +60,11 @@ last_commit_message()
 	git log --pretty=3Dformat:%s -1
 }
=20
+last_commit_id()
+{
+    git log --format=3D"%H" -n 1
+}
+
 test_expect_success 'init subproj' '
         test_create_repo subproj
 '
@@ -464,5 +469,106 @@ test_expect_success 'verify one file change per c=
ommit' '
 	        check_equal "$x" 1
         ))
 '
+# Tests for subtree add which creates .gittrees for storing metadata
+
+# Back to mainline and create new directory for testing
+cd ../..
+
+mkdir test_sub
+cd test_sub
+
+mkdir shared_projects
+# To shared_projects!
+cd shared_projects
+
+# Create couple of Git repos in shared_projects folder which can be
+# added as subtrees to our parent projects
+test_expect_success 'add subtree1' '
+        test_create_repo subtree1 &&
+        cd subtree1 &&
+        create sub1_file1 &&
+        git commit -m "Initial subtree1 commit"
+'
+
+# Store the latest commit value for future use
+expected_subtreeCommit=3D`echo $(last_commit_id)`
+expected_branch=3D`echo $(git rev-parse --abbrev-ref HEAD)`
+
+# Back to shared_projects
+cd ..
+
+test_expect_success 'add subtree2' '
+        test_create_repo subtree2 &&
+        cd subtree2 &&
+        create sub2_file1 &&
+        git commit -m "Initial subtree2 commit"
+'
+
+# Back to test_sub
+cd ../..
+
+# Create test parent repos that will add subtrees to itself
+test_expect_success 'add parent1' '
+        test_create_repo parent1 &&
+        cd parent1 &&
+        create parent1_file1 &&
+        git commit -m "Initial parent1 commit"
+'
+
+# Back to test_sub from parent1
+cd ..
+
+test_expect_success 'add parent2' '
+        test_create_repo parent2 &&
+        cd parent2 &&
+        create parent2_file1 &&
+        git commit -m "Initial parent2 commit"
+'
+
+
+# To parent1 now. Start the tests
+cd ../parent1
+
+# .gittrees file creation tests
+test_expect_success 'check add for subtree with master branch' '
+        git subtree add -m "Add sub1 subtree" -P sub1 ../shared_projec=
ts/subtree1 master &&
+        check_equal ''"$(last_commit_message)"'' "Add sub1 subtree"
+'
+
+# Store latest commit id for future use
+expected_subtreeMergeCommit=3D$(last_commit_id)
+
+test_expect_success 'check if .gittrees file was created' '
+        test -a '.gittrees'
+'
+# Now lets test if the .gittrees file has the correct information
+# Hardcoded some expected results for checking data inside .gittrees f=
ile
+expected_url=3D'../shared_projects/subtree1'
+expected_path=3D'sub1'
+
+echo $expected_url>>expected_gittrees
+echo $expected_path>>expected_gittrees
+echo $expected_branch>>expected_gittrees
+echo $expected_subtreeCommit>>expected_gittrees
+echo $expected_subtreeMergeCommit>>expected_gittrees
+
+grep =3D .gittrees | cut -f2 -d"=3D" | cut -f2 -d" " > actual_gittrees
+
+test_expect_success 'check .gittrees file has the necessary changes' '
+        test_cmp actual_gittrees expected_gittrees
+'
+
+test_expect_success 'check subtree does not get created with incorrect=
 remote url' '
+        test_must_fail git subtree add -P s2 ../shared_projects/subbtr=
ee1 master
+'
+
+test_expect_success 'check that subtree does not get created with inco=
rrect branch' '
+        test_must_fail git subtree add -P s2 ../shared_projects/subtre=
e1 development
+'
+
+test_expect_success 'add another subtree with master branch' '
+        git subtree add -m "Add sub2 subtree" -P sub2 ../shared_projec=
ts/subtree2 master &&
+        check_equal ''"$(last_commit_message)"'' "Add sub2 subtree"
+'
=20
 test_done
--=20
1.7.9
