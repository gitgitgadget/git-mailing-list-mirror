Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B413C1F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 18:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbdA2SGk (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 13:06:40 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:61784 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdA2SGi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 13:06:38 -0500
Received: from linux-7ekr.fritz.box ([92.225.234.74]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPA (Nemesis) id
 0LuMNz-1cNtIC1kDH-011jZo; Sun, 29 Jan 2017 19:06:35 +0100
From:   Cornelius Schumacher <schumacher@kde.org>
To:     git@vger.kernel.org
Cc:     josh@joshtriplett.org
Subject: [RFC] Proof of concept: Support multiple authors
Date:   Sun, 29 Jan 2017 19:06:34 +0100
Message-Id: <1485713194-11782-1-git-send-email-schumacher@kde.org>
X-Mailer: git-send-email 2.6.6
X-Provags-ID: V03:K0:p8VxjjsQCFSRdTyDKnvC+nAmuLlwRbqKYcEG3dHg5JzWjv/2TTV
 JAhxOpsa5EATHGIgP6e5yazFAF98SlzajKlzS3Udvp6lm+CX0broloIZ4EjMWzMhQx10q0S
 7g+HUFYPRq7m9Bygvd7GoPmuzYGmhQaZX2QuF+HDUp7NGXL72XuMOIxoUhQs3NwChqwU5ki
 gILyTH9YODKZX0niJ2y4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q6m5K6Kk2JA=:YO+OzrFgrrgSt74YrhcayA
 MunKKluNGxsqCM0aQWkHGzrtUNNWfYtlgoYp5xYX7goQttdNS/dRGla8SNlSXc/3hf4WLk7NU
 TL7nHshzGsWaiytIqFmvts7beBhJ53hJo9Z6WeZSmXwXi6Lfg1xB61dZRPTL3egz+/TtgJsIY
 QwwTaMijKBIHDuMt2DdOEk9D2TvVXsglDDqRSbPK6E9ZWr47hSeTmZo7G3JMbZ1lz6fVE6vkE
 gfIvM/OCzUotWatQfRxV55GRtTCQLhGycPuw9W/IL7vuWZxxcQab3JGTEB9stgmivFk2X0DP4
 RpQAT39ybTwWLdNmN7frZptgDsZmZlq2coEUcMSy0KiryQZJFvbPwDoAx/B32oPJYzunRzOrZ
 prUqKEtWygKqKRurdGQ76T9K2jHM2mvyUaovXUmQRxS5gtdeCPfL0TyQ0vbHJL1Hy07eb978d
 gyyULZkX3i00Xc3lzLdnkxLEcp0GVSnhPfj3CjvaZ4kxSXTTzxkEwdDNWibbwCf90H1b9cwXs
 2lZV+ZX/Epoeajbp5wnikomhUzM2euWEdap/SXn+wV/jzE2HVx8iMPxdKIY8u2BVFyT8yaIqc
 heGbBmqazBy2sinIhkKSWagPsbX8w0R8CPNuLZCvH8AQkcdE3Uw40jFFRj3ZweB4XouoYJKey
 PBeOYqkGOhblKFsUp+eoHJkgdtHa3JgH69pwmbt9chazUtboowIlI0RLBVP1hlvzI8n0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is a proof of concept implementation of support for
multiple authors. It adds an optional `authors` header to commits
which is set when there are authors configured in the git config.

A new command `git-authors` is used to manage the authors settings.
Authors are identified by initials and their names and emails are
set in a `.git_authors_map` file.

Signed-off-by: Cornelius Schumacher <schumacher@kde.org>
---

When doing pair programming we have to work around the limitation that
git can only have a single author in each commit. There are some tools
which help with that such as [git-duet] [1], but there are still some
limits, because the information about multiple authors is not reflected
in the native git data model.

Here is a proposal how to change that and implement native support for
multiple authors in git. It comes with a patch as a proof of concept.
The patch by no means is finished, it doesn't cover all cases and needs
more tests and error handling. It's meant as an illustration of the
concept.

The basic idea is to introduce a new optional `authors` header in
commits which contains a list of authors. The header is set in each new
commit when there is an entry `authors.current` in the git config listing
the current authors. When this config is not there the behavior falls
back to the current standard behavior.

When the header is there it is treated in the same way as the author
header. It's preserved on merges and similar operations, is displayed in
git show, and used to create a list of `From` addresses in `format-patch`.
Email supports multiple `From` addresses as specified in section 3.6.2 of
RFC 5322.

When multiple authors are configured, they still write the standard author
header to keep backwards compatibility. The first author is used as author
and committer. In the future it might be good to implement something like
automatic rotation of the order of authors to give credit in a fair way.

To make it easier to work with the authors there is a new command
`git-authors`. It sets the list of authors using initials as shortcut for
the full configuration with name and email. The mapping of initials to
names and email addresses is taken from a file `.git_authors_map` in the
home directory of the users. This way it's possible to quickly set a list
of authors by running a command such as `git authors ab cd`. This is
useful when doing pair programming because the people working together
usually switch quite frequently and using the command with the intials is
quicker and less error-prone than editing the configuration with full
names and emails.

The command also supports setting a single author, setting more than two
authors or clearing the configuration for multiple authors to go back to
the standard behavior without the new authors header.

The concept of the command and the mappings file is similar to what
git-duet does, so that it should be familiar to many people doing pair
programming. The behavior of git doesn't change when the new feature is
not used and when it's used it should be backwards compatible so that it
doesn't break existing functionality. This should make a smooth transition
for users who choose to make use of it.

Adding support for multiple authors would make the life of developers doing
pair programming easier. It would be useful in itself, but it would also
need support by other tools around git to use its full potential. This
might take a while, but I think it's worth the effort.

I'm willing to continue to work on this and create a patch which is suitable
for inclusion in git.

What do you think?

[1]: https://github.com/git-duet/git-duet

 .gitignore              |   1 +
 Makefile                |   3 +
 authors.c               | 205 ++++++++++++++++++++++++++++++++++++++++++++++++
 authors.h               |  29 +++++++
 builtin.h               |   1 +
 builtin/am.c            |  18 ++++-
 builtin/authors.c       |  82 +++++++++++++++++++
 builtin/commit-tree.c   |   2 +-
 builtin/commit.c        |  56 +++++++++++--
 builtin/merge.c         |   4 +-
 cache.h                 |   1 +
 commit.c                |  17 ++--
 commit.h                |   6 +-
 git.c                   |   1 +
 ident.c                 |   2 +-
 mailinfo.c              |  17 ++++
 mailinfo.h              |   2 +
 notes-cache.c           |   2 +-
 notes-utils.c           |   2 +-
 pretty.c                |  79 ++++++++++++++++++-
 t/helper/.gitignore     |   1 +
 t/helper/test-authors.c |  42 ++++++++++
 t/t9904-authors.sh      |  32 ++++++++
 23 files changed, 581 insertions(+), 24 deletions(-)
 create mode 100644 authors.c
 create mode 100644 authors.h
 create mode 100644 builtin/authors.c
 create mode 100644 t/helper/test-authors.c
 create mode 100755 t/t9904-authors.sh

diff --git a/.gitignore b/.gitignore
index 6722f78..1323907 100644
--- a/.gitignore
+++ b/.gitignore
@@ -16,6 +16,7 @@
 /git-apply
 /git-archimport
 /git-archive
+/git-authors
 /git-bisect
 /git-bisect--helper
 /git-blame
diff --git a/Makefile b/Makefile
index 27afd0f..22f4b28 100644
--- a/Makefile
+++ b/Makefile
@@ -597,6 +597,7 @@ X =

 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))

