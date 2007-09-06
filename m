From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 9/9] Implement git commit as a builtin command.
Date: Wed,  5 Sep 2007 20:23:38 -0400
Message-ID: <11890382271931-git-send-email-krh@redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com>
 <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com>
 <11890382252522-git-send-email-krh@redhat.com>
 <1189038225525-git-send-email-krh@redhat.com>
 <11890382262161-git-send-email-krh@redhat.com>
 <11890382264046-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5Mb-0001tF-J5
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbXIFAgB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbXIFAgA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:36:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218AbXIFAfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:48 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zm0h005473
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:48 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZlGm032627;
	Wed, 5 Sep 2007 20:35:47 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zhbd016503;
	Wed, 5 Sep 2007 20:35:46 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
In-Reply-To: <11890382264046-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57790>

Move git-commit.sh to contrib/examples.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 Makefile                       |    9 +-
 builtin-commit.c               |  742 ++++++++++++++++++++++++++++++++=
++++++++
 builtin.h                      |    3 +-
 contrib/examples/git-commit.sh |  665 ++++++++++++++++++++++++++++++++=
+++
 git-commit.sh                  |  665 --------------------------------=
---
 git.c                          |    3 +-
 6 files changed, 1414 insertions(+), 673 deletions(-)
 create mode 100644 builtin-commit.c
 create mode 100755 contrib/examples/git-commit.sh
 delete mode 100755 git-commit.sh

diff --git a/Makefile b/Makefile
index 4eb4637..beb3cbb 100644
--- a/Makefile
+++ b/Makefile
@@ -201,7 +201,7 @@ BASIC_LDFLAGS =3D
=20
 SCRIPT_SH =3D \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clean.sh git-clone.sh \
 	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
@@ -250,7 +250,7 @@ EXTRA_PROGRAMS =3D
 BUILT_INS =3D \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X git-cherry-pick$X \
+	git-fsck-objects$X git-cherry-pick$X git-status$X\
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
=20
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -322,6 +322,7 @@ BUILTIN_OBJS =3D \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
@@ -357,7 +358,6 @@ BUILTIN_OBJS =3D \
 	builtin-rev-parse.o \
 	builtin-revert.o \
 	builtin-rm.o \
-	builtin-runstatus.o \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
@@ -797,9 +797,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	chmod +x $@+ && \
 	mv $@+ $@
