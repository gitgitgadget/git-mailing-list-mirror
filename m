From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 3/9] strbuf: introduce strbuf_getline_{lf,nul}()
Date: Wed, 13 Jan 2016 19:03:03 -0800
Message-ID: <1452740590-16827-4-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYCB-0007Yv-Pt
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbcANDDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752737AbcANDDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 365773C42B;
	Wed, 13 Jan 2016 22:03:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DKYN
	Rfns9zp8wIAn8rpwzpLPG3Q=; b=Cq5T/rtowPdxo3KcTvfGrb0Z/2NZxLpp41m+
	rbCehXaqRY1Pbg8cwpcdwgoFAi8Mk8lanHb0ShR+AOcp+czNj2SZpCJ+RE2rV8tB
	zlZKToclcLPLHEoZjS337w/XZtcCGADeB3n1DFp+OOyBUAOry/pKgXPvldA2s+3B
	3tWQz1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	u/VHahDQ66wuWQAux/j4unC+lz62g5UQL9T9qbtJyJgtZoQpTzBDHN2uogvCBBee
	Yc6ZI9gP8KPdtMZwpNSQzrlqgOmen9OafWgltmBEODMBu/GtTYoGsrg7EgCIAVHn
	ZruHvzF9MGbw7rPVhK6fF/VEhvtZZCluUsoakmp6pr4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E5A43C42A;
	Wed, 13 Jan 2016 22:03:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 607CF3C429;
	Wed, 13 Jan 2016 22:03:16 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5B80A396-BA6B-11E5-A3FD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284004>

The strbuf_getline() interface allows a byte other than LF or NUL as
the line terminator, but this is only because I wrote these
codepaths anticipating that there might be a value other than NUL
and LF that could be useful when I introduced line_termination long
time ago.  No useful caller that uses other value has emerged.

By now, it is clear that the interface is overly broad without a
good reason.  Many codepaths have hardcoded preference to read
either LF terminated or NUL terminated records from their input, and
then call strbuf_getline() with LF or NUL as the third parameter.

This step introduces two thin wrappers around strbuf_getline(),
namely, strbuf_getline_lf() and strbuf_getline_nul(), and
mechanically rewrites these call sites to call either one of
them.  The changes contained in this patch are:

 * introduction of these two functions in strbuf.[ch]

 * mechanical conversion of all callers to strbuf_getline() with
   either '\n' or '\0' as the third parameter to instead call the
   respective thin wrapper.

After this step, output from "git grep 'strbuf_getline('" would
become a lot smaller.  An interim goal of this series is to make
this an empty set, so that we can have strbuf_getline_crlf() take
over the shorter name strbuf_getline().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.c                   |  8 ++++----
 builtin/am.c               | 14 +++++++-------
 builtin/cat-file.c         |  2 +-
 builtin/check-mailmap.c    |  2 +-
 builtin/clean.c            |  6 +++---
 builtin/clone.c            |  2 +-
 builtin/column.c           |  2 +-
 builtin/commit.c           |  2 +-
 builtin/fetch-pack.c       |  2 +-
 builtin/grep.c             |  2 +-
 builtin/hash-object.c      |  2 +-
 builtin/mailinfo.c         |  8 ++++----
 builtin/notes.c            |  2 +-
 builtin/pull.c             |  2 +-
 builtin/repack.c           |  2 +-
 builtin/rev-parse.c        |  4 ++--
 builtin/send-pack.c        |  2 +-
 compat/terminal.c          |  2 +-
 credential-cache--daemon.c |  4 ++--
 credential-store.c         |  2 +-
 credential.c               |  2 +-
 daemon.c                   |  2 +-
 fast-import.c              |  4 ++--
 ident.c                    |  2 +-
 remote-curl.c              |  6 +++---
 remote-testsvn.c           |  4 ++--
 remote.c                   |  4 ++--
 sequencer.c                |  2 +-
 sha1_file.c                |  2 +-
 shell.c                    |  2 +-
 strbuf.c                   | 10 ++++++++++
 strbuf.h                   |  7 +++++++
 test-sha1-array.c          |  2 +-
 transport-helper.c         |  2 +-
 walker.c                   |  2 +-
 wt-status.c                |  4 ++--
 36 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/bisect.c b/bisect.c
index 053d1a2..4bbf93e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -440,7 +440,7 @@ static void read_bisect_paths(struct argv_array *array)
 	if (!fp)
 		die_errno("Could not open file '%s'", filename);
 
