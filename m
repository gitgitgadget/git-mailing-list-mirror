Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400A382
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065830; cv=none; b=RY0OrGDPcgu0VWIRnIN8mYeYKv4AfkB9mmfLBL2x3Rk8n6mFkvipmBcL9Rjb00sDf31Riu3D4JTNs6DlFqKndHCJae7rlUHUG03GRRbC79zxHdHXE61/NhN07sHsC0TyP6wDrWUcA92AS2gauEB+aKkfg5Y/rDXqmqtIs95rrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065830; c=relaxed/simple;
	bh=1GbNgUyDCplqyTnvHAoUhdGYCjwPnF19OUev67GHLGg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1perllkCPEbcRLh7tc9VounKPRxDhOIZKMV6GsT71CAT/hVW2drorz3Ixo+MTORIHQ6SY2cRS7AqpsTjOaOkrgW5gHR5I5YSFi/0t+g+SEvAifgN/rVSMKG6+XLmkOZNGys8u6Y0lktLhs+MRRZTia8dJpf7tiRyfyoBO2X00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=kiYSW2QC; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="kiYSW2QC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711065809; x=1711325009;
	bh=GjqLYmMSnhOYoT978jGShstq0zZCJZ5wmFPJga6PsHM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kiYSW2QCjParBtUySX2Qg80D5vty1Kf6qfBUkcRTKgVcpFPv3wcsJxwwjGASiLCtc
	 8mDjbrozd5vBBdCSzMrh5QgqNDq21TnhmpZQQlvr3ZTXzmo64Ut0t54e5VYFfI/VVc
	 ZHL6cGNYy6y9cvI5BIfbfOEJssCloW3wT9SKTpjDZkAMiHz3ZZoejbb7L+U1qylEAm
	 GlcQIDk0E/bM9EPxSmrtL3Cp+4XxMLP6eD+qxw9aSNgrvpqqmNylek/i2wGogw4eFX
	 lce0CBbgd52RX+67xIiOMKii1HY6DQrYC+zIHOye1Y461lCWBz3LN68PJmWBFCJ1un
	 iKvBfL/uli+3A==
Date: Fri, 22 Mar 2024 00:03:18 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH 1/6] fast-import: tighten parsing of paths
Message-ID: <20240322000304.76810-2-thalia@archibald.dev>
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

Path parsing in fast-import is inconsistent and many unquoting errors
are suppressed.

`<path>` appears in the grammar in these places:

    filemodify ::=3D 'M' SP <mode> (<dataref> | 'inline') SP <path> LF
    filedelete ::=3D 'D' SP <path> LF
    filecopy   ::=3D 'C' SP <path> SP <path> LF
    filerename ::=3D 'R' SP <path> SP <path> LF
    ls         ::=3D 'ls' SP <dataref> SP <path> LF
    ls-commit  ::=3D 'ls' SP <path> LF

and fast-import.c parses them in five different ways:

1. For filemodify and filedelete:
   If `<path>` is a valid quoted string, unquote it;
   otherwise, treat it as literal bytes (including any number of SP).
2. For filecopy (source) and filerename (source):
   If `<path>` is a valid quoted string, unquote it;
   otherwise, treat it as literal bytes until the next SP.
3. For filecopy (dest) and filerename (dest):
   Like 1., but an unquoted empty string is an error.
4. For ls:
   If `<path>` starts with `"`, unquote it and report parse errors;
   otherwise, treat it as literal bytes (including any number of SP).
5. For ls-commit:
   Unquote `<path>` and report parse errors.
   (It must start with `"` to disambiguate from ls.)

In the first three, any errors from trying to unquote a string are
suppressed, so a quoted string that contains invalid escapes would be
interpreted as literal bytes. For example, `"\xff"` would fail to
unquote (because hex escapes are not supported), and it would instead be
interpreted as the byte sequence `"` `\` `x` `f` `f` `"`, which is
certainly not intended. Some front-ends erroneously use their language's
standard quoting routine and could silently introduce escapes that would
be incorrectly parsed due to this.