=20
-git-status: git-commit
-	$(QUIET_GEN)cp $< $@+ && mv $@+ $@
-
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
diff --git a/builtin-commit.c b/builtin-commit.c
new file mode 100644
index 0000000..aca5ff8
--- /dev/null
+++ b/builtin-commit.c
@@ -0,0 +1,742 @@
+/*
+ * Builtin "git commit"
+ *
+ * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "cache.h"
+#include "cache-tree.h"
+#include "builtin.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "commit.h"
+#include "revision.h"
+#include "wt-status.h"
+#include "run-command.h"
+#include "refs.h"
+#include "log-tree.h"
+#include "strbuf.h"
+#include "utf8.h"
+
+void launch_editor(const char *path, struct strbuf *sb);
+int rerere(void);
+
+static const char builtin_commit_usage[] =3D
+	"[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <log=
file> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--te=
mplate <file>] [[-i | -o] <path>...]";
+
+static unsigned char head_sha1[20], merge_head_sha1[20];
+static char *use_message_buffer;
+static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
+static struct lock_file lock_file;
+
+enum option_type {
+    OPTION_NONE,
+    OPTION_STRING,
+    OPTION_INTEGER,
+    OPTION_LAST,
+};
+
+struct option {
+    enum option_type type;
+    const char *long_name;
+    char short_name;
+    void *value;
+};
+
+static int scan_options(const char ***argv, struct option *options)
+{
+	const char *value, *eq;
+	int i;
+
+	if (**argv =3D=3D NULL)
+		return 0;
+	if ((**argv)[0] !=3D '-')
+		return 0;
+	if (!strcmp(**argv, "--"))
+		return 0;
+
+	value =3D NULL;
+	for (i =3D 0; options[i].type !=3D OPTION_LAST; i++) {
+		if ((**argv)[1] =3D=3D '-') {
+			if (!prefixcmp(options[i].long_name, **argv + 2)) {
+				if (options[i].type !=3D OPTION_NONE)
+					value =3D *++(*argv);
+				goto match;
+			}
+
+			eq =3D strchr(**argv + 2, '=3D');
+			if (eq && options[i].type !=3D OPTION_NONE &&
+			    !strncmp(**argv + 2,=20
+				     options[i].long_name, eq - **argv - 2)) {
+				value =3D eq + 1;
+				goto match;
+			}
+		}
+
+		if ((**argv)[1] =3D=3D options[i].short_name) {
+			if ((**argv)[2] =3D=3D '\0') {
+				if (options[i].type !=3D OPTION_NONE)
+					value =3D *++(*argv);
+				goto match;
+			}
+
+			if (options[i].type !=3D OPTION_NONE) {
+				value =3D **argv + 2;
+				goto match;
+			}
+		}
+	}
+
+	usage(builtin_commit_usage);
+
+ match:
+	switch (options[i].type) {
+	case OPTION_NONE:
+		*(int *)options[i].value =3D 1;
+		break;
+	case OPTION_STRING:
+		if (value =3D=3D NULL)
+			die("option %s requires a value.", (*argv)[-1]);
+		*(const char **)options[i].value =3D value;
+		break;
+	case OPTION_INTEGER:
+		if (value =3D=3D NULL)
+			die("option %s requires a value.", (*argv)[-1]);
+		*(int *)options[i].value =3D atoi(value);
+		break;
+	default:
+		assert(0);
+	}
+
+	(*argv)++;
+
+	return 1;
+}
+
+static char *logfile, *force_author, *message, *template_file;
+static char *edit_message, *use_message;
+static int all, edit_flag, also, interactive, only, no_verify, amend, =
signoff;
+static int quiet, verbose, untracked_files;
+
+static int no_edit, initial_commit, in_merge;
+const char *only_include_assumed;
+
+static struct option commit_options[] =3D {
+	{ OPTION_STRING, "file", 'F', (void *) &logfile },
+	{ OPTION_NONE, "all", 'a', &all },
+	{ OPTION_STRING, "author", 0, (void *) &force_author },
+	{ OPTION_NONE, "edit", 'e', &edit_flag },
+	{ OPTION_NONE, "include", 'i', &also },
+	{ OPTION_NONE, "interactive", 0, &interactive },
+	{ OPTION_NONE, "only", 'o', &only },
+	{ OPTION_STRING, "message", 'm', &message },
+	{ OPTION_NONE, "no-verify", 'n', &no_verify },
+	{ OPTION_NONE, "amend", 0, &amend },
+	{ OPTION_STRING, "reedit-message", 'c', &edit_message },
+	{ OPTION_STRING, "reuse-message", 'C', &use_message },
+	{ OPTION_NONE, "signoff", 's', &signoff },
+	{ OPTION_NONE, "quiet", 'q', &quiet },
+	{ OPTION_NONE, "verbose", 'v', &verbose },
+	{ OPTION_NONE, "untracked-files", 0, &untracked_files },
+	{ OPTION_STRING, "template", 't', &template_file },
+	{ OPTION_LAST },
+};
+
+/* FIXME: Taken from builtin-add, should be shared. */
+
+static void update_callback(struct diff_queue_struct *q,
+			    struct diff_options *opt, void *cbdata)
+{
+	int i, verbose;
+
+	verbose =3D *((int *)cbdata);
+	for (i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+		const char *path =3D p->one->path;
+		switch (p->status) {
+		default:
+			die("unexpacted diff status %c", p->status);
+		case DIFF_STATUS_UNMERGED:
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_TYPE_CHANGED:
+			add_file_to_cache(path, verbose);
+			break;
+		case DIFF_STATUS_DELETED:
+			remove_file_from_cache(path);
+			cache_tree_invalidate_path(active_cache_tree, path);
+			if (verbose)
+				printf("remove '%s'\n", path);
+			break;
+		}
+	}
+}
+
+static void
+add_files_to_cache(int fd, const char **files, const char *prefix)
+{
+	struct rev_info rev;
+
+	init_revisions(&rev, "");
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.prune_data =3D get_pathspec(prefix, files);
+	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback =3D update_callback;
+	rev.diffopt.format_callback_data =3D &verbose;
+
+	run_diff_files(&rev, 0);
+	refresh_cache(REFRESH_QUIET);
+
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write new index file");
+}
+
+static char *
+prepare_index(const char **files, const char *prefix)
+{
+	int fd;
+	struct tree *tree;
+	struct lock_file *next_index_lock;
+
+	fd =3D hold_locked_index(&lock_file, 1);
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	if (all) {
+		add_files_to_cache(fd, files, NULL);
+		return lock_file.filename;
+	} else if (also) {
+		add_files_to_cache(fd, files, prefix);
+		return lock_file.filename;
+	}
+
+	if (interactive)
+		interactive_add();
+
+	if (*files =3D=3D NULL) {
+		/* Commit index as-is. */
+		rollback_lock_file(&lock_file);
+		return get_index_file();
+	}
+
+	/*
+	 * FIXME: Warn on unknown files.  Shell script does
+	 *
+	 *   commit_only=3D`git-ls-files --error-unmatch -- "$@"`
+	 */
+
+	/*
+	 * FIXME: shell script does
+	 *
+	 *   git-read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD
+	 *
+	 * which warns about unmerged files in the index.
+	 */
+
+	/* update the user index file */
+	add_files_to_cache(fd, files, prefix);
+
+	if (!initial_commit) {
+		tree =3D parse_tree_indirect(head_sha1);
+		if (!tree)
+			die("failed to unpack HEAD tree object");
+		if (read_tree(tree, 0, NULL))
+			die("failed to read HEAD tree object");
+	}
+
+	/* Uh oh, abusing lock_file to create a garbage collected file */
+	next_index_lock =3D xmalloc(sizeof(*next_index_lock));
+	fd =3D hold_lock_file_for_update(next_index_lock,
+				       git_path("next-index-%d", getpid()), 1);
+	add_files_to_cache(fd, files, prefix);
+
+	return next_index_lock->filename;
+}
+
+static int run_status(FILE *fp, const char *index_file)
+{
+	struct wt_status s;
+
+	wt_status_prepare(&s);
+
+	if (amend) {
+		s.amend =3D 1;
+		s.reference =3D "HEAD^1";
+	}
+	s.verbose =3D verbose;
+	s.untracked =3D untracked_files;
+	s.index_file =3D index_file;
+	s.fp =3D fp;
+
+	wt_status_print(&s);
+
+	return s.commitable;
+}
+
+static const char sign_off_header[] =3D "Signed-off-by: ";
+
+static int prepare_log_message(const char *index_file)
+{
+	struct stat statbuf;
+	int commitable;
+	struct strbuf sb;
+	char *buffer;
+	FILE *fp;
+
+	strbuf_init(&sb);
+	if (message) {
+		strbuf_add(&sb, message, strlen(message));
+	} else if (logfile && !strcmp(logfile, "-")) {
+		if (isatty(0))
+			fprintf(stderr, "(reading log message from standard input)\n");
+		if (strbuf_read_fd(&sb, 0) < 0)
+			die("could not read log from standard input");
+	} else if (logfile) {
+		if (strbuf_read_path(&sb, logfile) < 0)
+			die("could not read log file '%s': %s",
+			    logfile, strerror(errno));
+	} else if (use_message) {
+		buffer =3D strstr(use_message_buffer, "\n\n");
+		if (!buffer || buffer[2] =3D=3D '\0')
+			die("commit has empty message");
+		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
+	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
+		if (strbuf_read_path(&sb, git_path("MERGE_MSG")) < 0)
+			die("could not read MERGE_MSG: %s", strerror(errno));
+	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
+		if (strbuf_read_path(&sb, git_path("SQUASH_MSG")) < 0)
+			die("could not read SQUASH_MSG: %s", strerror(errno));
+	} else if (!stat(template_file, &statbuf)) {
+		if (strbuf_read_path(&sb, template_file) < 0)
+			die("could not read %s: %s",
+			    template_file, strerror(errno));
+	}
+
+	fp =3D fopen(git_path(commit_editmsg), "w");
+	if (fp =3D=3D NULL)
+		die("could not open %s\n", git_path(commit_editmsg));
+	=09
+	stripspace(&sb, 0);
+	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
+		die("could not write commit template: %s\n",
+		    strerror(errno));
+
+	if (signoff) {
+		const char *info, *bol;
+
+		info =3D git_committer_info(1);
+		strbuf_add_char(&sb, '\0');
+		bol =3D strrchr(sb.buf + sb.len - 1, '\n');
+		if (!bol || prefixcmp(bol, sign_off_header))
+			fprintf(fp, "\n");
+		fprintf(fp, "Signed-off-by: %s\n", git_committer_info(1));
+	}
+
+	strbuf_release(&sb);
+
+	if (in_merge && !no_edit) {
+		fprintf(fp,
+			"#\n"
+			"# It looks like you may be committing a MERGE.\n"
+			"# If this is not correct, please remove the file\n"
+			"#	%s\n"
+			"# and try again.\n"
+			"#\n",
+			git_path("MERGE_HEAD"));
+	}
+
+	fprintf(fp,
+		"\n"
+		"# Please enter the commit message for your changes.\n"
+		"# (Comment lines starting with '#' will not be included)\n");
+	if (only_include_assumed)
+		fprintf(fp, "# %s\n", only_include_assumed);
+
+	commitable =3D run_status(fp, index_file);
+
+	fclose(fp);
+
+	return commitable;
+}
+
+/* Find out if the message starting at position 'start' in the strbuf
+ * contains only whitespace and Signed-off-by lines. */
+static int message_is_empty(struct strbuf *sb, int start)
+{
+	static const char signed_off_by[] =3D "Signed-off-by: ";
+	struct strbuf tmpl;
+	const char *nl;
+	int eol, i;
+
+	/* See if the template is just a prefix of the message. */
+	strbuf_init(&tmpl);
+	if (template_file && strbuf_read_path(&tmpl, template_file) > 0) {
+		stripspace(&tmpl, 1);
+		if (start + tmpl.len <=3D sb->len &&
+		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) =3D=3D 0)
+			start +=3D tmpl.len;
+	}
+	strbuf_release(&tmpl);
+
+	/* Check if the rest is just whitespace and Signed-of-by's. */
+	for (i =3D start; i < sb->len; i++) {
+		nl =3D memchr(sb->buf + i, '\n', sb->len - i);
+		if (nl)
+			eol =3D nl - sb->buf;
+		else
+			eol =3D sb->len;
+
+		if (strlen(signed_off_by) <=3D eol - i &&
+		    !prefixcmp(sb->buf + i, signed_off_by)) {
+			i =3D eol;
+			continue;
+		}
+		while (i < eol)
+			if (!isspace(sb->buf[i++]))
+				return 0;
+	}
+
+	return 1;
+}
+
+static void determine_author_info(struct strbuf *sb)
+{
+	char *p, *eol;
+	char *name =3D NULL, *email =3D NULL;
+
+	if (use_message) {
+		p =3D strstr(use_message_buffer, "\nauthor");
+		if (!p)
+			die("invalid commit: %s\n", use_message);
+		p++;
+		eol =3D strchr(p, '\n');
+		if (!eol)
+			die("invalid commit: %s\n", use_message);
+
+		strbuf_add(sb, p, eol + 1 - p);
+	} else if (force_author) {
+		const char *eoname =3D strstr(force_author, " <");
+		const char *eomail =3D strchr(force_author, '>');
+
+		if (!eoname || !eomail)
+			die("malformed --author parameter\n");
+		name =3D xstrndup(force_author, eoname - force_author);
+		email =3D xstrndup(eoname + 2, eomail - eoname - 2);
+		strbuf_printf(sb, "author %s\n",
+			      fmt_ident(name, email,=20
+					getenv("GIT_AUTHOR_DATE"), 1));
+		free(name);
+		free(email);
+	} else {
+		strbuf_printf(sb, "author %s\n", git_author_info(1));
+	}
+}
+
+static void parse_and_validate_options(const char ***argv)
+{
+	int f =3D 0;
+
+	(*argv)++;
+	while (scan_options(argv, commit_options))
+		;
+
+	if (logfile || message || use_message)
+		no_edit =3D 1;
+	if (edit_flag)
+		no_edit =3D 0;
+
+	if (get_sha1("HEAD", head_sha1))
+		initial_commit =3D 1;
+
+	if (!get_sha1("MERGE_HEAD", merge_head_sha1))
+		in_merge =3D 1;
+
+	/* Sanity check options */
+	if (amend && initial_commit)
+		die("You have nothing to amend.");
+	if (amend && in_merge)
+		die("You are in the middle of a merger -- cannot amend.");
+
+	if (use_message)
+		f++;
+	if (edit_message)
+		f++;
+	if (logfile)
+		f++;
+	if (f > 1)
+		die("Only one of -c/-C/-F can be used.");
+	if (message && f > 0)
+		die("Option -m cannot be combined with -c/-C/-F.");
+	if (edit_message)
+		use_message =3D edit_message;
+	if (amend)
+		use_message =3D "HEAD";
+	if (use_message) {
+		unsigned char sha1[20];
+		static char utf8[] =3D "UTF-8";
+		char *enc, *end, *out_enc;
+		struct commit *commit;
+
+		if (get_sha1(use_message, sha1))
+			die("could not lookup commit %s", use_message);
+		commit =3D lookup_commit(sha1);
+		if (!commit || parse_commit(commit))
+			die("could not parse commit %s", use_message);
+
+		enc =3D strstr(commit->buffer, "\nencoding");
+		if (enc) {
+			end =3D strchr(enc + 10, '\n');
+			enc =3D xstrndup(enc + 10, end - (enc + 10));
+		} else {
+			enc =3D utf8;
+		}
+		out_enc =3D git_commit_encoding ? git_commit_encoding : utf8;
+
+		use_message_buffer =3D
+			reencode_string(commit->buffer, out_enc, enc);
+		if (enc !=3D utf8)
+			free(enc);
+	}
+
+	if (also && only)
+		die("Only one of --include/--only can be used.");
+	if (!*argv && (also || (only && !amend)))
+		die("No paths with --include/--only does not make sense.");
+	if (!*argv && only && amend)
+		only_include_assumed =3D "Clever... amending the last one with dirty=
 index.";
+	if (*argv && !also && !only) {
+		only_include_assumed =3D "Explicit paths specified without -i nor -o=
; assuming --only paths...";
+		also =3D 0;
+	}
+
+	if (all && interactive)
+		die("Cannot use -a, --interactive or -i at the same time.");
+	else if (all && **argv)
+		die("Paths with -a does not make sense.");
+	else if (interactive && **argv)
+		die("Paths with --interactive does not make sense.");
+}
+
+int cmd_status(int argc, const char **argv, const char *prefix)
+{
+	const char *index_file;
+	int commitable;
+
+	git_config(git_status_config);
+
+	parse_and_validate_options(&argv);
+
+	index_file =3D prepare_index(argv, prefix);
+
+	commitable =3D run_status(stdout, index_file);
+
+	rollback_lock_file(&lock_file);
+
+	return commitable ? 0 : 1;
+}
+
+static int run_hook(const char *index_file, const char *name, const ch=
ar *arg)
+{
+	struct child_process hook;
+	const char *argv[3], *env[2];
+	char index[PATH_MAX];
+
+	argv[0] =3D git_path("hooks/%s", name);
+	argv[1] =3D arg;
+	argv[2] =3D NULL;
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file);
+	env[0] =3D index;
+	env[1] =3D NULL;
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv =3D argv;
+	hook.no_stdin =3D 1;
+	hook.stdout_to_stderr =3D 1;
+	hook.env =3D env;
+
+	return run_command(&hook);
+}
+
+static void print_summary(const char *prefix, const unsigned char *sha=
1)
+{
+	struct rev_info rev;
+	struct commit *commit;
+
+	commit =3D lookup_commit(sha1);
+	if (!commit)
+		die("couldn't look up newly created commit\n");
+	if (!commit || parse_commit(commit))
+		die("could not parse newly created commit");
+
+	init_revisions(&rev, prefix);
+	setup_revisions(0, NULL, &rev, NULL);
+
+	rev.abbrev =3D 0;
+	rev.diff =3D 1;
+	rev.diffopt.output_format =3D
+		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
+
+	rev.verbose_header =3D 1;
+	rev.show_root_diff =3D 1;
+	rev.commit_format =3D get_commit_format("format:%h: %s");
+	rev.always_show_header =3D 1;
+	=09
+	printf("Created %scommit ", initial_commit ? "initial " : "");
+
+	log_tree_commit(&rev, commit);
+}
+
+int git_commit_config(const char *k, const char *v)
+{
+	if (!strcmp(k, "commit.template")) {
+		template_file =3D xstrdup(v);
+		return 0;
+	}
+
+	return git_status_config(k, v);
+}
+
+static const char commit_utf8_warn[] =3D
+"Warning: commit message does not conform to UTF-8.\n"
+"You may want to amend it after fixing the message, or set the config\=
n"
+"variable i18n.commitencoding to the encoding your project uses.\n";
+
+int cmd_commit(int argc, const char **argv, const char *prefix)
+{
+	int header_len, parent_count =3D 0;
+	struct strbuf sb;
+	const char *index_file, *reflog_msg;
+	char *nl, *header_line;
+	unsigned char commit_sha1[20];
+	struct ref_lock *ref_lock;
+
+	git_config(git_commit_config);
+
+	parse_and_validate_options(&argv);
+
+	index_file =3D prepare_index(argv, prefix);
+
+	if (run_hook(index_file, "pre-commit", NULL))
+		exit(1);
+
+	if (!prepare_log_message(index_file)) {
+		run_status(stdout, index_file);
+		unlink(commit_editmsg);
+		return 1;
+	}
+
+	strbuf_init(&sb);
+
+	/* Start building up the commit header */
+	read_cache_from(index_file);
+	active_cache_tree =3D cache_tree();
+	if (cache_tree_update(active_cache_tree,
+			      active_cache, active_nr, 0, 0) < 0)
+		die("Error building trees");
+	strbuf_printf(&sb, "tree %s\n",
+		      sha1_to_hex(active_cache_tree->sha1));
+
+	/* Determine parents */
+	if (initial_commit) {
+		reflog_msg =3D "commit (initial)";=20
+		parent_count =3D 0;
+	} else if (amend) {
+		struct commit_list *c;
+		struct commit *commit;
+
+		reflog_msg =3D "commit (amend)";
+		commit =3D lookup_commit(head_sha1);
+		if (!commit || parse_commit(commit))
+			die("could not parse HEAD commit");
+
+		for (c =3D commit->parents; c; c =3D c->next)
+			strbuf_printf(&sb, "parent %s\n",
+				      sha1_to_hex(c->item->object.sha1));
+	} else if (in_merge) {
+		struct strbuf m;
+		FILE *fp;
+
+		reflog_msg =3D "commit (merge)";
+		strbuf_printf(&sb, "parent %s\n", sha1_to_hex(head_sha1));
+		strbuf_init(&m);
+		fp =3D fopen(git_path("MERGE_HEAD"), "r");
+		if (fp =3D=3D NULL)
+			die("could not open %s for reading: %s",
+			    git_path("MERGE_HEAD"), strerror(errno));
+		while (!m.eof) {
+			read_line(&m, fp, '\n');
+			if (!m.eof)
+				strbuf_printf(&sb, "parent %s\n", m.buf);
+		}
+		fclose(fp);
+		strbuf_release(&m);
+	} else {
+		reflog_msg =3D "commit";
+		strbuf_printf(&sb, "parent %s\n", sha1_to_hex(head_sha1));
+	}
+
+	determine_author_info(&sb);
+	strbuf_printf(&sb, "committer %s\n", git_committer_info(1));
+	if (!is_encoding_utf8(git_commit_encoding))
+		strbuf_printf(&sb, "encoding %s\n", git_commit_encoding);
+	strbuf_add_char(&sb, '\n');
+
+	/* Get the commit message and validate it */
+	header_len =3D sb.len;
+	if (!no_edit) {
+		fprintf(stderr, "launching editor, log %s\n", logfile);
+		launch_editor(git_path(commit_editmsg), &sb);
+	}
+	else if (strbuf_read_path(&sb, git_path(commit_editmsg)) < 0)
+		die("could not read commit message\n");
+	if (run_hook(index_file, "commit-msg", commit_editmsg))
+		exit(1);
+	if (stripspace(&sb, 1) < header_len ||
+	    message_is_empty(&sb, header_len))
+		die("* no commit message?  aborting commit.");
+	strbuf_add_char(&sb, '\0');
+	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
+		fprintf(stderr, commit_utf8_warn);
+
+	if (write_sha1_file(sb.buf, sb.len - 1, commit_type, commit_sha1))
+		die("failed to write commit object");
+		      =20
+	ref_lock =3D lock_any_ref_for_update("HEAD",
+					   initial_commit ? NULL : head_sha1,
+					   0);
+
+	nl =3D strchr(sb.buf + header_len, '\n');
+	header_line =3D xstrndup(sb.buf + header_len,
+			       nl - (sb.buf + header_len));
+	strbuf_release(&sb);
+	strbuf_printf(&sb, "%s: %s\n", reflog_msg, header_line);
+	strbuf_add_char(&sb, '\0');
+	free(header_line);
+
+	if (!ref_lock)
+		die("cannot lock HEAD ref");
+	if (write_ref_sha1(ref_lock, commit_sha1, sb.buf) < 0)
+		die("cannot update HEAD ref");
+
+	unlink(git_path("MERGE_HEAD"));
+	unlink(git_path("MERGE_MSG"));
+
+	if (lock_file.filename[0] && commit_locked_index(&lock_file))
+		die("failed to write new index");
+
+	rerere();
+
+	run_hook(index_file, "post-commit", NULL);
+
+	if (!quiet)
+		print_summary(prefix, commit_sha1);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 91bc595..c23cd6d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -23,6 +23,7 @@ extern int cmd_check_attr(int argc, const char **argv=
, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const cha=
r *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_cherry_pick(int argc, const char **argv, const char *pr=
efix);
+extern int cmd_commit(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit_tree(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_count_objects(int argc, const char **argv, const char *=
prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefi=
x);
@@ -63,10 +64,10 @@ extern int cmd_rev_list(int argc, const char **argv=
, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *pref=
ix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
-extern int cmd_runstatus(int argc, const char **argv, const char *pref=
ix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *pr=
efix);
+extern int cmd_status(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_stripspace(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *p=
refix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-comm=
it.sh
new file mode 100755
index 0000000..d7e7028
--- /dev/null
+++ b/contrib/examples/git-commit.sh
@@ -0,0 +1,665 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+# Copyright (c) 2006 Junio C Hamano
+
+USAGE=3D'[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | =
-F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>=
] [--template <file>] [[-i | -o] <path>...]'
+SUBDIRECTORY_OK=3DYes
+. git-sh-setup
+require_work_tree
+
+git rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=3Dt
+
+case "$0" in
+*status)
+	status_only=3Dt
+	;;
+*commit)
+	status_only=3D
+	;;
+esac
+
+refuse_partial () {
+	echo >&2 "$1"
+	echo >&2 "You might have meant to say 'git commit -i paths...', perha=
ps?"
+	exit 1
+}
+
+THIS_INDEX=3D"$GIT_DIR/index"
+NEXT_INDEX=3D"$GIT_DIR/next-index$$"
+rm -f "$NEXT_INDEX"
+save_index () {
+	cp -p "$THIS_INDEX" "$NEXT_INDEX"
+}
+
+run_status () {
+	# If TMP_INDEX is defined, that means we are doing
+	# "--only" partial commit, and that index file is used
+	# to build the tree for the commit.  Otherwise, if
+	# NEXT_INDEX exists, that is the index file used to
+	# make the commit.  Otherwise we are using as-is commit
+	# so the regular index file is what we use to compare.
+	if test '' !=3D "$TMP_INDEX"
+	then
+		GIT_INDEX_FILE=3D"$TMP_INDEX"
+		export GIT_INDEX_FILE
+	elif test -f "$NEXT_INDEX"
+	then
+		GIT_INDEX_FILE=3D"$NEXT_INDEX"
+		export GIT_INDEX_FILE
+	fi
+
+	case "$status_only" in
+	t) color=3D ;;
+	*) color=3D--nocolor ;;
+	esac
+	git runstatus ${color} \
+		${verbose:+--verbose} \
+		${amend:+--amend} \
+		${untracked_files:+--untracked}
+}
+
+trap '
+	test -z "$TMP_INDEX" || {
+		test -f "$TMP_INDEX" && rm -f "$TMP_INDEX"
+	}
+	rm -f "$NEXT_INDEX"
+' 0
+
+################################################################
+# Command line argument parsing and sanity checking
+
+all=3D
+also=3D
+interactive=3D
+only=3D
+logfile=3D
+use_commit=3D
+amend=3D
+edit_flag=3D
+no_edit=3D
+log_given=3D
+log_message=3D
+verify=3Dt
+quiet=3D
+verbose=3D
+signoff=3D
+force_author=3D
+only_include_assumed=3D
+untracked_files=3D
+templatefile=3D"`git config commit.template`"
+while case "$#" in 0) break;; esac
+do
+	case "$1" in
+	-F|--F|-f|--f|--fi|--fil|--file)
+		case "$#" in 1) usage ;; esac
+		shift
+		no_edit=3Dt
+		log_given=3Dt$log_given
+		logfile=3D"$1"
+		shift
+		;;
+	-F*|-f*)
+		no_edit=3Dt
+		log_given=3Dt$log_given
+		logfile=3D`expr "z$1" : 'z-[Ff]\(.*\)'`
+		shift
+		;;
+	--F=3D*|--f=3D*|--fi=3D*|--fil=3D*|--file=3D*)
+		no_edit=3Dt
+		log_given=3Dt$log_given
+		logfile=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
+		shift
+		;;
+	-a|--a|--al|--all)
+		all=3Dt
+		shift
+		;;
+	--au=3D*|--aut=3D*|--auth=3D*|--autho=3D*|--author=3D*)
+		force_author=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
+		shift
+		;;
+	--au|--aut|--auth|--autho|--author)
+		case "$#" in 1) usage ;; esac
+		shift
+		force_author=3D"$1"
+		shift
+		;;
+	-e|--e|--ed|--edi|--edit)
+		edit_flag=3Dt
+		shift
+		;;
+	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
+		also=3Dt
+		shift
+		;;
+	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
+	--interactiv|--interactive)
+		interactive=3Dt
+		shift
+		;;
+	-o|--o|--on|--onl|--only)
+		only=3Dt
+		shift
+		;;
+	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dm$log_given
+		if test "$log_message" =3D ''
+		then
+		    log_message=3D"$1"
+		else
+		    log_message=3D"$log_message
+
+$1"
+		fi
+		no_edit=3Dt
+		shift
+		;;
+	-m*)
+		log_given=3Dm$log_given
+		if test "$log_message" =3D ''
+		then
+		    log_message=3D`expr "z$1" : 'z-m\(.*\)'`
+		else
+		    log_message=3D"$log_message
+
+`expr "z$1" : 'z-m\(.*\)'`"
+		fi
+		no_edit=3Dt
+		shift
+		;;
+	--m=3D*|--me=3D*|--mes=3D*|--mess=3D*|--messa=3D*|--messag=3D*|--mess=
age=3D*)
+		log_given=3Dm$log_given
+		if test "$log_message" =3D ''
+		then
+		    log_message=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
+		else
+		    log_message=3D"$log_message
+
+`expr "z$1" : 'zq-[^=3D]*=3D\(.*\)'`"
+		fi
+		no_edit=3Dt
+		shift
+		;;
+	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
+	--no-verify)
+		verify=3D
+		shift
+		;;
+	--a|--am|--ame|--amen|--amend)
+		amend=3Dt
+		use_commit=3DHEAD
+		shift
+		;;
+	-c)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3D
+		shift
+		;;
+	--ree=3D*|--reed=3D*|--reedi=3D*|--reedit=3D*|--reedit-=3D*|--reedit-=
m=3D*|\
+	--reedit-me=3D*|--reedit-mes=3D*|--reedit-mess=3D*|--reedit-messa=3D*=
|\
+	--reedit-messag=3D*|--reedit-message=3D*)
+		log_given=3Dt$log_given
+		use_commit=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
+		no_edit=3D
+		shift
+		;;
+	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
+	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
+	--reedit-message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3D
+		shift
+		;;
+	-C)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3Dt
+		shift
+		;;
+	--reu=3D*|--reus=3D*|--reuse=3D*|--reuse-=3D*|--reuse-m=3D*|--reuse-m=
e=3D*|\
+	--reuse-mes=3D*|--reuse-mess=3D*|--reuse-messa=3D*|--reuse-messag=3D*=
|\
+	--reuse-message=3D*)
+		log_given=3Dt$log_given
+		use_commit=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
+		no_edit=3Dt
+		shift
+		;;
+	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
+	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3Dt
+		shift
+		;;
+	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
+		signoff=3Dt
+		shift
+		;;
+	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
+		case "$#" in 1) usage ;; esac
+		shift
+		templatefile=3D"$1"
+		no_edit=3D
+		shift
+		;;
+	-q|--q|--qu|--qui|--quie|--quiet)
+		quiet=3Dt
+		shift
+		;;
+	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
+		verbose=3Dt
+		shift
+		;;
+	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
+	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil=
|\
+	--untracked-file|--untracked-files)
+		untracked_files=3Dt
+		shift
+		;;
+	--)
+		shift
+		break
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+done
+case "$edit_flag" in t) no_edit=3D ;; esac
+
+################################################################
+# Sanity check options
+
+case "$amend,$initial_commit" in
+t,t)
+	die "You do not have anything to amend." ;;
+t,)
+	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
+		die "You are in the middle of a merge -- cannot amend."
+	fi ;;
+esac
+
+case "$log_given" in
+tt*)
+	die "Only one of -c/-C/-F can be used." ;;
+*tm*|*mt*)
+	die "Option -m cannot be combined with -c/-C/-F." ;;
+esac
+
+case "$#,$also,$only,$amend" in
+*,t,t,*)
+	die "Only one of --include/--only can be used." ;;
+0,t,,* | 0,,t,)
+	die "No paths with --include/--only does not make sense." ;;
+0,,t,t)
+	only_include_assumed=3D"# Clever... amending the last one with dirty =
index." ;;
+0,,,*)
+	;;
+*,,,*)
+	only_include_assumed=3D"# Explicit paths specified without -i nor -o;=
 assuming --only paths..."
