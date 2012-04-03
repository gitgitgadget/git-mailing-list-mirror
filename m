From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 2/2] fast-import: tighten parsing of mark references
Date: Mon,  2 Apr 2012 21:51:50 -0400
Message-ID: <1333417910-17955-3-git-send-email-pw@padd.com>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 03:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEsvH-0001QN-CA
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 03:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab2DCBwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 21:52:34 -0400
Received: from honk.padd.com ([74.3.171.149]:47813 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab2DCBwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 21:52:34 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 68DDD20CE;
	Mon,  2 Apr 2012 18:52:33 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1812C313CD; Mon,  2 Apr 2012 21:52:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc2.57.gb1c2d
In-Reply-To: <1333417910-17955-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194586>

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

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 fast-import.c          |   97 +++++++++++++++++++++++++++++++++++++-----------
 t/t9300-fast-import.sh |   20 +++++-----
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a85275d..bd1b9d1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2207,6 +2207,57 @@ static uintmax_t change_note_fanout(struct tree_entry *root,
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
+static uintmax_t parse_mark_ref_space(const char *p, char **endptr)
+{
+	uintmax_t mark;
+
+	mark = parse_mark_ref(p, endptr);
+	if (**endptr != ' ')
+		die("Missing space after mark: %s", command_buf.buf);
+	return mark;
+}
+
 static void file_change_m(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
@@ -2236,20 +2287,24 @@ static void file_change_m(struct branch *b)
 
 	if (*p == ':') {
 		char *x;
-		oe = find_mark(strtoumax(p + 1, &x, 10));
+		oe = find_mark(parse_mark_ref_space(p, &x));
 		hashcpy(sha1, oe->idx.sha1);
 		p = x;
 	} else if (!prefixcmp(p, "inline")) {
 		inline_data = 1;
 		p += 6;
+		if (*p != ' ')
+			die("Missing space after 'inline': %s",
+			    command_buf.buf);
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
+	++p;  /* skip space */
 
 	strbuf_reset(&uq);
 	if (!unquote_c_style(&uq, p, &endp)) {
@@ -2408,20 +2463,24 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 	/* <dataref> or 'inline' */
 	if (*p == ':') {
 		char *x;
-		oe = find_mark(strtoumax(p + 1, &x, 10));
+		oe = find_mark(parse_mark_ref_space(p, &x));
 		hashcpy(sha1, oe->idx.sha1);
 		p = x;
 	} else if (!prefixcmp(p, "inline")) {
 		inline_data = 1;
 		p += 6;
+		if (*p != ' ')
+			die("Missing space after 'inline': %s",
+			    command_buf.buf);
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
+	++p;  /* skip space */
 
 	/* <committish> */
 	s = lookup_branch(p);
@@ -2430,7 +2489,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 			die("Can't add a note on empty branch.");
 		hashcpy(commit_sha1, s->sha1);
 	} else if (*p == ':') {
-		uintmax_t commit_mark = strtoumax(p + 1, NULL, 10);
+		uintmax_t commit_mark = parse_mark_ref_eol(p);
 		struct object_entry *commit_oe = find_mark(commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
@@ -2537,7 +2596,7 @@ static int parse_from(struct branch *b)
 		hashcpy(b->branch_tree.versions[0].sha1, t);
 		hashcpy(b->branch_tree.versions[1].sha1, t);
 	} else if (*from == ':') {
-		uintmax_t idnum = strtoumax(from + 1, NULL, 10);
+		uintmax_t idnum = parse_mark_ref_eol(from);
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2572,7 +2631,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 		if (s)
 			hashcpy(n->sha1, s->sha1);
 		else if (*from == ':') {
-			uintmax_t idnum = strtoumax(from + 1, NULL, 10);
+			uintmax_t idnum = parse_mark_ref_eol(from);
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2735,7 +2794,7 @@ static void parse_new_tag(void)
 		type = OBJ_COMMIT;
 	} else if (*from == ':') {
 		struct object_entry *oe;
-		from_mark = strtoumax(from + 1, NULL, 10);
+		from_mark = parse_mark_ref_eol(from);
 		oe = find_mark(from_mark);
 		type = oe->type;
 		hashcpy(sha1, oe->idx.sha1);
@@ -2867,14 +2926,9 @@ static void parse_cat_blob(void)
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
@@ -2945,9 +2999,7 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 
 	if (**p == ':') {	/* <mark> */
 		char *endptr;
-		e = find_mark(strtoumax(*p + 1, &endptr, 10));
-		if (endptr == *p + 1)
-			die("Invalid mark: %s", command_buf.buf);
+		e = find_mark(parse_mark_ref_space(*p, &endptr));
 		if (!e)
 			die("Unknown mark: %s", command_buf.buf);
 		*p = endptr;
@@ -2955,9 +3007,12 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	} else {	/* <sha1> */
 		if (get_sha1_hex(*p, sha1))
 			die("Invalid SHA1: %s", command_buf.buf);
-		e = find_object(sha1);
 		*p += 40;
+		if (**p != ' ')
+			die("Missing space after SHA1: %s", command_buf.buf);
+		e = find_object(sha1);
 	}
+	*p += 1;  /* skip space */
 
 	while (!e || e->type != OBJ_TREE)
 		e = dereference(e, sha1);
@@ -3008,8 +3063,6 @@ static void parse_ls(struct branch *b)
 		root = new_tree_entry();
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
 		load_tree(root);
-		if (*p++ != ' ')
-			die("Missing space after tree-ish: %s", command_buf.buf);
 	}
 	if (*p == '"') {
 		static struct strbuf uq = STRBUF_INIT;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 621f02a..875ac7a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2693,7 +2693,7 @@ test_expect_success 'S: add commits 1 and 2, and blob 103' '
 #
 # filemodify, three datarefs
 #
-test_expect_failure 'S: filemodify markref no space' '
+test_expect_success 'S: filemodify markref no space' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/S
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2706,7 +2706,7 @@ test_expect_failure 'S: filemodify markref no space' '
 	grep -q "Missing space after mark" err
 '
 
-test_expect_failure 'S: filemodify inline no space' '
+test_expect_success 'S: filemodify inline no space' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/S
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2739,7 +2739,7 @@ test_expect_success 'S: filemodify sha1 no space' '
 #
 # notemodify, three ways to say dataref
 #
-test_expect_failure 'S: notemodify dataref markref no space' '
+test_expect_success 'S: notemodify dataref markref no space' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/S
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2752,7 +2752,7 @@ test_expect_failure 'S: notemodify dataref markref no space' '
 	grep -q "Missing space after mark" err
 '
 
-test_expect_failure 'S: notemodify dataref inline no space' '
+test_expect_success 'S: notemodify dataref inline no space' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/S
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2785,7 +2785,7 @@ test_expect_success 'S: notemodify dataref sha1 no space' '
 #
 # notemodify, mark in committish
 #
-test_expect_failure 'S: notemodify committish markref junk at eol' '
+test_expect_success 'S: notemodify committish markref junk at eol' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/Snotes
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2801,7 +2801,7 @@ test_expect_failure 'S: notemodify committish markref junk at eol' '
 #
 # from
 #
-test_expect_failure 'S: from markref junk at eol' '
+test_expect_success 'S: from markref junk at eol' '
 	# no &&
 	git fast-import --import-marks=marks --export-marks=marks <<-EOF 2>err
 	commit refs/heads/S2
@@ -2839,7 +2839,7 @@ test_expect_failure 'S: from markref junk at eol' '
 #
 # merge
 #
-test_expect_failure 'S: merge markref junk at eol' '
+test_expect_success 'S: merge markref junk at eol' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/S
 	mark :4
@@ -2858,7 +2858,7 @@ test_expect_failure 'S: merge markref junk at eol' '
 #
 # tag, from markref
 #
-test_expect_failure 'S: tag markref junk at eol' '
+test_expect_success 'S: tag markref junk at eol' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	tag refs/tags/Stag
 	from :2x
@@ -2885,7 +2885,7 @@ test_expect_success 'S: cat-blob markref junk at eol' '
 #
 # ls markref
 #
-test_expect_failure 'S: ls markref space' '
+test_expect_success 'S: ls markref space' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	ls :2x hello.c
 	EOF
@@ -2893,7 +2893,7 @@ test_expect_failure 'S: ls markref space' '
 	grep -q "Missing space after mark" err
 '
 
-test_expect_failure 'S: ls sha1 space' '
+test_expect_success 'S: ls sha1 space' '
 	sha1=$(grep -w :2 marks | cut -d\  -f2) &&
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	ls ${sha1}x hello.c
-- 
1.7.10.rc2.2.g38670
