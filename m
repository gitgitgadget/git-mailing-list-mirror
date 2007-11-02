From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 4/4] Implement git commit and status as a builtin commands.
Date: Fri,  2 Nov 2007 11:33:09 -0400
Message-ID: <1194017589-4669-4-git-send-email-krh@redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
 <1194017589-4669-2-git-send-email-krh@redhat.com>
 <1194017589-4669-3-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inycx-0004vp-Lo
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbXKBPjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754122AbXKBPjt
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:39:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52864 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115AbXKBPjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:39:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA2FXGkT007563;
	Fri, 2 Nov 2007 11:33:16 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXFI1020013;
	Fri, 2 Nov 2007 11:33:15 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXEIL006415;
	Fri, 2 Nov 2007 11:33:15 -0400
X-Mailer: git-send-email 1.5.3.4.206.g58ba4
In-Reply-To: <1194017589-4669-3-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63135>

Move git-commit.sh to contrib/examples.  This also removes the git-runs=
tatus
helper, which was mostly just a git-status.sh implementation detail.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 Makefile                                        |    9 +-
 builtin-commit.c                                |  614 +++++++++++++++=
++++++++
 builtin.h                                       |    3 +-
 git-commit.sh =3D> contrib/examples/git-commit.sh |    0=20
 git.c                                           |    3 +-
 5 files changed, 621 insertions(+), 8 deletions(-)
 create mode 100644 builtin-commit.c
 rename git-commit.sh =3D> contrib/examples/git-commit.sh (100%)

diff --git a/Makefile b/Makefile
index 042f79e..689eb33 100644
--- a/Makefile
+++ b/Makefile
@@ -209,7 +209,7 @@ BASIC_LDFLAGS =3D
=20
 SCRIPT_SH =3D \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clean.sh git-clone.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
@@ -256,7 +256,7 @@ EXTRA_PROGRAMS =3D
 BUILT_INS =3D \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X git-cherry-pick$X \
+	git-fsck-objects$X git-cherry-pick$X git-status$X\
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
=20
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -326,6 +326,7 @@ BUILTIN_OBJS =3D \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
@@ -364,7 +365,6 @@ BUILTIN_OBJS =3D \
 	builtin-rev-parse.o \
 	builtin-revert.o \
 	builtin-rm.o \
