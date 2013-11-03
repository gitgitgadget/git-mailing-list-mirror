From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] Add interpret-trailers builtin
Date: Sun, 03 Nov 2013 22:17:30 +0100
Message-ID: <20131103211731.15716.95056.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 03 22:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd53u-00032e-CC
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 22:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab3KCVSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 16:18:18 -0500
Received: from [194.158.98.15] ([194.158.98.15]:40120 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751952Ab3KCVSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 16:18:17 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A64FF37;
	Sun,  3 Nov 2013 22:17:51 +0100 (CET)
X-git-sha1: 4cc5bdfe061d3104faceffd479b4df773774bd48 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237278>

This RFC patch shows the work in progress to implement a new
command:

	git interpret-trailers

1) Rational:

This command should help with RFC 822 style headers, called
"trailers", that are found at the end of commit messages.

For a long time, these trailers have become a de facto standard
way to add helpful information into commit messages.

Until now git commit has only supported the well known
"Signed-off-by: " trailer, that is used by many projects like
the Linux kernel and Git.

It is better to implement features for these trailers in a new
command rather than in builtin/commit.c, because this way the
prepare-commit-msg and commit-msg hooks can reuse this command.

2) Current state:

Currently the usage string of this command is:

git interpret-trailers [--trim-empty] [--infile=file] [<token[=value]>...]

The following features are implemented:
	- the result is printed on stdout
	- the [<token[=value]>...] arguments are interpreted
	- a commit message passed using the "--infile=file" option is interpreted
	- the "trailer.<token>.value" options in the config are interpreted

The following features are planned but not yet implemented:
	- some documentation
	- more tests
	- the "trailer.<token>.if_exist" config option
	- the "trailer.<token>.if_missing" config option
	- the "trailer.<token>.command" config option

3) Notes:

* "trailer" seems better than "commitTrailer" as the config key because
it looks like all the config keys are lower case and "committrailer" is not
very readable.

* "trailer.<token>.value" looks better than "trailer.<token>.trailer", so
I chose the former.

* Rather than only one "trailer.<token>.style" config option, it seems
better to me to have both "trailer.<token>.if_exist" and
"trailer.<token>.if_missing".

* I might send a patch series instead of just one big patch when there will
be fewer big changes in the code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore                    |   1 +
 Makefile                      |   1 +
 builtin.h                     |   1 +
 builtin/interpret-trailers.c  | 284 ++++++++++++++++++++++++++++++++++++++++++
 git.c                         |   1 +
 strbuf.c                      |   7 ++
 strbuf.h                      |   1 +
 t/t7513-interpret-trailers.sh | 101 +++++++++++++++
 8 files changed, 397 insertions(+)
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh

diff --git a/.gitignore b/.gitignore
index 66199ed..e6cf15b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -73,6 +73,7 @@
 /git-index-pack
 /git-init
 /git-init-db
+/git-interpret-trailers
 /git-instaweb
 /git-log
 /git-lost-found
