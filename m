Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5112B93
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057115; cv=none; b=gsTMK4BOgUmEwlTKqLujYfSzf7Y8a7M6FQg0T7Ex5z/l5Rp+0m6NqGD/K8l0sZeGFkZjFAsKONhBeHgu56KPCKXspaffwnF50zMcK6r6WLFyzaWHWO4S64ksfrYV5ByBN5s/N4z6chZKLFY1iiGOAO015gP3BlrW8QRtQttejvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057115; c=relaxed/simple;
	bh=e8aR756vghLgDcBeVPHyniXZ9zLy1QzKMXbdiKRaKc4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGrlwfNMqlBd7vlCMFVfgwTwzrJ9HU/wnA4bS+tbDm0w9ZtJhrWLm+NJEaP1DagftoATfUMA546n8MScF0i2wLHldCa8pmwcpAZ/uREpvWo9CBd48X+oRLiIZM2GzuFFPMKL3hJ4VKYaCxLJ5g4edCqQSbrPeawafO8QbYLI+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=OnQSX7D/; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="OnQSX7D/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057103; x=1713316303;
	bh=03ZjVR4Cm5VC2BUDFhfsUcpribEUal0HbTr7LB4g3TI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OnQSX7D/HNk9i0kFYCPKsDhwuj5mGSG2zE3QsOt91vARdzS5kP3quk0Il3EgupURq
	 /nhU4bAUu6cwA2OgUbCfoUHrjj6at7MYKNWK3uodl8gVvtiIe0+xVsv0knlRZVDA2n
	 CfsmY5kA5W4OntsCErwDPq3mw9/ynW6lAIBQSIhCFZCN2juL9GNh9O2SsD432uZaim
	 A26xyuiZPLF3EjOFdmshuXMXa3GVicktvL6oaxfVIbRbVnuKTETaDIk54b90k+bCIS
	 dY7Tz3lx8+xyL4q1725fgfB/vWK9s5iGC0BDhmkUlYQYKS5ZylOmqOrr5GLKPb4oxp
	 tGuhiLdmnbiCw==
Date: Sun, 14 Apr 2024 01:11:37 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 1/8] fast-import: tighten path unquoting
Message-ID: <2c18fe5fe9b67a0650f72be7a7196644fe6e2131.1713056559.git.thalia@archibald.dev>
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

Path parsing in fast-import is inconsistent and many unquoting errors
are suppressed or not checked.

<path> appears in the grammar in these places:

    filemodify ::=3D 'M' SP <mode> (<dataref> | 'inline') SP <path> LF
    filedelete ::=3D 'D' SP <path> LF
    filecopy   ::=3D 'C' SP <path> SP <path> LF
    filerename ::=3D 'R' SP <path> SP <path> LF
    ls         ::=3D 'ls' SP <dataref> SP <path> LF
    ls-commit  ::=3D 'ls' SP <path> LF

and fast-import.c parses them in five different ways:

1. For filemodify and filedelete:
   Try to unquote <path>. If it unquotes without errors, use the
   unquoted version; otherwise, treat it as literal bytes to the end of
   the line (including any number of SP).
2. For filecopy (source) and filerename (source):
   Try to unquote <path>. If it unquotes without errors, use the
   unquoted version; otherwise, treat it as literal bytes up to, but not
   including, the next SP.
3. For filecopy (dest) and filerename (dest):
   Like 1., but an unquoted empty string is forbidden.
4. For ls:
   If <path> starts with `"`, unquote it and report parse errors;
   otherwise, treat it as literal bytes to the end of the line
   (including any number of SP).
5. For ls-commit:
   Unquote <path> and report parse errors.
   (It must start with `"` to disambiguate from ls.)

In the first three, any errors from trying to unquote a string are
suppressed, so a quoted string that contains invalid escapes would be
interpreted as literal bytes. For example, `"\xff"` would fail to
unquote (because hex escapes are not supported), and it would instead be
interpreted as the byte sequence '"', '\\', 'x', 'f', 'f', '"', which is
certainly not intended. Some front-ends erroneously use their language's
standard quoting routine instead of matching Git's, which could silently
introduce escapes that would be incorrectly parsed due to this and lead
to data corruption.

The documentation states =E2=80=9CTo use a source path that contains SP the=
 path