+TEST_PROGRAMS_NEED_X += test-authors
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
@@ -700,6 +701,7 @@ LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
+LIB_OBJS += authors.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blob.o
@@ -859,6 +861,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
+BUILTIN_OBJS += builtin/authors.o
 BUILTIN_OBJS += builtin/bisect--helper.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
diff --git a/authors.c b/authors.c
new file mode 100644
index 0000000..ba782a0
--- /dev/null
+++ b/authors.c
@@ -0,0 +1,205 @@
+#include "cache.h"
+#include "authors.h"
+#include "string.h"
+#include "strbuf.h"
+
+/*
+ * given an authors line, split the fields
+ * to allow the caller to parse it.
+ * Signal a success by returning 0.
+ */
+int split_authors_line(struct authors_split *split, const char *line, int len)
+{
+	const char *cp;
+
+	memset(split, 0, sizeof(*split));
+
+	split->begin = line;
+
+	for (cp = line + len - 1; *cp != '>'; cp--)
+		if (cp == line) return -1;
+
+	split->end = cp + 1;
+	return 0;
+}
+
+void read_authors_map_line(struct string_list *map, char *buffer)
+{
+	int len = strlen(buffer);
+
+	if (len && buffer[len - 1] == '\n')
+		buffer[--len] = 0;
+
+	string_list_insert(map, xstrdup(buffer));
+}
+
+void read_authors_map_file(struct string_list *map)
+{
+	char buffer[1024];
+	FILE *f;
+	const char *filename;
+	const char *home;
+
+	home = getenv("HOME");
+	if (!home)
+		die("HOME not set");
+
+	filename = mkpathdup("%s/.git_authors_map", home);
+
+	f = fopen(filename, "r");
+	if (!f) {
+		if (errno == ENOENT) {
+			warning("~/.git_authors_map does not exist");
+			return;
+		}
+		die_errno("unable to open authors map at %s", filename);
+	}
+
+	while (fgets(buffer, sizeof(buffer), f) != NULL)
+		read_authors_map_line(map, buffer);
+	fclose(f);
+}
+
+char *lookup_author(struct string_list *map, const char *author_abbr)
+{
+	struct string_list_item *author_item = NULL;
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, map) {
+		if (strncmp(item->string, author_abbr, strlen(author_abbr)) == 0 &&
+		    strlen(item->string) > strlen(author_abbr) &&
+		    *(item->string + strlen(author_abbr)) == ' ') {
+			author_item = item;
+			break;
+		}
+	}
+
+	if (!author_item)
+		return NULL;
+
+	return xstrdup(author_item->string + strlen(author_abbr) + 1);
+}
+
+const char *expand_authors(struct string_list *map, const char *author_shorts)
+{
+	int i;
+	const char *author_start = author_shorts;
+	const char *author_end;
+	char *author_short, *expanded_author;
+	static struct strbuf expanded_authors = STRBUF_INIT;
+
+	strbuf_reset(&expanded_authors);
+
+	for (i = 0; i <= strlen(author_shorts); i++) {
+		author_end = author_shorts + i;
+		if (*author_end == ' ' || *author_end == '\0') {
+			author_short = xstrndup(author_start, author_end - author_start);
+			expanded_author = lookup_author(map, author_short);
+			if (!expanded_author)
+				die("Could not expand author '%s'. Add it to the file ~/.git_authors_map.", author_short);
+			else {
+				if (expanded_authors.len > 0)
+					strbuf_addch(&expanded_authors, ',');
+				strbuf_addstr(&expanded_authors, expanded_author);
+				free(expanded_author);
+			}
+			free(author_short);
+
+			author_start = author_end + 1;
+		}
+	}
+
+	return expanded_authors.buf;
+}
+
+const char *git_authors_info(void)
+{
+	static struct strbuf authors_info = STRBUF_INIT;
+	const char *authors_config = NULL;
+	const char *date_str = NULL;
+	struct string_list authors_map = STRING_LIST_INIT_NODUP;
+
+	if (git_config_get_string_const("authors.current", &authors_config))
+		return NULL;
+
+	read_authors_map_file(&authors_map);
+
+	strbuf_reset(&authors_info);
+	strbuf_addstr(&authors_info, expand_authors(&authors_map, authors_config));
+
+	strbuf_addch(&authors_info, ' ');
+	date_str = getenv("GIT_AUTHOR_DATE");
+	if (date_str && date_str[0]) {
+		if (parse_date(date_str, &authors_info) < 0)
+			die("invalid date format: %s", date_str);
+	}
+	else
+		strbuf_addstr(&authors_info, ident_default_date());
+
+	return authors_info.buf;
+}
+
+const char *git_authors_first_info(const char *authors)
+{
+	static struct strbuf authors_first_info = STRBUF_INIT;
+	struct authors_split split;
+	const char *cp;
+
+	if (split_authors_line(&split, authors, strlen(authors)) < 0)
+		die("invalid authors format: %s", authors);
+
+	for (cp = split.begin; cp < split.end; cp++)
+		if (*cp == ',')
+			break;
+	strbuf_add(&authors_first_info, split.begin, cp - split.begin);
+	strbuf_add(&authors_first_info, split.end, strlen(authors));
+
+	return authors_first_info.buf;
+}
+
+const char *authors_split_to_email_froms(const struct authors_split *authors)
+{
+	static struct strbuf email_froms = STRBUF_INIT;
+	const char *cp;
+
+	strbuf_reset(&email_froms);
+
+	strbuf_addstr(&email_froms, "From: ");
+	for(cp = authors->begin; cp < authors->end; cp++)
+		if (*cp == ',')
+			strbuf_addstr(&email_froms, "\nFrom: ");
+		else
+			strbuf_addch(&email_froms, *cp);
+	strbuf_addch(&email_froms, '\n');
+
+	return email_froms.buf;
+}
+
+int has_multiple_authors(const char *authors)
+{
+	const char *cp = authors;
+
+	while (*cp != '\0')
+		if (*cp++ == ',')
+			return 1;
+	return 0;
+}
+
+const char *fmt_authors(const char *authors, const char *date_str)
+{
+	static struct strbuf authors_info = STRBUF_INIT;
+
+	strbuf_reset(&authors_info);
+
+	strbuf_addstr(&authors_info, authors);
+
+	strbuf_addch(&authors_info, ' ');
+	if (date_str && date_str[0]) {
+		if (parse_date(date_str, &authors_info) < 0)
+			die("invalid date format: %s", date_str);
+	}
+	else
+		strbuf_addstr(&authors_info, ident_default_date());
+
+	return authors_info.buf;
+}
diff --git a/authors.h b/authors.h
new file mode 100644
index 0000000..aa96674
--- /dev/null
+++ b/authors.h
@@ -0,0 +1,29 @@
+#ifndef AUTHORS_H
+#define AUTHORS_H
+
+#include "string-list.h"
+
+struct authors_split {
+	const char *begin;
+	const char *end;
+};
+/*
+ * Signals an success with 0
+ */
+extern int split_authors_line(struct authors_split *, const char *, int);
+
+extern const char *git_authors_info(void);
+extern const char *git_authors_first_info(const char *);
+
+extern void read_authors_map_file(struct string_list *);
+
+extern char *lookup_author(struct string_list *, const char *);
+extern const char *expand_authors(struct string_list *, const char *);
+
+extern const char *authors_split_to_email_froms(const struct authors_split *);
+
+extern int has_multiple_authors(const char *);
+
+extern const char *fmt_authors(const char *, const char *);
+
+#endif /* AUTHORS_H */
diff --git a/builtin.h b/builtin.h
index b9122bc..fec370e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -34,6 +34,7 @@ extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
+extern int cmd_authors(int argc, const char **argv, const char *prefix);
 extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/am.c b/builtin/am.c