diff --git a/Makefile b/Makefile
index af847f8..96441f1 100644
--- a/Makefile
+++ b/Makefile
@@ -937,6 +937,7 @@ BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
+BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
diff --git a/builtin.h b/builtin.h
index b56cf07..88c2999 100644
--- a/builtin.h
+++ b/builtin.h
@@ -71,6 +71,7 @@ extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
+extern int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
new file mode 100644
index 0000000..2bcd480
--- /dev/null
+++ b/builtin/interpret-trailers.c
@@ -0,0 +1,284 @@
+/*
+ * Builtin "git interpret-trailers"
+ *
+ * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
+ *
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "strbuf.h"
+
+static const char * const git_interpret_trailers_usage[] = {
+	N_("git interpret-trailers [--trim-empty] [--infile=file] [<token[=value]>...]"),
+	NULL
+};
+
+static void parse_arg(struct strbuf *tok, struct strbuf *val, const char *arg)
+{
+	char *end = strchr(arg, '=');
+	if (!end)
+		end = strchr(arg, ':');
+	if (end) {
+		strbuf_add(tok, arg, end - arg);
+		strbuf_trim(tok);
+		strbuf_addstr(val, end + 1);
+		strbuf_trim(val);
+	} else {
+		strbuf_addstr(tok, arg);
+		strbuf_trim(tok);
+	}
+}
+
+static struct string_list trailer_list;
+
+enum style_if_exist { DONT_REPEAT, OVERWRITE, REPEAT };
+enum style_if_missing { DONT_APPEND, APPEND };
+
+struct trailer_info {
+	char *value;
+	char *command;
+	enum style_if_exist style_exist;
+	enum style_if_missing style_missing;
+};
+
+static int git_trailer_config(const char *key, const char *value, void *cb)
+{
+	if (!prefixcmp(key, "trailer.")) {
+		const char *orig_key = key;
+		char *name;
+		struct string_list_item *item;
+		struct trailer_info *info;
+		enum { VALUE, COMMAND, IF_EXIST, IF_MISSING } type;
+
+		key += 8;
+		if (!suffixcmp(key, ".value")) {
+			name = xstrndup(key, strlen(key) - 6);
+			type = VALUE;
+		} else if (!suffixcmp(key, ".command")) {
+			name = xstrndup(key, strlen(key) - 8);
+			type = COMMAND;
+		} else if (!suffixcmp(key, ".if_exist")) {
+			name = xstrndup(key, strlen(key) - 9);
+			type = IF_EXIST;
+		} else if (!suffixcmp(key, ".if_missing")) {
+			name = xstrndup(key, strlen(key) - 11);
+			type = IF_MISSING;
+		} else
+			return 0;
+
+		item = string_list_insert(&trailer_list, name);
+
+		if (!item->util)
+			item->util = xcalloc(sizeof(struct trailer_info), 1);
+		info = item->util;
+		if (type == VALUE) {
+			if (info->value)
+				warning(_("more than one %s"), orig_key);
+			info->value = xstrdup(value);
+		} else if (type == IF_EXIST) {
+			if (!strcasecmp("dont_repeat", value)) {
+				info->style_exist = DONT_REPEAT;
+			} else if (!strcasecmp("overwrite", value)) {
+				info->style_exist = OVERWRITE;
+			} else if (!strcasecmp("repeat", value)) {
+				info->style_exist = REPEAT;
+			} else
+				warning(_("unknow value '%s' for key '%s'"), value, orig_key);
+		} else if (type == IF_MISSING) {
+			if (!strcasecmp("dont_append", value)) {
+				info->style_missing = DONT_APPEND;
+			} else if (!strcasecmp("append", value)) {
+				info->style_missing = APPEND;
+			} else
+				warning(_("unknow value '%s' for key '%s'"), value, orig_key);
+		} else {
+			if (info->command)
+				warning(_("more than one %s"), orig_key);
+			info->command = xstrdup(value);
+		}
+	}
+	return 0;
+}
+
+static size_t alnum_len(const char *buf, size_t len) {
+	while (--len >= 0 && !isalnum(buf[len]));
+	return len + 1;
+}
+
+static void apply_config(struct strbuf *tok, struct strbuf *val, struct trailer_info *info)
+{
+	if (info->value) {
+		strbuf_reset(tok);
+		strbuf_addstr(tok, info->value);
+	}
+	if (info->command) {
+	}
+}
+
+static void apply_config_list(struct strbuf *tok, struct strbuf *val)
+{
+	int j, tok_alnum_len = alnum_len(tok->buf, tok->len);
+
+	for (j = 0; j < trailer_list.nr; j++) {
+		struct string_list_item *item = trailer_list.items + j;
+		struct trailer_info *info = item->util;
+		if (!strncasecmp(tok->buf, item->string, tok_alnum_len) ||
+		    !strncasecmp(tok->buf, info->value, tok_alnum_len)) {
+			apply_config(tok, val, info);
+			break;
+		}
+	}
+}
+
+static struct strbuf **read_input_file(const char *infile)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (strbuf_read_file(&sb, infile, 0) < 0)
+		die_errno(_("could not read input file '%s'"), infile);
+
+	return strbuf_split(&sb, '\n');
+}
+
+/*
+ * Return the the (0 based) index of the first trailer line
+ * or the line count if there are no trailers.
+ */
+static int find_trailer_start(struct strbuf **lines)
+{
+	int count, start, empty = 1;
+
+	/* Get the line count */
+	for (count = 0; lines[count]; count++);
+
+	/*
+	 * Get the start of the trailers by looking starting from the end
+	 * for a line with only spaces before lines with one ':'.
+	 */
+	for (start = count - 1; start >= 0; start--) {
+		if (strbuf_isspace(lines[start])) {
+			if (empty)
+				continue;
+			return start + 1;
+		}
+		if (strchr(lines[start]->buf, ':')) {
+			if (empty)
+				empty = 0;
+			continue;
+		}
+		return count;
+	}
+
+	return empty ? count : start + 1;
+}
+
+static void print_tok_val(const char *tok_buf, size_t tok_len,
+			  const char *val_buf, size_t val_len)
+{
+	char c = tok_buf[tok_len - 1];
+	if (isalnum(c))
+		printf("%s: %s\n", tok_buf, val_buf);
+	else if (isspace(c) || c == '#')
+		printf("%s%s\n", tok_buf, val_buf);
+	else
+		printf("%s %s\n", tok_buf, val_buf);
+}
+
+static void process_input_file(const char *infile,
+			       struct string_list *tok_list,
+			       struct string_list *val_list)
+{
+	struct strbuf **lines = read_input_file(infile);
+	int start = find_trailer_start(lines);
+	int i;
+
+	/* Output non trailer lines as is */
+	for (i = 0; lines[i] && i < start; i++) {
+		printf("%s", lines[i]->buf);
+	}
+
+	/* Process trailer lines */
+	for (i = start; lines[i]; i++) {
+		struct strbuf tok = STRBUF_INIT;
+		struct strbuf val = STRBUF_INIT;
+		parse_arg(&tok, &val, lines[i]->buf);
+		string_list_append(tok_list, strbuf_detach(&tok, NULL));
+		string_list_append(val_list, strbuf_detach(&val, NULL));
+	}
+}
+
+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
+{
+	const char *infile = NULL;
+	int trim_empty = 0;
+	int i;
+	struct string_list tok_list = STRING_LIST_INIT_NODUP;
+	struct string_list val_list = STRING_LIST_INIT_NODUP;
+	char *applied_arg;
+
+	struct option options[] = {
+		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
+		OPT_FILENAME(0, "infile", &infile, N_("use message from file")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_interpret_trailers_usage, 0);
+
+	git_config(git_trailer_config, NULL);
+
+	/* Print the non trailer part of infile */
+	if (infile) {
+		process_input_file(infile, &tok_list, &val_list);
+		applied_arg = xcalloc(tok_list.nr, 1);
+	}
+
+	for (i = 0; i < argc; i++) {
+		struct strbuf tok = STRBUF_INIT;
+		struct strbuf val = STRBUF_INIT;
+		int j, seen = 0;
+
+		parse_arg(&tok, &val, argv[i]);
+
+		apply_config_list(&tok, &val);
+
+		/* Apply the trailer arguments to the trailers in infile */
+		for (j = 0; j < tok_list.nr; j++) {
+			struct string_list_item *tok_item = tok_list.items + j;
+			struct string_list_item *val_item = val_list.items + j;
+			int tok_alnum_len = alnum_len(tok.buf, tok.len);
+			if (!strncasecmp(tok.buf, tok_item->string, tok_alnum_len)) {
+				tok_item->string = xstrdup(tok.buf);
+				val_item->string = xstrdup(val.buf);
+				seen = 1;
+				applied_arg[j] = 1;
+				break;
+			}
+		}
+
+		/* Print the trailer arguments that are not in infile */
+		if (!seen && (!trim_empty || val.len > 0))
+			print_tok_val(tok.buf, tok.len, val.buf, val.len);
+
+		strbuf_release(&tok);
+		strbuf_release(&val);
+	}
+
+	/* Print the trailer part of infile */
+	for (i = 0; i < tok_list.nr; i++) {
+		struct strbuf tok = STRBUF_INIT;
+		struct strbuf val = STRBUF_INIT;
+		strbuf_addstr(&tok, tok_list.items[i].string);
+		strbuf_addstr(&val, val_list.items[i].string);
+
+		if (!applied_arg[i])
+			apply_config_list(&tok, &val);
+
+		if (!trim_empty || val.len > 0)
+			print_tok_val(tok.buf, tok.len, val.buf, val.len);
+	}
+
+	return 0;
+}
diff --git a/git.c b/git.c
index cb5208d..9f2eb77 100644
--- a/git.c
+++ b/git.c
@@ -383,6 +383,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
+		{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
 		{ "log", cmd_log, RUN_SETUP },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
diff --git a/strbuf.c b/strbuf.c
index 1170d01..f9080fa 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -106,6 +106,13 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+int strbuf_isspace(struct strbuf *sb)
+{
+	char *b;
+	for (b = sb->buf; *b && isspace(*b); b++);
+	return !*b;
+}
+
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 				 int terminator, int max)
 {
diff --git a/strbuf.h b/strbuf.h
index 73e80ce..02bff3a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -42,6 +42,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
+extern int strbuf_isspace(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 /*
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
new file mode 100755
index 0000000..5d2f967
--- /dev/null
+++ b/t/t7513-interpret-trailers.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Christian Couder
+#
+
+test_description='git interpret-trailers'
+
+. ./test-lib.sh
+
+cat >basic_message <<'EOF'
+subject
+
+body
+EOF
+
+cat >complex_message_body <<'EOF'
+my subject
+
+my body which is long
+and contains some special
+chars like : = ? !
+
+EOF
+
+# Do not remove trailing spaces below!
+cat >complex_message_trailers <<'EOF'
+Fixes: 
+Acked-by: 
+Reviewed-by: 
+Signed-off-by: 
+EOF
+
+test_expect_success 'without config' '
+	printf "ack: Peff\nReviewed-by: \nAcked-by: Johan\n" >expected &&
+	git interpret-trailers "ack = Peff" "Reviewed-by" "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--trim-empty without config' '
+	printf "ack: Peff\nAcked-by: Johan\n" >expected &&
+	git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup' '
+	git config trailer.ack.value "Acked-by: " &&
+	printf "Acked-by: Peff\n" >expected &&
+	git interpret-trailers --trim-empty "ack = Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by = Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by :Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup and = sign' '
+	git config trailer.ack.value "Acked-by= " &&
+	printf "Acked-by= Peff\n" >expected &&
+	git interpret-trailers --trim-empty "ack = Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by= Peff" >actual &&
+	test_cmp expected actual &&
+	git interpret-trailers --trim-empty "Acked-by : Peff" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with config setup and # sign' '
+	git config trailer.bug.value "Bug #" &&
+	printf "Bug #42\n" >expected &&
+	git interpret-trailers --trim-empty "bug = 42" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit basic message' '
+	git interpret-trailers --infile basic_message >actual &&
+	test_cmp basic_message actual
+'
+
+test_expect_success 'with commit complex message' '
+	cat complex_message_body complex_message_trailers >complex_message &&
+	cat complex_message_body >expected &&
+	printf "Fixes: \nAcked-by= \nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message and args' '
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers --infile complex_message "ack: Peff" "bug: 42" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with commit complex message, args and --trim-empty' '
+	cat complex_message_body >expected &&
+	printf "Bug #42\nAcked-by= Peff\n" >>expected &&
+	git interpret-trailers --trim-empty --infile complex_message "ack: Peff" "bug: 42" >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4.1.576.g36ba827.dirty
