Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42FDF59
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962143; cv=none; b=dpd9nWn4n8Poo4EkxU0ya4xnrso6UwXFnKtRSjzm2t9DmO+yseestdfRC5pUimrQ+rmF5v4+Q8DtV6wmj5DRVuOT0Bm4s74PzTOhjxB7cFR60GsSyo57Qh1QASUKUhmdXVKusLPtIuegu/8hG12CGDNNpQ2TaYUMSIfgSg764Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962143; c=relaxed/simple;
	bh=ooU8C2QfZf9wwaGU+oROzr3mVcg6IJmbqwnaDBhBV7M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOzFHA/rdNvK1GQgIhzN6U9zWIByyJqSB1R22t7elFR8PY3LhvA5u92/JZy+X3AbYKF54s1PDz5VovfS/vD70epcM21FbPQ9sZe+1bfT02JON6QgABvsU9ZHNGoiXI41mgc3ntimm+aictpA0SumibHt5I2tV+0vLbMV1FMiduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=OEefa9Bv; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="OEefa9Bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962130; x=1712221330;
	bh=LMNrzMZTHv/RvnAPItj1b4UL3WQuP46HpayYtkhYBmQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OEefa9BvqqzUgDA82bCQ5piepsZxA3UVTHEyg8C6h/+Tet1oZeg9ONQH+dGtTUOuJ
	 6MJ6CwlMLUg8McZWo4alHd90cpxxtD0zDmqAmI74kphv3ASnV9gEOgAc6515rCBJJm
	 l+3D7ZPeg4b2yRGSU8a+l3df41I3z+rPB/kwy9XpoiTNq5ZA8aA3ZEKXce1oX76ljB
	 6sQ+FzAvjfB31l29U097bTkPvfqTfkerAOKe+f0hXskS2neAyd0C9afLHaZ4e38aTi
	 jPM/SlB8PKT52B5Lw91jEYeyctsDgryHYacNFQi3e4GpXv7qDAtHyr8yB/TO5FQ2wK
	 LWwkICXPfuXNQ==
Date: Mon, 01 Apr 2024 09:02:03 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v2 0/8] fast-import: tighten parsing of paths
Message-ID: <cover.1711960552.git.thalia@archibald.dev>
In-Reply-To: <20240322000304.76810-1-thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev>
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

Thanks for the review, Patrick. I've made several changes, which I think ad=
dress
your feedback. What's the protocol for adding `Reviewed-by`? Since I don't =
know
whether I, you, or Junio add it, I've refrained from attaching your name to
these patches.

Changes since v1:
* In fast-import:
  * Move `strbuf_release` outside of `parse_path_space` and `parse_path_eol=
`.
  * Retain allocations for static `strbuf`s.
  * Rename `allow_spaces` parameter of `parse_path` to `include_spaces`.
  * Extract change to neighboring comments as patch 8.
* In tests:
  * Test `` for the root path additionally in all tests using `""`.
  * Pass all arguments by positional variables.
  * Use `local`.
  * Use `test_when_finished` instead of manual cleanup.
* In documentation:
  * Better document conditions under which a path is considered quoted or
    unquoted.
* Reword commit messages.

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
 builtin/fast-import.c             | 156 ++++----
 t/t9300-fast-import.sh            | 617 +++++++++++++++++++++---------
 3 files changed, 541 insertions(+), 262 deletions(-)

Range-diff against v1:
1:  8d9e0b25cb ! 1:  e790bdf714 fast-import: tighten parsing of paths
    @@ Metadata
     Author: Thalia Archibald <thalia@archibald.dev>

      ## Commit message ##
    -    fast-import: tighten parsing of paths
    +    fast-import: tighten path unquoting

         Path parsing in fast-import is inconsistent and many unquoting err=
ors
    -    are suppressed.
    +    are suppressed or not checked.

    -    `<path>` appears in the grammar in these places:
    +    <path> appears in the grammar in these places:

             filemodify ::=3D 'M' SP <mode> (<dataref> | 'inline') SP <path=
