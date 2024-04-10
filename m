Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2261154C0F
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742915; cv=none; b=ny/mBk6CKYFDMB3+GGIHHYe5W0AXNPi38KGUXUBb4aD4bNfmHSQtUKSjsr0i8ozOOWV+2Y9I1cPd4vDpbm/vG7cRq+XyLyhN0PdMtRwbUs+I0eBkoqSxWETYtPcA42d2/TNM9nbIJiW0v0/CqdrInWnmwQuMLKv9AGaE+9q198c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742915; c=relaxed/simple;
	bh=EhCZnxme7jwhJHVRVa3vUHQFAWYw3X6e4WGXGf/Mmr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkLwyReqgPxjYpvNAo3mdfFk0KVGPKPXXszqDURrqLn4Z6zzgE6iTPzMdtK+u6ko8ecbDjznNdGrJfKmtP7nGEDVOnBj+3miEGlrAQbw1QDWJtRxoh7iUgLTA6n8CVU2c0NJFyOFp3mov6A+rgYZhTXOA7WMW8TpJ70i37+HDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=I89hYoG2; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="I89hYoG2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712742909; x=1713002109;
	bh=JF3DAmftT4PTsUNPerUeoT31Z9ImVGCFWsHyIZAwHr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I89hYoG2mtLb/lU4e7RTp0/vQtM9TRWTIdlRz/ZzHoUObQ4DD1h7Rj6rrcbq1buFt
	 JUHcES0hMuDjbzLPFuTpfzv9aDEvl9UVw6JIslIOus9RbqI4PInVZ1wQ26du2tPhSk
	 +jCEY2mWr3A9db4V9e73vK09NOsYk1oVG9FCPuPUaX6CQtw6jV1PUwbqSl0XFXWDHS
	 UWiP+VBRswi8bigpZhw0PQeZjZGmIWP+BltrEv+eqkRvSfluUUxWXlAYg3+iSwsu8c
	 Xs3LwV/6sYrVsXz6M9pJhPA/EvqV5zU9c+yLt5K192YkCKdqqTIxnMzZX8rdd+yWeI
	 LfS2ixUUmQfLg==
Date: Wed, 10 Apr 2024 09:54:57 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v3 0/8] fast-import: tighten parsing of paths
Message-ID: <cover.1712741870.git.thalia@archibald.dev>
In-Reply-To: <cover.1711960552.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> fast-import has subtle differences in how it parses file paths between ea=
ch
> occurrence of <path> in the grammar. Many errors are suppressed or not ch=
ecked,
> which could lead to silent data corruption. A particularly bad case is wh=
en a
> front-end sent escapes that Git doesn't recognize (e.g., hex escapes are =
not
> supported), it would be treated as literal bytes instead of a quoted stri=
ng.
>
> Bring path parsing into line with the documented behavior and improve
> documentation to fill in missing details.

Updated to address review comments. Thanks, Patrick!

Changes since v2:
* Fix NUL overrun by replacing `strchr(p, ' ')` with `strchrnul(p, ' ')` in
  patch 1/8
* Fix "Missing dest" error condition in patch 1/8
* Test missing space after unquoted path
* Substitute shell parameters in test_expect_success call, instead of with
  string splicing
* Reformat (-subshells
* Rewrap long lines in `parse_path` and `parse_path_space`

Hopefully, this series sends without any rewrapped lines. I use Proton Mail=
 via
Proton Mail Bridge and Apple Mail. I have no idea how to control this, or i=
f I
even can, and see no relevant-looking settings in any of the three. In v2 a=
nd
now v3, I only manually modified the cover letter after using format-patch,=
 not
any of the others.

Thalia


Thalia Archibald (8):
  fast-import: tighten path unquoting
  fast-import: directly use strbufs for paths
  fast-import: allow unquoted empty path for root
  fast-import: remove dead strbuf
  fast-import: improve documentation for unquoted paths
  fast-import: document C-style escapes for paths
  fast-import: forbid escaped NUL in paths
  fast-import: make comments more precise

 Documentation/git-fast-import.txt |  30 +-
 builtin/fast-import.c             | 158 ++++----
 t/t9300-fast-import.sh            | 624 +++++++++++++++++++++---------
 3 files changed, 550 insertions(+), 262 deletions(-)

Range-diff against v2:
1:  e790bdf714 ! 1:  d9ab0c6a75 fast-import: tighten path unquoting
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const c=
har **p)
     + * or unquoted without escape sequences. When unquoted, it may only c=
