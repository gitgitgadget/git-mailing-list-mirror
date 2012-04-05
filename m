From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv3] fast-import: tighten parsing of mark references
Date: Wed, 4 Apr 2012 21:51:21 -0400
Message-ID: <20120405015121.GA10945@padd.com>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 03:51:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFbrJ-00080a-TG
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 03:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab2DEBv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 21:51:27 -0400
Received: from honk.padd.com ([74.3.171.149]:55762 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab2DEBv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 21:51:26 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 651062CBE;
	Wed,  4 Apr 2012 18:51:25 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9308A313D1; Wed,  4 Apr 2012 21:51:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1333417910-17955-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194756>

The syntax for the use of mark references in fast-import
demands either a SP (space) or LF (end-of-line) after
a mark reference.  Fast-import does not complain when garbage
appears after a mark reference in some cases.

Factor out parsing of mark references and complain if
errant characters are found.

Buggy input can cause fast-import to produce the wrong output,
silently, without error.  This makes it difficult to track
down buggy generators of fast-import streams.  An example is
seen in the last line of this commit command:

    commit refs/heads/S2
    committer Name <name@example.com> 1112912893 -0400
    data <<COMMIT
    commit message
    COMMIT
    from :1M 100644 :103 hello.c

It is missing a newline and should be:

    [...]
    from :1
    M 100644 :103 hello.c

What fast-import does is to produce a commit with the same
contents for hello.c as in refs/heads/S2^.  What the buggy
program was expecting was the contents of blob :103.  While
the resulting commit graph looked correct, the contents in
some commits were wrong.
---

This addresses all of Jonathan's comments, in particular:

  - give tests descriptive names

  - add asserts for trailing space for filemodify, notemodify
    to protect against flaws in future dataref implementions

  - compactify end pointer return and update, so:

      oe = find_mark(parse_mark_ref_space(&p));

  - replace "grep -q" with "test_i18ngrep"

  - drop first word in failure messages, so no "Missing"
    or "Garbage", resp., in:

      test_i18ngrep "space after SHA1" err
      test_i18ngrep "after mark" err

  - Erroneous datarefs "inlineX" and "no-such-dataref" should
    behave the same, in particular, they now complain "Invalid SHA1"
    rather than guessing an attempt at "inline ".

  - Revert change parse_treeish_dataref() API in case other
    changes are inflight.  Verify space handling in caller.

I did not refactor the 15 or so common lines in filemodify and
notemodify dataref handling.

I'll resend once 1.7.11 opens up.

Thanks all for the careful review.

		-- Pete

 fast-import.c          |  102 +++++++++++++-----
 t/t9300-fast-import.sh |  276 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 349 insertions(+), 29 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a85275d..0525e12 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2207,6 +2207,59 @@ static uintmax_t change_note_fanout(struct tree_entry *root,
 	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
 }
 
+/*
+ * Given a pointer into a string, parse a mark reference:
+ *
+ *   idnum ::= ':' bigint;
+ *
+ * Return the first character after the value in *endptr.
+ *
+ * Complain if the following character is not what is expected,
+ * either a space or end of the string.
+ */
+static uintmax_t parse_mark_ref(const char *p, char **endptr)
+{
+	uintmax_t mark;
+
+	assert(*p == ':');
+	++p;
+	mark = strtoumax(p, endptr, 10);
+	if (*endptr == p)
+		die("No value after ':' in mark: %s", command_buf.buf);
+	return mark;
+}
+
+/*
+ * Parse the mark reference, and complain if this is not the end of
+ * the string.
+ */
+static uintmax_t parse_mark_ref_eol(const char *p)
+{
+	char *end;
+	uintmax_t mark;
+
+	mark = parse_mark_ref(p, &end);
+	if (*end != '\0')
+		die("Garbage after mark: %s", command_buf.buf);
+	return mark;
+}
+
+/*
+ * Parse the mark reference, demanding a trailing space.  Return a
+ * pointer to the space.
+ */
+static uintmax_t parse_mark_ref_space(const char **p)
+{
+	uintmax_t mark;
+	char *end;
+
+	mark = parse_mark_ref(*p, &end);
+	if (*end != ' ')
+		die("Missing space after mark: %s", command_buf.buf);
+	*p = end;
+	return mark;
+}
+
 static void file_change_m(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
@@ -2235,21 +2288,21 @@ static void file_change_m(struct branch *b)
 	}
 
 	if (*p == ':') {
-		char *x;
-		oe = find_mark(strtoumax(p + 1, &x, 10));
+		oe = find_mark(parse_mark_ref_space(&p));
 		hashcpy(sha1, oe->idx.sha1);
-		p = x;
-	} else if (!prefixcmp(p, "inline")) {
+	} else if (!prefixcmp(p, "inline ")) {
 		inline_data = 1;
-		p += 6;
+		p += strlen("inline");  /* advance to space */
 	} else {
 		if (get_sha1_hex(p, sha1))
 			die("Invalid SHA1: %s", command_buf.buf);
 		oe = find_object(sha1);
 		p += 40;
+		if (*p != ' ')
+			die("Missing space after SHA1: %s", command_buf.buf);
 	}
-	if (*p++ != ' ')
-		die("Missing space after SHA1: %s", command_buf.buf);
+	assert(*p == ' ');
+	++p;  /* skip space */
 
 	strbuf_reset(&uq);
 	if (!unquote_c_style(&uq, p, &endp)) {
@@ -2407,21 +2460,21 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 	/* Now parse the notemodify command. */
 	/* <dataref> or 'inline' */
 	if (*p == ':') {
-		char *x;
-		oe = find_mark(strtoumax(p + 1, &x, 10));
+		oe = find_mark(parse_mark_ref_space(&p));
 		hashcpy(sha1, oe->idx.sha1);
-		p = x;
-	} else if (!prefixcmp(p, "inline")) {
+	} else if (!prefixcmp(p, "inline ")) {
 		inline_data = 1;
-		p += 6;
+		p += strlen("inline");  /* advance to space */
 	} else {
 		if (get_sha1_hex(p, sha1))
 			die("Invalid SHA1: %s", command_buf.buf);
 		oe = find_object(sha1);
 		p += 40;
+		if (*p != ' ')
+			die("Missing space after SHA1: %s", command_buf.buf);
 	}
-	if (*p++ != ' ')
-		die("Missing space after SHA1: %s", command_buf.buf);
+	assert(*p == ' ');
+	++p;  /* skip space */
 
 	/* <committish> */
 	s = lookup_branch(p);
@@ -2430,7 +2483,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 			die("Can't add a note on empty branch.");
 		hashcpy(commit_sha1, s->sha1);
 	} else if (*p == ':') {
-		uintmax_t commit_mark = strtoumax(p + 1, NULL, 10);
+		uintmax_t commit_mark = parse_mark_ref_eol(p);
 		struct object_entry *commit_oe = find_mark(commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
@@ -2537,7 +2590,7 @@ static int parse_from(struct branch *b)
 		hashcpy(b->branch_tree.versions[0].sha1, t);
 		hashcpy(b->branch_tree.versions[1].sha1, t);
 	} else if (*from == ':') {
-		uintmax_t idnum = strtoumax(from + 1, NULL, 10);
+		uintmax_t idnum = parse_mark_ref_eol(from);
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2572,7 +2625,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 		if (s)
 			hashcpy(n->sha1, s->sha1);
 		else if (*from == ':') {
-			uintmax_t idnum = strtoumax(from + 1, NULL, 10);
+			uintmax_t idnum = parse_mark_ref_eol(from);
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2735,7 +2788,7 @@ static void parse_new_tag(void)
 		type = OBJ_COMMIT;
 	} else if (*from == ':') {
 		struct object_entry *oe;
-		from_mark = strtoumax(from + 1, NULL, 10);
+		from_mark = parse_mark_ref_eol(from);
 		oe = find_mark(from_mark);
 		type = oe->type;
 		hashcpy(sha1, oe->idx.sha1);
@@ -2867,14 +2920,9 @@ static void parse_cat_blob(void)
 	/* cat-blob SP <object> LF */
 	p = command_buf.buf + strlen("cat-blob ");
 	if (*p == ':') {
-		char *x;
-		oe = find_mark(strtoumax(p + 1, &x, 10));
-		if (x == p + 1)
-			die("Invalid mark: %s", command_buf.buf);
+		oe = find_mark(parse_mark_ref_eol(p));
 		if (!oe)
 			die("Unknown mark: %s", command_buf.buf);
-		if (*x)
-			die("Garbage after mark: %s", command_buf.buf);
 		hashcpy(sha1, oe->idx.sha1);
 	} else {
 		if (get_sha1_hex(p, sha1))
@@ -2944,13 +2992,9 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	struct object_entry *e;
 
 	if (**p == ':') {	/* <mark> */
-		char *endptr;
-		e = find_mark(strtoumax(*p + 1, &endptr, 10));
-		if (endptr == *p + 1)
-			die("Invalid mark: %s", command_buf.buf);
+		e = find_mark(parse_mark_ref_space(p));
 		if (!e)
 			die("Unknown mark: %s", command_buf.buf);
-		*p = endptr;
 		hashcpy(sha1, e->idx.sha1);
 	} else {	/* <sha1> */
 		if (get_sha1_hex(*p, sha1))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0f5b5e5..cbc0e81 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2635,4 +2635,280 @@ test_expect_success \
 	'n=$(grep $a verify | wc -l) &&
 	 test 1 = $n'
 
+###
+### series S
+###
+#
+# Setup is roughly this.  Commits marked 1,2,3,4.  Blobs
+# marked 100 + commit.  Notes 200 +.  Make sure missing spaces
+# and EOLs after mark references cause errors.
+#
+# The error message looks like either:
+#   Missing space after ..
+# or
+#   Garbage after ..
+#
+# 1--2--4
+#  \   /
+#   -3-
+#
+test_tick
+
+cat >input <<INPUT_END
+commit refs/heads/S
+mark :1
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit 1
+COMMIT
+M 100644 inline hello.c
+data <<BLOB
+blob 1
+BLOB
+
+commit refs/heads/S
+mark :2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit 2
+COMMIT
+from :1
+M 100644 inline hello.c
+data <<BLOB
+blob 2
+BLOB
+
+blob
+mark :103
+data <<BLOB
+blob 3
+BLOB
+
+blob
+mark :202
+data <<BLOB
+note 2
+BLOB
+INPUT_END
+
+test_expect_success 'S: initialize for S tests' '
+	git fast-import --export-marks=marks <input
+'
+
+#
+# filemodify, three datarefs
+#
+test_expect_success 'S: filemodify with garbage after mark must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit N
+	COMMIT
+	M 100644 :103x hello.c
+	EOF
+	cat err &&
+	test_i18ngrep "space after mark" err
+'
+
+# inline is misspelled; fast-import thinks it is some unknown dataref
+# and complains "Invalid SHA1"
+test_expect_success 'S: filemodify with garbage after inline must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit N
+	COMMIT
+	M 100644 inlineX hello.c
+	data <<BLOB
+	inline
+	BLOB
+	EOF
+	cat err &&
+	test_i18ngrep "nvalid SHA1" err
+'
+
+test_expect_success 'S: filemodify with garbage after sha1 must fail' '
+	sha1=$(grep -w :103 marks | cut -d\  -f2) &&
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit N
+	COMMIT
+	M 100644 ${sha1}x hello.c
+	EOF
+	cat err &&
+	test_i18ngrep "space after SHA1" err
+'
+
+#
+# notemodify, three ways to say dataref
+#
+test_expect_success 'S: notemodify with garabge after mark dataref must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note dataref markref
+	COMMIT
+	N :103x :2
+	EOF
+	cat err &&
+	test_i18ngrep "space after mark" err
+'
+
+# inline is misspelled; fast-import thinks it is some unknown dataref
+# and complains "Invalid SHA1"
+test_expect_success 'S: notemodify with garbage after inline dataref must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note dataref inline
+	COMMIT
+	N inlineX :2
+	data <<BLOB
+	note blob
+	BLOB
+	EOF
+	cat err &&
+	test_i18ngrep "nvalid SHA1" err
+'
+
+test_expect_success 'S: notemodify with garbage after sha1 dataref must fail' '
+	sha1=$(grep -w :2 marks | cut -d\  -f2) &&
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note dataref sha1
+	COMMIT
+	N ${sha1}x :2
+	EOF
+	cat err &&
+	test_i18ngrep "space after SHA1" err
+'
+
+#
+# notemodify, mark in committish
+#
+test_expect_success 'S: notemodify with garbarge after mark committish must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/Snotes
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit S note committish
+	COMMIT
+	N :202 :2x
+	EOF
+	cat err &&
+	test_i18ngrep "after mark" err
+'
+
+#
+# from
+#
+test_expect_success 'S: from with garbage after mark must fail' '
+	# no &&
+	git fast-import --import-marks=marks --export-marks=marks <<-EOF 2>err
+	commit refs/heads/S2
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 3
+	COMMIT
+	from :1x
+	M 100644 :103 hello.c
+	EOF
+
+	ret=$? &&
+	echo returned $ret &&
+	test $ret -ne 0 && # failed, but it created the commit
+
+	# go create the commit, need it for merge test
+	git fast-import --import-marks=marks --export-marks=marks <<-EOF &&
+	commit refs/heads/S2
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 3
+	COMMIT
+	from :1
+	M 100644 :103 hello.c
+	EOF
+
+	# now evaluate the error
+	cat err &&
+	test_i18ngrep "after mark" err
+'
+
+
+#
+# merge
+#
+test_expect_success 'S: merge with garbage after mark must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	commit refs/heads/S
+	mark :4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit 3
+	COMMIT
+	from :2
+	merge :3x
+	M 100644 :103 hello.c
+	EOF
+	cat err &&
+	test_i18ngrep "after mark" err
+'
+
+#
+# tag, from markref
+#
+test_expect_success 'S: tag with garbage after mark must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	tag refs/tags/Stag
+	from :2x
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<TAG
+	tag S
+	TAG
+	EOF
+	cat err &&
+	test_i18ngrep "after mark" err
+'
+
+#
+# cat-blob markref
+#
+test_expect_success 'S: cat-blob with garbage after mark must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	cat-blob :2x
+	EOF
+	cat err &&
+	test_i18ngrep "after mark" err
+'
+
+#
+# ls markref
+#
+test_expect_success 'S: ls with garbage after mark must fail' '
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	ls :2x hello.c
+	EOF
+	cat err &&
+	test_i18ngrep "space after mark" err
+'
+
+test_expect_success 'S: ls with garbage after sha1 must fail' '
+	sha1=$(grep -w :2 marks | cut -d\  -f2) &&
+	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+	ls ${sha1}x hello.c
+	EOF
+	cat err &&
+	test_i18ngrep "space after tree-ish" err
+'
+
 test_done
-- 
1.7.10.rc2.62.gac32b.dirty
