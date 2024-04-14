Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8117551
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057129; cv=none; b=as/76n2VU/XSDwyBRljpdlhOtQq9aAX8d9PiMOmmNWBM/eMCAUk196D1w0XRDn+pVnNpEM3dYYRS3GHOSYlkelZz4MDHDMvXtatrbB4HN+659tJ7r87/2N99bJLBl4lsMUPSKm6YbIuIX8+cfQy9wo/gdAHtAjHgrwvBs7R1NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057129; c=relaxed/simple;
	bh=hpLbiifPi9kUCcQBn1c8fAleglk+BVBpzv6VaD6EQ9U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDYvxig9CSTHpxC+k1Fo3voO5qtbAJGwRDGJDuw6qXFUxB+sF9G7HjchU8j8/ahHSOHvzXuhPrHE/U6vMv6VwuWK+3hviXJ3uz1PYsLKlJaoiAvziX/l4vCg8afvhxRy3nTNJCv3R/mJ4PGbQlwBTCRIkp6NJOUpchp1P98Krfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=N9pKNROP; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="N9pKNROP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057118; x=1713316318;
	bh=1kJeKVqeWJq7EopYberIBt1W1zjNATGsHzkKamvXisc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N9pKNROPOPb1MoO9JRab/pDlc+OLyBUGu6iESirNkRaI6GHgYf8gx+eZ+ahHwaQWt
	 pViLug2HwBiDhQw70h6ghi+UnROuhiekTl1WT3sVBTvNx7mb+k1rtY9ces3YtY4moA
	 WQ6+AiBXOUMlpTaTf3bfeNb0j8QEtluwyo8v0uPh6bQgTWPMdiAp932ZGGYG4whsrR
	 WOdSDPSS7Qfp7YxDKvPbpb0ynAnzWcQgagAfQgfjBPQ3uqWgTeuS4GPRS6BJqahMFf
	 mzogauc+KjaRNfMXREY8iPgjcx31EdGFKYod32T51WSGvHQ9NJUhWcsyIWVuBq5jDy
	 +4AqP02rvyMeA==
Date: Sun, 14 Apr 2024 01:11:52 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 3/8] fast-import: allow unquoted empty path for root
Message-ID: <cae5764cec349d295035f2b910a5a00f12cb7908.1713056559.git.thalia@archibald.dev>
In-Reply-To: <cover.1713056559.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev> <cover.1713056559.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ever since filerename was added in f39a946a1f (Support wholesale
directory renames in fast-import, 2007-07-09) and filecopy in b6f3481bb4
(Teach fast-import to recursively copy files/directories, 2007-07-15),
both have produced an error when the destination path is empty. Later,
when support for targeting the root directory with an empty string was
added in 2794ad5244 (fast-import: Allow filemodify to set the root,
2010-10-10), this had the effect of allowing the quoted empty string
(`""`), but forbidding its unquoted variant (``). This seems to have
been intended as simple data validation for parsing two paths, rather
than a syntax restriction, because it was not extended to the other
operations.

All other occurrences of paths (in filemodify, filedelete, the source of
filecopy and filerename, and ls) allow both.

For most of this feature's lifetime, the documentation has not
prescribed the use of quoted empty strings. In e5959106d6
(Documentation/fast-import: put explanation of M 040000 <dataref> "" in
context, 2011-01-15), its documentation was changed from =E2=80=9C`<path>` =
may
also be an empty string (`""`) to specify the root of the tree=E2=80=9D to =
=E2=80=9CThe
root of the tree can be represented by an empty string as `<path>`=E2=80=
=9D.

Thus, we should assume that some front-ends have depended on this
behavior.

Remove this restriction for the destination paths of filecopy and
filerename and change tests targeting the root to test `""` and ``.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c  |   3 -
 t/t9300-fast-import.sh | 363 +++++++++++++++++++++--------------------
 2 files changed, 190 insertions(+), 176 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 765429a66c..c8a1e3ef3d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2423,9 +2423,6 @@ static void file_change_cr(const char *p, struct bran=
ch *b, int rename)
=20
 =09strbuf_reset(&source);
 =09parse_path_space(&source, p, &p, "source");