index 31fb605..cc131d4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -30,6 +30,7 @@
 #include "mailinfo.h"
 #include "apply.h"
 #include "string-list.h"
+#include "authors.h"

 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -106,6 +107,7 @@ struct am_state {
 	char *author_name;
 	char *author_email;
 	char *author_date;
+	char *authors;
 	char *msg;
 	size_t msg_len;

@@ -171,6 +173,7 @@ static void am_state_release(struct am_state *state)
 	free(state->author_name);
 	free(state->author_email);
 	free(state->author_date);
+	free(state->authors);
 	free(state->msg);
 	argv_array_clear(&state->git_apply_opts);
 }
@@ -1237,6 +1240,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	struct strbuf author_name = STRBUF_INIT;
 	struct strbuf author_date = STRBUF_INIT;
 	struct strbuf author_email = STRBUF_INIT;
+	struct strbuf authors = STRBUF_INIT;
 	int ret = 0;
 	struct mailinfo mi;

@@ -1303,6 +1307,8 @@ static int parse_mail(struct am_state *state, const char *mail)
 			strbuf_addstr(&author_email, x);
 		else if (skip_prefix(sb.buf, "Date: ", &x))
 			strbuf_addstr(&author_date, x);
+		else if (skip_prefix(sb.buf, "Authors: ", &x))
+			strbuf_addstr(&authors, x);
 	}
 	fclose(fp);

