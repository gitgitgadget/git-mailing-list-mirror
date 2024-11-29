Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690D1C6B4
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848295; cv=none; b=SAOnDRNxR0duenpQQQJj6wYVgPyZKF49LpqlEd1xSnNbSD6WVXp7ZKMqcpXEemI9sFsN3p+/o9UrfpIVhgZCp+WbPfcPNA7ppH4U7Af1n6kwz99NATM2ZrOAzk8kMyvt+ANwf6LwZHs6pprjCzIknM6XfUnj8ap6YOmCI1ALumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848295; c=relaxed/simple;
	bh=zIejrWMe/jlp3mfUpXYL/815hM8TrDXXMwsgNkPMTPY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDcLzibGzqkCmpkM62VmgVnyRlB0liUjVRKCIwFsg8CEidZsD6VmkaZXckXB+Pr2rP73BTzffh3cPvlYhvBA6a++HTGMV85FNHiWDfcp7rtZau0tA1CdBUjiD5KAq3EzG3XykR1c5kJgWH4/qtRQg893uiu6pru0eZekk9j2J/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=G6PxKjNR; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="G6PxKjNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732848279; x=1733107479;
	bh=AIW1kfEVMJVPPc4WyyWnwIJDgM+CgZAFei4c8JMbiPk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=G6PxKjNRb2BzMwCsePzEOe59NW2G3il0WeotSkvHNZH6nfB7O0n8F5LrgMtbeo3aJ
	 gHYRoDD58EN/ngSgM8I6y3+hlMxAE3Hqn28nqywJp+O091M/jFyaEsUsZkVBoaaci4
	 FexOSgAhgL4Vfv07jPH1ylGwi8vwRbHvEVXKh17JYN0uldQK2PthlWYmeMhA9/Osw1
	 g6YFnWMRw1G0w61DLvpEwN3Lj7YN2gF4Dh0j3H3fOk7nx/IsVCaaxJBxoeFR/d9OeA
	 TxQjl5SRLQ5TjHO3PWtH3UhozFKKb2uIpkvqN0EBrW8/cItERSLqxkaiPCPleAH8AE
	 y9JmT/nFrmeqg==
Date: Fri, 29 Nov 2024 02:44:33 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 1/2] worktree: add worktree with unique suffix
Message-ID: <20241128-wt_unique_ids-v1-1-30345d010e43@pm.me>
In-Reply-To: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 5c5579a146af5f8fc891649100dd828eecc42d53
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The `es/worktree-repair-copied` topic added support for repairing a
worktree from a copy scenario. However, the topic added the
ability for a repository to "take over" a worktree from another
repository if the worktree_id matched a worktree inside the current
repository which can happen if two repositories use the same worktree name.

This teaches Git to create worktrees with a unique suffix so the
worktree_id is unique across all repositories even if they have the
same name. For example creating a worktree `develop` would look like:

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
    =E2=94=94=E2=94=80=E2=94=80 develop/
    bar/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-1549518426/
    =E2=94=94=E2=94=80=E2=94=80 develop/

The actual worktree directory name is still `develop`, but the
worktree_id is unique and prevents the "take over" scenario. The suffix
is given by the `git_rand()` function. Worktree ids can already differ
from the actual directory name (appended with a number like `develop1`)
if the worktree name was already taken, so this should not be a
drastic change.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/git-worktree.txt     |  5 +-
 builtin/worktree.c                 |  6 +++
 t/t0035-safe-bare-repository.sh    |  4 +-
 t/t0600-reffiles-backend.sh        | 10 ++--
 t/t0601-reffiles-pack-refs.sh      |  4 +-
 t/t0610-reftable-basics.sh         | 54 +++++++++++-----------
 t/t1407-worktree-ref-store.sh      |  4 +-
 t/t1410-reflog.sh                  | 10 ++--
 t/t1415-worktree-refs.sh           | 26 +++++------
 t/t1450-fsck.sh                    | 14 +++---
 t/t1500-rev-parse.sh               |  6 +--
 t/t2400-worktree-add.sh            | 51 +++++++++++----------
 t/t2401-worktree-prune.sh          | 20 ++++----
 t/t2403-worktree-move.sh           | 32 ++++++-------
 t/t2405-worktree-submodule.sh      | 10 ++--
 t/t2406-worktree-repair.sh         | 93 ++++++++++++++++++++++++----------=
----
 t/t2407-worktree-heads.sh          | 27 +++++------
 t/t3200-branch.sh                  | 10 ++--
 t/t5304-prune.sh                   |  2 +-
 t/t7412-submodule-absorbgitdirs.sh |  4 +-
 20 files changed, 212 insertions(+), 180 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 8340b7f028e6c1c3bae3de0879e9754098466d14..e0604b043361828f94b58f676a5=
ed4f15b116348 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -352,12 +352,11 @@ DETAILS
 -------
 Each linked worktree has a private sub-directory in the repository's
 `$GIT_DIR/worktrees` directory.  The private sub-directory's name is usual=
ly
-the base name of the linked worktree's path, possibly appended with a
+the base name of the linked worktree's path, appended with a random
 number to make it unique.  For example, when `$GIT_DIR=3D/path/main/.git` =
the
 command `git worktree add /path/other/test-next next` creates the linked
 worktree in `/path/other/test-next` and also creates a
-`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next=
1`
-if `test-next` is already taken).
+`$GIT_DIR/worktrees/test-next-#######` directory.
=20
 Within a linked worktree, `$GIT_DIR` is set to point to this private
 directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fde9ff4dc9a734c655e95ccd62774282950cbba6..3ad355ca762729401fc0c8625f4=
fd05b154a84ec 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -421,6 +421,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
 =09struct strbuf sb =3D STRBUF_INIT;
 =09const char *name;
+=09const char *suffix;
 =09struct strvec child_env =3D STRVEC_INIT;
 =09unsigned int counter =3D 0;
 =09int len, ret;