-
-=09if (!*p)
-=09=09die("Missing dest: %s", command_buf.buf);
 =09strbuf_reset(&dest);
 =09parse_path_eol(&dest, p, "dest");
=20
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index de2f1304e8..13f98e6688 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1059,30 +1059,33 @@ test_expect_success 'M: rename subdirectory to new =
subdirectory' '
 =09compare_diff_raw expect actual
 '
=20
-test_expect_success 'M: rename root to subdirectory' '
-=09cat >input <<-INPUT_END &&
-=09commit refs/heads/M4
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09rename root
-=09COMMIT
+for root in '""' ''
+do
+=09test_expect_success "M: rename root ($root) to subdirectory" '
+=09=09cat >input <<-INPUT_END &&
+=09=09commit refs/heads/M4
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09rename root
+=09=09COMMIT
=20
-=09from refs/heads/M2^0
-=09R "" sub
+=09=09from refs/heads/M2^0
+=09=09R $root sub
=20
-=09INPUT_END
+=09=09INPUT_END
=20
-=09cat >expect <<-EOF &&
-=09:100644 100644 $oldf $oldf R100=09file2/oldf=09sub/file2/oldf
-=09:100755 100755 $f4id $f4id R100=09file4=09sub/file4
-=09:100755 100755 $newf $newf R100=09i/am/new/to/you=09sub/i/am/new/to/you
-=09:100755 100755 $f6id $f6id R100=09newdir/exec.sh=09sub/newdir/exec.sh
-=09:100644 100644 $f5id $f5id R100=09newdir/interesting=09sub/newdir/inter=
esting
-=09EOF
-=09git fast-import <input &&
-=09git diff-tree -M -r M4^ M4 >actual &&
-=09compare_diff_raw expect actual
-'
+=09=09cat >expect <<-EOF &&
+=09=09:100644 100644 $oldf $oldf R100=09file2/oldf=09sub/file2/oldf
+=09=09:100755 100755 $f4id $f4id R100=09file4=09sub/file4
+=09=09:100755 100755 $newf $newf R100=09i/am/new/to/you=09sub/i/am/new/to/=
you
+=09=09:100755 100755 $f6id $f6id R100=09newdir/exec.sh=09sub/newdir/exec.s=
h
+=09=09:100644 100644 $f5id $f5id R100=09newdir/interesting=09sub/newdir/in=
teresting
+=09=09EOF
+=09=09git fast-import <input &&
+=09=09git diff-tree -M -r M4^ M4 >actual &&
+=09=09compare_diff_raw expect actual
+=09'
+done
=20
 ###
 ### series N
@@ -1259,49 +1262,52 @@ test_expect_success PIPE 'N: empty directory reads =
as missing' '
 =09test_cmp expect actual
 '