@@ -1333,6 +1339,10 @@ static int parse_mail(struct am_state *state, const char *mail)
 	assert(!state->author_date);
 	state->author_date = strbuf_detach(&author_date, NULL);

+	assert(!state->authors);
+	if (authors.len > 0)
+		state->authors = strbuf_detach(&authors, NULL);
+
 	assert(!state->msg);
 	state->msg = strbuf_detach(&msg, &state->msg_len);

@@ -1341,6 +1351,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	strbuf_release(&author_date);
 	strbuf_release(&author_email);
 	strbuf_release(&author_name);
+	strbuf_release(&authors);
 	strbuf_release(&sb);
 	clear_mailinfo(&mi);
 	return ret;
@@ -1678,6 +1689,7 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
+	const char *authors_info = NULL;

 	if (run_hook_le(NULL, "pre-applypatch", NULL))
 		exit(1);
@@ -1701,8 +1713,12 @@ static void do_commit(const struct am_state *state)
 		setenv("GIT_COMMITTER_DATE",
 			state->ignore_date ? "" : state->author_date, 1);

+	if (state->authors)
+		authors_info = fmt_authors(state->authors,
+				state->ignore_date ? NULL : state->author_date);
+
 	if (commit_tree(state->msg, state->msg_len, tree.hash, parents, commit.hash,
-				author, state->sign_commit))
+				author, authors_info, state->sign_commit))
 		die(_("failed to write commit object"));

 	reflog_msg = getenv("GIT_REFLOG_ACTION");
