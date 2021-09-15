Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFBFC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40D4603E9
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhIOWeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 18:34:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57141 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhIOWem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 18:34:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D1D0E83D1;
        Wed, 15 Sep 2021 18:33:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=NCC9t/hvI6emsb6bKwOxIulG5
        rbaH7GXFdG8c4Vlxgg=; b=wC+siYAwm9v+iYxvy+l2T8noGCml1bY9ftvxjIwD1
        zwh1sUVxtuM6e/yic5ehJEIFHUM+j/IjwGvUvqpS9TvPoyoIn0cXlvOO4Ff49BWH
        ZlOjDLEytitBi2YpLqnfUOeQRliMJQPaeE85acn5fY1vOoSYZBSsMTBcfC2u3wAK
        NE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25440E83D0;
        Wed, 15 Sep 2021 18:33:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D2E2E83CE;
        Wed, 15 Sep 2021 18:33:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] diff: --quote-path-with-sp
Date:   Wed, 15 Sep 2021 15:33:16 -0700
Message-Id: <20210915223316.1653443-3-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-649-gd4f4107c2b
In-Reply-To: <20210915223316.1653443-1-gitster@pobox.com>
References: <20210915223316.1653443-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: EF3090D6-1674-11EC-A8BF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long time ago, we had a discussion with GNU patch/diff maintainer
and agreed that pathnames with certain "difficult" bytes needs to be
quoted to ensure the resulting patch is machine parseable in an
unambiguous way [*1*].  Recently, we saw a report that found that
GNU patch is unhappy with our diff output for a path with SP in it
[*2*].

Teach "git diff" and friends the "--quote-path-with-sp" option, that
encloses a pathname with SP in it inside a pair of double-quotes,
even though there is otherwise no byte in the pathname that need to
be encoded in the octal.

As an earlier parts of t/t3902 (outside the patch context) shows,
output from "ls-files", "ls-tree", and "diff --name-only" all follow
the same rule to decide paths with what bytes in them need quoting
and how they are quoted.

This experimental option deliberately refrains from touching these
output and affects ONLY the paths that appear in the patch header,
i.e. "diff --git", "--- a/path" and "+++ b/path" lines, that GNU
patch may care.  This is to minimize potential damage this change
may cause to tools and scripts the users have been relying on.

 *1* https://lore.kernel.org/git/87ek6s0w34.fsf@penguin.cs.ucla.edu/
 *2* https://lore.kernel.org/git/YR9Iaj%2FFqAyCMade@tilde.club/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  5 +++++
 diff.c                         | 16 ++++++++++------
 diff.h                         |  1 +
 quote.c                        | 23 ++++++++++++++++++-----
 quote.h                        |  3 ++-
 t/t3902-quoted.sh              | 24 +++++++++++++++++++++++-
 6 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.=
txt
index c89d530d3d..dd9b35c806 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -507,6 +507,11 @@ ifndef::git-format-patch[]
 	Implies `--patch`.
 endif::git-format-patch[]
=20
+--quote-path-with-sp::
+	(experimental) Quote a pathname that has SP in it inside a
+	pair of double quotes.  Such a quoted pathname should be
+	handled correctly by both Git and "GNU patch".
+
 --abbrev[=3D<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
diff --git a/diff.c b/diff.c
index 8143b737b7..73e42a9e18 100644
--- a/diff.c
+++ b/diff.c
@@ -480,11 +480,12 @@ int git_diff_basic_config(const char *var, const ch=
ar *value, void *cb)
 	return git_default_config(var, value, cb);
 }
=20
-static char *quote_two(const char *one, const char *two)
+static char *quote_two(const char *one, const char *two, const struct di=
ff_options *o)
 {
 	struct strbuf res =3D STRBUF_INIT;
+	int flags =3D o->flags.quote_path_with_sp ? CQUOTE_QUOTE_SP : 0;
=20
-	quote_two_c_style(&res, one, two, 0);
+	quote_two_c_style(&res, one, two, flags);
 	return strbuf_detach(&res, NULL);
 }