-	while (strbuf_getline(&str, fp, '\n') != EOF) {
+	while (strbuf_getline_lf(&str, fp) != EOF) {
 		strbuf_trim(&str);
 		if (sq_dequote_to_argv_array(str.buf, array))
 			die("Badly quoted content in file '%s': %s",
@@ -668,7 +668,7 @@ static int is_expected_rev(const struct object_id *oid)
 	if (!fp)
 		return 0;
 
-	if (strbuf_getline(&str, fp, '\n') != EOF)
+	if (strbuf_getline_lf(&str, fp) != EOF)
 		res = !strcmp(str.buf, oid_to_hex(oid));
 
 	strbuf_release(&str);
@@ -914,9 +914,9 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 				strerror(errno));
 		}
 	} else {
-		strbuf_getline(&str, fp, '\n');
+		strbuf_getline_lf(&str, fp);
 		*read_bad = strbuf_detach(&str, NULL);
-		strbuf_getline(&str, fp, '\n');
+		strbuf_getline_lf(&str, fp);
 		*read_good = strbuf_detach(&str, NULL);
 	}
 	strbuf_release(&str);
diff --git a/builtin/am.c b/builtin/am.c
index 94a533a..885fa19 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -268,7 +268,7 @@ static char *read_shell_var(FILE *fp, const char *key)
 	struct strbuf sb = STRBUF_INIT;
 	const char *str;
 
-	if (strbuf_getline(&sb, fp, '\n'))
+	if (strbuf_getline_lf(&sb, fp))
 		goto fail;
 
 	if (!skip_prefix(sb.buf, key, &str))
@@ -557,7 +557,7 @@ static int copy_notes_for_rebase(const struct am_state *state)
 
 	fp = xfopen(am_path(state, "rewritten"), "r");
 
