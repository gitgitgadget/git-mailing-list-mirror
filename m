From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] read-tree -m -u: do not overwrite or remove untracked working tree files.
Date: Wed, 17 May 2006 01:17:46 -0700
Message-ID: <7v8xp1jc9h.fsf_-_@assigned-by-dhcp.cox.net>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
	<7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
	<8aa486160605161611p4c9ddbc0v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 10:17:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHE8-0005Hj-TS
	for gcvg-git@gmane.org; Wed, 17 May 2006 10:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWEQIRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 May 2006 04:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWEQIRt
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 04:17:49 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33260 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932470AbWEQIRs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 04:17:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517081747.YBEK24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 04:17:47 -0400
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605161611p4c9ddbc0v@mail.gmail.com> (sbejar@gmail.com's
	message of "Wed, 17 May 2006 01:11:29 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20167>

When a merge results in a creation of a path that did not exist
in HEAD, and if you already have that path on the working tree,
because the index has not been told about the working tree file,
read-tree happily removes it.  The issue was brought up by Santi
B=E9jar on the list.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
>> This is totally untested, but on top of "next" you could do
>> something like this, perhaps.
>
> Thanks, it works here.

  This is an updated version, applicable to the "master" branch.
  The earlier one only dealt with very limited cases, and I
  suspect it did not do the right thing when "--reset" is
  involved (it would probably had broken "git reset --hard").

  This is an RFC patch that I consider of somewhat dubious value.
  Not the implementation quality, but the semantic change it
  implies.  Before, we could freely work in a working tree, which
  is just a scratch area to build the index, littered with
  throw-away files, knowing they would not prevent merge between
  our HEAD and other branch from happenning even if a merge needs
  to blow them away.  With this change, it is not a case anymore.
  Your merge will fail to proceed and you have to remove those
  throw-away files yourself and retry the merge.  The extent of
  the damage can be seen by the change to t1002 test this commit
  contains.  It arguably is making things much safer by refusing to
  proceed, so this might be a desirable change.  I am still
  undecided.

435ac2bfd2ef29c584531cd4a29c1f018f9aea13
 read-tree.c                   |   43 ++++++++++++++++++++++++---
 t/t1002-read-tree-m-u-2way.sh |   66 +++++++++++++++++++++++++++------=
--------
 t/t3500-cherry.sh             |    1 +
 t/t4002-diff-basic.sh         |    6 ++--
 t/t6022-merge-rename.sh       |    1 +
 5 files changed, 87 insertions(+), 30 deletions(-)

435ac2bfd2ef29c584531cd4a29c1f018f9aea13
diff --git a/read-tree.c b/read-tree.c
index e16e91b..6dc95a3 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -408,7 +408,7 @@ static void verify_uptodate(struct cache
 {
 	struct stat st;
=20
-	if (index_only)
+	if (index_only || reset)
 		return;
=20
 	if (!lstat(ce->name, &st)) {
@@ -426,6 +426,21 @@ static void verify_uptodate(struct cache
 	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
=20
+/*
+ * We do not want to remove or overwrite a working tree file that
+ * is not tracked.
+ */
+static void verify_absent(const char *path, const char *action)
+{
+	struct stat st;
+
+	if (index_only || reset || !update)
+		return;
+	if (!lstat(path, &st))
+		die("Untracked working tree file '%s' "
+		    "would be %s by merge.", path, action);
+}
+
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old)
 {
 	merge->ce_flags |=3D htons(CE_UPDATE);
@@ -443,6 +458,9 @@ static int merged_entry(struct cache_ent
 			verify_uptodate(old);
 		}
 	}
+	else
+		verify_absent(merge->name, "overwritten");
+
 	merge->ce_flags &=3D ~htons(CE_STAGEMASK);
 	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD);
 	return 1;
@@ -452,6 +470,8 @@ static int deleted_entry(struct cache_en
 {
 	if (old)
 		verify_uptodate(old);
+	else
+		verify_absent(ce->name, "removed");
 	ce->ce_mode =3D 0;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
 	return 1;
@@ -487,6 +507,7 @@ static int threeway_merge(struct cache_e
 	int count;
 	int head_match =3D 0;
 	int remote_match =3D 0;
+	const char *path =3D NULL;
=20
 	int df_conflict_head =3D 0;
 	int df_conflict_remote =3D 0;
@@ -498,8 +519,11 @@ static int threeway_merge(struct cache_e
 	for (i =3D 1; i < head_idx; i++) {
 		if (!stages[i])
 			any_anc_missing =3D 1;
-		else
+		else {
+			if (!path)
+				path =3D stages[i]->name;
 			no_anc_exists =3D 0;
+		}
 	}
=20
 	index =3D stages[0];
@@ -515,6 +539,13 @@ static int threeway_merge(struct cache_e
 		remote =3D NULL;
 	}
=20
+	if (!path && index)
+		path =3D index->name;
+	if (!path && head)
+		path =3D head->name;
+	if (!path && remote)
+		path =3D remote->name;
+
 	/* First, if there's a #16 situation, note that to prevent #13
 	 * and #14.=20
 	 */
@@ -575,6 +606,8 @@ static int threeway_merge(struct cache_e
 		    (remote_deleted && head && head_match)) {
 			if (index)
 				return deleted_entry(index, index);
+			else if (path)
+				verify_absent(path, "removed");
 			return 0;
 		}
 		/*
@@ -592,6 +625,8 @@ static int threeway_merge(struct cache_e
 	if (index) {
 		verify_uptodate(index);
 	}
+	else if (path)
+		verify_absent(path, "overwritten");
=20
 	nontrivial_merge =3D 1;
=20
@@ -689,7 +724,7 @@ static int oneway_merge(struct cache_ent
 			     merge_size);
=20
 	if (!a)
-		return deleted_entry(old, NULL);
+		return deleted_entry(old, old);
 	if (old && same(old, a)) {
 		if (reset) {
 			struct stat st;
@@ -699,7 +734,7 @@ static int oneway_merge(struct cache_ent
 		}
 		return keep_entry(old);
 	}
-	return merged_entry(a, NULL);
+	return merged_entry(a, old);
 }
=20
 static int read_cache_unmerged(void)
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way=
=2Esh
index 4d175d8..8335a63 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -39,7 +39,6 @@ test_expect_success \
      echo nitfol >nitfol &&
      echo bozbar >bozbar &&
      echo rezrov >rezrov &&
-     echo yomin >yomin &&
      git-update-index --add nitfol bozbar rezrov &&
      treeH=3D`git-write-tree` &&
      echo treeH $treeH &&
@@ -56,7 +55,8 @@ test_expect_success \
=20
 test_expect_success \
     '1, 2, 3 - no carry forward' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >1-3.out &&
      cmp M.out 1-3.out &&
@@ -66,11 +66,12 @@ test_expect_success \
      check_cache_at frotz clean &&
      check_cache_at nitfol clean'
=20
-echo '+100644 X 0	yomin' >expected
-
 test_expect_success \
     '4 - carry forward local addition.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
+     echo "+100644 X 0	yomin" >expected &&
+     echo yomin >yomin &&
      git-update-index --add yomin &&
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >4.out || return 1
@@ -85,7 +86,9 @@ test_expect_success \
=20
 test_expect_success \
     '5 - carry forward local addition.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
+     git-read-tree -m -u $treeH &&
      echo yomin >yomin &&
      git-update-index --add yomin &&
      echo yomin yomin >yomin &&
@@ -103,7 +106,9 @@ test_expect_success \
=20
 test_expect_success \
     '6 - local addition already has the same.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
+     echo frotz >frotz &&
      git-update-index --add frotz &&
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >6.out &&
@@ -117,7 +122,8 @@ test_expect_success \
=20
 test_expect_success \
     '7 - local addition already has the same.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo frotz >frotz &&
      git-update-index --add frotz &&
      echo frotz frotz >frotz &&
@@ -134,14 +140,16 @@ test_expect_success \
=20
 test_expect_success \
     '8 - conflicting addition.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo frotz frotz >frotz &&
      git-update-index --add frotz &&
      if git-read-tree -m -u $treeH $treeM; then false; else :; fi'
=20
 test_expect_success \
     '9 - conflicting addition.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo frotz frotz >frotz &&
      git-update-index --add frotz &&
      echo frotz >frotz &&
@@ -149,7 +157,8 @@ test_expect_success \
=20
 test_expect_success \
     '10 - path removed.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo rezrov >rezrov &&
      git-update-index --add rezrov &&
      git-read-tree -m -u $treeH $treeM &&
@@ -160,7 +169,8 @@ test_expect_success \
=20
 test_expect_success \
     '11 - dirty path removed.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo rezrov >rezrov &&
      git-update-index --add rezrov &&
      echo rezrov rezrov >rezrov &&
@@ -168,14 +178,16 @@ test_expect_success \
=20
 test_expect_success \
     '12 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo rezrov rezrov >rezrov &&
      git-update-index --add rezrov &&
      if git-read-tree -m -u $treeH $treeM; then false; else :; fi'
=20
 test_expect_success \
     '13 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo rezrov rezrov >rezrov &&
      git-update-index --add rezrov &&
      echo rezrov >rezrov &&
@@ -188,7 +200,8 @@ EOF
=20
 test_expect_success \
     '14 - unchanged in two heads.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo nitfol nitfol >nitfol &&
      git-update-index --add nitfol &&
      git-read-tree -m -u $treeH $treeM &&
@@ -207,7 +220,8 @@ test_expect_success \
=20
 test_expect_success \
     '15 - unchanged in two heads.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo nitfol nitfol >nitfol &&
      git-update-index --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
@@ -227,14 +241,16 @@ test_expect_success \
=20
 test_expect_success \
     '16 - conflicting local change.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo bozbar bozbar >bozbar &&
      git-update-index --add bozbar &&
      if git-read-tree -m -u $treeH $treeM; then false; else :; fi'
=20
 test_expect_success \
     '17 - conflicting local change.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo bozbar bozbar >bozbar &&
      git-update-index --add bozbar &&
      echo bozbar bozbar bozbar >bozbar &&
@@ -242,7 +258,8 @@ test_expect_success \
=20
 test_expect_success \
     '18 - local change already having a good result.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo gnusto >bozbar &&
      git-update-index --add bozbar &&
      git-read-tree -m -u $treeH $treeM &&
@@ -254,7 +271,8 @@ test_expect_success \
=20
 test_expect_success \
     '19 - local change already having a good result, further modified.=
' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo gnusto >bozbar &&
      git-update-index --add bozbar &&
      echo gnusto gnusto >bozbar &&
@@ -273,7 +291,8 @@ test_expect_success \
=20
 test_expect_success \
     '20 - no local change, use new tree.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo bozbar >bozbar &&
      git-update-index --add bozbar &&
      git-read-tree -m -u $treeH $treeM &&
@@ -285,7 +304,8 @@ test_expect_success \
=20
 test_expect_success \
     '21 - no local change, dirty cache.' \
-    'rm -f .git/index &&
+    'rm -f .git/index nitfol bozbar rezrov frotz &&
+     git-read-tree --reset -u $treeH &&
      echo bozbar >bozbar &&
      git-update-index --add bozbar &&
      echo gnusto gnusto >bozbar &&
@@ -294,7 +314,7 @@ test_expect_success \
 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \
     'DF vs DF/DF case setup.' \
-    'rm -f .git/index &&
+    'rm -f .git/index
      echo DF >DF &&
      git-update-index --add DF &&
      treeDF=3D`git-write-tree` &&
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index b141f89..e83bbee 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -30,6 +30,7 @@ test_expect_success \
      git-commit -m "Add C." &&
=20
      git-checkout -f master &&
+     rm -f B C &&
=20
      echo Third >> A &&
      git-update-index A &&
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 769274a..56eda63 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -191,7 +191,7 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git-read-tree $tree_A &&
      git-checkout-index -f -a &&
-     git-read-tree -m $tree_O || return 1
+     git-read-tree --reset $tree_O || return 1
      git-update-index --refresh >/dev/null ;# this can exit non-zero
      git-diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OA'
@@ -201,7 +201,7 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git-read-tree $tree_B &&
      git-checkout-index -f -a &&
-     git-read-tree -m $tree_O || return 1
+     git-read-tree --reset $tree_O || return 1
      git-update-index --refresh >/dev/null ;# this can exit non-zero
      git-diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OB'
@@ -211,7 +211,7 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git-read-tree $tree_B &&
      git-checkout-index -f -a &&
-     git-read-tree -m $tree_A || return 1
+     git-read-tree --reset $tree_A || return 1
      git-update-index --refresh >/dev/null ;# this can exit non-zero
      git-diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-AB'
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index a2d24b5..5ac2564 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -111,6 +111,7 @@ test_expect_success 'pull renaming branc
=20
 test_expect_success 'pull renaming branch into another renaming one' \
 '
+	rm -f B
 	git reset --hard
 	git checkout red
 	git pull . white && {
--=20
1.3.3.g8a24