=20
-test_expect_success 'N: copy root directory by tree hash' '
-=09cat >expect <<-EOF &&
-=09:100755 000000 $newf $zero D=09file3/newf
-=09:100644 000000 $oldf $zero D=09file3/oldf
-=09EOF
-=09root=3D$(git rev-parse refs/heads/branch^0^{tree}) &&
-=09cat >input <<-INPUT_END &&
-=09commit refs/heads/N6
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09copy root directory by tree hash
-=09COMMIT
+for root in '""' ''
+do
+=09test_expect_success "N: copy root ($root) by tree hash" '
+=09=09cat >expect <<-EOF &&
+=09=09:100755 000000 $newf $zero D=09file3/newf
+=09=09:100644 000000 $oldf $zero D=09file3/oldf
+=09=09EOF
+=09=09root_tree=3D$(git rev-parse refs/heads/branch^0^{tree}) &&
+=09=09cat >input <<-INPUT_END &&
+=09=09commit refs/heads/N6
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09copy root directory by tree hash
+=09=09COMMIT
=20
-=09from refs/heads/branch^0
-=09M 040000 $root ""
-=09INPUT_END
-=09git fast-import <input &&
-=09git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
-=09compare_diff_raw expect actual
-'
+=09=09from refs/heads/branch^0
+=09=09M 040000 $root_tree $root
+=09=09INPUT_END
+=09=09git fast-import <input &&
+=09=09git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
+=09=09compare_diff_raw expect actual
+=09'
=20
-test_expect_success 'N: copy root by path' '
-=09cat >expect <<-EOF &&
-=09:100755 100755 $newf $newf C100=09file2/newf=09oldroot/file2/newf
-=09:100644 100644 $oldf $oldf C100=09file2/oldf=09oldroot/file2/oldf
-=09:100755 100755 $f4id $f4id C100=09file4=09oldroot/file4
-=09:100755 100755 $f6id $f6id C100=09newdir/exec.sh=09oldroot/newdir/exec.=
sh
-=09:100644 100644 $f5id $f5id C100=09newdir/interesting=09oldroot/newdir/i=
nteresting
-=09EOF
-=09cat >input <<-INPUT_END &&
-=09commit refs/heads/N-copy-root-path
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09copy root directory by (empty) path
-=09COMMIT
+=09test_expect_success "N: copy root ($root) by path" '
+=09=09cat >expect <<-EOF &&
+=09=09:100755 100755 $newf $newf C100=09file2/newf=09oldroot/file2/newf
+=09=09:100644 100644 $oldf $oldf C100=09file2/oldf=09oldroot/file2/oldf
+=09=09:100755 100755 $f4id $f4id C100=09file4=09oldroot/file4
+=09=09:100755 100755 $f6id $f6id C100=09newdir/exec.sh=09oldroot/newdir/ex=
ec.sh
+=09=09:100644 100644 $f5id $f5id C100=09newdir/interesting=09oldroot/newdi=
r/interesting
+=09=09EOF
+=09=09cat >input <<-INPUT_END &&
+=09=09commit refs/heads/N-copy-root-path
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09copy root directory by (empty) path
+=09=09COMMIT
=20
-=09from refs/heads/branch^0
-=09C "" oldroot
-=09INPUT_END
-=09git fast-import <input &&
-=09git diff-tree -C --find-copies-harder -r branch N-copy-root-path >actua=
l &&
-=09compare_diff_raw expect actual
-'
+=09=09from refs/heads/branch^0
+=09=09C $root oldroot
+=09=09INPUT_END
+=09=09git fast-import <input &&
+=09=09git diff-tree -C --find-copies-harder -r branch N-copy-root-path >ac=
tual &&
+=09=09compare_diff_raw expect actual
+=09'
+done
=20
 test_expect_success 'N: delete directory by copying' '
 =09cat >expect <<-\EOF &&
@@ -1431,98 +1437,102 @@ test_expect_success 'N: reject foo/ syntax in ls a=
rgument' '
 =09INPUT_END
 '