-	builtin-runstatus.o \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
@@ -830,9 +830,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
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
index 0000000..a5a9e3e
--- /dev/null
+++ b/builtin-commit.c
@@ -0,0 +1,614 @@
+/*
+ * Builtin "git commit"
+ *
+ * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
+ */
+
+#include "git-compat-util.h"
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
+#include "parse-options.h"
+
+static const char * const builtin_commit_usage[] =3D {
+	"git-commit [options] [--] <filepattern>...",
+	NULL
+};
+
+static unsigned char head_sha1[20], merge_head_sha1[20];
+static char *use_message_buffer;
+static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
+static struct lock_file lock_file;
+
+static char *logfile, *force_author, *message, *template_file;
+static char *edit_message, *use_message;
+static int all, edit_flag, also, interactive, only, amend, signoff;
+static int quiet, verbose, untracked_files, no_verify;
+
+static int no_edit, initial_commit, in_merge;
+const char *only_include_assumed;
+
+static struct option builtin_commit_options[] =3D {
+	OPT__QUIET(&quiet),
+	OPT__VERBOSE(&verbose),
+	OPT_GROUP("Commit message options"),
+
+	OPT_STRING('F', "file", &logfile, "FILE", "read log from file"),
+	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for=
 commit"),
+	OPT_STRING('m', "message", &message, "MESSAGE", "specify commit messa=
ge"),
+	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and=
 edit message from specified commit "),
+	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse messa=
ge from specified commit"),
+	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),
+	OPT_STRING('t', "template", &template_file, "FILE", "use specified te=
mplate file"),
+	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
+
+	OPT_GROUP("Commit contents options"),
+	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
+	OPT_BOOLEAN('i', "include", &also, "add specified files to index for =
commit"),
+	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"=
),
+	OPT_BOOLEAN('o', "only", &only, ""),
+	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
+	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
+	OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untrack=
ed files"),
+
+	OPT_END()
+};
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
+		add_files_to_cache(verbose, NULL, files);
+		if (write_cache(fd, active_cache, active_nr) || close(fd))
+			die("unable to write new_index file");
+		return lock_file.filename;
+	} else if (also) {
+		add_files_to_cache(verbose, prefix, files);
+		if (write_cache(fd, active_cache, active_nr) || close(fd))
+			die("unable to write new_index file");
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
+	/* update the user index file */
+	add_files_to_cache(verbose, prefix, files);
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write new_index file");
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
+	add_files_to_cache(verbose, prefix, files);
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write new_index file");
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
+	strbuf_init(&sb, 0);
+	if (message) {
+		strbuf_add(&sb, message, strlen(message));
+	} else if (logfile && !strcmp(logfile, "-")) {
+		if (isatty(0))
+			fprintf(stderr, "(reading log message from standard input)\n");
+		if (strbuf_read(&sb, 0, 0) < 0)
+			die("could not read log from standard input");
+	} else if (logfile) {
+		if (strbuf_read_file(&sb, logfile, 0) < 0)
+			die("could not read log file '%s': %s",
+			    logfile, strerror(errno));
+	} else if (use_message) {
+		buffer =3D strstr(use_message_buffer, "\n\n");
+		if (!buffer || buffer[2] =3D=3D '\0')
+			die("commit has empty message");
+		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
+	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
+			die("could not read MERGE_MSG: %s", strerror(errno));
+	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
+			die("could not read SQUASH_MSG: %s", strerror(errno));
+	} else if (!stat(template_file, &statbuf)) {
+		if (strbuf_read_file(&sb, template_file, 0) < 0)
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
+		strbuf_addch(&sb, '\0');
+		bol =3D strrchr(sb.buf + sb.len - 1, '\n');
+		if (!bol || prefixcmp(bol, sign_off_header))
+			fprintf(fp, "\n");
+		fprintf(fp, "%s%s\n", sign_off_header, git_committer_info(1));
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
+	struct strbuf tmpl;
+	const char *nl;
+	int eol, i;
+
+	/* See if the template is just a prefix of the message. */
+	strbuf_init(&tmpl, 0);
+	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
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
+		if (strlen(sign_off_header) <=3D eol - i &&
+		    !prefixcmp(sb->buf + i, sign_off_header)) {
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
+	if (force_author) {
+		const char *eoname =3D strstr(force_author, " <");
+		const char *eomail =3D strchr(force_author, '>');
+
+		if (!eoname || !eomail)
+			die("malformed --author parameter\n");
+		name =3D xstrndup(force_author, eoname - force_author);
+		email =3D xstrndup(eoname + 2, eomail - eoname - 2);
+		strbuf_addf(sb, "author %s\n",
+			    fmt_ident(name, email,=20
+				      getenv("GIT_AUTHOR_DATE"), 1));
+		free(name);
+		free(email);
+	} else if (use_message) {
+		p =3D strstr(use_message_buffer, "\nauthor");
+		if (!p)
+			die("invalid commit: %s\n", use_message);
+		p++;
+		eol =3D strchr(p, '\n');
+		if (!eol)
+			die("invalid commit: %s\n", use_message);
+
+		strbuf_add(sb, p, eol + 1 - p);
+	} else {
+		strbuf_addf(sb, "author %s\n", git_author_info(1));
+	}
+}
+
+static int parse_and_validate_options(int argc, const char *argv[])
+{
+	int f =3D 0;
+
+	argc =3D parse_options(argc, argv, builtin_commit_options,
+			     builtin_commit_usage, 0);
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
+		const char *out_enc;
+		char *enc, *end;
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
+		if (strcmp(out_enc, enc))
+			use_message_buffer =3D
+				reencode_string(commit->buffer, out_enc, enc);
+
+		/* If we failed to reencode the buffer, just copy it
+		 * byte for byte so the user can try to fix it up.
+		 * This also handles the case where input and output
+		 * encodings are identical. */
+		if (use_message_buffer =3D=3D NULL)
+			use_message_buffer =3D xstrdup(commit->buffer);
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
+	else if (all && argc > 0)
+		die("Paths with -a does not make sense.");
+	else if (interactive && argc > 0)
+		die("Paths with --interactive does not make sense.");
+
+	return argc;
+}
+
+int cmd_status(int argc, const char **argv, const char *prefix)
+{
+	const char *index_file;
+	int commitable;
+
+	git_config(git_status_config);
+
+	argc =3D parse_and_validate_options(argc, argv);
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
+	argc =3D parse_and_validate_options(argc, argv);
+
+	index_file =3D prepare_index(argv, prefix);
+
+	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+		exit(1);
+
+	if (!prepare_log_message(index_file) && !in_merge) {
+		run_status(stdout, index_file);
+		unlink(commit_editmsg);
+		return 1;
+	}
+
+	strbuf_init(&sb, 0);
+
+	/* Start building up the commit header */
+	read_cache_from(index_file);
+	active_cache_tree =3D cache_tree();
+	if (cache_tree_update(active_cache_tree,
+			      active_cache, active_nr, 0, 0) < 0)
+		die("Error building trees");
+	strbuf_addf(&sb, "tree %s\n",
+		    sha1_to_hex(active_cache_tree->sha1));
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
+			strbuf_addf(&sb, "parent %s\n",
+				      sha1_to_hex(c->item->object.sha1));
+	} else if (in_merge) {
+		struct strbuf m;
+		FILE *fp;
+
+		reflog_msg =3D "commit (merge)";
+		strbuf_addf(&sb, "parent %s\n", sha1_to_hex(head_sha1));
+		strbuf_init(&m, 0);
+		fp =3D fopen(git_path("MERGE_HEAD"), "r");
+		if (fp =3D=3D NULL)
+			die("could not open %s for reading: %s",
+			    git_path("MERGE_HEAD"), strerror(errno));
+		while (strbuf_getline(&m, fp, '\n') !=3D EOF)
+			strbuf_addf(&sb, "parent %s\n", m.buf);
+		fclose(fp);
+		strbuf_release(&m);
+	} else {
+		reflog_msg =3D "commit";
+		strbuf_addf(&sb, "parent %s\n", sha1_to_hex(head_sha1));
+	}
+
+	determine_author_info(&sb);
+	strbuf_addf(&sb, "committer %s\n", git_committer_info(1));
+	if (!is_encoding_utf8(git_commit_encoding))
+		strbuf_addf(&sb, "encoding %s\n", git_commit_encoding);
+	strbuf_addch(&sb, '\n');
+
+	/* Get the commit message and validate it */
+	header_len =3D sb.len;
+	if (!no_edit) {
+		fprintf(stderr, "launching editor, log %s\n", logfile);
+		launch_editor(git_path(commit_editmsg), &sb);
+	}
+	else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0)
+		die("could not read commit message\n");
+	if (run_hook(index_file, "commit-msg", commit_editmsg))
+		exit(1);
+	stripspace(&sb, 1);
+	if (sb.len < header_len ||
+	    message_is_empty(&sb, header_len))
+		die("* no commit message?  aborting commit.");
+	strbuf_addch(&sb, '\0');
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
+	strbuf_addf(&sb, "%s: %s\n", reflog_msg, header_line);
+	strbuf_addch(&sb, '\0');
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
index 9a6213a..0f8456c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,6 +24,7 @@ extern int cmd_check_attr(int argc, const char **argv=
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
@@ -68,10 +69,10 @@ extern int cmd_rev_list(int argc, const char **argv=
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
diff --git a/git-commit.sh b/contrib/examples/git-commit.sh
similarity index 100%
rename from git-commit.sh
rename to contrib/examples/git-commit.sh
diff --git a/git.c b/git.c
index 4e10581..8522095 100644
--- a/git.c
+++ b/git.c
@@ -298,6 +298,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
@@ -346,10 +347,10 @@ static void handle_internal_command(int argc, con=
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
1.5.3.4.206.g58ba4