diff --git a/builtin/authors.c b/builtin/authors.c
new file mode 100644
index 0000000..3342b91
--- /dev/null
+++ b/builtin/authors.c
@@ -0,0 +1,82 @@
+#include "builtin.h"
+#include "authors.h"
+#include "parse-options.h"
+
+static const char *const builtin_authors_usage[] = {
+	N_("git authors [<options>]"),
+	NULL
+};
+
+static int actions;
+
+#define ACTION_LIST (1<<0)
+#define ACTION_GET (1<<1)
+#define ACTION_SET (1<<2)
+#define ACTION_CLEAR (1<<3)
+
+static struct option builtin_authors_options[] = {
+	OPT_BIT('c', "clear", &actions, N_("clear current authors"), ACTION_CLEAR),
+	OPT_BIT('l', "list", &actions, N_("list all available authors"), ACTION_LIST)
+};
+
+static struct string_list authors_map = STRING_LIST_INIT_NODUP;
+
+int cmd_authors(int argc, const char **argv, const char *prefix)
+{
+	struct string_list_item *item;
+
+	argc = parse_options(argc, argv, prefix, builtin_authors_options,
+			     builtin_authors_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (actions == 0) {
+	if (argc == 0)
+		actions = ACTION_GET;
+	else
+	actions = ACTION_SET;
+	}
+
+	read_authors_map_file(&authors_map);
+
+	if (actions == ACTION_LIST)
+		for_each_string_list_item(item, &authors_map) {
+		printf("%s\n", item->string);
+	}
+	else if (actions == ACTION_GET) {
+		const char *authors_config = NULL;
+		const char *expanded_authors;
+
+		if (git_config_get_string_const("authors.current", &authors_config))
+			die("No current authors set. Use `git authors <initials> <initials> to set authors.");
+
+		printf("Short:    %s\n", authors_config);
+
+		expanded_authors = expand_authors(&authors_map, authors_config);
+
+		printf("Expanded: %s\n", expanded_authors);
+	}
+	else if (actions == ACTION_SET) {
+		int i;
+		static struct strbuf authors_info = STRBUF_INIT;
+		int lookup_error = 0;
+
+		for (i = 0; i < argc; ++i) {
+			if (!lookup_author(&authors_map, argv[i])) {
+				lookup_error--;
+				error("Couldn't find author '%s'", argv[i]);
+			}
+			if (i > 0)
+				strbuf_addch(&authors_info, ' ');
+				strbuf_addstr(&authors_info, argv[i]);
+		}
+		if (lookup_error < 0)
+			die("Add missing authors to ~/.git_authors_map");
+
+		git_config_set("authors.current", authors_info.buf);
+	}
+	else if (actions == ACTION_CLEAR) {
+		git_config_set("authors.current", NULL);
+	}
+
+	return 0;
+}
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 6050172..ecc2ce4 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -118,7 +118,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	}

 	if (commit_tree(buffer.buf, buffer.len, tree_oid.hash, parents,
-			commit_oid.hash, NULL, sign_commit)) {
+			commit_oid.hash, NULL, NULL, sign_commit)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 711f96c..88038ce 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -33,6 +33,7 @@
 #include "notes-utils.h"
 #include "mailmap.h"
 #include "sigchain.h"
+#include "authors.h"

 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -622,6 +623,29 @@ static void determine_author_info(struct strbuf *author_ident)
 	free(date);
 }

+static void determine_authors_info(struct strbuf *authors_info)
+{
+	const char *current_authors_info;
+
+	if (author_message) {
+		struct authors_split authors;
+		size_t len;
+		const char *a;
+
+		a = find_commit_header(author_message_buffer, "authors", &len);
+		if (a) {
+			if (split_authors_line(&authors, a, len) < 0)
+				die(_("commit '%s' has malformed authors line"), author_message);
+
+			strbuf_add(authors_info, a, len);
+		}
+	} else {
+		current_authors_info = git_authors_info();
+		if (current_authors_info)
+			strbuf_addstr(authors_info, current_authors_info);
+	}
+}
+
 static int author_date_is_interesting(void)
 {
 	return author_message || force_date;
@@ -660,7 +684,8 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
-			     struct strbuf *author_ident)
+			     struct strbuf *author_ident,
+			     struct strbuf *authors_info)
 {
 	struct stat statbuf;
 	struct strbuf committer_ident = STRBUF_INIT;
@@ -671,8 +696,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 	int old_display_comment_prefix;

-	/* This checks and barfs if author is badly specified */
-	determine_author_info(author_ident);
+	determine_authors_info(authors_info);
+	if (authors_info->len > 0) {
+		strbuf_addstr(author_ident, git_authors_first_info(authors_info->buf));
+		strbuf_addstr(&committer_ident, git_authors_first_info(authors_info->buf));
+	} else {
+		/* This checks and barfs if author is badly specified */
+		determine_author_info(author_ident);
+		strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
+	}

 	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
 		return 0;
@@ -800,11 +832,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	strbuf_release(&sb);

 	/* This checks if committer ident is explicitly given */
-	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
 	if (use_editor && include_status) {
 		int ident_shown = 0;
 		int saved_color_setting;
 		struct ident_split ci, ai;
+		struct authors_split authors_split;

 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == CLEANUP_SCISSORS)
@@ -854,6 +886,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		assert_split_ident(&ai, author_ident);
 		assert_split_ident(&ci, &committer_ident);

+		if (authors_info->len > 0) {
+			split_authors_line(&authors_split, authors_info->buf, authors_info->len);
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				_("%s"
+				"Authors:   %.*s"),
+				ident_shown++ ? "" : "\n",
+				(int)(authors_split.end - authors_split.begin), authors_split.begin);
+		}
 		if (ident_cmp(&ai, &ci))
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
@@ -1637,6 +1677,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)

 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf authors_info = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
@@ -1675,7 +1716,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
 	if (!prepare_to_commit(index_file, prefix,
-			       current_head, &s, &author_ident)) {
+			       current_head, &s, &author_ident, &authors_info)) {
 		rollback_index_files();
 		return 1;
 	}
@@ -1762,11 +1803,14 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}

 	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