ontain a
     + * space if `include_spaces` is nonzero.
     + */
    -+static void parse_path(struct strbuf *sb, const char *p, const char *=
*endp, int include_spaces, const char *field)
    ++static void parse_path(struct strbuf *sb, const char *p, const char *=
*endp,
    ++=09=09int include_spaces, const char *field)
     +{
     +=09if (*p =3D=3D '"') {
     +=09=09if (unquote_c_style(sb, p, endp))
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const c=
har **p)
     +=09=09if (include_spaces)
     +=09=09=09*endp =3D p + strlen(p);
     +=09=09else
    -+=09=09=09*endp =3D strchr(p, ' ');
    ++=09=09=09*endp =3D strchrnul(p, ' ');
     +=09=09strbuf_add(sb, p, *endp - p);
     +=09}
     +}
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const c=
har **p)
     + * It may not contain spaces when unquoted. Update *endp to point to =
the first
     + * character after the space.
     + */
    -+static void parse_path_space(struct strbuf *sb, const char *p, const =
char **endp, const char *field)
    ++static void parse_path_space(struct strbuf *sb, const char *p,
    ++=09=09const char **endp, const char *field)
     +{
     +=09parse_path(sb, p, endp, 0, field);
     +=09if (**endp !=3D ' ')
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
     =20
     -=09endp++;
     -=09if (!*endp)
    -+=09if (!p)
    ++=09if (!*p)
      =09=09die("Missing dest: %s", command_buf.buf);
     -
     -=09d =3D endp;
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit filemodify
     +=09=09COMMIT
     +=09=09from :301
    -+=09=09M 100644 :402 '"$path"'
    ++=09=09M 100644 :402 $path
     +
     +=09=09commit refs/heads/S-path-eol
     +=09=09mark :303
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit filedelete
     +=09=09COMMIT
     +=09=09from :302
    -+=09=09D '"$path"'
    ++=09=09D $path
     +
     +=09=09commit refs/heads/S-path-eol
     +=09=09mark :304
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit filecopy dest
     +=09=09COMMIT
     +=09=09from :301
    -+=09=09C hello.c '"$path"'
    ++=09=09C hello.c $path
     +
     +=09=09commit refs/heads/S-path-eol
     +=09=09mark :305
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit filerename dest
     +=09=09COMMIT
     +=09=09from :301
    -+=09=09R hello.c '"$path"'
    ++=09=09R hello.c $path
     +
    -+=09=09ls :305 '"$path"'
    ++=09=09ls :305 $path
     +=09=09EOF
     +
     +=09=09commit_m=3D$(grep :302 marks.out | cut -d\  -f2) &&
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09blob1=3D$(grep :401 marks.out | cut -d\  -f2) &&
     +=09=09blob2=3D$(grep :402 marks.out | cut -d\  -f2) &&
     +
    -+=09=09( printf "100644 blob $blob2\t'"$unquoted_path"'\n" &&
    -+=09=09  printf "100644 blob $blob1\thello.c\n" ) | sort >tree_m.exp &=
&
    ++=09=09(
    ++=09=09=09printf "100644 blob $blob2\t$unquoted_path\n" &&
    ++=09=09=09printf "100644 blob $blob1\thello.c\n"
    ++=09=09) | sort >tree_m.exp &&
     +=09=09git ls-tree $commit_m | sort >tree_m.out &&
     +=09=09test_cmp tree_m.exp tree_m.out &&
     +
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09git ls-tree $commit_d >tree_d.out &&
     +=09=09test_cmp tree_d.exp tree_d.out &&
     +
    -+=09=09( printf "100644 blob $blob1\t'"$unquoted_path"'\n" &&
    -+=09=09  printf "100644 blob $blob1\thello.c\n" ) | sort >tree_c.exp &=
&
    ++=09=09(
    ++=09=09=09printf "100644 blob $blob1\t$unquoted_path\n" &&
    ++=09=09=09printf "100644 blob $blob1\thello.c\n"
    ++=09=09) | sort >tree_c.exp &&
     +=09=09git ls-tree $commit_c | sort >tree_c.out &&
     +=09=09test_cmp tree_c.exp tree_c.out &&
     +
    -+=09=09printf "100644 blob $blob1\t'"$unquoted_path"'\n" >tree_r.exp &=
&
    ++=09=09printf "100644 blob $blob1\t$unquoted_path\n" >tree_r.exp &&
     +=09=09git ls-tree $commit_r >tree_r.out &&
     +=09=09test_cmp tree_r.exp tree_r.out &&
     +
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09data <<COMMIT
     +=09=09initial commit
     +=09=09COMMIT
    -+=09=09M 100644 :401 '"$path"'
    ++=09=09M 100644 :401 $path
     +
     +=09=09commit refs/heads/S-path-space
     +=09=09mark :302
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit filecopy source
     +=09=09COMMIT
     +=09=09from :301
    -+=09=09C '"$path"' hello2.c
    ++=09=09C $path hello2.c
     +
     +=09=09commit refs/heads/S-path-space
     +=09=09mark :303
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit filerename source
     +=09=09COMMIT
     +=09=09from :301
    -+=09=09R '"$path"' hello2.c
    ++=09=09R $path hello2.c
     +
     +=09=09EOF
     +
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit_r=3D$(grep :303 marks.out | cut -d\  -f2) &&
     +=09=09blob=3D$(grep :401 marks.out | cut -d\  -f2) &&
     +
    -+=09=09( printf "100644 blob $blob\t'"$unquoted_path"'\n" &&
    -+=09=09  printf "100644 blob $blob\thello2.c\n" ) | sort >tree_c.exp &=
&
    ++=09=09(
    ++=09=09=09printf "100644 blob $blob\t$unquoted_path\n" &&
    ++=09=09=09printf "100644 blob $blob\thello2.c\n"
    ++=09=09) | sort >tree_c.exp &&
     +=09=09git ls-tree $commit_c | sort >tree_c.out &&
     +=09=09test_cmp tree_c.exp tree_c.out &&
     +
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09commit with bad path
     +=09=09COMMIT
     +=09=09from :2
    -+=09=09'"$prefix$path$suffix"'
    ++=09=09$prefix$path$suffix
     +=09=09EOF
     +
    -+=09=09test_grep '"'$err_grep'"' err
    ++=09=09test_grep "$err_grep" err
     +=09'
     +}
     +
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09test_path_fail "$change" "invalid escape in quoted $field" "$prefi=
x" '"hello\xff"' "$suffix" "Invalid $field"
     +}
     +test_path_eol_quoted_fail () {
    -+=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    -+=09test_path_base_fail "$change" "$prefix" "$field" "$suffix"
    -+=09test_path_fail "$change" "garbage after quoted $field" "$prefix" '=
"hello.c"x' "$suffix" "Garbage after $field"
    -+=09test_path_fail "$change" "space after quoted $field"   "$prefix" '=
"hello.c" ' "$suffix" "Garbage after $field"
    ++=09local change=3D"$1" prefix=3D"$2" field=3D"$3"
    ++=09test_path_base_fail "$change" "$prefix" "$field" ''
    ++=09test_path_fail "$change" "garbage after quoted $field" "$prefix" '=
"hello.c"' 'x' "Garbage after $field"
    ++=09test_path_fail "$change" "space after quoted $field"   "$prefix" '=
"hello.c"' ' ' "Garbage after $field"
     +}
     +test_path_eol_fail () {
    -+=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    -+=09test_path_eol_quoted_fail "$change" "$prefix" "$field" "$suffix"
    ++=09local change=3D"$1" prefix=3D"$2" field=3D"$3"
    ++=09test_path_eol_quoted_fail "$change" "$prefix" "$field"
     +}
     +test_path_space_fail () {
    -+=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    -+=09test_path_base_fail "$change" "$prefix" "$field" "$suffix"
    -+=09test_path_fail "$change" "missing space after quoted $field" "$pre=
fix" '"hello.c"x' "$suffix" "Missing space after $field"
    ++=09local change=3D"$1" prefix=3D"$2" field=3D"$3"
    ++=09test_path_base_fail "$change" "$prefix" "$field" ' world.c'
    ++=09test_path_fail "$change" "missing space after quoted $field"   "$p=
refix" '"hello.c"' 'x world.c' "Missing space after $field"
    ++=09test_path_fail "$change" "missing space after unquoted $field" "$p=
refix" 'hello.c'   ''          "Missing space after $field"
     +}
     +
    -+test_path_eol_fail   filemodify       'M 100644 :1 ' path   ''
    -+test_path_eol_fail   filedelete       'D '           path   ''
    -+test_path_space_fail filecopy         'C '           source ' world.c=