must be quoted.=E2=80=9D, so it is expected that some implementations depen=
d on
spaces being allowed in paths in the final position. Thus we have two
documented ways to parse paths, so simplify the implementation to that.

Now we have:

1. `parse_path_eol` for filemodify, filedelete, filecopy (dest),
   filerename (dest), ls, and ls-commit:

   If <path> starts with `"`, unquote it and report parse errors;
   otherwise, treat it as literal bytes to the end of the line
   (including any number of SP).

2. `parse_path_space` for filecopy (source) and filerename (source):

   If <path> starts with `"`, unquote it and report parse errors;
   otherwise, treat it as literal bytes up to, but not including, the
   next SP. It must be followed by SP.

There remain two special cases: The dest <path> in filecopy and rename
cannot be an unquoted empty string (this will be addressed subsequently)
and <path> in ls-commit must be quoted to disambiguate it from ls.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c  | 108 ++++++++++-------
 t/t9300-fast-import.sh | 258 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 322 insertions(+), 44 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 782bda007c..8eba89689b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2258,10 +2258,60 @@ static uintmax_t parse_mark_ref_space(const char **=
p)
 =09return mark;
 }
=20
+/*
+ * Parse the path string into the strbuf. The path can either be quoted wi=
th
+ * escape sequences or unquoted without escape sequences. Unquoted strings=
 may
+ * contain spaces only if `is_last_field` is nonzero; otherwise, it stops
+ * parsing at the first space.
+ */
+static void parse_path(struct strbuf *sb, const char *p, const char **endp=
,
+=09=09int is_last_field, const char *field)
+{
+=09if (*p =3D=3D '"') {
+=09=09if (unquote_c_style(sb, p, endp))
+=09=09=09die("Invalid %s: %s", field, command_buf.buf);
+=09} else {
+=09=09/*
+=09=09 * Unless we are parsing the last field of a line,
+=09=09 * SP is the end of this field.
+=09=09 */
+=09=09*endp =3D is_last_field
+=09=09=09? p + strlen(p)
+=09=09=09: strchrnul(p, ' ');
+=09=09strbuf_add(sb, p, *endp - p);
+=09}
+}
+
+/*
+ * Parse the path string into the strbuf, and complain if this is not the =
end of
+ * the string. Unquoted strings may contain spaces.
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
+ * Unquoted strings may not contain spaces. Update *endp to point to the f=
irst
+ * character after the space.
+ */
+static void parse_path_space(struct strbuf *sb, const char *p,
+=09=09const char **endp, const char *field)
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
@@ -2299,11 +2349,8 @@ static void file_change_m(const char *p, struct bran=
ch *b)
 =09}