-			 parents, sha1, author_ident.buf, sign_commit, extra)) {
+			 parents, sha1, author_ident.buf,
+			 authors_info.len > 0 ? authors_info.buf : NULL,
+			 sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
 	strbuf_release(&author_ident);
+	strbuf_release(&authors_info);
 	free_commit_extra_headers(extra);

 	nl = strchr(sb.buf, '\n');
diff --git a/builtin/merge.c b/builtin/merge.c
index a96d4fb..a23599c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -798,7 +798,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	pptr = commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
-			result_commit, NULL, sign_commit))
+			result_commit, NULL, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, result_commit, "In-index merge");
 	drop_save();
@@ -823,7 +823,7 @@ static int finish_automerge(struct commit *head,
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
-			result_commit, NULL, sign_commit))
+			result_commit, NULL, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, remoteheads, result_commit, buf.buf);
diff --git a/cache.h b/cache.h
index 40f7ddd..3cb4a84 100644
--- a/cache.h
+++ b/cache.h
@@ -1327,6 +1327,7 @@ extern const char *fmt_ident(const char *name, const char *email, const char *da
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
+extern const char *ident_default_date(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int git_ident_config(const char *, const char *, void *);
diff --git a/commit.c b/commit.c
index 2cf8515..40eb1c4 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,7 @@
 #include "commit-slab.h"
 #include "prio-queue.h"
 #include "sha1-lookup.h"
+#include "authors.h"

 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);

@@ -1312,7 +1313,8 @@ static inline int standard_header_field(const char *field, size_t len)
 		(len == 6 && !memcmp(field, "parent ", 7)) ||
 		(len == 6 && !memcmp(field, "author ", 7)) ||
 		(len == 9 && !memcmp(field, "committer ", 10)) ||
-		(len == 8 && !memcmp(field, "encoding ", 9)));
+		(len == 8 && !memcmp(field, "encoding ", 9)) ||
+		(len == 7 && !memcmp(field, "authors ", 8)));
 }

 static int excluded_header_field(const char *field, size_t len, const char **exclude)
@@ -1388,14 +1390,14 @@ void free_commit_extra_headers(struct commit_extra_header *extra)
 int commit_tree(const char *msg, size_t msg_len,
 		const unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
-		const char *author, const char *sign_commit)
+		const char *author, const char *authors, const char *sign_commit)
 {
 	struct commit_extra_header *extra = NULL, **tail = &extra;
 	int result;

 	append_merge_tag_headers(parents, &tail);
 	result = commit_tree_extended(msg, msg_len, tree, parents, ret,
-				      author, sign_commit, extra);
+				      author, authors, sign_commit, extra);
 	free_commit_extra_headers(extra);
 	return result;
 }