+	also=3D
+	;;
+esac
+unset only
+case "$all,$interactive,$also,$#" in
+*t,*t,*)
+	die "Cannot use -a, --interactive or -i at the same time." ;;
+t,,[1-9]*)
+	die "Paths with -a does not make sense." ;;
+,t,[1-9]*)
+	die "Paths with --interactive does not make sense." ;;
+,,t,0)
+	die "No paths with -i does not make sense." ;;
+esac
+
+if test ! -z "$templatefile" -a -z "$log_given"
+then
+	if test ! -f "$templatefile"
+	then
+		die "Commit template file does not exist."
+	fi
+fi
+
+################################################################
+# Prepare index to have a tree to be committed
+
+case "$all,$also" in
+t,)
+	if test ! -f "$THIS_INDEX"
+	then
+		die 'nothing to commit (use "git add file1 file2" to include for com=
mit)'
+	fi
+	save_index &&
+	(
+		cd_to_toplevel &&
+		GIT_INDEX_FILE=3D"$NEXT_INDEX" &&
+		export GIT_INDEX_FILE &&
+		git diff-files --name-only -z |
+		git update-index --remove -z --stdin
+	) || exit
+	;;
+,t)
+	save_index &&
+	git ls-files --error-unmatch -- "$@" >/dev/null || exit
+
+	git diff-files --name-only -z -- "$@"  |
+	(
+		cd_to_toplevel &&
+		GIT_INDEX_FILE=3D"$NEXT_INDEX" &&
+		export GIT_INDEX_FILE &&
+		git update-index --remove -z --stdin
+	) || exit
+	;;
+,)
+	if test "$interactive" =3D t; then
+		git add --interactive || exit
+	fi
+	case "$#" in
+	0)
+		;; # commit as-is
+	*)
+		if test -f "$GIT_DIR/MERGE_HEAD"
+		then
+			refuse_partial "Cannot do a partial commit during a merge."
+		fi
+		TMP_INDEX=3D"$GIT_DIR/tmp-index$$"
+		commit_only=3D`git ls-files --error-unmatch -- "$@"` || exit
+
+		# Build a temporary index and update the real index
+		# the same way.
+		if test -z "$initial_commit"
+		then
+			GIT_INDEX_FILE=3D"$THIS_INDEX" \
+			git read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD
+		else
+			rm -f "$TMP_INDEX"
+		fi || exit
+
+		printf '%s\n' "$commit_only" |
+		GIT_INDEX_FILE=3D"$TMP_INDEX" \
+		git update-index --add --remove --stdin &&
+
+		save_index &&
+		printf '%s\n' "$commit_only" |
+		(
+			GIT_INDEX_FILE=3D"$NEXT_INDEX"
+			export GIT_INDEX_FILE
+			git update-index --remove --stdin
+		) || exit
+		;;
+	esac
+	;;
+esac
+
+################################################################
+# If we do as-is commit, the index file will be THIS_INDEX,
+# otherwise NEXT_INDEX after we make this commit.  We leave
+# the index as is if we abort.
+
+if test -f "$NEXT_INDEX"
+then
+	USE_INDEX=3D"$NEXT_INDEX"
+else
+	USE_INDEX=3D"$THIS_INDEX"
+fi
+
+case "$status_only" in
+t)
+	# This will silently fail in a read-only repository, which is
+	# what we want.
+	GIT_INDEX_FILE=3D"$USE_INDEX" git update-index -q --unmerged --refres=
h
+	run_status
+	exit $?
+	;;
+'')
+	GIT_INDEX_FILE=3D"$USE_INDEX" git update-index -q --refresh || exit
+	;;
+esac
+
+################################################################
+# Grab commit message, write out tree and make commit.
+
+if test t =3D "$verify" && test -x "$GIT_DIR"/hooks/pre-commit
+then
+	if test "$TMP_INDEX"
+	then
+		GIT_INDEX_FILE=3D"$TMP_INDEX" "$GIT_DIR"/hooks/pre-commit
+	else
+		GIT_INDEX_FILE=3D"$USE_INDEX" "$GIT_DIR"/hooks/pre-commit
+	fi || exit
+fi
+
+if test "$log_message" !=3D ''
+then
+	printf '%s\n' "$log_message"
+elif test "$logfile" !=3D ""
+then
+	if test "$logfile" =3D -
+	then
+		test -t 0 &&
+		echo >&2 "(reading log message from standard input)"
+		cat
+	else
+		cat <"$logfile"
+	fi
+elif test "$use_commit" !=3D ""
+then
+	encoding=3D$(git config i18n.commitencoding || echo UTF-8)
+	git show -s --pretty=3Draw --encoding=3D"$encoding" "$use_commit" |
+	sed -e '1,/^$/d' -e 's/^    //'
+elif test -f "$GIT_DIR/MERGE_MSG"
+then
+	cat "$GIT_DIR/MERGE_MSG"
+elif test -f "$GIT_DIR/SQUASH_MSG"
+then
+	cat "$GIT_DIR/SQUASH_MSG"
+elif test "$templatefile" !=3D ""
+then
+	cat "$templatefile"
+fi | git stripspace >"$GIT_DIR"/COMMIT_EDITMSG
+
+case "$signoff" in
+t)
+	sign=3D$(git-var GIT_COMMITTER_IDENT | sed -e '
+		s/>.*/>/
+		s/^/Signed-off-by: /
+		')
+	blank_before_signoff=3D
+	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
+	grep 'Signed-off-by:' >/dev/null || blank_before_signoff=3D'
+'
+	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
+	grep "$sign"$ >/dev/null ||
+	printf '%s%s\n' "$blank_before_signoff" "$sign" \
+		>>"$GIT_DIR"/COMMIT_EDITMSG
+	;;
+esac
+
+if test -f "$GIT_DIR/MERGE_HEAD" && test -z "$no_edit"; then
+	echo "#"
+	echo "# It looks like you may be committing a MERGE."
+	echo "# If this is not correct, please remove the file"
+	printf '%s\n' "#	$GIT_DIR/MERGE_HEAD"
+	echo "# and try again"
+	echo "#"
+fi >>"$GIT_DIR"/COMMIT_EDITMSG
+
+# Author
+if test '' !=3D "$use_commit"
+then
+	eval "$(get_author_ident_from_commit "$use_commit")"
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+fi
+if test '' !=3D "$force_author"
+then
+	GIT_AUTHOR_NAME=3D`expr "z$force_author" : 'z\(.*[^ ]\) *<.*'` &&
+	GIT_AUTHOR_EMAIL=3D`expr "z$force_author" : '.*\(<.*\)'` &&
+	test '' !=3D "$GIT_AUTHOR_NAME" &&
+	test '' !=3D "$GIT_AUTHOR_EMAIL" ||
+	die "malformed --author parameter"
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+fi
+
+PARENTS=3D"-p HEAD"
+if test -z "$initial_commit"
+then
+	rloga=3D'commit'
+	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
+		rloga=3D'commit (merge)'
+		PARENTS=3D"-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
+	elif test -n "$amend"; then
+		rloga=3D'commit (amend)'
+		PARENTS=3D$(git cat-file commit HEAD |
+			sed -n -e '/^$/q' -e 's/^parent /-p /p')
+	fi
+	current=3D"$(git rev-parse --verify HEAD)"
+else
+	if [ -z "$(git ls-files)" ]; then
+		echo >&2 'nothing to commit (use "git add file1 file2" to include fo=
r commit)'
+		exit 1
+	fi
+	PARENTS=3D""
+	rloga=3D'commit (initial)'
+	current=3D''
+fi
+set_reflog_action "$rloga"
+
+if test -z "$no_edit"
+then
+	{
+		echo ""
+		echo "# Please enter the commit message for your changes."
+		echo "# (Comment lines starting with '#' will not be included)"
+		test -z "$only_include_assumed" || echo "$only_include_assumed"
+		run_status
+	} >>"$GIT_DIR"/COMMIT_EDITMSG
+else
+	# we need to check if there is anything to commit
+	run_status >/dev/null
+fi
+if [ "$?" !=3D "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
+then
+	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
+	run_status
+	exit 1
+fi
+
+case "$no_edit" in
+'')
+	git-var GIT_AUTHOR_IDENT > /dev/null  || die
+	git-var GIT_COMMITTER_IDENT > /dev/null  || die
+	git_editor "$GIT_DIR/COMMIT_EDITMSG"
+	;;
+esac
+
+case "$verify" in
+t)
+	if test -x "$GIT_DIR"/hooks/commit-msg
+	then
+		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || exit
+	fi
+esac
+
+if test -z "$no_edit"
+then
+    sed -e '
+        /^diff --git a\/.*/{
+	    s///
+	    q
+	}
+	/^#/d
+    ' "$GIT_DIR"/COMMIT_EDITMSG
+else
+    cat "$GIT_DIR"/COMMIT_EDITMSG
+fi |
+git stripspace >"$GIT_DIR"/COMMIT_MSG
+
+# Test whether the commit message has any content we didn't supply.
+have_commitmsg=3D
+grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
+	git stripspace > "$GIT_DIR"/COMMIT_BAREMSG
+
+# Is the commit message totally empty?
+if test -s "$GIT_DIR"/COMMIT_BAREMSG
+then
+	if test "$templatefile" !=3D ""
+	then
+		# Test whether this is just the unaltered template.
+		if cnt=3D`sed -e '/^#/d' < "$templatefile" |
+			git stripspace |
+			diff "$GIT_DIR"/COMMIT_BAREMSG - |
+			wc -l` &&
+		   test 0 -lt $cnt
+		then
+			have_commitmsg=3Dt
+		fi
+	else
+		# No template, so the content in the commit message must
+		# have come from the user.
+		have_commitmsg=3Dt
+	fi
+fi
+
+rm -f "$GIT_DIR"/COMMIT_BAREMSG
+
+if test "$have_commitmsg" =3D "t"
+then
+	if test -z "$TMP_INDEX"
+	then
+		tree=3D$(GIT_INDEX_FILE=3D"$USE_INDEX" git write-tree)
+	else
+		tree=3D$(GIT_INDEX_FILE=3D"$TMP_INDEX" git write-tree) &&
+		rm -f "$TMP_INDEX"
+	fi &&
+	commit=3D$(git commit-tree $tree $PARENTS <"$GIT_DIR/COMMIT_MSG") &&
+	rlogm=3D$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
+	git update-ref -m "$GIT_REFLOG_ACTION: $rlogm" HEAD $commit "$current=
" &&
+	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" &&
+	if test -f "$NEXT_INDEX"
+	then
+		mv "$NEXT_INDEX" "$THIS_INDEX"
+	else
+		: ;# happy
+	fi
+else
+	echo >&2 "* no commit message?  aborting commit."
+	false
+fi
+ret=3D"$?"
+rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH=
_MSG"
+
+cd_to_toplevel
+
+git rerere
+
+if test "$ret" =3D 0
+then
+	if test -x "$GIT_DIR"/hooks/post-commit
+	then
+		"$GIT_DIR"/hooks/post-commit
+	fi
+	if test -z "$quiet"
+	then
+		commit=3D`git diff-tree --always --shortstat --pretty=3D"format:%h: =
%s"\
+		       --summary --root HEAD --`
+		echo "Created${initial_commit:+ initial} commit $commit"
+	fi
+fi
+
+exit "$ret"
diff --git a/git-commit.sh b/git-commit.sh
deleted file mode 100755
index d7e7028..0000000
--- a/git-commit.sh
+++ /dev/null
@@ -1,665 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-# Copyright (c) 2006 Junio C Hamano
-
-USAGE=3D'[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | =
-F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>=
] [--template <file>] [[-i | -o] <path>...]'
-SUBDIRECTORY_OK=3DYes
-. git-sh-setup
-require_work_tree
-
-git rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=3Dt
-
-case "$0" in
-*status)
-	status_only=3Dt
-	;;
-*commit)
-	status_only=3D
-	;;
-esac
-
-refuse_partial () {
-	echo >&2 "$1"
-	echo >&2 "You might have meant to say 'git commit -i paths...', perha=
ps?"
-	exit 1
-}
-
-THIS_INDEX=3D"$GIT_DIR/index"
-NEXT_INDEX=3D"$GIT_DIR/next-index$$"
-rm -f "$NEXT_INDEX"
-save_index () {
-	cp -p "$THIS_INDEX" "$NEXT_INDEX"
-}
-
-run_status () {
-	# If TMP_INDEX is defined, that means we are doing
-	# "--only" partial commit, and that index file is used
-	# to build the tree for the commit.  Otherwise, if
-	# NEXT_INDEX exists, that is the index file used to
-	# make the commit.  Otherwise we are using as-is commit
-	# so the regular index file is what we use to compare.
-	if test '' !=3D "$TMP_INDEX"
-	then
-		GIT_INDEX_FILE=3D"$TMP_INDEX"
-		export GIT_INDEX_FILE
-	elif test -f "$NEXT_INDEX"
-	then
-		GIT_INDEX_FILE=3D"$NEXT_INDEX"
-		export GIT_INDEX_FILE
-	fi
-
-	case "$status_only" in
-	t) color=3D ;;
-	*) color=3D--nocolor ;;
-	esac
-	git runstatus ${color} \
-		${verbose:+--verbose} \
-		${amend:+--amend} \
-		${untracked_files:+--untracked}
-}
-
-trap '
-	test -z "$TMP_INDEX" || {
-		test -f "$TMP_INDEX" && rm -f "$TMP_INDEX"
-	}
-	rm -f "$NEXT_INDEX"
-' 0
-
-################################################################
-# Command line argument parsing and sanity checking
-
-all=3D
-also=3D
-interactive=3D
-only=3D
-logfile=3D
-use_commit=3D
-amend=3D
-edit_flag=3D
-no_edit=3D
-log_given=3D
-log_message=3D
-verify=3Dt
-quiet=3D
-verbose=3D
-signoff=3D
-force_author=3D
-only_include_assumed=3D
-untracked_files=3D
-templatefile=3D"`git config commit.template`"
-while case "$#" in 0) break;; esac
-do
-	case "$1" in
-	-F|--F|-f|--f|--fi|--fil|--file)
-		case "$#" in 1) usage ;; esac
-		shift
-		no_edit=3Dt
-		log_given=3Dt$log_given
-		logfile=3D"$1"
-		shift
-		;;
-	-F*|-f*)
-		no_edit=3Dt
-		log_given=3Dt$log_given
-		logfile=3D`expr "z$1" : 'z-[Ff]\(.*\)'`
-		shift
-		;;
-	--F=3D*|--f=3D*|--fi=3D*|--fil=3D*|--file=3D*)
-		no_edit=3Dt
-		log_given=3Dt$log_given
-		logfile=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
-		shift
-		;;
-	-a|--a|--al|--all)
-		all=3Dt
-		shift
-		;;
-	--au=3D*|--aut=3D*|--auth=3D*|--autho=3D*|--author=3D*)
-		force_author=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
-		shift
-		;;
-	--au|--aut|--auth|--autho|--author)
-		case "$#" in 1) usage ;; esac
-		shift
-		force_author=3D"$1"
-		shift
-		;;
-	-e|--e|--ed|--edi|--edit)
-		edit_flag=3Dt
-		shift
-		;;
-	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
-		also=3Dt
-		shift
-		;;
-	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
-	--interactiv|--interactive)
-		interactive=3Dt
-		shift
-		;;
-	-o|--o|--on|--onl|--only)
-		only=3Dt
-		shift
-		;;
-	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dm$log_given
-		if test "$log_message" =3D ''
-		then
-		    log_message=3D"$1"
-		else
-		    log_message=3D"$log_message
-
-$1"
-		fi
-		no_edit=3Dt
-		shift
-		;;
-	-m*)
-		log_given=3Dm$log_given
-		if test "$log_message" =3D ''
-		then
-		    log_message=3D`expr "z$1" : 'z-m\(.*\)'`
-		else
-		    log_message=3D"$log_message
-
-`expr "z$1" : 'z-m\(.*\)'`"
-		fi
-		no_edit=3Dt
-		shift
-		;;
-	--m=3D*|--me=3D*|--mes=3D*|--mess=3D*|--messa=3D*|--messag=3D*|--mess=
age=3D*)
-		log_given=3Dm$log_given
-		if test "$log_message" =3D ''
-		then
-		    log_message=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
-		else
-		    log_message=3D"$log_message
-
-`expr "z$1" : 'zq-[^=3D]*=3D\(.*\)'`"
-		fi
-		no_edit=3Dt
-		shift
-		;;
-	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
-	--no-verify)
-		verify=3D
-		shift
-		;;
-	--a|--am|--ame|--amen|--amend)
-		amend=3Dt
-		use_commit=3DHEAD
-		shift
-		;;
-	-c)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3D
-		shift
-		;;
-	--ree=3D*|--reed=3D*|--reedi=3D*|--reedit=3D*|--reedit-=3D*|--reedit-=
m=3D*|\
-	--reedit-me=3D*|--reedit-mes=3D*|--reedit-mess=3D*|--reedit-messa=3D*=
|\
-	--reedit-messag=3D*|--reedit-message=3D*)
-		log_given=3Dt$log_given
-		use_commit=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
-		no_edit=3D
-		shift
-		;;
-	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
-	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
-	--reedit-message)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3D
-		shift
-		;;
-	-C)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3Dt
-		shift
-		;;
-	--reu=3D*|--reus=3D*|--reuse=3D*|--reuse-=3D*|--reuse-m=3D*|--reuse-m=
e=3D*|\
-	--reuse-mes=3D*|--reuse-mess=3D*|--reuse-messa=3D*|--reuse-messag=3D*=
|\
-	--reuse-message=3D*)
-		log_given=3Dt$log_given
-		use_commit=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
-		no_edit=3Dt
-		shift
-		;;
-	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
-	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3Dt
-		shift
-		;;
-	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
-		signoff=3Dt
-		shift
-		;;
-	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
-		case "$#" in 1) usage ;; esac
-		shift
-		templatefile=3D"$1"
-		no_edit=3D
-		shift
-		;;
-	-q|--q|--qu|--qui|--quie|--quiet)
-		quiet=3Dt
-		shift
-		;;
-	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-		verbose=3Dt
-		shift
-		;;
-	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
-	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil=
|\
-	--untracked-file|--untracked-files)
-		untracked_files=3Dt
-		shift
-		;;
-	--)
-		shift
-		break
-		;;
-	-*)
-		usage
-		;;
-	*)
-		break
-		;;
-	esac
-done
-case "$edit_flag" in t) no_edit=3D ;; esac
-
-################################################################
-# Sanity check options
-
-case "$amend,$initial_commit" in
-t,t)
-	die "You do not have anything to amend." ;;
-t,)
-	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
-		die "You are in the middle of a merge -- cannot amend."
-	fi ;;
-esac
-
-case "$log_given" in
-tt*)
-	die "Only one of -c/-C/-F can be used." ;;
-*tm*|*mt*)
-	die "Option -m cannot be combined with -c/-C/-F." ;;
-esac
-
-case "$#,$also,$only,$amend" in
-*,t,t,*)
-	die "Only one of --include/--only can be used." ;;
-0,t,,* | 0,,t,)
-	die "No paths with --include/--only does not make sense." ;;
-0,,t,t)
-	only_include_assumed=3D"# Clever... amending the last one with dirty =
index." ;;
-0,,,*)
-	;;
-*,,,*)
-	only_include_assumed=3D"# Explicit paths specified without -i nor -o;=
 assuming --only paths..."