=20
 =09strbuf_reset(&uq);
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
@@ -2367,48 +2414,29 @@ static void file_change_m(const char *p, struct bra=
nch *b)
 static void file_change_d(const char *p, struct branch *b)
 {
 =09static struct strbuf uq =3D STRBUF_INIT;
-=09const char *endp;
=20
 =09strbuf_reset(&uq);
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
 =09strbuf_reset(&s_uq);
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
 =09s =3D s_uq.buf;
=20
-=09endp++;
-=09if (!*endp)
+=09if (!*p)
 =09=09die("Missing dest: %s", command_buf.buf);
-
-=09d =3D endp;
 =09strbuf_reset(&d_uq);
-=09if (!unquote_c_style(&d_uq, d, &endp)) {
-=09=09if (*endp)
-=09=09=09die("Garbage after dest in: %s", command_buf.buf);
-=09=09d =3D d_uq.buf;
-=09}
+=09parse_path_eol(&d_uq, p, "dest");
+=09d =3D d_uq.buf;
=20
 =09memset(&leaf, 0, sizeof(leaf));
 =09if (rename)
@@ -3152,6 +3180,7 @@ static void print_ls(int mode, const unsigned char *h=
ash, const char *path)
=20
 static void parse_ls(const char *p, struct branch *b)
 {
+=09static struct strbuf uq =3D STRBUF_INIT;
 =09struct tree_entry *root =3D NULL;
 =09struct tree_entry leaf =3D {NULL};
=20
@@ -3168,16 +3197,9 @@ static void parse_ls(const char *p, struct branch *b=
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
+=09strbuf_reset(&uq);
+=09parse_path_eol(&uq, p, "path");
+=09p =3D uq.buf;
 =09tree_content_get(root, p, &leaf, 1);
 =09/*
 =09 * A directory in preparation would have a sha1 of zero
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 60e30fed3c..de2f1304e8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2142,6 +2142,7 @@ test_expect_success 'Q: deny note on empty branch' '
 =09EOF
 =09test_must_fail git fast-import <input
 '
+
 ###
 ### series R (feature and option)
 ###
@@ -2790,7 +2791,7 @@ test_expect_success 'R: blob appears only once' '
 '
=20
 ###
-### series S
+### series S (mark and path parsing)
 ###
 #
 # Make sure missing spaces and EOLs after mark references
@@ -3060,6 +3061,261 @@ test_expect_success 'S: ls with garbage after sha1 =
must fail' '
 =09test_grep "space after tree-ish" err
 '
=20
+#
+# Path parsing
+#
+# There are two sorts of ways a path can be parsed, depending on whether i=
t is
+# the last field on the line. Additionally, ls without a <dataref> has a s=
pecial
+# case. Test every occurrence of <path> in the grammar against every error=
 case.
+#
+
+#
+# Valid paths at the end of a line: filemodify, filedelete, filecopy (dest=
),
+# filerename (dest), and ls.
+#
+# commit :301 from root -- modify hello.c (for setup)
+# commit :302 from :301 -- modify $path
+# commit :303 from :302 -- delete $path
+# commit :304 from :301 -- copy hello.c $path
+# commit :305 from :301 -- rename hello.c $path
+# ls :305 $path
+#
+test_path_eol_success () {
+=09local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
+=09test_expect_success "S: paths at EOL with $test must work" '
+=09=09test_when_finished "git branch -D S-path-eol" &&
+
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
+=09=09commit refs/heads/S-path-eol
+=09=09mark :301
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09initial commit
+=09=09COMMIT
+=09=09M 100644 :401 hello.c
+
+=09=09commit refs/heads/S-path-eol
+=09=09mark :302
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filemodify
+=09=09COMMIT
+=09=09from :301
+=09=09M 100644 :402 $path
+
+=09=09commit refs/heads/S-path-eol
+=09=09mark :303
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filedelete
+=09=09COMMIT
+=09=09from :302
+=09=09D $path
+
+=09=09commit refs/heads/S-path-eol
+=09=09mark :304
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filecopy dest
+=09=09COMMIT
+=09=09from :301
+=09=09C hello.c $path
+
+=09=09commit refs/heads/S-path-eol
+=09=09mark :305
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filerename dest
+=09=09COMMIT
+=09=09from :301
+=09=09R hello.c $path
+
+=09=09ls :305 $path
+=09=09EOF
+
+=09=09commit_m=3D$(grep :302 marks.out | cut -d\  -f2) &&
+=09=09commit_d=3D$(grep :303 marks.out | cut -d\  -f2) &&
+=09=09commit_c=3D$(grep :304 marks.out | cut -d\  -f2) &&
+=09=09commit_r=3D$(grep :305 marks.out | cut -d\  -f2) &&
+=09=09blob1=3D$(grep :401 marks.out | cut -d\  -f2) &&
+=09=09blob2=3D$(grep :402 marks.out | cut -d\  -f2) &&
+
+=09=09(
+=09=09=09printf "100644 blob $blob2\t$unquoted_path\n" &&
+=09=09=09printf "100644 blob $blob1\thello.c\n"
+=09=09) | sort >tree_m.exp &&
+=09=09git ls-tree $commit_m | sort >tree_m.out &&
+=09=09test_cmp tree_m.exp tree_m.out &&
+
+=09=09printf "100644 blob $blob1\thello.c\n" >tree_d.exp &&
+=09=09git ls-tree $commit_d >tree_d.out &&
+=09=09test_cmp tree_d.exp tree_d.out &&
+
+=09=09(
+=09=09=09printf "100644 blob $blob1\t$unquoted_path\n" &&
+=09=09=09printf "100644 blob $blob1\thello.c\n"
+=09=09) | sort >tree_c.exp &&
+=09=09git ls-tree $commit_c | sort >tree_c.out &&
+=09=09test_cmp tree_c.exp tree_c.out &&
+
+=09=09printf "100644 blob $blob1\t$unquoted_path\n" >tree_r.exp &&
+=09=09git ls-tree $commit_r >tree_r.out &&
+=09=09test_cmp tree_r.exp tree_r.out &&
+
+=09=09test_cmp out tree_r.exp
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
+# commit :301 from root -- modify $path (for setup)
+# commit :302 from :301 -- copy $path hello2.c
+# commit :303 from :301 -- rename $path hello2.c
+#
+test_path_space_success () {
+=09local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
+=09test_expect_success "S: paths before space with $test must work" '
+=09=09test_when_finished "git branch -D S-path-space" &&
+
+=09=09git fast-import --export-marks=3Dmarks.out <<-EOF 2>err &&
+=09=09blob
+=09=09mark :401
+=09=09data <<BLOB
+=09=09hello world
+=09=09BLOB
+
+=09=09commit refs/heads/S-path-space
+=09=09mark :301
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09initial commit
+=09=09COMMIT
+=09=09M 100644 :401 $path
+
+=09=09commit refs/heads/S-path-space
+=09=09mark :302
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filecopy source
+=09=09COMMIT
+=09=09from :301
+=09=09C $path hello2.c
+
+=09=09commit refs/heads/S-path-space
+=09=09mark :303
+=09=09committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_=
DATE
+=09=09data <<COMMIT
+=09=09commit filerename source
+=09=09COMMIT
+=09=09from :301
+=09=09R $path hello2.c
+
+=09=09EOF
+
+=09=09commit_c=3D$(grep :302 marks.out | cut -d\  -f2) &&
+=09=09commit_r=3D$(grep :303 marks.out | cut -d\  -f2) &&
+=09=09blob=3D$(grep :401 marks.out | cut -d\  -f2) &&
+
+=09=09(
+=09=09=09printf "100644 blob $blob\t$unquoted_path\n" &&
+=09=09=09printf "100644 blob $blob\thello2.c\n"
+=09=09) | sort >tree_c.exp &&
+=09=09git ls-tree $commit_c | sort >tree_c.out &&
+=09=09test_cmp tree_c.exp tree_c.out &&
+
+=09=09printf "100644 blob $blob\thello2.c\n" >tree_r.exp &&
+=09=09git ls-tree $commit_r >tree_r.out &&
+=09=09test_cmp tree_r.exp tree_r.out
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
+=09local change=3D"$1" what=3D"$2" prefix=3D"$3" path=3D"$4" suffix=3D"$5"=
 err_grep=3D"$6"
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
+=09=09$prefix$path$suffix
+=09=09EOF
+
+=09=09test_grep "$err_grep" err
+=09'
+}
+
+test_path_base_fail () {
+=09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
+=09test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"=
hello.c'    "$suffix" "Invalid $field"
+=09test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"=
hello\xff"' "$suffix" "Invalid $field"
+}
+test_path_eol_quoted_fail () {
+=09local change=3D"$1" prefix=3D"$2" field=3D"$3"
+=09test_path_base_fail "$change" "$prefix" "$field" ''
+=09test_path_fail "$change" "garbage after quoted $field" "$prefix" '"hell=
o.c"' 'x' "Garbage after $field"
+=09test_path_fail "$change" "space after quoted $field"   "$prefix" '"hell=
o.c"' ' ' "Garbage after $field"
+}
+test_path_eol_fail () {
+=09local change=3D"$1" prefix=3D"$2" field=3D"$3"
+=09test_path_eol_quoted_fail "$change" "$prefix" "$field"
+}
+test_path_space_fail () {
+=09local change=3D"$1" prefix=3D"$2" field=3D"$3"
+=09test_path_base_fail "$change" "$prefix" "$field" ' world.c'
+=09test_path_fail "$change" "missing space after quoted $field"   "$prefix=
" '"hello.c"' 'x world.c' "Missing space after $field"
+=09test_path_fail "$change" "missing space after unquoted $field" "$prefix=
" 'hello.c'   ''          "Missing space after $field"
+}
+
+test_path_eol_fail   filemodify       'M 100644 :1 ' path
+test_path_eol_fail   filedelete       'D '           path
+test_path_space_fail filecopy         'C '           source
+test_path_eol_fail   filecopy         'C hello.c '   dest
+test_path_space_fail filerename       'R '           source
+test_path_eol_fail   filerename       'R hello.c '   dest
+test_path_eol_fail   'ls (in commit)' 'ls :2 '       path
+
+# When 'ls' has no <dataref>, the <path> must be quoted.
+test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path
+
 ###
 ### series T (ls)
 ###
--=20
2.44.0