The documentation states that =E2=80=9CTo use a source path that contains S=
P the
path must be quoted.=E2=80=9D, so it is expected that some implementations
depend on spaces being allowed in paths in the final position. Thus we
have two documented ways to parse paths, so simplify the implementation
to that.

Now we have:

1. `parse_path_eol` for filemodify, filedelete, filecopy (dest),
   filerename (dest), ls, and ls-commit:

   If `<path>` starts with `"`, unquote it and report parse errors;
   otherwise, treat it as literal bytes (including any number of SP).
   Garbage after a quoted string or an unquoted empty string are errors.
   (In ls-commit, it must be quoted to disambiguate from ls.)

2. `parse_path_space` for filecopy (source) and filerename (source):

   If `<path>` starts with `"`, unquote it and report parse errors;
   otherwise, treat it as literal bytes until the next SP.
   It must be followed by a SP. An unquoted empty string is an error.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 Documentation/git-fast-import.txt |   3 +-
 builtin/fast-import.c             | 115 ++++++++------
 t/t9300-fast-import.sh            | 252 +++++++++++++++++++++++++++++-
 3 files changed, 316 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index b2607366b9..271bd63a10 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -649,7 +649,8 @@ The value of `<path>` must be in canonical form. That i=
s it must not:
 * contain the special component `.` or `..` (e.g. `foo/./bar` and
   `foo/../bar` are invalid).
=20
-The root of the tree can be represented by an empty string as `<path>`.
+The root of the tree can be represented by a quoted empty string (`""`)
+as `<path>`.
=20
 It is recommended that `<path>` always be encoded using UTF-8.
=20
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 71a195ca22..b2adec8d9a 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2224,7 +2224,7 @@ static int parse_mapped_oid_hex(const char *hex, stru=
ct object_id *oid, const ch
  *
  *   idnum ::=3D ':' bigint;
  *
- * Return the first character after the value in *endptr.
+ * Update *endptr to point to the first character after the value.
  *
  * Complain if the following character is not what is expected,
  * either a space or end of the string.
@@ -2257,8 +2257,8 @@ static uintmax_t parse_mark_ref_eol(const char *p)
 }
=20
 /*
- * Parse the mark reference, demanding a trailing space.  Return a
- * pointer to the space.
+ * Parse the mark reference, demanding a trailing space. Update *p to
+ * point to the first character after the space.
  */
 static uintmax_t parse_mark_ref_space(const char **p)
 {
@@ -2272,10 +2272,57 @@ static uintmax_t parse_mark_ref_space(const char **=
p)
 =09return mark;
 }
=20
+/*
+ * Parse the path string into the strbuf. It may be quoted with escape seq=
uences
+ * or unquoted without escape sequences. When unquoted, it may only contai=
n a
+ * space if `allow_spaces` is nonzero.
+ */
+static void parse_path(struct strbuf *sb, const char *p, const char **endp=
, int allow_spaces, const char *field)
+{
+=09strbuf_reset(sb);
+=09if (*p =3D=3D '"') {
+=09=09if (unquote_c_style(sb, p, endp))
+=09=09=09die("Invalid %s: %s", field, command_buf.buf);
+=09} else {
+=09=09if (allow_spaces)
+=09=09=09*endp =3D p + strlen(p);
+=09=09else
+=09=09=09*endp =3D strchr(p, ' ');
+=09=09if (*endp =3D=3D p)
+=09=09=09die("Missing %s: %s", field, command_buf.buf);
+=09=09strbuf_add(sb, p, *endp - p);
+=09}
+}
+
+/*
+ * Parse the path string into the strbuf, and complain if this is not the =
end of
+ * the string. It may contain spaces even when unquoted.
+ */
+static void parse_path_eol(struct strbuf *sb, const char *p, const char *f=
ield)
+{
+=09const char *end;
+
+=09parse_path(sb, p, &end, 1, field);
+=09if (*end)
+=09=09die("Garbage after %s: %s", field, command_buf.buf);
+}
+
+/*
+ * Parse the path string into the strbuf, and ensure it is followed by a s=
pace.
+ * It may not contain spaces when unquoted. Update *endp to point to the f=
irst
+ * character after the space.
+ */
+static void parse_path_space(struct strbuf *sb, const char *p, const char =
**endp, const char *field)
+{
+=09parse_path(sb, p, endp, 0, field);
+=09if (**endp !=3D ' ')
+=09=09die("Missing space after %s: %s", field, command_buf.buf);
+=09(*endp)++;
+}
+
 static void file_change_m(const char *p, struct branch *b)
 {
 =09static struct strbuf uq =3D STRBUF_INIT;
-=09const char *endp;
 =09struct object_entry *oe;
 =09struct object_id oid;
 =09uint16_t mode, inline_data =3D 0;
@@ -2312,12 +2359,8 @@ static void file_change_m(const char *p, struct bran=
ch *b)
 =09=09=09die("Missing space after SHA1: %s", command_buf.buf);
 =09}