@@ -1518,7 +1520,8 @@ N_("Warning: commit message did not conform to UTF-8.\n"
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const unsigned char *tree,
 			 struct commit_list *parents, unsigned char *ret,
-			 const char *author, const char *sign_commit,
+			 const char *author, const char *authors,
+			 const char *sign_commit,
 			 struct commit_extra_header *extra)
 {
 	int result;
@@ -1549,11 +1552,13 @@ int commit_tree_extended(const char *msg, size_t msg_len,

 	/* Person/date information */
 	if (!author)
-		author = git_author_info(IDENT_STRICT);
+		author = authors ? git_authors_first_info(authors) : git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
-	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
+	strbuf_addf(&buffer, "committer %s\n", authors ? git_authors_first_info(authors) : git_committer_info(IDENT_STRICT));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+	if (authors)
+		strbuf_addf(&buffer, "authors %s\n", authors);

 	while (extra) {
 		add_extra_header(&buffer, extra);
diff --git a/commit.h b/commit.h
index 9c12abb..4880460 100644
--- a/commit.h
+++ b/commit.h
@@ -331,12 +331,14 @@ extern void append_merge_tag_headers(struct commit_list *parents,
 extern int commit_tree(const char *msg, size_t msg_len,
 		       const unsigned char *tree,
 		       struct commit_list *parents, unsigned char *ret,
-		       const char *author, const char *sign_commit);
+		       const char *author, const char *authors,
+		       const char *sign_commit);

 extern int commit_tree_extended(const char *msg, size_t msg_len,
 				const unsigned char *tree,
 				struct commit_list *parents, unsigned char *ret,
-				const char *author, const char *sign_commit,
+				const char *author, const char *authors,
+				const char *sign_commit,
 				struct commit_extra_header *);

 extern struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
diff --git a/git.c b/git.c
index b367cf6..b6fb852 100644
--- a/git.c
+++ b/git.c
@@ -397,6 +397,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
+	{ "authors", cmd_authors, RUN_SETUP },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP },
diff --git a/ident.c b/ident.c
index ac4ae02..b538abc 100644
--- a/ident.c
+++ b/ident.c
@@ -177,7 +177,7 @@ const char *ident_default_email(void)
 	return git_default_email.buf;
 }

-static const char *ident_default_date(void)
+const char *ident_default_date(void)
 {
 	if (!git_default_date.len)
 		datestamp(&git_default_date);
diff --git a/mailinfo.c b/mailinfo.c
index a489d9d..43c85de 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "utf8.h"
 #include "strbuf.h"
+#include "authors.h"
 #include "mailinfo.h"

 static void cleanup_space(struct strbuf *sb)
@@ -533,6 +534,18 @@ static int check_header(struct mailinfo *mi,
 {
 	int i, ret = 0, len;
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf from = STRBUF_INIT;
+
+	if (overwrite && cmp_header(line, "From")) {
+		len = strlen("From: ");
+		strbuf_add(&from, line->buf + len, line->len - len);
+		decode_header(mi, &from);
+
+		if (mi->authors.len > 0)
+			strbuf_addch(&mi->authors,',');
+		strbuf_addstr(&mi->authors, from.buf);
+	}
+	strbuf_release(&from);

 	/* search for the interesting parts */
 	for (i = 0; header[i]; i++) {
@@ -1068,6 +1081,8 @@ static void handle_info(struct mailinfo *mi)
 			fprintf(mi->output, "%s: %s\n", header[i], hdr->buf);
 		}
 	}
+	if (has_multiple_authors(mi->authors.buf))
+		fprintf(mi->output, "Authors: %s\n", mi->authors.buf);
 	fprintf(mi->output, "\n");
 }

@@ -1133,6 +1148,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->charset, 0);
 	strbuf_init(&mi->log_message, 0);
 	strbuf_init(&mi->inbody_header_accum, 0);
+	strbuf_init(&mi->authors, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
@@ -1147,6 +1163,7 @@ void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->email);
 	strbuf_release(&mi->charset);
 	strbuf_release(&mi->inbody_header_accum);
+	strbuf_release(&mi->authors);
 	free(mi->message_id);

 	for (i = 0; mi->p_hdr_data[i]; i++)
diff --git a/mailinfo.h b/mailinfo.h
index 04a2535..d264d0d 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -33,6 +33,8 @@ struct mailinfo {

 	struct strbuf log_message;
 	int input_error;
+
+	struct strbuf authors;
 };

 extern void setup_mailinfo(struct mailinfo *);
diff --git a/notes-cache.c b/notes-cache.c
index 5dfc5cb..2b58add 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -58,7 +58,7 @@ int notes_cache_write(struct notes_cache *c)
 	if (write_notes_tree(&c->tree, tree_sha1))
 		return -1;
 	if (commit_tree(c->validity, strlen(c->validity), tree_sha1, NULL,
-			commit_sha1, NULL, NULL) < 0)
+			commit_sha1, NULL, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.update_ref, commit_sha1,
 		       NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
diff --git a/notes-utils.c b/notes-utils.c
index 24a3361..8adf381 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -26,7 +26,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}

-	if (commit_tree(msg, msg_len, tree_sha1, parents, result_sha1, NULL, NULL))
+	if (commit_tree(msg, msg_len, tree_sha1, parents, result_sha1, NULL, NULL, NULL))
 		die("Failed to commit notes tree to database");
 }

diff --git a/pretty.c b/pretty.c
index 5e68383..d505f2a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -11,6 +11,7 @@
 #include "reflog-walk.h"
 #include "gpg-interface.h"
 #include "trailer.h"
+#include "authors.h"

 static char *user_format;
 static struct cmt_fmt_map {
@@ -510,6 +511,55 @@ void pp_user_info(struct pretty_print_context *pp,
 	}
 }