'
    -+test_path_eol_fail   filecopy         'C hello.c '   dest   ''
    -+test_path_space_fail filerename       'R '           source ' world.c=
'
    -+test_path_eol_fail   filerename       'R hello.c '   dest   ''
    -+test_path_eol_fail   'ls (in commit)' 'ls :2 '       path   ''
    ++test_path_eol_fail   filemodify       'M 100644 :1 ' path
    ++test_path_eol_fail   filedelete       'D '           path
    ++test_path_space_fail filecopy         'C '           source
    ++test_path_eol_fail   filecopy         'C hello.c '   dest
    ++test_path_space_fail filerename       'R '           source
    ++test_path_eol_fail   filerename       'R hello.c '   dest
    ++test_path_eol_fail   'ls (in commit)' 'ls :2 '       path
     +
     +# When 'ls' has no <dataref>, the <path> must be quoted.
    -+test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path=
 ''
    ++test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path
     +
      ###
      ### series T (ls)
2:  82a6f53c13 ! 2:  696ca27bb7 fast-import: directly use strbufs for paths
    @@ Commit message
         Signed-off-by: Thalia Archibald <thalia@archibald.dev>
    =20
      ## builtin/fast-import.c ##
    -@@ builtin/fast-import.c: static void parse_path_space(struct strbuf *=
sb, const char *p, const char **endp
    +@@ builtin/fast-import.c: static void parse_path_space(struct strbuf *=
sb, const char *p,
     =20
      static void file_change_m(const char *p, struct branch *b)
      {
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
     +=09strbuf_reset(&source);
     +=09parse_path_space(&source, p, &p, "source");
     =20
    - =09if (!p)
    + =09if (!*p)
      =09=09die("Missing dest: %s", command_buf.buf);
     -=09strbuf_reset(&d_uq);
     -=09parse_path_eol(&d_uq, p, "dest");
3:  893bbf5e73 ! 3:  39879d0a66 fast-import: allow unquoted empty path for =
root
    @@ Commit message
    =20
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static void file_change_cr(const char *p, st=
ruct branch *b, int rename)
    - =09struct tree_entry leaf;
     =20
      =09strbuf_reset(&source);
    --=09parse_path_space(&source, p, &p, "source");
    + =09parse_path_space(&source, p, &p, "source");
     -
    --=09if (!p)
    +-=09if (!*p)
     -=09=09die("Missing dest: %s", command_buf.buf);
      =09strbuf_reset(&dest);
    -+=09parse_path_space(&source, p, &p, "source");
      =09parse_path_eol(&dest, p, "dest");
     =20
    - =09memset(&leaf, 0, sizeof(leaf));
    =20
      ## t/t9300-fast-import.sh ##
     @@ t/t9300-fast-import.sh: test_expect_success 'M: rename subdirectory=
 to new subdirectory' '
    @@ t/t9300-fast-import.sh: test_expect_success 'M: rename subdirectory =
to new subdi
     -=09from refs/heads/M2^0
     -=09R "" sub
     +=09=09from refs/heads/M2^0
    -+=09=09R '"$root"' sub
    ++=09=09R $root sub
     =20
     -=09INPUT_END
     +=09=09INPUT_END
    @@ t/t9300-fast-import.sh: test_expect_success PIPE 'N: empty directory=
 reads as mi
     -=09compare_diff_raw expect actual
     -'
     +=09=09from refs/heads/branch^0
    -+=09=09M 040000 $root_tree '"$root"'
    ++=09=09M 040000 $root_tree $root
     +=09=09INPUT_END
     +=09=09git fast-import <input &&
     +=09=09git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
    @@ t/t9300-fast-import.sh: test_expect_success PIPE 'N: empty directory=
 reads as mi
     -=09compare_diff_raw expect actual
     -'
     +=09=09from refs/heads/branch^0
    -+=09=09C '"$root"' oldroot
    ++=09=09C $root oldroot
     +=09=09INPUT_END
     +=09=09git fast-import <input &&
     +=09=09git diff-tree -C --find-copies-harder -r branch N-copy-root-pat=
h >actual &&
    @@ t/t9300-fast-import.sh: test_expect_success 'N: reject foo/ syntax i=
n ls argumen
     -=09test_cmp expect.foo actual.foo &&
     -=09test_cmp expect.bar actual.bar
     -'
    -+=09=09M 040000 $tree '"$root"'
    ++=09=09M 040000 $tree $root
     +=09=09M 644 inline foo/foo
     +=09=09data <<EOF
     +=09=09hello, world
    @@ t/t9300-fast-import.sh: test_expect_success 'N: reject foo/ syntax i=
n ls argumen
     -=09git fast-import <input &&
     -=09git diff --exit-code branch:newdir N9
     -'
    -+=09=09M 040000 $branch '"$root"'
    -+=09=09C "newdir" '"$root"'
    ++=09=09M 040000 $branch $root
    ++=09=09C "newdir" $root
     +=09=09INPUT_END
     +=09=09git fast-import <input &&
     +=09=09git diff --exit-code branch:newdir N9
    @@ t/t9300-fast-import.sh: test_expect_success 'N: reject foo/ syntax i=
n ls argumen
     -=09test_cmp expect.baz actual.baz &&
     -=09test_cmp expect.qux actual.qux &&
     -=09test_cmp expect.qux actual.quux'
    -+=09=09M 040000 $tree '"$root"'
    ++=09=09M 040000 $tree $root
     +=09=09M 100644 inline foo/bar/qux
     +=09=09data <<EOF
     +=09=09hello, world
     +=09=09EOF
    -+=09=09R "foo" '"$root"'
    ++=09=09R "foo" $root
     +=09=09C "bar/qux" "bar/quux"
     +=09=09INPUT_END
     +=09=09git show N11:bar/baz >actual.baz &&
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
      #
     =20
      #
    -@@ t/t9300-fast-import.sh: test_path_eol_quoted_fail 'ls (without data=
ref in commit)' 'ls ' path ''
    +@@ t/t9300-fast-import.sh: test_path_eol_quoted_fail 'ls (without data=
ref in commit)' 'ls ' path
      ###
      # Setup is carried over from series S.
     =20
    @@ t/t9300-fast-import.sh: test_expect_success 'U: validate directory d=
elete result
     +=09=09must succeed
     +=09=09COMMIT
     +=09=09from refs/heads/U^0
    -+=09=09D '"$root"'
    ++=09=09D $root
     =20
     -=09INPUT_END
     +=09=09INPUT_END
4:  cb05a184e6 =3D 4:  1cef05e59a fast-import: remove dead strbuf
5:  1f34b632d7 =3D 5:  2e78690023 fast-import: improve documentation for un=
quoted paths
6:  82a4da68af =3D 6:  1b07ddffe0 fast-import: document C-style escapes for=
 paths
7:  c087c6a860 ! 7:  dc67464b6a fast-import: forbid escaped NUL in paths
    @@ Documentation/git-fast-import.txt: and must be in canonical form. Th=
at is it mus
      `filedelete`
    =20
      ## builtin/fast-import.c ##
    -@@ builtin/fast-import.c: static void parse_path(struct strbuf *sb, co=
nst char *p, const char **endp, int
    +@@ builtin/fast-import.c: static void parse_path(struct strbuf *sb, co=
nst char *p, const char **endp,
      =09if (*p =3D=3D '"') {
      =09=09if (unquote_c_style(sb, p, endp))
      =09=09=09die("Invalid %s: %s", field, command_buf.buf);
    @@ t/t9300-fast-import.sh: test_path_base_fail () {
     +=09test_path_fail "$change" "escaped NUL in quoted $field"    "$prefi=
x" '"hello\000"' "$suffix" "NUL in $field"
      }
      test_path_eol_quoted_fail () {
    - =09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    + =09local change=3D"$1" prefix=3D"$2" field=3D"$3"
8:  a503c55b83 =3D 8:  5e02d887bc fast-import: make comments more precise
--=20
2.44.0