> LF
             filedelete ::=3D 'D' SP <path> LF
    @@ Commit message
         and fast-import.c parses them in five different ways:

         1. For filemodify and filedelete:
    -       If `<path>` is a valid quoted string, unquote it;
    -       otherwise, treat it as literal bytes (including any number of S=
P).
    +       Try to unquote <path>. If it unquotes without errors, use the
    +       unquoted version; otherwise, treat it as literal bytes to the e=
nd of
    +       the line (including any number of SP).
         2. For filecopy (source) and filerename (source):
    -       If `<path>` is a valid quoted string, unquote it;
    -       otherwise, treat it as literal bytes until the next SP.
    +       Try to unquote <path>. If it unquotes without errors, use the
    +       unquoted version; otherwise, treat it as literal bytes up to, b=
ut not
    +       including, the next SP.
         3. For filecopy (dest) and filerename (dest):
    -       Like 1., but an unquoted empty string is an error.
    +       Like 1., but an unquoted empty string is forbidden.
         4. For ls:
    -       If `<path>` starts with `"`, unquote it and report parse errors=
;
    -       otherwise, treat it as literal bytes (including any number of S=
P).
    +       If <path> starts with `"`, unquote it and report parse errors;
    +       otherwise, treat it as literal bytes to the end of the line
    +       (including any number of SP).
         5. For ls-commit:
    -       Unquote `<path>` and report parse errors.
    +       Unquote <path> and report parse errors.
            (It must start with `"` to disambiguate from ls.)

         In the first three, any errors from trying to unquote a string are
         suppressed, so a quoted string that contains invalid escapes would=
 be
         interpreted as literal bytes. For example, `"\xff"` would fail to
         unquote (because hex escapes are not supported), and it would inst=
ead be
    -    interpreted as the byte sequence `"` `\` `x` `f` `f` `"`, which is
    +    interpreted as the byte sequence '"', '\\', 'x', 'f', 'f', '"', wh=
ich is
         certainly not intended. Some front-ends erroneously use their lang=
uage's
    -    standard quoting routine and could silently introduce escapes that=
 would
    -    be incorrectly parsed due to this.
    +    standard quoting routine instead of matching Git's, which could si=
lently
    +    introduce escapes that would be incorrectly parsed due to this and=
 lead
    +    to data corruption.

    -    The documentation states that =E2=80=9CTo use a source path that c=
ontains SP the
    -    path must be quoted.=E2=80=9D, so it is expected that some impleme=
ntations
    -    depend on spaces being allowed in paths in the final position. Thu=
s we
    -    have two documented ways to parse paths, so simplify the implement=
ation
    -    to that.
    +    The documentation states =E2=80=9CTo use a source path that contai=
ns SP the path
    +    must be quoted.=E2=80=9D, so it is expected that some implementati=
ons depend on
    +    spaces being allowed in paths in the final position. Thus we have =
two
    +    documented ways to parse paths, so simplify the implementation to =
that.

         Now we have:

         1. `parse_path_eol` for filemodify, filedelete, filecopy (dest),
            filerename (dest), ls, and ls-commit:

    -       If `<path>` starts with `"`, unquote it and report parse errors=
;
    -       otherwise, treat it as literal bytes (including any number of S=
P).
    -       Garbage after a quoted string or an unquoted empty string are e=
rrors.
    -       (In ls-commit, it must be quoted to disambiguate from ls.)
    +       If <path> starts with `"`, unquote it and report parse errors;
    +       otherwise, treat it as literal bytes to the end of the line
    +       (including any number of SP).

         2. `parse_path_space` for filecopy (source) and filerename (source=
):

    -       If `<path>` starts with `"`, unquote it and report parse errors=
;
    -       otherwise, treat it as literal bytes until the next SP.
    -       It must be followed by a SP. An unquoted empty string is an err=
or.
    +       If <path> starts with `"`, unquote it and report parse errors;
    +       otherwise, treat it as literal bytes up to, but not including, =
the
    +       next SP. It must be followed by SP.
    +
    +    There remain two special cases: The dest <path> in filecopy and re=