-	while (!strbuf_getline(&sb, fp, '\n')) {
+	while (!strbuf_getline_lf(&sb, fp)) {
 		unsigned char from_obj[GIT_SHA1_RAWSZ], to_obj[GIT_SHA1_RAWSZ];
 
 		if (sb.len != GIT_SHA1_HEXSZ * 2 + 1) {
@@ -801,7 +801,7 @@ static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 	struct strbuf sb = STRBUF_INIT;
 	int subject_printed = 0;
 
-	while (!strbuf_getline(&sb, in, '\n')) {
+	while (!strbuf_getline_lf(&sb, in)) {
 		const char *str;
 
 		if (str_isspace(sb.buf))
@@ -859,7 +859,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 		return error(_("could not open '%s' for reading: %s"), *paths,
 				strerror(errno));
 
-	while (!strbuf_getline(&sb, fp, '\n')) {
+	while (!strbuf_getline_lf(&sb, fp)) {
 		if (*sb.buf == '#')
 			continue; /* skip comment lines */
 
@@ -884,7 +884,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	while (!strbuf_getline(&sb, in, '\n')) {
+	while (!strbuf_getline_lf(&sb, in)) {
 		const char *str;
 
 		if (skip_prefix(sb.buf, "# User ", &str))
@@ -1298,7 +1298,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	/* Extract message and author information */
 	fp = xfopen(am_path(state, "info"), "r");
-	while (!strbuf_getline(&sb, fp, '\n')) {
+	while (!strbuf_getline_lf(&sb, fp)) {
 		const char *x;
 
 		if (skip_prefix(sb.buf, "Subject: ", &x)) {
@@ -1364,7 +1364,7 @@ static int get_mail_commit_sha1(unsigned char *commit_id, const char *mail)
 	FILE *fp = xfopen(mail, "r");
 	const char *x;
 
-	if (strbuf_getline(&sb, fp, '\n'))
+	if (strbuf_getline_lf(&sb, fp))
 		return -1;
 
 	if (!skip_prefix(sb.buf, "From ", &x))
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index c0fd8db..d2ebaf1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -401,7 +401,7 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index eaaea54..cf0f54f 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -54,7 +54,7 @@ int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 
 	if (use_stdin) {
 		struct strbuf buf = STRBUF_INIT;
-		while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		while (strbuf_getline_lf(&buf, stdin) != EOF) {
 			check_mailmap(&mailmap, buf.buf);
 			maybe_flush_or_die(stdout, "stdout");
 		}
diff --git a/builtin/clean.c b/builtin/clean.c
index d7acb94..cc5f972 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -594,7 +594,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 			       clean_get_color(CLEAN_COLOR_RESET));
 		}
 
-		if (strbuf_getline(&choice, stdin, '\n') != EOF) {
+		if (strbuf_getline_lf(&choice, stdin) != EOF) {
 			strbuf_trim(&choice);
 		} else {
 			eof = 1;
@@ -676,7 +676,7 @@ static int filter_by_patterns_cmd(void)
 		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
 		clean_print_color(CLEAN_COLOR_RESET);
-		if (strbuf_getline(&confirm, stdin, '\n') != EOF)
+		if (strbuf_getline_lf(&confirm, stdin) != EOF)
 			strbuf_trim(&confirm);
 		else
 			putchar('\n');
@@ -774,7 +774,7 @@ static int ask_each_cmd(void)
 			qname = quote_path_relative(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
-			if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
+			if (strbuf_getline_lf(&confirm, stdin) != EOF) {
 				strbuf_trim(&confirm);
 			} else {
 				putchar('\n');
diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..182af32 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -339,7 +339,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	FILE *in = fopen(src->buf, "r");
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline(&line, in, '\n') != EOF) {
+	while (strbuf_getline_lf(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
diff --git a/builtin/column.c b/builtin/column.c
index 449413c..40eab08 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -51,7 +51,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 			die(_("--command must be the first argument"));
 	}
 	finalize_colopts(&colopts, -1);
-	while (!strbuf_getline(&sb, stdin, '\n'))
+	while (!strbuf_getline_lf(&sb, stdin))
 		string_list_append(&list, sb.buf);
 
 	print_columns(&list, colopts, &copts);
diff --git a/builtin/commit.c b/builtin/commit.c
index dca09e2..fe247ed 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1687,7 +1687,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (fp == NULL)
 			die_errno(_("could not open '%s' for reading"),
 				  git_path_merge_head());
-		while (strbuf_getline(&m, fp, '\n') != EOF) {
+		while (strbuf_getline_lf(&m, fp) != EOF) {
 			struct commit *parent;
 
 			parent = get_merge_parent(m.buf);
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4a6b340..e6cc151 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -156,7 +156,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		else {
 			/* read from stdin one ref per line, until EOF */
 			struct strbuf line = STRBUF_INIT;
-			while (strbuf_getline(&line, stdin, '\n') != EOF)
+			while (strbuf_getline_lf(&line, stdin) != EOF)
 				add_sought_entry(&sought, &nr_sought, &alloc_sought, line.buf);
 			strbuf_release(&line);
 		}
diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..b2346f1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -562,7 +562,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
-	while (strbuf_getline(&sb, patterns, '\n') == 0) {
+	while (strbuf_getline_lf(&sb, patterns) == 0) {
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
 			continue;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 43b098b..3bc5ec1 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -60,7 +60,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 999a525..694c357 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -410,7 +410,7 @@ static int is_rfc2822_header(const struct strbuf *line)
 static int read_one_header_line(struct strbuf *line, FILE *in)
 {
 	/* Get the first part of the line. */
-	if (strbuf_getline(line, in, '\n'))
+	if (strbuf_getline_lf(line, in))
 		return 0;
 
 	/*
@@ -435,7 +435,7 @@ static int read_one_header_line(struct strbuf *line, FILE *in)
 		peek = fgetc(in); ungetc(peek, in);
 		if (peek != ' ' && peek != '\t')
 			break;
-		if (strbuf_getline(&continuation, in, '\n'))
+		if (strbuf_getline_lf(&continuation, in))
 			break;
 		continuation.buf[0] = ' ';
 		strbuf_rtrim(&continuation);
@@ -644,7 +644,7 @@ static void handle_filter(struct strbuf *line);
 
 static int find_boundary(void)
 {
-	while (!strbuf_getline(&line, fin, '\n')) {
+	while (!strbuf_getline_lf(&line, fin)) {
 		if (*content_top && is_multipart_boundary(&line))
 			return 1;
 	}
@@ -692,7 +692,7 @@ again:
 
 	strbuf_release(&newline);
 	/* replenish line */
-	if (strbuf_getline(&line, fin, '\n'))
+	if (strbuf_getline_lf(&line, fin))
 		return 0;
 	strbuf_addch(&line, '\n');
 	return 1;
diff --git a/builtin/notes.c b/builtin/notes.c
index 515cebb..c1ace5a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -290,7 +290,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		t = &default_notes_tree;
 	}
 
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		unsigned char from_obj[20], to_obj[20];
 		struct strbuf **split;
 		int err;
diff --git a/builtin/pull.c b/builtin/pull.c
index bf3fd3f..bdc62ab 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -378,7 +378,7 @@ static void get_merge_heads(struct sha1_array *merge_heads)
 
 	if (!(fp = fopen(filename, "r")))
 		die_errno(_("could not open '%s' for reading"), filename);
-	while (strbuf_getline(&sb, fp, '\n') != EOF) {
+	while (strbuf_getline_lf(&sb, fp) != EOF) {
 		if (get_sha1_hex(sb.buf, sha1))
 			continue;  /* invalid line: does not start with SHA1 */
 		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
diff --git a/builtin/repack.c b/builtin/repack.c
index 9456110..858db38 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -266,7 +266,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		return ret;
 
 	out = xfdopen(cmd.out, "r");
-	while (strbuf_getline(&line, out, '\n') != EOF) {
+	while (strbuf_getline_lf(&line, out) != EOF) {
 		if (line.len != 40)
 			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
 		string_list_append(&names, line.buf);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02d747d..b827ffd 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -386,7 +386,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
-		if (strbuf_getline(&sb, stdin, '\n') == EOF)
+		if (strbuf_getline_lf(&sb, stdin) == EOF)
 			die("premature end of input");
 		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
@@ -399,7 +399,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
-	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
+	while (strbuf_getline_lf(&sb, stdin) != EOF) {
 		const char *s;
 		const char *help;
 		struct option *o;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f6e5d64..8f9f4f1 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -212,7 +212,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				argv_array_push(&all_refspecs, buf);
 		} else {
 			struct strbuf line = STRBUF_INIT;
-			while (strbuf_getline(&line, stdin, '\n') != EOF)
+			while (strbuf_getline_lf(&line, stdin) != EOF)
 				argv_array_push(&all_refspecs, line.buf);
 			strbuf_release(&line);
 		}
diff --git a/compat/terminal.c b/compat/terminal.c
index 313897d..fa13ee6 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -122,7 +122,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
 	fputs(prompt, output_fh);
 	fflush(output_fh);
 
-	r = strbuf_getline(&buf, input_fh, '\n');
+	r = strbuf_getline_lf(&buf, input_fh);
 	if (!echo) {
 		putc('\n', output_fh);
 		fflush(output_fh);
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index eef6fce..3db5d68 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -97,12 +97,12 @@ static int read_request(FILE *fh, struct credential *c,
 	static struct strbuf item = STRBUF_INIT;
 	const char *p;
 
-	strbuf_getline(&item, fh, '\n');
+	strbuf_getline_lf(&item, fh);
 	if (!skip_prefix(item.buf, "action=", &p))
 		return error("client sent bogus action line: %s", item.buf);
 	strbuf_addstr(action, p);
 
-	strbuf_getline(&item, fh, '\n');
+	strbuf_getline_lf(&item, fh);
 	if (!skip_prefix(item.buf, "timeout=", &p))
 		return error("client sent bogus timeout line: %s", item.buf);
 	*timeout = atoi(p);
diff --git a/credential-store.c b/credential-store.c
index 00aea3a..c5f9a0e 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -23,7 +23,7 @@ static int parse_credential_file(const char *fn,
 		return found_credential;
 	}
 
-	while (strbuf_getline(&line, fh, '\n') != EOF) {
+	while (strbuf_getline_lf(&line, fh) != EOF) {
 		credential_from_url(&entry, line.buf);
 		if (entry.username && entry.password &&
 		    credential_match(c, &entry)) {
diff --git a/credential.c b/credential.c
index b146ad8..7d6501d 100644
--- a/credential.c
+++ b/credential.c
@@ -142,7 +142,7 @@ int credential_read(struct credential *c, FILE *fp)
 {
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline(&line, fp, '\n') != EOF) {
+	while (strbuf_getline_lf(&line, fp) != EOF) {
 		char *key = line.buf;
 		char *value = strchr(key, '=');
 
diff --git a/daemon.c b/daemon.c
index 56679a1..161c0cf 100644
--- a/daemon.c
+++ b/daemon.c
@@ -424,7 +424,7 @@ static void copy_to_log(int fd)
 		return;
 	}
 
-	while (strbuf_getline(&line, fp, '\n') != EOF) {
+	while (strbuf_getline_lf(&line, fp) != EOF) {
 		logerror("%s", line.buf);
 		strbuf_setlen(&line, 0);
 	}
diff --git a/fast-import.c b/fast-import.c
index e3b421d..ae3ecf0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1888,7 +1888,7 @@ static int read_next_command(void)
 			struct recent_command *rc;
 
 			strbuf_detach(&command_buf, NULL);
-			stdin_eof = strbuf_getline(&command_buf, stdin, '\n');
+			stdin_eof = strbuf_getline_lf(&command_buf, stdin);
 			if (stdin_eof)
 				return EOF;
 
@@ -1960,7 +1960,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 
 		strbuf_detach(&command_buf, NULL);
 		for (;;) {
-			if (strbuf_getline(&command_buf, stdin, '\n') == EOF)
+			if (strbuf_getline_lf(&command_buf, stdin) == EOF)
 				die("EOF in data (terminator '%s' not found)", term);
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
diff --git a/ident.c b/ident.c
index 5ff1aad..9c0b387 100644
--- a/ident.c
+++ b/ident.c
@@ -55,7 +55,7 @@ static int add_mailname_host(struct strbuf *buf)
 				strerror(errno));
 		return -1;
 	}
-	if (strbuf_getline(&mailnamebuf, mailname, '\n') == EOF) {
+	if (strbuf_getline_lf(&mailnamebuf, mailname) == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
diff --git a/remote-curl.c b/remote-curl.c
index cc7a8a6..fcb0004 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -827,7 +827,7 @@ static void parse_fetch(struct strbuf *buf)
 			die("http transport does not support %s", buf->buf);
 
 		strbuf_reset(buf);
-		if (strbuf_getline(buf, stdin, '\n') == EOF)
+		if (strbuf_getline_lf(buf, stdin) == EOF)
 			return;
 		if (!*buf->buf)
 			break;
@@ -940,7 +940,7 @@ static void parse_push(struct strbuf *buf)
 			die("http transport does not support %s", buf->buf);
 
 		strbuf_reset(buf);
-		if (strbuf_getline(buf, stdin, '\n') == EOF)
+		if (strbuf_getline_lf(buf, stdin) == EOF)
 			goto free_specs;
 		if (!*buf->buf)
 			break;
@@ -990,7 +990,7 @@ int main(int argc, const char **argv)
 	do {
 		const char *arg;
 
-		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
+		if (strbuf_getline_lf(&buf, stdin) == EOF) {
 			if (ferror(stdin))
 				error("remote-curl: error reading command stream from git");
 			return 1;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index f599c37..f05ff45 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -154,7 +154,7 @@ static void check_or_regenerate_marks(int latestrev)
 		fclose(marksfile);
 	} else {
 		strbuf_addf(&sb, ":%d ", latestrev);
-		while (strbuf_getline(&line, marksfile, '\n') != EOF) {
+		while (strbuf_getline_lf(&line, marksfile) != EOF) {
 			if (starts_with(line.buf, sb.buf)) {
 				found++;
 				break;
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 	marksfilename = marksfilename_sb.buf;
 
 	while (1) {
-		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
+		if (strbuf_getline_lf(&buf, stdin) == EOF) {
 			if (ferror(stdin))
 				die("Error reading command stream");
 			else
diff --git a/remote.c b/remote.c
index 1101f82..7e6e625 100644
--- a/remote.c
+++ b/remote.c
@@ -256,7 +256,7 @@ static void read_remotes_file(struct remote *remote)
 	if (!f)
 		return;
 	remote->origin = REMOTE_REMOTES;
-	while (strbuf_getline(&buf, f, '\n') != EOF) {
+	while (strbuf_getline_lf(&buf, f) != EOF) {
 		const char *v;
 
 		strbuf_rtrim(&buf);
@@ -281,7 +281,7 @@ static void read_branches_file(struct remote *remote)
 	if (!f)
 		return;
 
-	strbuf_getline(&buf, f, '\n');
+	strbuf_getline_lf(&buf, f);
 	strbuf_trim(&buf);
 	if (!buf.len) {
 		strbuf_release(&buf);
diff --git a/sequencer.c b/sequencer.c
index a0600ae..f1cf735 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -886,7 +886,7 @@ static int sequencer_rollback(struct replay_opts *opts)
 	if (!f)
 		return error(_("cannot open %s: %s"), git_path_head_file(),
 						strerror(errno));
-	if (strbuf_getline(&buf, f, '\n')) {
+	if (strbuf_getline_lf(&buf, f)) {
 		error(_("cannot read %s: %s"), git_path_head_file(),
 		      ferror(f) ?  strerror(errno) : _("unexpected end of file"));
 		fclose(f);
diff --git a/sha1_file.c b/sha1_file.c
index 50896ff..3b66742 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -395,7 +395,7 @@ void add_to_alternates_file(const char *reference)
 		struct strbuf line = STRBUF_INIT;
 		int found = 0;
 
-		while (strbuf_getline(&line, in, '\n') != EOF) {
+		while (strbuf_getline_lf(&line, in) != EOF) {
 			if (!strcmp(reference, line.buf)) {
 				found = 1;
 				break;
diff --git a/shell.c b/shell.c
index ace62e4..c5439a6 100644
--- a/shell.c
+++ b/shell.c
@@ -88,7 +88,7 @@ static void run_shell(void)
 		int count;
 
 		fprintf(stderr, "git> ");
-		if (strbuf_getline(&line, stdin, '\n') == EOF) {
+		if (strbuf_getline_lf(&line, stdin) == EOF) {
 			fprintf(stderr, "\n");
 			strbuf_release(&line);
 			break;
diff --git a/strbuf.c b/strbuf.c
index 7ad5ea4..2ff898c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -522,6 +522,16 @@ int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
 	return 0;
 }
 
+int strbuf_getline_lf(struct strbuf *sb, FILE *fp)
+{
+	return strbuf_getline(sb, fp, '\n');
+}
+
+int strbuf_getline_nul(struct strbuf *sb, FILE *fp)
+{
+	return strbuf_getline(sb, fp, '\0');
+}
+
 int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
 {
 	strbuf_reset(sb);
diff --git a/strbuf.h b/strbuf.h
index d84c866..5501743 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -388,6 +388,12 @@ extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
  */
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 
+
+typedef int (*strbuf_getline_fn)(struct strbuf *, FILE *);
+
+extern int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
+extern int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
+
 /*
  * Similar to strbuf_getline(), but uses '\n' as the terminator,
  * and additionally treats a '\r' that comes immediately before '\n'
@@ -395,6 +401,7 @@ extern int strbuf_getline(struct strbuf *, FILE *, int);
  */
 extern int strbuf_getline_crlf(struct strbuf *, FILE *);
 
+
 /**
  * Like `strbuf_getline`, but keeps the trailing terminator (if
  * any) in the buffer.
diff --git a/test-sha1-array.c b/test-sha1-array.c
index ddc491e..700f3f3 100644
--- a/test-sha1-array.c
+++ b/test-sha1-array.c
@@ -11,7 +11,7 @@ int main(int argc, char **argv)
 	struct sha1_array array = SHA1_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline(&line, stdin, '\n') != EOF) {
+	while (strbuf_getline_lf(&line, stdin) != EOF) {
 		const char *arg;
 		unsigned char sha1[20];
 
diff --git a/transport-helper.c b/transport-helper.c
index 63d5427..74eb217 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	strbuf_reset(buffer);
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
-	if (strbuf_getline(buffer, helper, '\n') == EOF) {
+	if (strbuf_getline_lf(buffer, helper) == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
 		return 1;
diff --git a/walker.c b/walker.c
index cdeb63f..7615857 100644
--- a/walker.c
+++ b/walker.c
@@ -220,7 +220,7 @@ int walker_targets_stdin(char ***target, const char ***write_ref)
 		char *rf_one = NULL;
 		char *tg_one;
 
-		if (strbuf_getline(&buf, stdin, '\n') == EOF)
+		if (strbuf_getline_lf(&buf, stdin) == EOF)
 			break;
 		tg_one = buf.buf;
 		rf_one = strchr(tg_one, '\t');
diff --git a/wt-status.c b/wt-status.c
index 3e3b8c0..7aa3d1b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -988,7 +988,7 @@ static char *read_line_from_git_path(const char *filename)
 		strbuf_release(&buf);
 		return NULL;
 	}
-	strbuf_getline(&buf, fp, '\n');
+	strbuf_getline_lf(&buf, fp);
 	if (!fclose(fp)) {
 		return strbuf_detach(&buf, NULL);
 	} else {
@@ -1076,7 +1076,7 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
 	if (!f)
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
-	while (!strbuf_getline(&line, f, '\n')) {
+	while (!strbuf_getline_lf(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
 		strbuf_trim(&line);
-- 
2.7.0-242-gdd583c7