+void pp_authors_info(struct pretty_print_context *pp,
+		     struct strbuf *sb,
+		     const char *line, const char *encoding)
+{
+	struct ident_split ident;
+	char *line_end;
+	struct authors_split authors;
+
+	if (pp->fmt == CMIT_FMT_ONELINE)
+		return;
+
+	line_end = strchrnul(line, '\n');
+
+	if (split_authors_line(&authors, line, line_end - line))
+		return;
+
+	if (cmit_fmt_is_mail(pp->fmt)) {
+		strbuf_addstr(sb, authors_split_to_email_froms(&authors));
+	} else {
+		strbuf_addstr(sb, "Authors: ");
+		if (pp->fmt == CMIT_FMT_FULLER)
+			strbuf_addstr(sb, "    ");
+		strbuf_add(sb, authors.begin, authors.end - authors.begin);
+		strbuf_addch(sb, '\n');
+	}
+
+	/* Use the ident split for parsing the date part */
+	if (split_ident_line(&ident, line, line_end - line))
+		return;
+
+	switch (pp->fmt) {
+	case CMIT_FMT_MEDIUM:
+		strbuf_addf(sb, "Date:    %s\n",
+			    show_ident_date(&ident, &pp->date_mode));
+		break;
+	case CMIT_FMT_EMAIL:
+	case CMIT_FMT_MBOXRD:
+		strbuf_addf(sb, "Date: %s\n",
+			    show_ident_date(&ident, DATE_MODE(RFC2822)));
+		break;
+	case CMIT_FMT_FULLER:
+		strbuf_addf(sb, "AuthorsDate: %s\n",
+			    show_ident_date(&ident, &pp->date_mode));
+		break;
+	default:
+		break;
+	}
+}
+
 static int is_blank_line(const char *line, int *len_p)
 {
 	int len = *len_p;
@@ -1544,6 +1594,23 @@ static void pp_header(struct pretty_print_context *pp,
 		      struct strbuf *sb)
 {
 	int parents_shown = 0;
+	int has_authors = 0;
+	const char *msg = *msg_p;
+
+	/* Check if header has `authors` header */
+	for(;;) {
+		const char *line = msg;
+		int linelen = get_one_line(msg);
+		if (!linelen)
+			break;
+		msg += linelen;
+		if (linelen == 1)
+			break;
+		if (starts_with(line, "authors ")) {
+			has_authors = 1;
+			break;
+		}
+	}

 	for (;;) {
 		const char *name, *line = *msg_p;
@@ -1582,13 +1649,19 @@ static void pp_header(struct pretty_print_context *pp,
 		 * FULLER shows both authors and dates.
 		 */
 		if (skip_prefix(line, "author ", &name)) {
-			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Author", sb, name, encoding);
+			if (!has_authors) {
+				strbuf_grow(sb, linelen + 80);
+				pp_user_info(pp, "Author", sb, name, encoding);
+			}
 		}
 		if (skip_prefix(line, "committer ", &name) &&
 		    (pp->fmt == CMIT_FMT_FULL || pp->fmt == CMIT_FMT_FULLER)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Commit", sb, name, encoding);
+			pp_user_info(pp, has_authors ? "Commit " : "Commit", sb, name, encoding);
+		}
+		if (skip_prefix(line, "authors ", &name)) {
+			strbuf_grow(sb, linelen + 80);
+			pp_authors_info(pp, sb, name, encoding);
 		}
 	}
 }
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b36..9ad4bbc 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,3 +1,4 @@
+/test-authors
 /test-chmtime
 /test-ctype
 /test-config
diff --git a/t/helper/test-authors.c b/t/helper/test-authors.c
new file mode 100644
index 0000000..ab93f9f
--- /dev/null
+++ b/t/helper/test-authors.c
@@ -0,0 +1,42 @@
+#include "cache.h"
+#include "authors.h"
+
+static const char *usage_msg = "\n"
+"  test-authors split [authors_info]\n"
+"  test-authors has-multiple-authors [authors]\n";
+
+static void test_split_authors(const char **argv)
+{
+	struct authors_split split;
+	int result;
+	struct strbuf splitted = STRBUF_INIT;
+
+	printf("%s -> ",*argv);
+	result = split_authors_line(&split, *argv, strlen(*argv));
+	if (result)
+		printf("error");
+	else {
+		strbuf_add(&splitted, split.begin, split.end - split.begin);
+		printf(splitted.buf);
+	}
+	printf("\n");
+}
+
+static void test_has_multiple_authors(const char **argv)
+{
+	printf("%s -> %s\n", *argv, has_multiple_authors(*argv) ? "yes" : "no");
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	argv++;
+	if (argc != 3)
+		usage(usage_msg);
+	if (!strcmp(*argv, "split"))
+		test_split_authors(argv+1);
+	else if (!strcmp(*argv, "has-multiple"))
+		test_has_multiple_authors(argv+1);
+	else
+		usage(usage_msg);
+	return 0;
+}
diff --git a/t/t9904-authors.sh b/t/t9904-authors.sh
new file mode 100755
index 0000000..eb7fffa
--- /dev/null
+++ b/t/t9904-authors.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='test authors'
+
+. ./test-lib.sh
+
+check_split() {
+	echo "$1 -> $2" >expect
+	test_expect_success "split '$1'" "
+	test-authors split '$1' >actual &&
+	test_cmp expect actual
+	"
+}
+
+check_split 'xxx' 'error'
+check_split 'Some Guy <sg@example.com> 1484387401 +0100' 'Some Guy <sg@example.com>'
+check_split 'Some Guy <sg@example.com>,Another Pal <ap@example.com> 1484387401 +0100' 'Some Guy <sg@example.com>,Another Pal <ap@example.com>'
+check_split 'Some Guy <sg@example.com>,Another Pal <ap@example.com>' 'Some Guy <sg@example.com>,Another Pal <ap@example.com>'
+
+check_has_multiple() {
+	echo "$1 -> $2" >expect
+	test_expect_success "has multiple authors '$1'" "
+	test-authors has-multiple '$1' >actual &&
+	test_cmp expect actual
+	"
+}
+
+check_has_multiple 'abc' 'no'
+check_has_multiple 'Some Guy <sg@example.com>' 'no'
+check_has_multiple 'Some Guy <sg@example.com>,Another Pal <ap@example.com>' 'yes'
+
+test_done
--
2.6.6