=20
@@ -1784,6 +1785,7 @@ static void emit_rewrite_diff(const char *name_a,
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
 	struct strbuf out =3D STRBUF_INIT;
+	int flags =3D o->flags.quote_path_with_sp ? CQUOTE_QUOTE_SP : 0;
=20
 	if (diff_mnemonic_prefix && o->flags.reverse_diff) {
 		a_prefix =3D o->b_prefix;
@@ -1798,8 +1800,8 @@ static void emit_rewrite_diff(const char *name_a,
=20
 	strbuf_reset(&a_name);
 	strbuf_reset(&b_name);
-	quote_two_c_style(&a_name, a_prefix, name_a, 0);
-	quote_two_c_style(&b_name, b_prefix, name_b, 0);
+	quote_two_c_style(&a_name, a_prefix, name_a, flags);
+	quote_two_c_style(&b_name, b_prefix, name_b, flags);
=20
 	size_one =3D fill_textconv(o->repo, textconv_one, one, &data_one);
 	size_two =3D fill_textconv(o->repo, textconv_two, two, &data_two);
@@ -3449,8 +3451,8 @@ static void builtin_diff(const char *name_a,
 	name_a =3D DIFF_FILE_VALID(one) ? name_a : name_b;
 	name_b =3D DIFF_FILE_VALID(two) ? name_b : name_a;
=20
-	a_one =3D quote_two(a_prefix, name_a + (*name_a =3D=3D '/'));
-	b_two =3D quote_two(b_prefix, name_b + (*name_b =3D=3D '/'));
+	a_one =3D quote_two(a_prefix, name_a + (*name_a =3D=3D '/'), o);
+	b_two =3D quote_two(b_prefix, name_b + (*name_b =3D=3D '/'), o);
 	lbl[0] =3D DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] =3D DIFF_FILE_VALID(two) ? b_two : "/dev/null";
 	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_o=
ne, b_two, reset);
@@ -5445,6 +5447,8 @@ static void prep_parse_options(struct diff_options =
*options)
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
 		OPT_BOOL(0, "full-index", &options->flags.full_index,
 			 N_("show full pre- and post-image object names on the \"index\" line=
s")),
+		OPT_BOOL(0, "quote-path-with-sp", &options->flags.quote_path_with_sp,
+			 N_("quote path with SP in it")),
 		OPT_COLOR_FLAG(0, "color", &options->use_color,
 			       N_("show colored diff")),
 		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
diff --git a/diff.h b/diff.h
index 8ba85c5e60..f90f07bb72 100644
--- a/diff.h
+++ b/diff.h
@@ -198,6 +198,7 @@ struct diff_flags {
 	unsigned suppress_diff_headers;
 	unsigned dual_color_diffed_diffs;
 	unsigned suppress_hunk_header_line_count;
+	unsigned quote_path_with_sp;
 };
=20
 static inline void diff_flags_or(struct diff_flags *a,
diff --git a/quote.c b/quote.c
index 8a3a5e39eb..292ad76de5 100644
--- a/quote.c
+++ b/quote.c
@@ -233,9 +233,11 @@ static inline int cq_must_quote(char c)
 	return cq_lookup[(unsigned char)c] + quote_path_fully > 0;
 }
=20
-/* returns the longest prefix not needing a quote up to maxlen if positi=
ve.
-   This stops at the first \0 because it's marked as a character needing=
 an
-   escape */
+/*
+ * Return the longest prefix not needing a quote up to maxlen if positiv=
e.
+ * This stops at the first \0 because it's marked as a character needing=
 an
+ * escape.
+ */
 static size_t next_quote_pos(const char *s, ssize_t maxlen)
 {
 	size_t len;
@@ -320,11 +322,22 @@ size_t quote_c_style(const char *name, struct strbu=
f *sb, FILE *fp, unsigned fla
 	return quote_c_style_counted(name, -1, sb, fp, flags);
 }
=20
+/*
+ * Quote concatenation of prefix and path (nothing in between); when
+ * even one of the two needs quoting, the whole thing needs to be
+ * quoted.  This is done by concatenating the result of quoting prefix
+ * and path without surrounding dq next to each other and then enclosing
+ * the whole thing inside a dq pair if needed.
+ */
 void quote_two_c_style(struct strbuf *sb, const char *prefix, const char=
 *path,
 		       unsigned flags)
 {
-	int nodq =3D !!(flags & CQUOTE_NODQ);
-	if (quote_c_style(prefix, NULL, NULL, 0) ||
+	int nodq =3D (flags & CQUOTE_NODQ);
+	int force_dq =3D ((flags & CQUOTE_QUOTE_SP) &&
+			(strchr(prefix, ' ') || strchr(path, ' ')));
+
+	if (force_dq ||
+	    quote_c_style(prefix, NULL, NULL, 0) ||
 	    quote_c_style(path, NULL, NULL, 0)) {
 		if (!nodq)
 			strbuf_addch(sb, '"');
diff --git a/quote.h b/quote.h
index 049d8dd0b3..3e027d28c2 100644
--- a/quote.h
+++ b/quote.h
@@ -81,7 +81,8 @@ int sq_dequote_to_strvec(char *arg, struct strvec *);
 int unquote_c_style(struct strbuf *, const char *quoted, const char **en=
dp);
=20
 /* Bits in the flags parameter to quote_c_style() */
-#define CQUOTE_NODQ 01
+#define CQUOTE_NODQ 01 /* do not enclose the result in dq pair */
+#define CQUOTE_QUOTE_SP 02 /* string with SP needs quoting */
 size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned=
);
 void quote_two_c_style(struct strbuf *, const char *, const char *, unsi=
gned);
=20
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index f528008c36..c76cde435c 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -27,7 +27,7 @@ for_each_name () {
 	    "$FN$HT$GN" "$FN$LF$GN" "$FN $GN" "$FN$GN" "$FN$DQ$GN" \
 	    "With SP in it" "$FN/file"
 	do
-		eval "$1"
+		eval "$1" || return 1
 	done
 }
=20
@@ -45,6 +45,14 @@ test_expect_success 'setup' '
=20
 '
=20
+# With core.quotepath=3Dtrue (default), bytes with hi-bit set, in additi=
on to
+# controls like \n and \t, are written in octal and the path is enclosed=
 in
+# a pair of double-quotes.
+#
+# With core.quotepath=3Dfalse, the special case for bytes with hi-bit se=
t is
+# disabled.
+#
+# A SP is treated just like any other bytes, nothing special.
 test_expect_success 'setup expected files' '
 cat >expect.quoted <<\EOF &&
 Name
@@ -149,4 +157,18 @@ test_expect_success 'check fully quoted output from =
ls-tree' '
=20
 '
=20
+test_expect_success 'diff --quote-path-with-sp' '
+	git diff --quote-path-with-sp HEAD^ HEAD -- "With*" >actual &&
+	sed -e "s/Z$//" >expect <<-\EOF &&
+	diff --git "a/With SP in it" "b/With SP in it"
+	index e79c5e8..e019be0 100644
+	--- "a/With SP in it"	Z
+	+++ "b/With SP in it"	Z
+	@@ -1 +1 @@
+	-initial
+	+second
+	EOF
+	test_cmp expect actual
+'
+
 test_done
--=20
2.33.0-649-gd4f4107c2b