@@ -455,6 +456,11 @@ static int add_worktree(const char *path, const char *=
refname,
 =09strbuf_reset(&sb);
 =09name =3D sb_name.buf;
 =09git_path_buf(&sb_repo, "worktrees/%s", name);
+=09suffix =3D getenv("GIT_TEST_WORKTREE_SUFFIX");
+=09if (suffix)
+=09=09strbuf_addf(&sb_repo, "-%s", suffix);
+=09else
+=09=09strbuf_addf(&sb_repo, "-%u", git_rand());
 =09len =3D sb_repo.len;
 =09if (safe_create_leading_directories_const(sb_repo.buf))
 =09=09die_errno(_("could not create leading directories of '%s'"),
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository=
.sh
index d3cb2a1cb9edb8f9ad7480be6ec3e02b464046bd..30cbf7fd32e2e4afd6d680e0328=
ee18b791778da 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -41,7 +41,7 @@ test_expect_success 'setup an embedded bare repo, seconda=
ry worktree and submodu
 =09=09git -c protocol.file.allow=3Dalways \
 =09=09=09submodule add --name subn -- ./bare-repo subd
 =09) &&
-=09test_path_is_dir outer-repo/.git/worktrees/outer-secondary &&
+=09test_path_is_dir outer-repo/.git/worktrees/outer-secondary-* &&
 =09test_path_is_dir outer-repo/.git/modules/subn
 '
=20
@@ -97,7 +97,7 @@ test_expect_success 'no trace when "bare repository" is a=
 subdir of .git' '
 '
=20
 test_expect_success 'no trace in $GIT_DIR of secondary worktree' '
-=09expect_accepted_implicit -C outer-repo/.git/worktrees/outer-secondary
+=09expect_accepted_implicit -C outer-repo/.git/worktrees/outer-secondary-*
 '
=20
 test_expect_success 'no trace in $GIT_DIR of a submodule' '
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index bef2b70871364931ab8b3ead950f59d11b6fe216..8da81b1ae34f5f095ba9406e8f0=
31fd5e43ac789 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -256,12 +256,12 @@ test_expect_success 'delete fails cleanly if packed-r=
efs.new write fails' '
 =09test_cmp unchanged actual
 '
=20
-RWT=3D"test-tool ref-store worktree:wt"
+RWT=3D"test-tool ref-store worktree:wt-123"
 RMAIN=3D"test-tool ref-store worktree:main"
=20
 test_expect_success 'setup worktree' '
 =09test_commit first &&
-=09git worktree add -b wt-main wt &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add -b wt-main wt &&
 =09(
 =09=09cd wt &&
 =09=09test_commit second
@@ -279,9 +279,9 @@ test_expect_success 'for_each_reflog()' '
 =09mkdir -p     .git/logs/refs/bisect &&
 =09echo $ZERO_OID >.git/logs/refs/bisect/random &&
=20
-=09echo $ZERO_OID >.git/worktrees/wt/logs/PSEUDO_WT_HEAD &&
-=09mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
-=09echo $ZERO_OID >.git/worktrees/wt/logs/refs/bisect/wt-random &&
+=09echo $ZERO_OID >.git/worktrees/wt-123/logs/PSEUDO_WT_HEAD &&
+=09mkdir -p     .git/worktrees/wt-123/logs/refs/bisect &&
+=09echo $ZERO_OID >.git/worktrees/wt-123/logs/refs/bisect/wt-random &&
=20
 =09$RWT for-each-reflog >actual &&
 =09cat >expected <<-\EOF &&
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index d8cbd3f202b5f00c9a94c5a2ea2dced6606b6f4d..d6597938caca5e6c3a6e86b860f=
3c0d309aa2140 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -326,8 +326,8 @@ test_expect_success 'refs/worktree must not be packed' =
'
 =09git pack-refs --all &&
 =09test_path_is_missing .git/refs/tags/wt1 &&
 =09test_path_is_file .git/refs/worktree/foo &&
-=09test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
-=09test_path_is_file .git/worktrees/wt2/refs/worktree/foo
+=09test_path_is_file .git/worktrees/wt1-*/refs/worktree/foo &&
+=09test_path_is_file .git/worktrees/wt2-*/refs/worktree/foo
 '
=20
 # we do not want to count on running pack-refs to
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index eaf6fab6d29f01430abae3c7abf5a750d4271a36..f21fd9dbba2b77636045b297073=
e340209d61a2d 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -965,11 +965,11 @@ test_expect_success 'worktree: adding worktree create=
s separate stack' '
 =09test_commit -C repo A &&
=20
 =09git -C repo worktree add ../worktree &&
-=09test_path_is_file repo/.git/worktrees/worktree/refs/heads &&
+=09test_path_is_file repo/.git/worktrees/worktree-*/refs/heads &&
 =09echo "ref: refs/heads/.invalid" >expect &&
-=09test_cmp expect repo/.git/worktrees/worktree/HEAD &&
-=09test_path_is_dir repo/.git/worktrees/worktree/reftable &&
-=09test_path_is_file repo/.git/worktrees/worktree/reftable/tables.list
+=09test_cmp expect repo/.git/worktrees/worktree-*/HEAD &&
+=09test_path_is_dir repo/.git/worktrees/worktree-*/reftable &&
+=09test_path_is_file repo/.git/worktrees/worktree-*/reftable/tables.list
 '
=20
 test_expect_success 'worktree: pack-refs in main repo packs main refs' '
@@ -982,10 +982,10 @@ test_expect_success 'worktree: pack-refs in main repo=
 packs main refs' '
 =09GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
 =09git -C worktree update-ref refs/worktree/per-worktree HEAD &&
=20
-=09test_line_count =3D 4 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 4 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 3 repo/.git/reftable/tables.list &&
 =09git -C repo pack-refs &&
-=09test_line_count =3D 4 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 4 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list
 '
=20
@@ -999,10 +999,10 @@ test_expect_success 'worktree: pack-refs in worktree =
packs worktree refs' '
 =09GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
 =09git -C worktree update-ref refs/worktree/per-worktree HEAD &&
=20
-=09test_line_count =3D 4 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 4 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 3 repo/.git/reftable/tables.list &&
 =09git -C worktree pack-refs &&
-=09test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 1 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 3 repo/.git/reftable/tables.list
 '
=20
@@ -1014,12 +1014,12 @@ test_expect_success 'worktree: creating shared ref =
updates main stack' '
 =09git -C repo worktree add ../worktree &&
 =09git -C repo pack-refs &&
 =09git -C worktree pack-refs &&
-=09test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 1 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list &&
=20
 =09GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
 =09git -C worktree update-ref refs/heads/shared HEAD &&
-=09test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 1 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 2 repo/.git/reftable/tables.list
 '
=20
@@ -1031,11 +1031,11 @@ test_expect_success 'worktree: creating per-worktre=
e ref updates worktree stack'
 =09git -C repo worktree add ../worktree &&
 =09git -C repo pack-refs &&
 =09git -C worktree pack-refs &&
-=09test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 1 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list &&
=20
 =09git -C worktree update-ref refs/bisect/per-worktree HEAD &&
-=09test_line_count =3D 2 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 2 repo/.git/worktrees/worktree-*/reftable/tables.li=
st &&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list
 '
=20
@@ -1044,14 +1044,14 @@ test_expect_success 'worktree: creating per-worktre=
e ref from main repo' '
 =09git init repo &&
 =09test_commit -C repo A &&
=20
-=09git -C repo worktree add ../worktree &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git -C repo worktree add ../worktree &&
 =09git -C repo pack-refs &&
 =09git -C worktree pack-refs &&
-=09test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 1 repo/.git/worktrees/worktree-456/reftable/tables.=
list &&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list &&
=20
-=09git -C repo update-ref worktrees/worktree/refs/bisect/per-worktree HEAD=
 &&
-=09test_line_count =3D 2 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09git -C repo update-ref worktrees/worktree-456/refs/bisect/per-worktree =
HEAD &&
+=09test_line_count =3D 2 repo/.git/worktrees/worktree-456/reftable/tables.=
list &&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list
 '
=20
@@ -1060,18 +1060,18 @@ test_expect_success 'worktree: creating per-worktre=
e ref from second worktree' '
 =09git init repo &&
 =09test_commit -C repo A &&
=20
-=09git -C repo worktree add ../wt1 &&
-=09git -C repo worktree add ../wt2 &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git -C repo worktree add ../wt1 &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git -C repo worktree add ../wt2 &&
 =09git -C repo pack-refs &&
 =09git -C wt1 pack-refs &&
 =09git -C wt2 pack-refs &&
-=09test_line_count =3D 1 repo/.git/worktrees/wt1/reftable/tables.list &&
-=09test_line_count =3D 1 repo/.git/worktrees/wt2/reftable/tables.list &&
+=09test_line_count =3D 1 repo/.git/worktrees/wt1-123/reftable/tables.list =
&&
+=09test_line_count =3D 1 repo/.git/worktrees/wt2-456/reftable/tables.list =
&&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list &&
=20
-=09git -C wt1 update-ref worktrees/wt2/refs/bisect/per-worktree HEAD &&
-=09test_line_count =3D 1 repo/.git/worktrees/wt1/reftable/tables.list &&
-=09test_line_count =3D 2 repo/.git/worktrees/wt2/reftable/tables.list &&
+=09git -C wt1 update-ref worktrees/wt2-456/refs/bisect/per-worktree HEAD &=
&
+=09test_line_count =3D 1 repo/.git/worktrees/wt1-123/reftable/tables.list =
&&
+=09test_line_count =3D 2 repo/.git/worktrees/wt2-456/reftable/tables.list =
&&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list
 '
=20
@@ -1080,18 +1080,18 @@ test_expect_success 'worktree: can create shared an=
d per-worktree ref in one tra
 =09git init repo &&
 =09test_commit -C repo A &&
=20
-=09git -C repo worktree add ../worktree &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git -C repo worktree add ../worktree &&
 =09git -C repo pack-refs &&
 =09git -C worktree pack-refs &&
-=09test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 1 repo/.git/worktrees/worktree-123/reftable/tables.=
list &&
 =09test_line_count =3D 1 repo/.git/reftable/tables.list &&
=20
 =09cat >stdin <<-EOF &&
-=09create worktrees/worktree/refs/bisect/per-worktree HEAD
+=09create worktrees/worktree-123/refs/bisect/per-worktree HEAD
 =09create refs/branches/shared HEAD
 =09EOF
 =09git -C repo update-ref --stdin <stdin &&
-=09test_line_count =3D 2 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
+=09test_line_count =3D 2 repo/.git/worktrees/worktree-123/reftable/tables.=
list &&
 =09test_line_count =3D 2 repo/.git/reftable/tables.list
 '
=20
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 48b1c92a41450b25645d6cd782aa86c8e630164b..4d081627a1e6b55936cd4051ed7=
60fa92e7cdc02 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -8,12 +8,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
-RWT=3D"test-tool ref-store worktree:wt"
+RWT=3D"test-tool ref-store worktree:wt-456"
 RMAIN=3D"test-tool ref-store worktree:main"
=20
 test_expect_success 'setup' '
 =09test_commit first &&
-=09git worktree add -b wt-main wt &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree add -b wt-main wt &&
 =09(
 =09=09cd wt &&
 =09=09test_commit second
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 246a3f46abafdf0e24528be59b33a4987ff791c1..c1b6b4d8fab8d261713a192478a=
f12179f9bc917 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -402,12 +402,12 @@ test_expect_success 'expire with multiple worktrees' =
'
 =09=09cd main-wt &&
 =09=09test_tick &&
 =09=09test_commit foo &&
-=09=09git  worktree add link-wt &&
+=09=09GIT_TEST_WORKTREE_SUFFIX=3D123 git  worktree add link-wt &&
 =09=09test_tick &&
 =09=09test_commit -C link-wt foobar &&
 =09=09test_tick &&
 =09=09git reflog expire --verbose --all --expire=3D$test_tick &&
-=09=09test-tool ref-store worktree:link-wt for-each-reflog-ent HEAD >actua=
l &&
+=09=09test-tool ref-store worktree:link-wt-123 for-each-reflog-ent HEAD >a=
ctual &&
 =09=09test_must_be_empty actual
 =09)
 '
@@ -418,17 +418,17 @@ test_expect_success 'expire one of multiple worktrees=
' '
 =09=09cd main-wt2 &&
 =09=09test_tick &&
 =09=09test_commit foo &&
-=09=09git worktree add link-wt &&
+=09=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree add link-wt &&
 =09=09test_tick &&
 =09=09test_commit -C link-wt foobar &&
 =09=09test_tick &&
-=09=09test-tool ref-store worktree:link-wt for-each-reflog-ent HEAD \
+=09=09test-tool ref-store worktree:link-wt-456 for-each-reflog-ent HEAD \
 =09=09=09>expect-link-wt &&
 =09=09git reflog expire --verbose --all --expire=3D$test_tick \
 =09=09=09--single-worktree &&
 =09=09test-tool ref-store worktree:main for-each-reflog-ent HEAD \
 =09=09=09>actual-main &&
-=09=09test-tool ref-store worktree:link-wt for-each-reflog-ent HEAD \
+=09=09test-tool ref-store worktree:link-wt-456 for-each-reflog-ent HEAD \
 =09=09=09>actual-link-wt &&
 =09=09test_must_be_empty actual-main &&
 =09=09test_cmp expect-link-wt actual-link-wt
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index eb4eec8becbfa64efcde4e866334363a866c01a2..c46bf29aa4d9ceac85147d685a1=
d23144ec23b2b 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -9,8 +9,8 @@ test_expect_success 'setup' '
 =09test_commit initial &&
 =09test_commit wt1 &&
 =09test_commit wt2 &&
-=09git worktree add wt1 wt1 &&
-=09git worktree add wt2 wt2 &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add wt1 wt1 &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree add wt2 wt2 &&
 =09git checkout initial &&
 =09git update-ref refs/worktree/foo HEAD &&
 =09git -C wt1 update-ref refs/worktree/foo HEAD &&
@@ -37,16 +37,16 @@ test_expect_success 'ambiguous main-worktree/HEAD' '
 '
=20
 test_expect_success 'resolve worktrees/xx/HEAD' '
-=09test_cmp_rev worktrees/wt1/HEAD wt1 &&
-=09( cd wt1 && test_cmp_rev worktrees/wt1/HEAD wt1 ) &&
-=09( cd wt2 && test_cmp_rev worktrees/wt1/HEAD wt1 )
+=09test_cmp_rev worktrees/wt1-123/HEAD wt1 &&
+=09( cd wt1 && test_cmp_rev worktrees/wt1-123/HEAD wt1 ) &&
+=09( cd wt2 && test_cmp_rev worktrees/wt1-123/HEAD wt1 )
 '
=20
 test_expect_success 'ambiguous worktrees/xx/HEAD' '
-=09git update-ref refs/heads/worktrees/wt1/HEAD $(git rev-parse HEAD) &&
-=09test_when_finished git update-ref -d refs/heads/worktrees/wt1/HEAD &&
-=09git rev-parse worktrees/wt1/HEAD 2>warn &&
-=09grep "worktrees/wt1/HEAD.*ambiguous" warn
+=09git update-ref refs/heads/worktrees/wt1-123/HEAD $(git rev-parse HEAD) =
&&
+=09test_when_finished git update-ref -d refs/heads/worktrees/wt1-123/HEAD =
&&
+=09git rev-parse worktrees/wt1-123/HEAD 2>warn &&
+=09grep "worktrees/wt1-123/HEAD.*ambiguous" warn
 '
=20
 test_expect_success 'reflog of main-worktree/HEAD' '
@@ -58,12 +58,12 @@ test_expect_success 'reflog of main-worktree/HEAD' '
 '
=20
 test_expect_success 'reflog of worktrees/xx/HEAD' '
-=09git -C wt2 reflog HEAD | sed "s/HEAD/worktrees\/wt2\/HEAD/" >expected &=
&
-=09git reflog worktrees/wt2/HEAD >actual &&
+=09git -C wt2 reflog HEAD | sed "s/HEAD/worktrees\/wt2-456\/HEAD/" >expect=
ed &&
+=09git reflog worktrees/wt2-456/HEAD >actual &&
 =09test_cmp expected actual &&
-=09git -C wt1 reflog worktrees/wt2/HEAD >actual.wt1 &&
+=09git -C wt1 reflog worktrees/wt2-456/HEAD >actual.wt1 &&
 =09test_cmp expected actual.wt1 &&
-=09git -C wt2 reflog worktrees/wt2/HEAD >actual.wt2 &&
+=09git -C wt2 reflog worktrees/wt2-456/HEAD >actual.wt2 &&
 =09test_cmp expected actual.wt2
 '
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 280cbf3e031e1ab67ed28aa2af4c3b105b7d254e..de25ab24fd8924e288969650a65=
8908a5e9afd22 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -152,10 +152,10 @@ test_expect_success REFFILES 'HEAD link pointing at a=
 funny object (from differe
=20
 test_expect_success REFFILES 'other worktree HEAD link pointing at a funny=
 object' '
 =09test_when_finished "git worktree remove -f other" &&
-=09git worktree add other &&
-=09echo $ZERO_OID >.git/worktrees/other/HEAD &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add other &&
+=09echo $ZERO_OID >.git/worktrees/other-123/HEAD &&
 =09test_must_fail git fsck 2>out &&
-=09test_grep "worktrees/other/HEAD: detached HEAD points" out
+=09test_grep "worktrees/other-123/HEAD: detached HEAD points" out
 '
=20
 test_expect_success 'other worktree HEAD link pointing at missing object' =
'
@@ -164,7 +164,7 @@ test_expect_success 'other worktree HEAD link pointing =
at missing object' '
 =09object_id=3D$(echo "Contents missing from repo" | git hash-object --std=
in) &&
 =09test-tool -C other ref-store main update-ref msg HEAD $object_id "" REF=
_NO_DEREF,REF_SKIP_OID_VERIFICATION &&
 =09test_must_fail git fsck 2>out &&
-=09test_grep "worktrees/other/HEAD: invalid sha1 pointer" out
+=09test_grep "worktrees/other-.*/HEAD: invalid sha1 pointer" out
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny place' '
@@ -172,7 +172,7 @@ test_expect_success 'other worktree HEAD link pointing =
at a funny place' '
 =09git worktree add other &&
 =09git -C other symbolic-ref HEAD refs/funny/place &&
 =09test_must_fail git fsck 2>out &&
-=09test_grep "worktrees/other/HEAD points to something strange" out
+=09test_grep "worktrees/other-.*/HEAD points to something strange" out
 '
=20
 test_expect_success 'commit with multiple signatures is okay' '
@@ -1033,7 +1033,7 @@ test_expect_success 'fsck error on gitattributes with=
 excessive size' '
=20
 test_expect_success 'fsck detects problems in worktree index' '
 =09test_when_finished "git worktree remove -f wt" &&
-=09git worktree add wt &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add wt &&
=20
 =09echo "this will be removed to break the worktree index" >wt/file &&
 =09git -C wt add file &&
@@ -1042,7 +1042,7 @@ test_expect_success 'fsck detects problems in worktre=
e index' '
=20
 =09test_must_fail git fsck --name-objects >actual 2>&1 &&
 =09cat >expect <<-EOF &&
-=09missing blob $blob (.git/worktrees/wt/index:file)
+=09missing blob $blob (.git/worktrees/wt-123/index:file)
 =09EOF
 =09test_cmp expect actual
 '
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 30c31918fde6539d52800e18dfbb3423b5b73491..49e0ac68858d922336a498caaa7=
43f2f4011d28a 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -80,7 +80,7 @@ test_expect_success 'setup' '
 =09git checkout -b side &&
 =09test_commit def &&
 =09git checkout main &&
-=09git worktree add worktree side
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add worktree side
 '
=20
 test_rev_parse toplevel false false true '' .git "$ROOT/.git"
@@ -113,7 +113,7 @@ test_expect_success 'rev-parse --path-format=3Dabsolute=
' '
 =09test_one "." "$ROOT/.git" --path-format=3Dabsolute --git-common-dir &&
 =09test_one "sub/dir" "$ROOT/.git" --path-format=3Dabsolute --git-dir &&
 =09test_one "sub/dir" "$ROOT/.git" --path-format=3Dabsolute --git-common-d=
ir &&
-=09test_one "worktree" "$ROOT/.git/worktrees/worktree" --path-format=3Dabs=
olute --git-dir &&
+=09test_one "worktree" "$ROOT/.git/worktrees/worktree-123" --path-format=
=3Dabsolute --git-dir &&
 =09test_one "worktree" "$ROOT/.git" --path-format=3Dabsolute --git-common-=
dir &&
 =09test_one "." "$ROOT" --path-format=3Dabsolute --show-toplevel &&
 =09test_one "." "$ROOT/.git/objects" --path-format=3Dabsolute --git-path o=
bjects &&
@@ -125,7 +125,7 @@ test_expect_success 'rev-parse --path-format=3Drelative=
' '
 =09test_one "." ".git" --path-format=3Drelative --git-common-dir &&
 =09test_one "sub/dir" "../../.git" --path-format=3Drelative --git-dir &&
 =09test_one "sub/dir" "../../.git" --path-format=3Drelative --git-common-d=
ir &&
-=09test_one "worktree" "../.git/worktrees/worktree" --path-format=3Drelati=
ve --git-dir &&
+=09test_one "worktree" "../.git/worktrees/worktree-123" --path-format=3Dre=
lative --git-dir &&
 =09test_one "worktree" "../.git" --path-format=3Drelative --git-common-dir=
 &&
 =09test_one "." "./" --path-format=3Drelative --show-toplevel &&
 =09test_one "." ".git/objects" --path-format=3Drelative --git-path objects=
 &&
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index bc4f4e90d6ecfedbde9082bda6f9e4eec3e3575d..33262b49f18521c805f188a10f9=
44dbfa9f285ba 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -71,21 +71,21 @@ test_expect_success '"add" worktree' '
 test_expect_success '"add" worktree with lock' '
 =09git worktree add --detach --lock here-with-lock main &&
 =09test_when_finished "git worktree unlock here-with-lock || :" &&
-=09test -f .git/worktrees/here-with-lock/locked
+=09test -f .git/worktrees/here-with-lock-*/locked
 '
=20
 test_expect_success '"add" worktree with lock and reason' '
 =09lock_reason=3D"why not" &&
 =09git worktree add --detach --lock --reason "$lock_reason" here-with-lock=
-reason main &&
 =09test_when_finished "git worktree unlock here-with-lock-reason || :" &&
-=09test -f .git/worktrees/here-with-lock-reason/locked &&
+=09test -f .git/worktrees/here-with-lock-reason-*/locked &&
 =09echo "$lock_reason" >expect &&
-=09test_cmp expect .git/worktrees/here-with-lock-reason/locked
+=09test_cmp expect .git/worktrees/here-with-lock-reason-*/locked
 '
=20
 test_expect_success '"add" worktree with reason but no lock' '
 =09test_must_fail git worktree add --detach --reason "why not" here-with-r=
eason-only main &&
-=09test_path_is_missing .git/worktrees/here-with-reason-only/locked
+=09test_path_is_missing .git/worktrees/here-with-reason-only-*/locked
 '
=20
 test_expect_success '"add" worktree from a subdir' '
@@ -413,16 +413,16 @@ test_expect_success '"add --orphan" with empty reposi=
tory' '
 test_expect_success '"add" worktree with orphan branch and lock' '
 =09git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
 =09test_when_finished "git worktree unlock orphan-with-lock || :" &&
-=09test -f .git/worktrees/orphan-with-lock/locked
+=09test -f .git/worktrees/orphan-with-lock-*/locked
 '
=20
 test_expect_success '"add" worktree with orphan branch, lock, and reason' =
'
 =09lock_reason=3D"why not" &&
 =09git worktree add --detach --lock --reason "$lock_reason" orphan-with-lo=
ck-reason main &&
 =09test_when_finished "git worktree unlock orphan-with-lock-reason || :" &=
&
-=09test -f .git/worktrees/orphan-with-lock-reason/locked &&
+=09test -f .git/worktrees/orphan-with-lock-reason-*/locked &&
 =09echo "$lock_reason" >expect &&
-=09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
+=09test_cmp expect .git/worktrees/orphan-with-lock-reason-*/locked
 '
=20
 # Note: Quoted arguments containing spaces are not supported.
@@ -1088,10 +1088,10 @@ test_expect_success '"add" invokes post-checkout ho=
ok (branch)' '
 =09post_checkout_hook &&
 =09{
 =09=09echo $ZERO_OID $(git rev-parse HEAD) 1 &&
-=09=09echo $(pwd)/.git/worktrees/gumby &&
+=09=09echo $(pwd)/.git/worktrees/gumby-123 &&
 =09=09echo $(pwd)/gumby
 =09} >hook.expect &&
-=09git worktree add gumby &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D"123" git worktree add gumby &&
 =09test_cmp hook.expect gumby/hook.actual
 '
=20
@@ -1099,10 +1099,10 @@ test_expect_success '"add" invokes post-checkout ho=
ok (detached)' '
 =09post_checkout_hook &&
 =09{
 =09=09echo $ZERO_OID $(git rev-parse HEAD) 1 &&
-=09=09echo $(pwd)/.git/worktrees/grumpy &&
+=09=09echo $(pwd)/.git/worktrees/grumpy-456 &&
 =09=09echo $(pwd)/grumpy
 =09} >hook.expect &&
-=09git worktree add --detach grumpy &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D"456" git worktree add --detach grumpy &&
 =09test_cmp hook.expect grumpy/hook.actual
 '
=20
@@ -1117,10 +1117,10 @@ test_expect_success '"add" in other worktree invoke=
s post-checkout hook' '
 =09post_checkout_hook &&
 =09{
 =09=09echo $ZERO_OID $(git rev-parse HEAD) 1 &&
-=09=09echo $(pwd)/.git/worktrees/guppy &&
+=09=09echo $(pwd)/.git/worktrees/guppy-789 &&
 =09=09echo $(pwd)/guppy
 =09} >hook.expect &&
-=09git -C gloopy worktree add --detach ../guppy &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D"789" git -C gloopy worktree add --detach ..=
/guppy &&
 =09test_cmp hook.expect guppy/hook.actual
 '
=20
@@ -1129,11 +1129,11 @@ test_expect_success '"add" in bare repo invokes pos=
t-checkout hook' '
 =09git clone --bare . bare &&
 =09{
 =09=09echo $ZERO_OID $(git --git-dir=3Dbare rev-parse HEAD) 1 &&
-=09=09echo $(pwd)/bare/worktrees/goozy &&
+=09=09echo $(pwd)/bare/worktrees/goozy-651 &&
 =09=09echo $(pwd)/goozy
 =09} >hook.expect &&
 =09post_checkout_hook bare &&
-=09git -C bare worktree add --detach ../goozy &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D"651" git -C bare worktree add --detach ../g=
oozy &&
 =09test_cmp hook.expect goozy/hook.actual
 '
=20
@@ -1165,8 +1165,9 @@ test_expect_success '"add" not tripped up by magic wo=
rktree matching"' '
 '
=20
 test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
-=09git worktree add --detach ".  weird*..?.lock.lock" &&
-=09test -d .git/worktrees/---weird-.-
+=09GIT_TEST_WORKTREE_SUFFIX=3D"1234" \
+=09=09git worktree add --detach ".  weird*..?.lock.lock" &&
+=09test -d .git/worktrees/---weird-.--1234
 '
=20
 test_expect_success '"add" should not fail because of another bad worktree=
' '
@@ -1210,23 +1211,23 @@ test_expect_success '"add" with initialized submodu=
le, with submodule.recurse se
 test_expect_success 'can create worktrees with relative paths' '
 =09test_when_finished "git worktree remove relative" &&
 =09test_config worktree.useRelativePaths false &&
-=09git worktree add --relative-paths ./relative &&
-=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add --relative-paths ./rela=
tive &&
+=09echo "gitdir: ../.git/worktrees/relative-123" >expect &&
 =09test_cmp expect relative/.git &&
 =09echo "../../../relative/.git" >expect &&
-=09test_cmp expect .git/worktrees/relative/gitdir
+=09test_cmp expect .git/worktrees/relative-123/gitdir
 '
=20
 test_expect_success 'can create worktrees with absolute paths' '
 =09test_config worktree.useRelativePaths true &&
-=09git worktree add ./relative &&
-=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add ./relative &&
+=09echo "gitdir: ../.git/worktrees/relative-123" >expect &&
 =09test_cmp expect relative/.git &&
-=09git worktree add --no-relative-paths ./absolute &&
-=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree add --no-relative-paths ./a=
bsolute &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute-456" >expect &&
 =09test_cmp expect absolute/.git &&
 =09echo "$(pwd)/absolute/.git" >expect &&
-=09test_cmp expect .git/worktrees/absolute/gitdir
+=09test_cmp expect .git/worktrees/absolute-456/gitdir
 '
=20
 test_expect_success 'move repo without breaking relative internal links' '
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 5eb52b9abbf29514dc082c260ebb7a5e8e63aae0..856fcdd19d376d3448ee0be4659=
2fe68d44617c4 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -83,29 +83,29 @@ test_expect_success 'not prune locked checkout' '
 test_expect_success 'not prune recent checkouts' '
 =09test_when_finished rm -r .git/worktrees &&
 =09git worktree add jlm HEAD &&
-=09test -d .git/worktrees/jlm &&
+=09test -d .git/worktrees/jlm-* &&
 =09rm -rf jlm &&
 =09git worktree prune --verbose --expire=3D2.days.ago &&
-=09test -d .git/worktrees/jlm
+=09test -d .git/worktrees/jlm-*
 '
=20
 test_expect_success 'not prune proper checkouts' '
 =09test_when_finished rm -r .git/worktrees &&
 =09git worktree add --detach "$PWD/nop" main &&
 =09git worktree prune &&
-=09test -d .git/worktrees/nop
+=09test -d .git/worktrees/nop-*
 '
=20
 test_expect_success 'prune duplicate (linked/linked)' '
 =09test_when_finished rm -fr .git/worktrees w1 w2 &&
-=09git worktree add --detach w1 &&
-=09git worktree add --detach w2 &&
-=09sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &=
&
-=09mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D1 git worktree add --detach w1 &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D2 git worktree add --detach w2 &&
+=09sed "s/w2/w1/" .git/worktrees/w2-2/gitdir >.git/worktrees/w2-2/gitdir.n=
ew &&
+=09mv .git/worktrees/w2-2/gitdir.new .git/worktrees/w2-2/gitdir &&
 =09git worktree prune --verbose 2>actual &&
 =09test_grep "duplicate entry" actual &&
-=09test -d .git/worktrees/w1 &&
-=09! test -d .git/worktrees/w2
+=09test -d .git/worktrees/w1-1 &&
+=09! test -d .git/worktrees/w2-2
 '
=20
 test_expect_success 'prune duplicate (main/linked)' '
@@ -117,7 +117,7 @@ test_expect_success 'prune duplicate (main/linked)' '
 =09mv repo wt &&
 =09git -C wt worktree prune --verbose 2>actual &&
 =09test_grep "duplicate entry" actual &&
-=09! test -d .git/worktrees/wt
+=09! test -d .git/worktrees/wt-*
 '
=20
 test_expect_success 'not prune proper worktrees inside linked worktree wit=
h relative paths' '
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 422c1a05580057b18ab8bfdfe38da4d723749493..ba3f05c16a4969fb84d98052ae3=
75ef162f3e73a 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -24,27 +24,27 @@ test_expect_success 'lock main worktree' '
 test_expect_success 'lock linked worktree' '
 =09git worktree lock --reason hahaha source &&
 =09echo hahaha >expected &&
-=09test_cmp expected .git/worktrees/source/locked
+=09test_cmp expected .git/worktrees/source-*/locked
 '
=20
 test_expect_success 'lock linked worktree from another worktree' '
-=09rm .git/worktrees/source/locked &&
+=09rm .git/worktrees/source-*/locked &&
 =09git worktree add elsewhere &&
 =09git -C elsewhere worktree lock --reason hahaha ../source &&
 =09echo hahaha >expected &&
-=09test_cmp expected .git/worktrees/source/locked
+=09test_cmp expected .git/worktrees/source-*/locked
 '
=20
 test_expect_success 'lock worktree twice' '
 =09test_must_fail git worktree lock source &&
 =09echo hahaha >expected &&
-=09test_cmp expected .git/worktrees/source/locked
+=09test_cmp expected .git/worktrees/source-*/locked
 '
=20
 test_expect_success 'lock worktree twice (from the locked worktree)' '
 =09test_must_fail git -C source worktree lock . &&
 =09echo hahaha >expected &&
-=09test_cmp expected .git/worktrees/source/locked
+=09test_cmp expected .git/worktrees/source-*/locked
 '
=20
 test_expect_success 'unlock main worktree' '
@@ -183,19 +183,19 @@ test_expect_success 'force remove worktree with untra=
cked file' '
=20
 test_expect_success 'remove missing worktree' '
 =09git worktree add to-be-gone &&
-=09test -d .git/worktrees/to-be-gone &&
+=09test -d .git/worktrees/to-be-gone-* &&
 =09mv to-be-gone gone &&
 =09git worktree remove to-be-gone &&
-=09test_path_is_missing .git/worktrees/to-be-gone
+=09test_path_is_missing .git/worktrees/to-be-gone-*
 '
=20
 test_expect_success 'NOT remove missing-but-locked worktree' '
 =09git worktree add gone-but-locked &&
 =09git worktree lock gone-but-locked &&
-=09test -d .git/worktrees/gone-but-locked &&
+=09test -d .git/worktrees/gone-but-locked-* &&
 =09mv gone-but-locked really-gone-now &&
 =09test_must_fail git worktree remove gone-but-locked &&
-=09test_path_is_dir .git/worktrees/gone-but-locked
+=09test_path_is_dir .git/worktrees/gone-but-locked-*
 '
=20
 test_expect_success 'proper error when worktree not found' '
@@ -249,27 +249,27 @@ test_expect_success 'not remove a repo with initializ=
ed submodule' '
=20
 test_expect_success 'move worktree with absolute path to relative path' '
 =09test_config worktree.useRelativePaths false &&
-=09git worktree add ./absolute &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add ./absolute &&
 =09git worktree move --relative-paths absolute relative &&
-=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09echo "gitdir: ../.git/worktrees/absolute-123" >expect &&
 =09test_cmp expect relative/.git &&
 =09echo "../../../relative/.git" >expect &&
-=09test_cmp expect .git/worktrees/absolute/gitdir &&
+=09test_cmp expect .git/worktrees/absolute-123/gitdir &&
 =09test_config worktree.useRelativePaths true &&
 =09git worktree move relative relative2 &&
-=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09echo "gitdir: ../.git/worktrees/absolute-123" >expect &&
 =09test_cmp expect relative2/.git &&
 =09echo "../../../relative2/.git" >expect &&
-=09test_cmp expect .git/worktrees/absolute/gitdir
+=09test_cmp expect .git/worktrees/absolute-123/gitdir
 '
=20
 test_expect_success 'move worktree with relative path to absolute path' '
 =09test_config worktree.useRelativePaths true &&
 =09git worktree move --no-relative-paths relative2 absolute &&
-=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute-123" >expect &&
 =09test_cmp expect absolute/.git &&
 =09echo "$(pwd)/absolute/.git" >expect &&
-=09test_cmp expect .git/worktrees/absolute/gitdir
+=09test_cmp expect .git/worktrees/absolute-123/gitdir
 '
=20
 test_done
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index 1d7f60563387f9c2f53dfc3a79ac0289afe57611..5479b2a74aa0d9b1e8880ed7c03=
8307ffa1d0c54 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -9,6 +9,7 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 base_path=3D$(pwd -P)
+suffix=3D4567
=20
 test_expect_success 'setup: create origin repos'  '
 =09git config --global protocol.file.allow always &&
@@ -61,9 +62,10 @@ test_expect_success 'submodule is checked out after manu=
ally adding submodule wo
 '
=20
 test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submo=
dules in a linked worktree' '
-=09git -C main worktree add "$base_path/checkout-recurse" --detach  &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D$suffix \
+=09=09git -C main worktree add "$base_path/checkout-recurse" --detach  &&
 =09git -C checkout-recurse submodule update --init &&
-=09echo "gitdir: ../../main/.git/worktrees/checkout-recurse/modules/sub" >=
expect-gitfile &&
+=09echo "gitdir: ../../main/.git/worktrees/checkout-recurse-$suffix/module=
s/sub" >expect-gitfile &&
 =09cat checkout-recurse/sub/.git >actual-gitfile &&
 =09test_cmp expect-gitfile actual-gitfile &&
 =09git -C main/sub rev-parse HEAD >expect-head-main &&
@@ -82,14 +84,14 @@ test_expect_success 'core.worktree is removed in $GIT_D=
IR/modules/<name>/config,
 =09git -C checkout-recurse/sub config --get core.worktree >actual-linked &=
&
 =09test_cmp expect-linked actual-linked &&
 =09git -C checkout-recurse checkout --recurse-submodules first &&
-=09test_expect_code 1 git -C main/.git/worktrees/checkout-recurse/modules/=
sub config --get core.worktree >linked-config &&
+=09test_expect_code 1 git -C main/.git/worktrees/checkout-recurse-$suffix/=
modules/sub config --get core.worktree >linked-config &&
 =09test_must_be_empty linked-config &&
 =09git -C main/sub config --get core.worktree >actual-main &&
 =09test_cmp expect-main actual-main
 '
=20
 test_expect_success 'unsetting core.worktree does not prevent running comm=
ands directly against the submodule repository' '
-=09git -C main/.git/worktrees/checkout-recurse/modules/sub log
+=09git -C main/.git/worktrees/checkout-recurse-$suffix/modules/sub log
 '
=20
 test_done
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 49b70b999518d47e1edd72a61a847b427f4c67a1..49d020f5fe786014ddc428bcb74=
cb706f8cef3d1 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -106,8 +106,8 @@ test_expect_success 'repo not found; .git not file' '
=20
 test_expect_success 'repo not found; .git not referencing repo' '
 =09test_when_finished "rm -rf side not-a-repo && git worktree prune" &&
-=09git worktree add --detach side &&
-=09sed s,\.git/worktrees/side$,not-a-repo, side/.git >side/.newgit &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D1234 git worktree add --detach side &&
+=09sed s,\.git/worktrees/side-1234$,not-a-repo, side/.git >side/.newgit &&
 =09mv side/.newgit side/.git &&
 =09mkdir not-a-repo &&
 =09test_must_fail git worktree repair side 2>err &&
@@ -127,41 +127,41 @@ test_expect_success 'repo not found; .git file broken=
' '
 test_expect_success 'repair broken gitdir' '
 =09test_when_finished "rm -rf orig moved && git worktree prune" &&
 =09git worktree add --detach orig &&
-=09sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
-=09rm .git/worktrees/orig/gitdir &&
+=09sed s,orig/\.git$,moved/.git, .git/worktrees/orig-*/gitdir >expect &&
+=09rm .git/worktrees/orig-*/gitdir &&
 =09mv orig moved &&
 =09git worktree repair moved 2>err &&
-=09test_cmp expect .git/worktrees/orig/gitdir &&
+=09test_cmp expect .git/worktrees/orig-*/gitdir &&
 =09test_grep "gitdir unreadable" err
 '
=20
 test_expect_success 'repair incorrect gitdir' '
 =09test_when_finished "rm -rf orig moved && git worktree prune" &&
 =09git worktree add --detach orig &&
-=09sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+=09sed s,orig/\.git$,moved/.git, .git/worktrees/orig-*/gitdir >expect &&
 =09mv orig moved &&
 =09git worktree repair moved 2>err &&
-=09test_cmp expect .git/worktrees/orig/gitdir &&
+=09test_cmp expect .git/worktrees/orig-*/gitdir &&
 =09test_grep "gitdir incorrect" err
 '
=20
 test_expect_success 'repair gitdir (implicit) from linked worktree' '
 =09test_when_finished "rm -rf orig moved && git worktree prune" &&
 =09git worktree add --detach orig &&
-=09sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+=09sed s,orig/\.git$,moved/.git, .git/worktrees/orig-*/gitdir >expect &&
 =09mv orig moved &&
 =09git -C moved worktree repair 2>err &&
-=09test_cmp expect .git/worktrees/orig/gitdir &&
+=09test_cmp expect .git/worktrees/orig-*/gitdir &&
 =09test_grep "gitdir incorrect" err
 '
=20
 test_expect_success 'unable to repair gitdir (implicit) from main worktree=
' '
 =09test_when_finished "rm -rf orig moved && git worktree prune" &&
 =09git worktree add --detach orig &&
-=09cat .git/worktrees/orig/gitdir >expect &&
+=09cat .git/worktrees/orig-*/gitdir >expect &&
 =09mv orig moved &&
 =09git worktree repair 2>err &&
-=09test_cmp expect .git/worktrees/orig/gitdir &&
+=09test_cmp expect .git/worktrees/orig-*/gitdir &&
 =09test_must_be_empty err
 '
=20
@@ -170,15 +170,15 @@ test_expect_success 'repair multiple gitdir files' '
 =09=09git worktree prune" &&
 =09git worktree add --detach orig1 &&
 =09git worktree add --detach orig2 &&
-=09sed s,orig1/\.git$,moved1/.git, .git/worktrees/orig1/gitdir >expect1 &&
-=09sed s,orig2/\.git$,moved2/.git, .git/worktrees/orig2/gitdir >expect2 &&
+=09sed s,orig1/\.git$,moved1/.git, .git/worktrees/orig1-*/gitdir >expect1 =
&&
+=09sed s,orig2/\.git$,moved2/.git, .git/worktrees/orig2-*/gitdir >expect2 =
&&
 =09mv orig1 moved1 &&
 =09mv orig2 moved2 &&
 =09git worktree repair moved1 moved2 2>err &&
-=09test_cmp expect1 .git/worktrees/orig1/gitdir &&
-=09test_cmp expect2 .git/worktrees/orig2/gitdir &&
-=09test_grep "gitdir incorrect:.*orig1/gitdir$" err &&
-=09test_grep "gitdir incorrect:.*orig2/gitdir$" err
+=09test_cmp expect1 .git/worktrees/orig1-*/gitdir &&
+=09test_cmp expect2 .git/worktrees/orig2-*/gitdir &&
+=09test_grep "gitdir incorrect:.*orig1-.*/gitdir$" err &&
+=09test_grep "gitdir incorrect:.*orig2-.*/gitdir$" err
 '
=20
 test_expect_success 'repair moved main and linked worktrees' '
@@ -186,14 +186,12 @@ test_expect_success 'repair moved main and linked wor=
ktrees' '
 =09test_create_repo main &&
 =09test_commit -C main init &&
 =09git -C main worktree add --detach ../side &&
-=09sed "s,side/\.git$,sidemoved/.git," \
-=09=09main/.git/worktrees/side/gitdir >expect-gitdir &&
-=09sed "s,main/.git/worktrees/side$,mainmoved/.git/worktrees/side," \
-=09=09side/.git >expect-gitfile &&
+=09sed "s,side,sidemoved," main/.git/worktrees/side-*/gitdir >expect-gitdi=
r &&
+=09sed "s,main,mainmoved," side/.git >expect-gitfile &&
 =09mv main mainmoved &&
 =09mv side sidemoved &&
 =09git -C mainmoved worktree repair ../sidemoved &&
-=09test_cmp expect-gitdir mainmoved/.git/worktrees/side/gitdir &&
+=09test_cmp expect-gitdir mainmoved/.git/worktrees/side-*/gitdir &&
 =09test_cmp expect-gitfile sidemoved/.git
 '
=20
@@ -203,16 +201,15 @@ test_expect_success 'repair copied main and linked wo=
rktrees' '
 =09git -C orig init main &&
 =09test_commit -C orig/main nothing &&
 =09git -C orig/main worktree add ../linked &&
-=09cp orig/main/.git/worktrees/linked/gitdir orig/main.expect &&
+=09cp orig/main/.git/worktrees/linked-*/gitdir orig/main.expect &&
 =09cp orig/linked/.git orig/linked.expect &&
 =09cp -R orig dup &&
 =09sed "s,orig/linked/\.git$,dup/linked/.git," orig/main.expect >dup/main.=
expect &&
-=09sed "s,orig/main/\.git/worktrees/linked$,dup/main/.git/worktrees/linked=
," \
-=09=09orig/linked.expect >dup/linked.expect &&
+=09sed "s,orig,dup," orig/linked.expect >dup/linked.expect &&
 =09git -C dup/main worktree repair ../linked &&
-=09test_cmp orig/main.expect orig/main/.git/worktrees/linked/gitdir &&
+=09test_cmp orig/main.expect orig/main/.git/worktrees/linked-*/gitdir &&
 =09test_cmp orig/linked.expect orig/linked/.git &&
-=09test_cmp dup/main.expect dup/main/.git/worktrees/linked/gitdir &&
+=09test_cmp dup/main.expect dup/main/.git/worktrees/linked-*/gitdir &&
 =09test_cmp dup/linked.expect dup/linked/.git
 '
=20
@@ -221,11 +218,11 @@ test_expect_success 'repair worktree with relative pa=
th with missing gitfile' '
 =09test_create_repo main &&
 =09git -C main config worktree.useRelativePaths true &&
 =09test_commit -C main init &&
-=09git -C main worktree add --detach ../wt &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git -C main worktree add --detach ../wt =
&&
 =09rm wt/.git &&
 =09test_path_is_missing wt/.git &&
 =09git -C main worktree repair &&
-=09echo "gitdir: ../main/.git/worktrees/wt" >expect &&
+=09echo "gitdir: ../main/.git/worktrees/wt-123" >expect &&
 =09test_cmp expect wt/.git
 '
=20
@@ -233,12 +230,12 @@ test_expect_success 'repair absolute worktree to use =
relative paths' '
 =09test_when_finished "rm -rf main side sidemoved" &&
 =09test_create_repo main &&
 =09test_commit -C main init &&
-=09git -C main worktree add --detach ../side &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git -C main worktree add --detach ../sid=
e &&
 =09echo "../../../../sidemoved/.git" >expect-gitdir &&
-=09echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
+=09echo "gitdir: ../main/.git/worktrees/side-456" >expect-gitfile &&
 =09mv side sidemoved &&
 =09git -C main worktree repair --relative-paths ../sidemoved &&
-=09test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+=09test_cmp expect-gitdir main/.git/worktrees/side-456/gitdir &&
 =09test_cmp expect-gitfile sidemoved/.git
 '
=20
@@ -246,13 +243,39 @@ test_expect_success 'repair relative worktree to use =
absolute paths' '
 =09test_when_finished "rm -rf main side sidemoved" &&
 =09test_create_repo main &&
 =09test_commit -C main init &&
-=09git -C main worktree add --relative-paths --detach ../side &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D789 git -C main worktree add --relative-path=
s --detach ../side &&
 =09echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
-=09echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
+=09echo "gitdir: $(pwd)/main/.git/worktrees/side-789" >expect-gitfile &&
 =09mv side sidemoved &&
 =09git -C main worktree repair ../sidemoved &&
-=09test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+=09test_cmp expect-gitdir main/.git/worktrees/side-789/gitdir &&
 =09test_cmp expect-gitfile sidemoved/.git
 '
=20
+test_expect_success 'does not repair worktrees from another repo' '
+=09test_when_finished "rm -rf repo1 repo2" &&
+=09mkdir -p repo1 &&
+=09git -C repo1 init main &&
+=09test_commit -C repo1/main nothing &&
+=09git -C repo1/main worktree add ../linked &&
+=09cp repo1/main/.git/worktrees/linked-*/gitdir repo1/main.expect &&
+=09cp repo1/linked/.git repo1/linked.expect &&
+=09mkdir -p repo2 &&
+=09git -C repo2 init main &&
+=09test_commit -C repo2/main nothing &&
+=09git -C repo2/main worktree add ../linked &&
+=09cp repo2/main/.git/worktrees/linked-*/gitdir repo2/main.expect &&
+=09cp repo2/linked/.git repo2/linked.expect &&
+=09git -C repo1/main worktree repair ../../repo2/linked &&
+=09test_cmp repo1/main.expect repo1/main/.git/worktrees/linked-*/gitdir &&
+=09test_cmp repo1/linked.expect repo1/linked/.git &&
+=09test_cmp repo2/main.expect repo2/main/.git/worktrees/linked-*/gitdir &&
+=09test_cmp repo2/linked.expect repo2/linked/.git &&
+=09git -C repo2/main worktree repair ../../repo1/linked &&
+=09test_cmp repo1/main.expect repo1/main/.git/worktrees/linked-*/gitdir &&
+=09test_cmp repo1/linked.expect repo1/linked/.git &&
+=09test_cmp repo2/main.expect repo2/main/.git/worktrees/linked-*/gitdir &&
+=09test_cmp repo2/linked.expect repo2/linked/.git
+'
+
 test_done
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index f6835c91dcc49cfeb23881fe0ef7a96629bfb2e6..1587dadfd1e1fa122edccc62ffd=
9aa4c20f0ec80 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -19,7 +19,8 @@ test_expect_success 'setup' '
 =09=09test_commit $i &&
 =09=09git branch wt-$i &&
 =09=09git branch fake-$i &&
-=09=09git worktree add wt-$i wt-$i || return 1
+=09=09GIT_TEST_WORKTREE_SUFFIX=3D$i \
+=09=09=09git worktree add wt-$i wt-$i || return 1
 =09done &&
=20
 =09# Create a server that updates each branch by one commit
@@ -132,20 +133,20 @@ test_expect_success 'refuse to overwrite when in erro=
r states' '
 =09test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
=20
 =09# Both branches are currently under rebase.
-=09mkdir -p .git/worktrees/wt-3/rebase-merge &&
-=09touch .git/worktrees/wt-3/rebase-merge/interactive &&
-=09echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
-=09echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
-=09mkdir -p .git/worktrees/wt-4/rebase-merge &&
-=09touch .git/worktrees/wt-4/rebase-merge/interactive &&
-=09echo refs/heads/fake-2 >.git/worktrees/wt-4/rebase-merge/head-name &&
-=09echo refs/heads/fake-1 >.git/worktrees/wt-4/rebase-merge/onto &&
+=09mkdir -p .git/worktrees/wt-3-3/rebase-merge &&
+=09touch .git/worktrees/wt-3-3/rebase-merge/interactive &&
+=09echo refs/heads/fake-1 >.git/worktrees/wt-3-3/rebase-merge/head-name &&
+=09echo refs/heads/fake-2 >.git/worktrees/wt-3-3/rebase-merge/onto &&
+=09mkdir -p .git/worktrees/wt-4-4/rebase-merge &&
+=09touch .git/worktrees/wt-4-4/rebase-merge/interactive &&
+=09echo refs/heads/fake-2 >.git/worktrees/wt-4-4/rebase-merge/head-name &&
+=09echo refs/heads/fake-1 >.git/worktrees/wt-4-4/rebase-merge/onto &&
=20
 =09# Both branches are currently under bisect.
-=09touch .git/worktrees/wt-4/BISECT_LOG &&
-=09echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
-=09touch .git/worktrees/wt-1/BISECT_LOG &&
-=09echo refs/heads/fake-1 >.git/worktrees/wt-1/BISECT_START &&
+=09touch .git/worktrees/wt-4-4/BISECT_LOG &&
+=09echo refs/heads/fake-2 >.git/worktrees/wt-4-4/BISECT_START &&
+=09touch .git/worktrees/wt-1-1/BISECT_LOG &&
+=09echo refs/heads/fake-1 >.git/worktrees/wt-1-1/BISECT_START &&
=20
 =09for i in 1 2
 =09do
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ccfa6a720d090c2f7f2a085f60065bdcfaf8d1d9..e44497ac94394119662115b1f6a=
a035c7f0565d2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -246,14 +246,14 @@ test_expect_success 'git branch -M baz bam should suc=
ceed when baz is checked ou
 '
=20
 test_expect_success REFFILES 'git branch -M fails if updating any linked w=
orking tree fails' '
-=09git worktree add -b baz bazdir1 &&
-=09git worktree add -f bazdir2 baz &&
-=09touch .git/worktrees/bazdir1/HEAD.lock &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add -b baz bazdir1 &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree add -f bazdir2 baz &&
+=09touch .git/worktrees/bazdir1-123/HEAD.lock &&
 =09test_must_fail git branch -M baz bam &&
 =09test $(git -C bazdir2 rev-parse --abbrev-ref HEAD) =3D bam &&
 =09git branch -M bam baz &&
-=09rm .git/worktrees/bazdir1/HEAD.lock &&
-=09touch .git/worktrees/bazdir2/HEAD.lock &&
+=09rm .git/worktrees/bazdir1-123/HEAD.lock &&
+=09touch .git/worktrees/bazdir2-456/HEAD.lock &&
 =09test_must_fail git branch -M baz bam &&
 =09test $(git -C bazdir1 rev-parse --abbrev-ref HEAD) =3D bam &&
 =09rm -rf bazdir1 bazdir2 &&
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e641df0116c24404e4892a0e30af4ef4bf8db493..0e98c6627a98ed197d7ab1ff41e=
8dd41eeaff3ac 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -293,7 +293,7 @@ test_expect_success 'prune: handle HEAD in multiple wor=
ktrees' '
 =09echo "new blob for third-worktree" >third-worktree/blob &&
 =09git -C third-worktree add blob &&
 =09git -C third-worktree commit -m "third" &&
-=09rm .git/worktrees/third-worktree/index &&
+=09rm .git/worktrees/third-worktree-*/index &&
 =09test_must_fail git -C third-worktree show :blob &&
 =09git prune --expire=3Dnow &&
 =09git -C third-worktree show HEAD:blob >actual &&
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbg=
itdirs.sh
index f77832185765585e2bda1677f8cbbe13841127f7..acf9544e35966f054cbc90c37e8=
4377c9f461f2b 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -123,7 +123,7 @@ test_expect_success 'absorb the git dir outside of prim=
ary worktree' '
 =09test_when_finished "rm -rf repo-bare.git" &&
 =09git clone --bare . repo-bare.git &&
 =09test_when_finished "rm -rf repo-wt" &&
-=09git -C repo-bare.git worktree add ../repo-wt &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git -C repo-bare.git worktree add ../rep=
o-wt &&
=20
 =09test_when_finished "rm -f .gitconfig" &&
 =09test_config_global protocol.file.allow always &&
@@ -134,7 +134,7 @@ test_expect_success 'absorb the git dir outside of prim=
ary worktree' '
 =09cat >expect <<-EOF &&
 =09Migrating git directory of '\''sub2'\'' from
 =09'\''$cwd/repo-wt/sub2/.git'\'' to
-=09'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
+=09'\''$cwd/repo-bare.git/worktrees/repo-wt-123/modules/sub2'\''
 =09EOF
 =09git -C repo-wt submodule absorbgitdirs 2>actual &&
 =09test_cmp expect actual

--=20
2.47.0