=20
-test_expect_success 'N: copy to root by id and modify' '
-=09echo "hello, world" >expect.foo &&
-=09echo hello >expect.bar &&
-=09git fast-import <<-SETUP_END &&
-=09commit refs/heads/N7
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09hello, tree
-=09COMMIT
+for root in '""' ''
+do
+=09test_expect_success "N: copy to root ($root) by id and modify" '
+=09=09echo "hello, world" >expect.foo &&
+=09=09echo hello >expect.bar &&
+=09=09git fast-import <<-SETUP_END &&
+=09=09commit refs/heads/N7
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09hello, tree
+=09=09COMMIT
=20
-=09deleteall
-=09M 644 inline foo/bar
-=09data <<EOF
-=09hello
-=09EOF
-=09SETUP_END
+=09=09deleteall
+=09=09M 644 inline foo/bar
+=09=09data <<EOF
+=09=09hello
+=09=09EOF
+=09=09SETUP_END
=20
-=09tree=3D$(git rev-parse --verify N7:) &&
-=09git fast-import <<-INPUT_END &&
-=09commit refs/heads/N8
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09copy to root by id and modify
-=09COMMIT
+=09=09tree=3D$(git rev-parse --verify N7:) &&
+=09=09git fast-import <<-INPUT_END &&
+=09=09commit refs/heads/N8
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09copy to root by id and modify
+=09=09COMMIT
=20
-=09M 040000 $tree ""
-=09M 644 inline foo/foo
-=09data <<EOF
-=09hello, world
-=09EOF
-=09INPUT_END
-=09git show N8:foo/foo >actual.foo &&
-=09git show N8:foo/bar >actual.bar &&
-=09test_cmp expect.foo actual.foo &&
-=09test_cmp expect.bar actual.bar
-'
+=09=09M 040000 $tree $root
+=09=09M 644 inline foo/foo
+=09=09data <<EOF
+=09=09hello, world
+=09=09EOF
+=09=09INPUT_END
+=09=09git show N8:foo/foo >actual.foo &&
+=09=09git show N8:foo/bar >actual.bar &&
+=09=09test_cmp expect.foo actual.foo &&
+=09=09test_cmp expect.bar actual.bar
+=09'
=20
-test_expect_success 'N: extract subtree' '
-=09branch=3D$(git rev-parse --verify refs/heads/branch^{tree}) &&
-=09cat >input <<-INPUT_END &&
-=09commit refs/heads/N9
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09extract subtree branch:newdir
-=09COMMIT
+=09test_expect_success "N: extract subtree to the root ($root)" '
+=09=09branch=3D$(git rev-parse --verify refs/heads/branch^{tree}) &&
+=09=09cat >input <<-INPUT_END &&
+=09=09commit refs/heads/N9
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09extract subtree branch:newdir
+=09=09COMMIT
=20
-=09M 040000 $branch ""
-=09C "newdir" ""
-=09INPUT_END
-=09git fast-import <input &&
-=09git diff --exit-code branch:newdir N9
-'
+=09=09M 040000 $branch $root
+=09=09C "newdir" $root
+=09=09INPUT_END
+=09=09git fast-import <input &&
+=09=09git diff --exit-code branch:newdir N9
+=09'
=20
-test_expect_success 'N: modify subtree, extract it, and modify again' '
-=09echo hello >expect.baz &&
-=09echo hello, world >expect.qux &&
-=09git fast-import <<-SETUP_END &&
-=09commit refs/heads/N10
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09hello, tree
-=09COMMIT
+=09test_expect_success "N: modify subtree, extract it to the root ($root),=
 and modify again" '
+=09=09echo hello >expect.baz &&
+=09=09echo hello, world >expect.qux &&
+=09=09git fast-import <<-SETUP_END &&
+=09=09commit refs/heads/N10
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09hello, tree
+=09=09COMMIT
=20
-=09deleteall
-=09M 644 inline foo/bar/baz
-=09data <<EOF
-=09hello
-=09EOF
-=09SETUP_END
+=09=09deleteall
+=09=09M 644 inline foo/bar/baz
+=09=09data <<EOF
+=09=09hello
+=09=09EOF
+=09=09SETUP_END
=20
-=09tree=3D$(git rev-parse --verify N10:) &&
-=09git fast-import <<-INPUT_END &&
-=09commit refs/heads/N11
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09copy to root by id and modify
-=09COMMIT
+=09=09tree=3D$(git rev-parse --verify N10:) &&
+=09=09git fast-import <<-INPUT_END &&
+=09=09commit refs/heads/N11
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09copy to root by id and modify
+=09=09COMMIT
=20
-=09M 040000 $tree ""
-=09M 100644 inline foo/bar/qux
-=09data <<EOF
-=09hello, world
-=09EOF
-=09R "foo" ""
-=09C "bar/qux" "bar/quux"
-=09INPUT_END
-=09git show N11:bar/baz >actual.baz &&
-=09git show N11:bar/qux >actual.qux &&
-=09git show N11:bar/quux >actual.quux &&
-=09test_cmp expect.baz actual.baz &&
-=09test_cmp expect.qux actual.qux &&
-=09test_cmp expect.qux actual.quux'
+=09=09M 040000 $tree $root
+=09=09M 100644 inline foo/bar/qux
+=09=09data <<EOF
+=09=09hello, world
+=09=09EOF
+=09=09R "foo" $root
+=09=09C "bar/qux" "bar/quux"
+=09=09INPUT_END
+=09=09git show N11:bar/baz >actual.baz &&
+=09=09git show N11:bar/qux >actual.qux &&
+=09=09git show N11:bar/quux >actual.quux &&
+=09=09test_cmp expect.baz actual.baz &&
+=09=09test_cmp expect.qux actual.qux &&
+=09=09test_cmp expect.qux actual.quux
+=09'
+done
=20
 ###
 ### series O