name
    +    cannot be an unquoted empty string (this will be addressed subsequ=
ently)
    +    and <path> in ls-commit must be quoted to disambiguate it from ls.

         Signed-off-by: Thalia Archibald <thalia@archibald.dev>

    - ## Documentation/git-fast-import.txt ##
    -@@ Documentation/git-fast-import.txt: The value of `<path>` must be in=
 canonical form. That is it must not:
    - * contain the special component `.` or `..` (e.g. `foo/./bar` and
    -   `foo/../bar` are invalid).
    -
    --The root of the tree can be represented by an empty string as `<path>=
`.
    -+The root of the tree can be represented by a quoted empty string (`""=
`)
    -+as `<path>`.
    -
    - It is recommended that `<path>` always be encoded using UTF-8.
    -
    -
      ## builtin/fast-import.c ##
    -@@ builtin/fast-import.c: static int parse_mapped_oid_hex(const char *=
hex, struct object_id *oid, const ch
    -  *
    -  *   idnum ::=3D ':' bigint;
    -  *
    -- * Return the first character after the value in *endptr.
    -+ * Update *endptr to point to the first character after the value.
    -  *
    -  * Complain if the following character is not what is expected,
    -  * either a space or end of the string.
    -@@ builtin/fast-import.c: static uintmax_t parse_mark_ref_eol(const ch=
ar *p)
    - }
    -
    - /*
    -- * Parse the mark reference, demanding a trailing space.  Return a
    -- * pointer to the space.
    -+ * Parse the mark reference, demanding a trailing space. Update *p to
    -+ * point to the first character after the space.
    -  */
    - static uintmax_t parse_mark_ref_space(const char **p)
    - {
     @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const =
char **p)
      =09return mark;
      }
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const c=
har **p)
     +/*
     + * Parse the path string into the strbuf. It may be quoted with escap=
e sequences
     + * or unquoted without escape sequences. When unquoted, it may only c=
ontain a
    -+ * space if `allow_spaces` is nonzero.
    ++ * space if `include_spaces` is nonzero.
     + */
    -+static void parse_path(struct strbuf *sb, const char *p, const char *=
*endp, int allow_spaces, const char *field)
    ++static void parse_path(struct strbuf *sb, const char *p, const char *=
*endp, int include_spaces, const char *field)
     +{
    -+=09strbuf_reset(sb);
     +=09if (*p =3D=3D '"') {
     +=09=09if (unquote_c_style(sb, p, endp))
     +=09=09=09die("Invalid %s: %s", field, command_buf.buf);
     +=09} else {
    -+=09=09if (allow_spaces)
    ++=09=09if (include_spaces)
     +=09=09=09*endp =3D p + strlen(p);
     +=09=09else
     +=09=09=09*endp =3D strchr(p, ' ');
    -+=09=09if (*endp =3D=3D p)
    -+=09=09=09die("Missing %s: %s", field, command_buf.buf);
     +=09=09strbuf_add(sb, p, *endp - p);
     +=09}
     +}
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const c=
har **p)
      =09struct object_id oid;
      =09uint16_t mode, inline_data =3D 0;
     @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b)
    - =09=09=09die("Missing space after SHA1: %s", command_buf.buf);
      =09}

    --=09strbuf_reset(&uq);
    + =09strbuf_reset(&uq);
     -=09if (!unquote_c_style(&uq, p, &endp)) {
     -=09=09if (*endp)
     -=09=09=09die("Garbage after path in: %s", command_buf.buf);
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
      =09static struct strbuf uq =3D STRBUF_INIT;
     -=09const char *endp;

    --=09strbuf_reset(&uq);
    + =09strbuf_reset(&uq);
     -=09if (!unquote_c_style(&uq, p, &endp)) {
     -=09=09if (*endp)
     -=09=09=09die("Garbage after path in: %s", command_buf.buf);
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
     -=09const char *endp;
      =09struct tree_entry leaf;

    --=09strbuf_reset(&s_uq);
    + =09strbuf_reset(&s_uq);
     -=09if (!unquote_c_style(&s_uq, s, &endp)) {
     -=09=09if (*endp !=3D ' ')
     -=09=09=09die("Missing space after source: %s", command_buf.buf);
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
     -=09=09strbuf_add(&s_uq, s, endp - s);
     -=09}
     +=09parse_path_space(&s_uq, p, &p, "source");
    -+=09parse_path_eol(&d_uq, p, "dest");
      =09s =3D s_uq.buf;
    --
    +
     -=09endp++;
     -=09if (!*endp)
    --=09=09die("Missing dest: %s", command_buf.buf);
    ++=09if (!p)
    + =09=09die("Missing dest: %s", command_buf.buf);
     -
     -=09d =3D endp;
    --=09strbuf_reset(&d_uq);
    + =09strbuf_reset(&d_uq);
     -=09if (!unquote_c_style(&d_uq, d, &endp)) {
     -=09=09if (*endp)
     -=09=09=09die("Garbage after dest in: %s", command_buf.buf);
     -=09=09d =3D d_uq.buf;
     -=09}
    ++=09parse_path_eol(&d_uq, p, "dest");
     +=09d =3D d_uq.buf;

      =09memset(&leaf, 0, sizeof(leaf));
      =09if (rename)
    -@@ builtin/fast-import.c: static void parse_ls(const char *p, struct b=
ranch *b)
    +@@ builtin/fast-import.c: static void print_ls(int mode, const unsigne=
d char *hash, const char *path)
    +
    + static void parse_ls(const char *p, struct branch *b)
      {
    ++=09static struct strbuf uq =3D STRBUF_INIT;
      =09struct tree_entry *root =3D NULL;
      =09struct tree_entry leaf =3D {NULL};
    -+=09static struct strbuf uq =3D STRBUF_INIT;

    - =09/* ls SP (<tree-ish> SP)? <path> */
    - =09if (*p =3D=3D '"') {
     @@ builtin/fast-import.c: static void parse_ls(const char *p, struct b=
ranch *b)
      =09=09=09root->versions[1].mode =3D S_IFDIR;
      =09=09load_tree(root);
    @@ builtin/fast-import.c: static void parse_ls(const char *p, struct br=
anch *b)
     -=09=09=09die("Garbage after path in: %s", command_buf.buf);
     -=09=09p =3D uq.buf;
     -=09}
    ++=09strbuf_reset(&uq);
     +=09parse_path_eol(&uq, p, "path");
     +=09p =3D uq.buf;
      =09tree_content_get(root, p, &leaf, 1);
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +# Path parsing
     +#
     +# There are two sorts of ways a path can be parsed, depending on whet=
her it is
    -+# the last field on the line. Additionally, ls without a <tree-ish> h=
as a
    -+# special case. Test every occurrence of <path> in the grammar agains=
t every
    -+# error case.
    ++# the last field on the line. Additionally, ls without a <dataref> ha=
s a special
    ++# case. Test every occurrence of <path> in the grammar against every =
error case.
     +#
     +
     +#
     +# Valid paths at the end of a line: filemodify, filedelete, filecopy =
(dest),
     +# filerename (dest), and ls.
     +#
    -+# commit :301 from root -- modify hello.c
    ++# commit :301 from root -- modify hello.c (for setup)
     +# commit :302 from :301 -- modify $path
     +# commit :303 from :302 -- delete $path
     +# commit :304 from :301 -- copy hello.c $path
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +# ls :305 $path
     +#
     +test_path_eol_success () {
    -+=09test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
    ++=09local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
     +=09test_expect_success "S: paths at EOL with $test must work" '
    ++=09=09test_when_finished "git branch -D S-path-eol" &&
    ++
     +=09=09git fast-import --export-marks=3Dmarks.out <<-EOF >out 2>err &&
     +=09=09blob
     +=09=09mark :401
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09hallo welt
     +=09=09BLOB
     +
    -+=09=09commit refs/heads/path-eol
    ++=09=09commit refs/heads/S-path-eol
     +=09=09mark :301
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09COMMIT
     +=09=09M 100644 :401 hello.c
     +
    -+=09=09commit refs/heads/path-eol
    ++=09=09commit refs/heads/S-path-eol
     +=09=09mark :302
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09from :301
     +=09=09M 100644 :402 '"$path"'
     +
    -+=09=09commit refs/heads/path-eol
    ++=09=09commit refs/heads/S-path-eol
     +=09=09mark :303
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09from :302
     +=09=09D '"$path"'
     +
    -+=09=09commit refs/heads/path-eol
    ++=09=09commit refs/heads/S-path-eol
     +=09=09mark :304
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09from :301
     +=09=09C hello.c '"$path"'
     +
    -+=09=09commit refs/heads/path-eol
    ++=09=09commit refs/heads/S-path-eol
     +=09=09mark :305
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09git ls-tree $commit_r >tree_r.out &&
     +=09=09test_cmp tree_r.exp tree_r.out &&
     +
    -+=09=09test_cmp out tree_r.exp &&
    -+
    -+=09=09git branch -D path-eol
    ++=09=09test_cmp out tree_r.exp
     +=09'
     +}
     +
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +#
     +# Valid paths before a space: filecopy (source) and filerename (sourc=
e).
     +#
    -+# commit :301 from root -- modify $path
    ++# commit :301 from root -- modify $path (for setup)
     +# commit :302 from :301 -- copy $path hello2.c
     +# commit :303 from :301 -- rename $path hello2.c
     +#
     +test_path_space_success () {
    -+=09test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
    ++=09local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
     +=09test_expect_success "S: paths before space with $test must work" '
    ++=09=09test_when_finished "git branch -D S-path-space" &&
    ++
     +=09=09git fast-import --export-marks=3Dmarks.out <<-EOF 2>err &&
     +=09=09blob
     +=09=09mark :401
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09hello world
     +=09=09BLOB
     +
    -+=09=09commit refs/heads/path-space
    ++=09=09commit refs/heads/S-path-space
     +=09=09mark :301
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09COMMIT
     +=09=09M 100644 :401 '"$path"'
     +
    -+=09=09commit refs/heads/path-space
    ++=09=09commit refs/heads/S-path-space
     +=09=09mark :302
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +=09=09from :301
     +=09=09C '"$path"' hello2.c
     +
    -+=09=09commit refs/heads/path-space
    ++=09=09commit refs/heads/S-path-space
     +=09=09mark :303
     +=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMI=
TTER_DATE
     +=09=09data <<COMMIT
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +
     +=09=09printf "100644 blob $blob\thello2.c\n" >tree_r.exp &&
     +=09=09git ls-tree $commit_r >tree_r.out &&
    -+=09=09test_cmp tree_r.exp tree_r.out &&
    -+
    -+=09=09git branch -D path-space
    ++=09=09test_cmp tree_r.exp tree_r.out
     +=09'
     +}
     +
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +# of <path> in the grammar against all error kinds.
     +#
     +test_path_fail () {
    -+=09what=3D"$1" path=3D"$2" err_grep=3D"$3"
    ++=09local change=3D"$1" what=3D"$2" prefix=3D"$3" path=3D"$4" suffix=
=3D"$5" err_grep=3D"$6"
     +=09test_expect_success "S: $change with $what must fail" '
     +=09=09test_must_fail git fast-import <<-EOF 2>err &&
     +=09=09blob
    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage afte=
r sha1 must
     +}
     +
     +test_path_base_fail () {
    -+=09test_path_fail 'unclosed " in '"$field"          '"hello.c'    "In=
valid $field"
    -+=09test_path_fail "invalid escape in quoted $field" '"hello\xff"' "In=
valid $field"
    ++=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    ++=09test_path_fail "$change" 'unclosed " in '"$field"          "$prefi=
x" '"hello.c'    "$suffix" "Invalid $field"
    ++=09test_path_fail "$change" "invalid escape in quoted $field" "$prefi=
x" '"hello\xff"' "$suffix" "Invalid $field"
     +}
     +test_path_eol_quoted_fail () {
    -+=09test_path_base_fail
    -+=09test_path_fail "garbage after quoted $field" '"hello.c"x' "Garbage=
 after $field"
    -+=09test_path_fail "space after quoted $field"   '"hello.c" ' "Garbage=
 after $field"
    ++=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    ++=09test_path_base_fail "$change" "$prefix" "$field" "$suffix"
    ++=09test_path_fail "$change" "garbage after quoted $field" "$prefix" '=
"hello.c"x' "$suffix" "Garbage after $field"
    ++=09test_path_fail "$change" "space after quoted $field"   "$prefix" '=
"hello.c" ' "$suffix" "Garbage after $field"
     +}
     +test_path_eol_fail () {
    -+=09test_path_eol_quoted_fail
    -+=09test_path_fail 'empty unquoted path' '' "Missing $field"
    ++=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    ++=09test_path_eol_quoted_fail "$change" "$prefix" "$field" "$suffix"
     +}
     +test_path_space_fail () {
    -+=09test_path_base_fail
    -+=09test_path_fail 'empty unquoted path' '' "Missing $field"
    -+=09test_path_fail "missing space after quoted $field" '"hello.c"x' "M=
issing space after $field"
    ++=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
    ++=09test_path_base_fail "$change" "$prefix" "$field" "$suffix"
    ++=09test_path_fail "$change" "missing space after quoted $field" "$pre=
fix" '"hello.c"x' "$suffix" "Missing space after $field"
     +}
     +
    -+change=3Dfilemodify       prefix=3D'M 100644 :1 ' field=3Dpath   suff=
ix=3D''         test_path_eol_fail
    -+change=3Dfiledelete       prefix=3D'D '           field=3Dpath   suff=
ix=3D''         test_path_eol_fail
    -+change=3Dfilecopy         prefix=3D'C '           field=3Dsource suff=
ix=3D' world.c' test_path_space_fail
    -+change=3Dfilecopy         prefix=3D'C hello.c '   field=3Ddest   suff=
ix=3D''         test_path_eol_fail
    -+change=3Dfilerename       prefix=3D'R '           field=3Dsource suff=
ix=3D' world.c' test_path_space_fail
    -+change=3Dfilerename       prefix=3D'R hello.c '   field=3Ddest   suff=
ix=3D''         test_path_eol_fail
    -+change=3D'ls (in commit)' prefix=3D'ls :2 '       field=3Dpath   suff=
ix=3D''         test_path_eol_fail
    ++test_path_eol_fail   filemodify       'M 100644 :1 ' path   ''
    ++test_path_eol_fail   filedelete       'D '           path   ''
    ++test_path_space_fail filecopy         'C '           source ' world.c=
'
    ++test_path_eol_fail   filecopy         'C hello.c '   dest   ''
    ++test_path_space_fail filerename       'R '           source ' world.c=
'
    ++test_path_eol_fail   filerename       'R hello.c '   dest   ''
    ++test_path_eol_fail   'ls (in commit)' 'ls :2 '       path   ''
     +
    -+# When 'ls' has no <tree-ish>, the <path> must be quoted.
    -+change=3D'ls (without tree-ish in commit)' prefix=3D'ls ' field=3Dpat=
h suffix=3D'' \
    -+test_path_eol_quoted_fail &&
    -+test_path_fail 'empty unquoted path' '' "Invalid dataref"
    ++# When 'ls' has no <dataref>, the <path> must be quoted.
    ++test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path=
 ''
     +
      ###
      ### series T (ls)
2:  a2aca9f9e6 ! 2:  82a6f53c13 fast-import: directly use strbufs for paths
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
      =09=09=09die("Missing space after SHA1: %s", command_buf.buf);
      =09}

    +-=09strbuf_reset(&uq);
     -=09parse_path_eol(&uq, p, "path");
     -=09p =3D uq.buf;
    ++=09strbuf_reset(&path);
     +=09parse_path_eol(&path, p, "path");

      =09/* Git does not track empty, non-toplevel directories. */
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
     -=09static struct strbuf uq =3D STRBUF_INIT;
     +=09static struct strbuf path =3D STRBUF_INIT;

    +-=09strbuf_reset(&uq);
     -=09parse_path_eol(&uq, p, "path");
     -=09p =3D uq.buf;
     -=09tree_content_remove(&b->branch_tree, p, NULL, 1);
    ++=09strbuf_reset(&path);
     +=09parse_path_eol(&path, p, "path");
     +=09tree_content_remove(&b->branch_tree, path.buf, NULL, 1);
      }
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
     +=09static struct strbuf dest =3D STRBUF_INIT;
      =09struct tree_entry leaf;

    +-=09strbuf_reset(&s_uq);
     -=09parse_path_space(&s_uq, p, &p, "source");
    --=09parse_path_eol(&d_uq, p, "dest");
     -=09s =3D s_uq.buf;
    --=09d =3D d_uq.buf;
    ++=09strbuf_reset(&source);
     +=09parse_path_space(&source, p, &p, "source");
    +
    + =09if (!p)
    + =09=09die("Missing dest: %s", command_buf.buf);
    +-=09strbuf_reset(&d_uq);
    +-=09parse_path_eol(&d_uq, p, "dest");
    +-=09d =3D d_uq.buf;
    ++=09strbuf_reset(&dest);
     +=09parse_path_eol(&dest, p, "dest");

      =09memset(&leaf, 0, sizeof(leaf));
    @@ builtin/fast-import.c: static void file_change_m(const char *p, stru=
ct branch *b
      =09=09&leaf.versions[1].oid,
      =09=09leaf.versions[1].mode,
      =09=09leaf.tree);
    -@@ builtin/fast-import.c: static void parse_ls(const char *p, struct b=
ranch *b)
    +@@ builtin/fast-import.c: static void print_ls(int mode, const unsigne=
d char *hash, const char *path)
    +
    + static void parse_ls(const char *p, struct branch *b)
      {
    - =09struct tree_entry *root =3D NULL;
    - =09struct tree_entry leaf =3D {NULL};
     -=09static struct strbuf uq =3D STRBUF_INIT;
     +=09static struct strbuf path =3D STRBUF_INIT;
    + =09struct tree_entry *root =3D NULL;
    + =09struct tree_entry leaf =3D {NULL};

    - =09/* ls SP (<tree-ish> SP)? <path> */
    - =09if (*p =3D=3D '"') {
     @@ builtin/fast-import.c: static void parse_ls(const char *p, struct b=
ranch *b)
      =09=09=09root->versions[1].mode =3D S_IFDIR;
      =09=09load_tree(root);
      =09}
    +-=09strbuf_reset(&uq);
     -=09parse_path_eol(&uq, p, "path");
     -=09p =3D uq.buf;
     -=09tree_content_get(root, p, &leaf, 1);
    ++=09strbuf_reset(&path);
     +=09parse_path_eol(&path, p, "path");
     +=09tree_content_get(root, path.buf, &leaf, 1);
      =09/*
3:  ecaf4883d1 < -:  ---------- fast-import: release unfreed strbufs
-:  ---------- > 3:  893bbf5e73 fast-import: allow unquoted empty path for =
root
4:  058a38416a ! 4:  cb05a184e6 fast-import: remove dead strbuf
    @@ Metadata
      ## Commit message ##
         fast-import: remove dead strbuf

    -    The strbuf in `note_change_n` has been unused since the function w=
as
    +    The strbuf in `note_change_n` is to copy the remainder of `p` befo=
re
    +    potentially invalidating it when reading the next line. However, `=
p` is
    +    not used after that point. It has been unused since the function w=
as
         created in a8dd2e7d2b (fast-import: Add support for importing comm=
it
         notes, 2009-10-09) and looks to be a fossil from adapting
    -    `note_change_m`. Remove it.
    +    `file_change_m`. Remove it.

         Signed-off-by: Thalia Archibald <thalia@archibald.dev>

5:  a5e8df0759 < -:  ---------- fast-import: document C-style escapes for p=
aths
6:  9792940ba9 < -:  ---------- fast-import: forbid escaped NUL in paths
-:  ---------- > 5:  1f34b632d7 fast-import: improve documentation for unqu=
oted paths
-:  ---------- > 6:  82a4da68af fast-import: document C-style escapes for p=
aths
-:  ---------- > 7:  c087c6a860 fast-import: forbid escaped NUL in paths
-:  ---------- > 8:  a503c55b83 fast-import: make comments more precise
--
2.44.0