-	also=3D
-	;;
-esac
-unset only
-case "$all,$interactive,$also,$#" in
-*t,*t,*)
-	die "Cannot use -a, --interactive or -i at the same time." ;;
-t,,[1-9]*)
-	die "Paths with -a does not make sense." ;;
-,t,[1-9]*)
-	die "Paths with --interactive does not make sense." ;;
-,,t,0)
-	die "No paths with -i does not make sense." ;;
-esac
-
-if test ! -z "$templatefile" -a -z "$log_given"
-then
-	if test ! -f "$templatefile"
-	then
-		die "Commit template file does not exist."
-	fi
-fi
-
-################################################################
-# Prepare index to have a tree to be committed
-
-case "$all,$also" in
-t,)
-	if test ! -f "$THIS_INDEX"
-	then
-		die 'nothing to commit (use "git add file1 file2" to include for com=
mit)'
-	fi
-	save_index &&
-	(
-		cd_to_toplevel &&
-		GIT_INDEX_FILE=3D"$NEXT_INDEX" &&
-		export GIT_INDEX_FILE &&
-		git diff-files --name-only -z |
-		git update-index --remove -z --stdin
-	) || exit
-	;;
-,t)
-	save_index &&
-	git ls-files --error-unmatch -- "$@" >/dev/null || exit
-
-	git diff-files --name-only -z -- "$@"  |
-	(
-		cd_to_toplevel &&
-		GIT_INDEX_FILE=3D"$NEXT_INDEX" &&
-		export GIT_INDEX_FILE &&
-		git update-index --remove -z --stdin
-	) || exit
-	;;
-,)
-	if test "$interactive" =3D t; then
-		git add --interactive || exit
-	fi
-	case "$#" in
-	0)
-		;; # commit as-is
-	*)
-		if test -f "$GIT_DIR/MERGE_HEAD"
-		then
-			refuse_partial "Cannot do a partial commit during a merge."
-		fi
-		TMP_INDEX=3D"$GIT_DIR/tmp-index$$"
-		commit_only=3D`git ls-files --error-unmatch -- "$@"` || exit
-
-		# Build a temporary index and update the real index
-		# the same way.
-		if test -z "$initial_commit"
-		then
-			GIT_INDEX_FILE=3D"$THIS_INDEX" \
-			git read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD
-		else
-			rm -f "$TMP_INDEX"
-		fi || exit
-
-		printf '%s\n' "$commit_only" |
-		GIT_INDEX_FILE=3D"$TMP_INDEX" \
-		git update-index --add --remove --stdin &&
-
-		save_index &&
-		printf '%s\n' "$commit_only" |
-		(
-			GIT_INDEX_FILE=3D"$NEXT_INDEX"
-			export GIT_INDEX_FILE
-			git update-index --remove --stdin
-		) || exit
-		;;
-	esac
-	;;
-esac
-
-################################################################
-# If we do as-is commit, the index file will be THIS_INDEX,
-# otherwise NEXT_INDEX after we make this commit.  We leave
-# the index as is if we abort.
-
-if test -f "$NEXT_INDEX"
-then
-	USE_INDEX=3D"$NEXT_INDEX"
-else
-	USE_INDEX=3D"$THIS_INDEX"
-fi
-
-case "$status_only" in
-t)
-	# This will silently fail in a read-only repository, which is
-	# what we want.
-	GIT_INDEX_FILE=3D"$USE_INDEX" git update-index -q --unmerged --refres=
h
-	run_status
-	exit $?
-	;;
-'')
-	GIT_INDEX_FILE=3D"$USE_INDEX" git update-index -q --refresh || exit
-	;;
-esac
-
-################################################################
-# Grab commit message, write out tree and make commit.
-
-if test t =3D "$verify" && test -x "$GIT_DIR"/hooks/pre-commit
-then
-	if test "$TMP_INDEX"
-	then
-		GIT_INDEX_FILE=3D"$TMP_INDEX" "$GIT_DIR"/hooks/pre-commit
-	else
-		GIT_INDEX_FILE=3D"$USE_INDEX" "$GIT_DIR"/hooks/pre-commit
-	fi || exit
-fi
-
-if test "$log_message" !=3D ''
-then
-	printf '%s\n' "$log_message"
-elif test "$logfile" !=3D ""
-then
-	if test "$logfile" =3D -
-	then
-		test -t 0 &&
-		echo >&2 "(reading log message from standard input)"
-		cat
-	else
-		cat <"$logfile"
-	fi
-elif test "$use_commit" !=3D ""
-then
-	encoding=3D$(git config i18n.commitencoding || echo UTF-8)
-	git show -s --pretty=3Draw --encoding=3D"$encoding" "$use_commit" |
-	sed -e '1,/^$/d' -e 's/^    //'
-elif test -f "$GIT_DIR/MERGE_MSG"
-then
-	cat "$GIT_DIR/MERGE_MSG"
-elif test -f "$GIT_DIR/SQUASH_MSG"
-then
-	cat "$GIT_DIR/SQUASH_MSG"
-elif test "$templatefile" !=3D ""
-then
-	cat "$templatefile"
-fi | git stripspace >"$GIT_DIR"/COMMIT_EDITMSG
-
-case "$signoff" in
-t)
-	sign=3D$(git-var GIT_COMMITTER_IDENT | sed -e '
-		s/>.*/>/
-		s/^/Signed-off-by: /
-		')
-	blank_before_signoff=3D
-	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
-	grep 'Signed-off-by:' >/dev/null || blank_before_signoff=3D'
-'
-	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
-	grep "$sign"$ >/dev/null ||
-	printf '%s%s\n' "$blank_before_signoff" "$sign" \
-		>>"$GIT_DIR"/COMMIT_EDITMSG
-	;;
-esac
-
-if test -f "$GIT_DIR/MERGE_HEAD" && test -z "$no_edit"; then
-	echo "#"
-	echo "# It looks like you may be committing a MERGE."
-	echo "# If this is not correct, please remove the file"
-	printf '%s\n' "#	$GIT_DIR/MERGE_HEAD"
-	echo "# and try again"
-	echo "#"
-fi >>"$GIT_DIR"/COMMIT_EDITMSG
-
-# Author
-if test '' !=3D "$use_commit"
-then
-	eval "$(get_author_ident_from_commit "$use_commit")"
-	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-fi
-if test '' !=3D "$force_author"
-then
-	GIT_AUTHOR_NAME=3D`expr "z$force_author" : 'z\(.*[^ ]\) *<.*'` &&
-	GIT_AUTHOR_EMAIL=3D`expr "z$force_author" : '.*\(<.*\)'` &&
-	test '' !=3D "$GIT_AUTHOR_NAME" &&
-	test '' !=3D "$GIT_AUTHOR_EMAIL" ||
-	die "malformed --author parameter"
-	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
-fi
-
-PARENTS=3D"-p HEAD"
-if test -z "$initial_commit"
-then
-	rloga=3D'commit'
-	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
-		rloga=3D'commit (merge)'
-		PARENTS=3D"-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
-	elif test -n "$amend"; then
-		rloga=3D'commit (amend)'
-		PARENTS=3D$(git cat-file commit HEAD |
-			sed -n -e '/^$/q' -e 's/^parent /-p /p')
-	fi
-	current=3D"$(git rev-parse --verify HEAD)"
-else
-	if [ -z "$(git ls-files)" ]; then
-		echo >&2 'nothing to commit (use "git add file1 file2" to include fo=
r commit)'
-		exit 1
-	fi
-	PARENTS=3D""
-	rloga=3D'commit (initial)'
-	current=3D''
-fi
-set_reflog_action "$rloga"
-
-if test -z "$no_edit"
-then
-	{
-		echo ""
-		echo "# Please enter the commit message for your changes."
-		echo "# (Comment lines starting with '#' will not be included)"
-		test -z "$only_include_assumed" || echo "$only_include_assumed"
-		run_status
-	} >>"$GIT_DIR"/COMMIT_EDITMSG
-else
-	# we need to check if there is anything to commit
-	run_status >/dev/null
-fi
-if [ "$?" !=3D "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
-then
-	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
-	run_status
-	exit 1
-fi
-
-case "$no_edit" in
-'')
-	git-var GIT_AUTHOR_IDENT > /dev/null  || die
-	git-var GIT_COMMITTER_IDENT > /dev/null  || die
-	git_editor "$GIT_DIR/COMMIT_EDITMSG"
-	;;
-esac
-
-case "$verify" in
-t)
-	if test -x "$GIT_DIR"/hooks/commit-msg
-	then
-		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || exit
-	fi
-esac
-
-if test -z "$no_edit"
-then
-    sed -e '
-        /^diff --git a\/.*/{
-	    s///
-	    q
-	}
-	/^#/d
-    ' "$GIT_DIR"/COMMIT_EDITMSG
-else
-    cat "$GIT_DIR"/COMMIT_EDITMSG
-fi |
-git stripspace >"$GIT_DIR"/COMMIT_MSG
-
-# Test whether the commit message has any content we didn't supply.
-have_commitmsg=3D
-grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
-	git stripspace > "$GIT_DIR"/COMMIT_BAREMSG
-
-# Is the commit message totally empty?
-if test -s "$GIT_DIR"/COMMIT_BAREMSG
-then
-	if test "$templatefile" !=3D ""
-	then
-		# Test whether this is just the unaltered template.
-		if cnt=3D`sed -e '/^#/d' < "$templatefile" |
-			git stripspace |
-			diff "$GIT_DIR"/COMMIT_BAREMSG - |
-			wc -l` &&
-		   test 0 -lt $cnt
-		then
-			have_commitmsg=3Dt
-		fi
-	else
-		# No template, so the content in the commit message must
-		# have come from the user.
-		have_commitmsg=3Dt
-	fi
-fi
-
-rm -f "$GIT_DIR"/COMMIT_BAREMSG
-
-if test "$have_commitmsg" =3D "t"
-then
-	if test -z "$TMP_INDEX"
-	then
-		tree=3D$(GIT_INDEX_FILE=3D"$USE_INDEX" git write-tree)
-	else
-		tree=3D$(GIT_INDEX_FILE=3D"$TMP_INDEX" git write-tree) &&
-		rm -f "$TMP_INDEX"
-	fi &&
-	commit=3D$(git commit-tree $tree $PARENTS <"$GIT_DIR/COMMIT_MSG") &&
-	rlogm=3D$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
-	git update-ref -m "$GIT_REFLOG_ACTION: $rlogm" HEAD $commit "$current=
" &&
-	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" &&
-	if test -f "$NEXT_INDEX"
-	then
-		mv "$NEXT_INDEX" "$THIS_INDEX"
-	else
-		: ;# happy
-	fi
-else
-	echo >&2 "* no commit message?  aborting commit."
-	false
-fi
-ret=3D"$?"
-rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH=
_MSG"
-
-cd_to_toplevel
-
-git rerere
-
-if test "$ret" =3D 0
-then
-	if test -x "$GIT_DIR"/hooks/post-commit
-	then
-		"$GIT_DIR"/hooks/post-commit
-	fi
-	if test -z "$quiet"
-	then
-		commit=3D`git diff-tree --always --shortstat --pretty=3D"format:%h: =
%s"\
-		       --summary --root HEAD --`
-		echo "Created${initial_commit:+ initial} commit $commit"
-	fi
-fi
-
-exit "$ret"
diff --git a/git.c b/git.c
index cab0e72..62859a2 100644
--- a/git.c
+++ b/git.c
@@ -321,6 +321,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
@@ -363,10 +364,10 @@ static void handle_internal_command(int argc, con=
st char **argv)
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
-		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
--=20
1.5.2.GIT