=20
-=09strbuf_reset(&uq);
-=09if (!unquote_c_style(&uq, p, &endp)) {
-=09=09if (*endp)
-=09=09=09die("Garbage after path in: %s", command_buf.buf);
-=09=09p =3D uq.buf;
-=09}
+=09parse_path_eol(&uq, p, "path");
+=09p =3D uq.buf;
=20
 =09/* Git does not track empty, non-toplevel directories. */
 =09if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *p) {
@@ -2381,48 +2424,23 @@ static void file_change_m(const char *p, struct bra=
nch *b)
 static void file_change_d(const char *p, struct branch *b)
 {
 =09static struct strbuf uq =3D STRBUF_INIT;
-=09const char *endp;
=20
-=09strbuf_reset(&uq);
-=09if (!unquote_c_style(&uq, p, &endp)) {
-=09=09if (*endp)
-=09=09=09die("Garbage after path in: %s", command_buf.buf);
-=09=09p =3D uq.buf;
-=09}
+=09parse_path_eol(&uq, p, "path");
+=09p =3D uq.buf;
 =09tree_content_remove(&b->branch_tree, p, NULL, 1);
 }
=20
-static void file_change_cr(const char *s, struct branch *b, int rename)
+static void file_change_cr(const char *p, struct branch *b, int rename)
 {
-=09const char *d;
+=09const char *s, *d;
 =09static struct strbuf s_uq =3D STRBUF_INIT;
 =09static struct strbuf d_uq =3D STRBUF_INIT;
-=09const char *endp;
 =09struct tree_entry leaf;
=20
-=09strbuf_reset(&s_uq);
-=09if (!unquote_c_style(&s_uq, s, &endp)) {
-=09=09if (*endp !=3D ' ')
-=09=09=09die("Missing space after source: %s", command_buf.buf);
-=09} else {
-=09=09endp =3D strchr(s, ' ');
-=09=09if (!endp)
-=09=09=09die("Missing space after source: %s", command_buf.buf);
-=09=09strbuf_add(&s_uq, s, endp - s);
-=09}
+=09parse_path_space(&s_uq, p, &p, "source");
+=09parse_path_eol(&d_uq, p, "dest");
 =09s =3D s_uq.buf;
-
-=09endp++;
-=09if (!*endp)
-=09=09die("Missing dest: %s", command_buf.buf);
-
-=09d =3D endp;
-=09strbuf_reset(&d_uq);
-=09if (!unquote_c_style(&d_uq, d, &endp)) {
-=09=09if (*endp)
-=09=09=09die("Garbage after dest in: %s", command_buf.buf);
-=09=09d =3D d_uq.buf;
-=09}
+=09d =3D d_uq.buf;
=20
 =09memset(&leaf, 0, sizeof(leaf));
 =09if (rename)
@@ -3168,6 +3186,7 @@ static void parse_ls(const char *p, struct branch *b)
 {
 =09struct tree_entry *root =3D NULL;
 =09struct tree_entry leaf =3D {NULL};
+=09static struct strbuf uq =3D STRBUF_INIT;
=20
 =09/* ls SP (<tree-ish> SP)? <path> */
 =09if (*p =3D=3D '"') {
@@ -3182,16 +3201,8 @@ static void parse_ls(const char *p, struct branch *b=
)
 =09=09=09root->versions[1].mode =3D S_IFDIR;
 =09=09load_tree(root);
 =09}
-=09if (*p =3D=3D '"') {
-=09=09static struct strbuf uq =3D STRBUF_INIT;
-=09=09const char *endp;
-=09=09strbuf_reset(&uq);
-=09=09if (unquote_c_style(&uq, p, &endp))
-=09=09=09die("Invalid path: %s", command_buf.buf);
-=09=09if (*endp)
-=09=09=09die("Garbage after path in: %s", command_buf.buf);
-=09=09p =3D uq.buf;
-=09}
+=09parse_path_eol(&uq, p, "path");
+=09p =3D uq.buf;
 =09tree_content_get(root, p, &leaf, 1);
 =09/*
 =09 * A directory in preparation would have a sha1 of zero
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index dbb5042b0b..ef04b43f46 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2146,6 +2146,7 @@ test_expect_success 'Q: deny note on empty branch' '
 =09EOF
 =09test_must_fail git fast-import <input
 '
+
 ###
 ### series R (feature and option)
 ###
@@ -2794,7 +2795,7 @@ test_expect_success 'R: blob appears only once' '
 '
=20
 ###
-### series S
+### series S (mark and path parsing)
 ###
 #
 # Make sure missing spaces and EOLs after mark references
@@ -3064,6 +3065,255 @@ test_expect_success 'S: ls with garbage after sha1 =
must fail' '
 =09test_grep "space after tree-ish" err
 '
=20
+#
+# Path parsing
+#
+# There are two sorts of ways a path can be parsed, depending on whether i=
t is
+# the last field on the line. Additionally, ls without a <tree-ish> has a
+# special case. Test every occurrence of <path> in the grammar against eve=
ry
+# error case.
+#
+
+#
+# Valid paths at the end of a line: filemodify, filedelete, filecopy (dest=
),
+# filerename (dest), and ls.
+#
+# commit :301 from root -- modify hello.c
+# commit :302 from :301 -- modify $path
+# commit :303 from :302 -- delete $path
+# commit :304 from :301 -- copy hello.c $path
+# commit :305 from :301 -- rename hello.c $path
+# ls :305 $path
+#
+test_path_eol_success () {
+=09test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
+=09test_expect_success "S: paths at EOL with $test must work" '
+=09=09git fast-import --export-marks=3Dmarks.out <<-EOF >out 2>err &&
+=09=09blob
+=09=09mark :401
+=09=09data <<BLOB
+=09=09hello world
+=09=09BLOB
+
+=09=09blob
+=09=09mark :402
+=09=09data <<BLOB
+=09=09hallo welt
+=09=09BLOB
+
+=09=09commit refs/heads/path-eol
+=09=09mark :301
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09initial commit
+=09=09COMMIT
+=09=09M 100644 :401 hello.c
+
+=09=09commit refs/heads/path-eol
+=09=09mark :302
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filemodify
+=09=09COMMIT
+=09=09from :301
+=09=09M 100644 :402 '"$path"'
+
+=09=09commit refs/heads/path-eol
+=09=09mark :303
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filedelete
+=09=09COMMIT
+=09=09from :302
+=09=09D '"$path"'
+
+=09=09commit refs/heads/path-eol
+=09=09mark :304
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filecopy dest
+=09=09COMMIT
+=09=09from :301
+=09=09C hello.c '"$path"'
+
+=09=09commit refs/heads/path-eol
+=09=09mark :305
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filerename dest
+=09=09COMMIT
+=09=09from :301
+=09=09R hello.c '"$path"'
+
+=09=09ls :305 '"$path"'
+=09=09EOF
+
+=09=09commit_m=3D$(grep :302 marks.out | cut -d\  -f2) &&
+=09=09commit_d=3D$(grep :303 marks.out | cut -d\  -f2) &&
+=09=09commit_c=3D$(grep :304 marks.out | cut -d\  -f2) &&
+=09=09commit_r=3D$(grep :305 marks.out | cut -d\  -f2) &&
+=09=09blob1=3D$(grep :401 marks.out | cut -d\  -f2) &&
+=09=09blob2=3D$(grep :402 marks.out | cut -d\  -f2) &&
+
+=09=09( printf "100644 blob $blob2\t'"$unquoted_path"'\n" &&
+=09=09  printf "100644 blob $blob1\thello.c\n" ) | sort >tree_m.exp &&
+=09=09git ls-tree $commit_m | sort >tree_m.out &&
+=09=09test_cmp tree_m.exp tree_m.out &&
+
+=09=09printf "100644 blob $blob1\thello.c\n" >tree_d.exp &&
+=09=09git ls-tree $commit_d >tree_d.out &&
+=09=09test_cmp tree_d.exp tree_d.out &&
+
+=09=09( printf "100644 blob $blob1\t'"$unquoted_path"'\n" &&
+=09=09  printf "100644 blob $blob1\thello.c\n" ) | sort >tree_c.exp &&
+=09=09git ls-tree $commit_c | sort >tree_c.out &&
+=09=09test_cmp tree_c.exp tree_c.out &&
+
+=09=09printf "100644 blob $blob1\t'"$unquoted_path"'\n" >tree_r.exp &&
+=09=09git ls-tree $commit_r >tree_r.out &&
+=09=09test_cmp tree_r.exp tree_r.out &&
+
+=09=09test_cmp out tree_r.exp &&
+
+=09=09git branch -D path-eol
+=09'
+}
+
+test_path_eol_success 'quoted spaces'   '" hello world.c "' ' hello world.=
c '
+test_path_eol_success 'unquoted spaces' ' hello world.c '   ' hello world.=
c '
+
+#
+# Valid paths before a space: filecopy (source) and filerename (source).
+#
+# commit :301 from root -- modify $path
+# commit :302 from :301 -- copy $path hello2.c
+# commit :303 from :301 -- rename $path hello2.c
+#
+test_path_space_success () {
+=09test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
+=09test_expect_success "S: paths before space with $test must work" '
+=09=09git fast-import --export-marks=3Dmarks.out <<-EOF 2>err &&
+=09=09blob
+=09=09mark :401
+=09=09data <<BLOB
+=09=09hello world
+=09=09BLOB
+
+=09=09commit refs/heads/path-space
+=09=09mark :301
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09initial commit
+=09=09COMMIT
+=09=09M 100644 :401 '"$path"'
+
+=09=09commit refs/heads/path-space
+=09=09mark :302
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filecopy source
+=09=09COMMIT
+=09=09from :301
+=09=09C '"$path"' hello2.c
+
+=09=09commit refs/heads/path-space
+=09=09mark :303
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filerename source
+=09=09COMMIT
+=09=09from :301
+=09=09R '"$path"' hello2.c
+
+=09=09EOF
+
+=09=09commit_c=3D$(grep :302 marks.out | cut -d\  -f2) &&
+=09=09commit_r=3D$(grep :303 marks.out | cut -d\  -f2) &&
+=09=09blob=3D$(grep :401 marks.out | cut -d\  -f2) &&
+
+=09=09( printf "100644 blob $blob\t'"$unquoted_path"'\n" &&
+=09=09  printf "100644 blob $blob\thello2.c\n" ) | sort >tree_c.exp &&
+=09=09git ls-tree $commit_c | sort >tree_c.out &&
+=09=09test_cmp tree_c.exp tree_c.out &&
+
+=09=09printf "100644 blob $blob\thello2.c\n" >tree_r.exp &&
+=09=09git ls-tree $commit_r >tree_r.out &&
+=09=09test_cmp tree_r.exp tree_r.out &&
+
+=09=09git branch -D path-space
+=09'
+}
+
+test_path_space_success 'quoted spaces'      '" hello world.c "' ' hello w=
orld.c '
+test_path_space_success 'no unquoted spaces' 'hello_world.c'     'hello_wo=
rld.c'
+
+#
+# Test a single commit change with an invalid path. Run it with all occurr=
ences
+# of <path> in the grammar against all error kinds.
+#
+test_path_fail () {
+=09what=3D"$1" path=3D"$2" err_grep=3D"$3"
+=09test_expect_success "S: $change with $what must fail" '
+=09=09test_must_fail git fast-import <<-EOF 2>err &&
+=09=09blob
+=09=09mark :1
+=09=09data <<BLOB
+=09=09hello world
+=09=09BLOB
+
+=09=09commit refs/heads/S-path-fail
+=09=09mark :2
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit setup
+=09=09COMMIT
+=09=09M 100644 :1 hello.c
+
+=09=09commit refs/heads/S-path-fail
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit with bad path
+=09=09COMMIT
+=09=09from :2
+=09=09'"$prefix$path$suffix"'
+=09=09EOF
+
+=09=09test_grep '"'$err_grep'"' err
+=09'
+}
+
+test_path_base_fail () {
+=09test_path_fail 'unclosed " in '"$field"          '"hello.c'    "Invalid=
 $field"
+=09test_path_fail "invalid escape in quoted $field" '"hello\xff"' "Invalid=
 $field"
+}
+test_path_eol_quoted_fail () {
+=09test_path_base_fail
+=09test_path_fail "garbage after quoted $field" '"hello.c"x' "Garbage afte=
r $field"
+=09test_path_fail "space after quoted $field"   '"hello.c" ' "Garbage afte=
r $field"
+}
+test_path_eol_fail () {
+=09test_path_eol_quoted_fail
+=09test_path_fail 'empty unquoted path' '' "Missing $field"
+}
+test_path_space_fail () {
+=09test_path_base_fail
+=09test_path_fail 'empty unquoted path' '' "Missing $field"
+=09test_path_fail "missing space after quoted $field" '"hello.c"x' "Missin=
g space after $field"
+}
+
+change=3Dfilemodify       prefix=3D'M 100644 :1 ' field=3Dpath   suffix=3D=
''         test_path_eol_fail
+change=3Dfiledelete       prefix=3D'D '           field=3Dpath   suffix=3D=
''         test_path_eol_fail
+change=3Dfilecopy         prefix=3D'C '           field=3Dsource suffix=3D=
' world.c' test_path_space_fail
+change=3Dfilecopy         prefix=3D'C hello.c '   field=3Ddest   suffix=3D=
''         test_path_eol_fail
+change=3Dfilerename       prefix=3D'R '           field=3Dsource suffix=3D=
' world.c' test_path_space_fail
+change=3Dfilerename       prefix=3D'R hello.c '   field=3Ddest   suffix=3D=
''         test_path_eol_fail
+change=3D'ls (in commit)' prefix=3D'ls :2 '       field=3Dpath   suffix=3D=
''         test_path_eol_fail
+
+# When 'ls' has no <tree-ish>, the <path> must be quoted.
+change=3D'ls (without tree-ish in commit)' prefix=3D'ls ' field=3Dpath suf=
fix=3D'' \
+test_path_eol_quoted_fail &&
+test_path_fail 'empty unquoted path' '' "Invalid dataref"
+
 ###
 ### series T (ls)
 ###
--=20
2.44.0