@@ -3067,6 +3077,7 @@ test_expect_success 'S: ls with garbage after sha1 mu=
st fail' '
 # There are two sorts of ways a path can be parsed, depending on whether i=
t is
 # the last field on the line. Additionally, ls without a <dataref> has a s=
pecial
 # case. Test every occurrence of <path> in the grammar against every error=
 case.
+# Paths for the root (empty strings) are tested elsewhere.
 #
=20
 #
@@ -3321,16 +3332,19 @@ test_path_eol_quoted_fail 'ls (without dataref in c=
ommit)' 'ls ' path
 ###
 # Setup is carried over from series S.
=20
-test_expect_success 'T: ls root tree' '
-=09sed -e "s/Z\$//" >expect <<-EOF &&
-=09040000 tree $(git rev-parse S^{tree})=09Z
-=09EOF
-=09sha1=3D$(git rev-parse --verify S) &&
-=09git fast-import --import-marks=3Dmarks <<-EOF >actual &&
-=09ls $sha1 ""
-=09EOF
-=09test_cmp expect actual
-'
+for root in '""' ''
+do
+=09test_expect_success "T: ls root ($root) tree" '
+=09=09sed -e "s/Z\$//" >expect <<-EOF &&
+=09=09040000 tree $(git rev-parse S^{tree})=09Z
+=09=09EOF
+=09=09sha1=3D$(git rev-parse --verify S) &&
+=09=09git fast-import --import-marks=3Dmarks <<-EOF >actual &&
+=09=09ls $sha1 $root
+=09=09EOF
+=09=09test_cmp expect actual
+=09'
+done
=20
 test_expect_success 'T: delete branch' '
 =09git branch to-delete &&
@@ -3432,30 +3446,33 @@ test_expect_success 'U: validate directory delete r=
esult' '
 =09compare_diff_raw expect actual
 '
=20
-test_expect_success 'U: filedelete root succeeds' '
-=09cat >input <<-INPUT_END &&
-=09commit refs/heads/U
-=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DAT=
E
-=09data <<COMMIT
-=09must succeed
-=09COMMIT
-=09from refs/heads/U^0
-=09D ""
+for root in '""' ''
+do
+=09test_expect_success "U: filedelete root ($root) succeeds" '
+=09=09cat >input <<-INPUT_END &&
+=09=09commit refs/heads/U-delete-root
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09must succeed
+=09=09COMMIT
+=09=09from refs/heads/U^0
+=09=09D $root
=20
-=09INPUT_END
+=09=09INPUT_END
=20
-=09git fast-import <input
-'
+=09=09git fast-import <input
+=09'
=20
-test_expect_success 'U: validate root delete result' '
-=09cat >expect <<-EOF &&
-=09:100644 000000 $f7id $ZERO_OID D=09hello.c
-=09EOF
+=09test_expect_success "U: validate root ($root) delete result" '
+=09=09cat >expect <<-EOF &&
+=09=09:100644 000000 $f7id $ZERO_OID D=09hello.c
+=09=09EOF
=20
-=09git diff-tree -M -r U^1 U >actual &&
+=09=09git diff-tree -M -r U U-delete-root >actual &&
=20
-=09compare_diff_raw expect actual
-'
+=09=09compare_diff_raw expect actual
+=09'
+done
=20
 ###
 ### series V (checkpoint)
--=20
2.44.0


