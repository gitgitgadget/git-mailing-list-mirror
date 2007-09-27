From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 3/4] Implement git commit as a builtin command.
Date: Thu, 27 Sep 2007 00:50:31 -0400
Message-ID: <1190868632-29287-3-git-send-email-krh@redhat.com>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
 <1190868632-29287-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 27 07:09:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ialcl-0004QP-Bu
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbXI0FIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 01:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbXI0FIw
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:08:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57137 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbXI0FIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:08:48 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58kuq031485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2007 01:08:46 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58j5m001670;
	Thu, 27 Sep 2007 01:08:45 -0400
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58gMs002271;
	Thu, 27 Sep 2007 01:08:44 -0400
X-Mailer: git-send-email 1.5.3.2.1119.gab6f-dirty
In-Reply-To: <1190868632-29287-2-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59260>

Move git-commit.sh to contrib/examples.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 Makefile                       |    9 +-
 builtin-commit.c               |  611 ++++++++++++++++++++++++++++++++=
+++++++
 builtin-tag.c                  |    3 +-
 builtin.h                      |    3 +-
 contrib/examples/git-commit.sh |  627 ++++++++++++++++++++++++++++++++=
++++++++
 git-commit.sh                  |  627 --------------------------------=
--------
 git.c                          |    3 +-
 strbuf.h                       |    1 +
 t/t3501-revert-cherry-pick.sh  |    4 +-
 t/t3901-i18n-patch.sh          |    8 +-
 t/test-lib.sh                  |    4 +-
 11 files changed, 1255 insertions(+), 645 deletions(-)
 create mode 100644 builtin-commit.c
 create mode 100755 contrib/examples/git-commit.sh
 delete mode 100755 git-commit.sh

diff --git a/Makefile b/Makefile
index d90e959..6172589 100644
--- a/Makefile
+++ b/Makefile
@@ -206,7 +206,7 @@ BASIC_LDFLAGS =3D
=20
 SCRIPT_SH =3D \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clean.sh git-clone.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
@@ -254,7 +254,7 @@ EXTRA_PROGRAMS =3D
 BUILT_INS =3D \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X git-cherry-pick$X \
+	git-fsck-objects$X git-cherry-pick$X git-status$X\
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
=20
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -324,6 +324,7 @@ BUILTIN_OBJS =3D \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
@@ -362,7 +363,6 @@ BUILTIN_OBJS =3D \
 	builtin-rev-parse.o \
 	builtin-revert.o \
 	builtin-rm.o \
-	builtin-runstatus.o \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
@@ -822,9 +822,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
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
index 0000000..69e8b19
--- /dev/null
+++ b/builtin-commit.c
@@ -0,0 +1,611 @@
+/*
+ * Builtin "git commit"
+ *
+ * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
+ */
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
+	{ OPTION_BOOLEAN, "all", 'a', &all },
+	{ OPTION_STRING, "author", 0, (void *) &force_author },
+	{ OPTION_BOOLEAN, "edit", 'e', &edit_flag },
+	{ OPTION_BOOLEAN, "include", 'i', &also },
+	{ OPTION_BOOLEAN, "interactive", 0, &interactive },
+	{ OPTION_BOOLEAN, "only", 'o', &only },
+	{ OPTION_STRING, "message", 'm', &message },
+	{ OPTION_BOOLEAN, "no-verify", 'n', &no_verify },
+	{ OPTION_BOOLEAN, "amend", 0, &amend },
+	{ OPTION_STRING, "reedit-message", 'c', &edit_message },
+	{ OPTION_STRING, "reuse-message", 'C', &use_message },
+	{ OPTION_BOOLEAN, "signoff", 's', &signoff },
+	{ OPTION_BOOLEAN, "quiet", 'q', &quiet },
+	{ OPTION_BOOLEAN, "verbose", 'v', &verbose },
+	{ OPTION_BOOLEAN, "untracked-files", 0, &untracked_files },
+	{ OPTION_STRING, "template", 't', &template_file },
+	{ OPTION_LAST },
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
+		add_files_to_cache(0, prefix, files);
+		if (write_cache(fd, active_cache, active_nr) || close(fd))
+			die("unable to write new index file");
+		return lock_file.filename;
+	} else if (also) {
+		add_files_to_cache(fd, prefix, files);
+		if (write_cache(fd, active_cache, active_nr) || close(fd))
+			die("unable to write new index file");
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
+	add_files_to_cache(0, prefix, files);
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write new index file");
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
+	add_files_to_cache(0, prefix, files);
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write new index file");
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
+		if (strbuf_read_file(&sb, logfile) < 0)
+			die("could not read log file '%s': %s",
+			    logfile, strerror(errno));
+	} else if (use_message) {
+		buffer =3D strstr(use_message_buffer, "\n\n");
+		if (!buffer || buffer[2] =3D=3D '\0')
+			die("commit has empty message");
+		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
+	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path("MERGE_MSG")) < 0)
+			die("could not read MERGE_MSG: %s", strerror(errno));
+	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path("SQUASH_MSG")) < 0)
+			die("could not read SQUASH_MSG: %s", strerror(errno));
+	} else if (!stat(template_file, &statbuf)) {
+		if (strbuf_read_file(&sb, template_file) < 0)
+			die("could not read %s: %s",
+			    template_file, strerror(errno));
+	}
+
+	fp =3D fopen(git_path(commit_editmsg), "w");
+	if (fp =3D=3D NULL)
+		die("could not open %s\n", git_path(commit_editmsg));
+
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
+	if (template_file && strbuf_read_file(&tmpl, template_file) > 0) {
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
+		strbuf_addf(sb, "author %s\n",
+			    fmt_ident(name, email,
+				      getenv("GIT_AUTHOR_DATE"), 1));
+		free(name);
+		free(email);
+	} else {
+		strbuf_addf(sb, "author %s\n", git_author_info(1));
+	}
+}
+
+static void parse_and_validate_options(const char ***argv)
+{
+	int f =3D 0;
+
+	(*argv)++;
+	while (parse_options(argv, commit_options, ARRAY_SIZE(commit_options)=
,
+			     builtin_commit_usage))
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
+
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
+		reflog_msg =3D "commit (initial)";
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
+	else if (strbuf_read_file(&sb, git_path(commit_editmsg)) < 0)
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
+
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
diff --git a/builtin-tag.c b/builtin-tag.c
index a1a2cf0..0a36a5d 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -17,12 +17,11 @@ static const char builtin_tag_usage[] =3D
=20
 static char signingkey[1000];
=20
-static void launch_editor(const char *path, struct strbuf *buffer)
+void launch_editor(const char *path, struct strbuf *buffer)
 {
 	const char *editor, *terminal;
 	struct child_process child;
 	const char *args[3];
-	int fd;
=20
 	editor =3D getenv("GIT_EDITOR");
 	if (!editor && editor_program)
diff --git a/builtin.h b/builtin.h
index 65cc0fb..470a788 100644
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
@@ -67,10 +68,10 @@ extern int cmd_rev_list(int argc, const char **argv=
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
index 0000000..44ccc44
--- /dev/null
+++ b/contrib/examples/git-commit.sh
@@ -0,0 +1,627 @@
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
+	if test "$status_only" =3D "t" -o "$use_status_color" =3D "t"; then
+		color=3D
+	else
+		color=3D--nocolor
+	fi
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
+while test $# !=3D 0
+do
+	case "$1" in
+	-F|--F|-f|--f|--fi|--fil|--file)
+		case "$#" in 1) usage ;; esac
+		shift
+		no_edit=3Dt
+		log_given=3Dt$log_given
+		logfile=3D"$1"
+		;;
+	-F*|-f*)
+		no_edit=3Dt
+		log_given=3Dt$log_given
+		logfile=3D"${1#-[Ff]}"
+		;;
+	--F=3D*|--f=3D*|--fi=3D*|--fil=3D*|--file=3D*)
+		no_edit=3Dt
+		log_given=3Dt$log_given
+		logfile=3D"${1#*=3D}"
+		;;
+	-a|--a|--al|--all)
+		all=3Dt
+		;;
+	--au=3D*|--aut=3D*|--auth=3D*|--autho=3D*|--author=3D*)
+		force_author=3D"${1#*=3D}"
+		;;
+	--au|--aut|--auth|--autho|--author)
+		case "$#" in 1) usage ;; esac
+		shift
+		force_author=3D"$1"
+		;;
+	-e|--e|--ed|--edi|--edit)
+		edit_flag=3Dt
+		;;
+	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
+		also=3Dt
+		;;
+	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
+	--interactiv|--interactive)
+		interactive=3Dt
+		;;
+	-o|--o|--on|--onl|--only)
+		only=3Dt
+		;;
+	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dm$log_given
+		log_message=3D"${log_message:+${log_message}
+
+}$1"
+		no_edit=3Dt
+		;;
+	-m*)
+		log_given=3Dm$log_given
+		log_message=3D"${log_message:+${log_message}
+
+}${1#-m}"
+		no_edit=3Dt
+		;;
+	--m=3D*|--me=3D*|--mes=3D*|--mess=3D*|--messa=3D*|--messag=3D*|--mess=
age=3D*)
+		log_given=3Dm$log_given
+		log_message=3D"${log_message:+${log_message}
+
+}${1#*=3D}"
+		no_edit=3Dt
+		;;
+	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
+	--no-verify)
+		verify=3D
+		;;
+	--a|--am|--ame|--amen|--amend)
+		amend=3Dt
+		use_commit=3DHEAD
+		;;
+	-c)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3D
+		;;
+	--ree=3D*|--reed=3D*|--reedi=3D*|--reedit=3D*|--reedit-=3D*|--reedit-=
m=3D*|\
+	--reedit-me=3D*|--reedit-mes=3D*|--reedit-mess=3D*|--reedit-messa=3D*=
|\
+	--reedit-messag=3D*|--reedit-message=3D*)
+		log_given=3Dt$log_given
+		use_commit=3D"${1#*=3D}"
+		no_edit=3D
+		;;
+	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
+	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
+	--reedit-message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3D
+		;;
+	-C)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3Dt
+		;;
+	--reu=3D*|--reus=3D*|--reuse=3D*|--reuse-=3D*|--reuse-m=3D*|--reuse-m=
e=3D*|\
+	--reuse-mes=3D*|--reuse-mess=3D*|--reuse-messa=3D*|--reuse-messag=3D*=
|\
+	--reuse-message=3D*)
+		log_given=3Dt$log_given
+		use_commit=3D"${1#*=3D}"
+		no_edit=3Dt
+		;;
+	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
+	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=3Dt$log_given
+		use_commit=3D"$1"
+		no_edit=3Dt
+		;;
+	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
+		signoff=3Dt
+		;;
+	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
+		case "$#" in 1) usage ;; esac
+		shift
+		templatefile=3D"$1"
+		no_edit=3D
+		;;
+	-q|--q|--qu|--qui|--quie|--quiet)
+		quiet=3Dt
+		;;
+	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
+		verbose=3Dt
+		;;
+	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
+	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil=
|\
+	--untracked-file|--untracked-files)
+		untracked_files=3Dt
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
+	shift
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
+
+		TMP_INDEX=3D"$GIT_DIR/tmp-index$$"
+		W=3D
+		test -z "$initial_commit" && W=3D--with-tree=3DHEAD
+		commit_only=3D`git ls-files --error-unmatch $W -- "$@"` || exit
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
+			git update-index --add --remove --stdin
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
+    GIT_INDEX_FILE=3D"${TMP_INDEX:-${USE_INDEX}}" "$GIT_DIR"/hooks/pre=
-commit \
+    || exit
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
+if [ "$?" !=3D "0" -a ! -f "$GIT_DIR/MERGE_HEAD" ]
+then
+	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
+	use_status_color=3Dt
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
+	git gc --auto
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
index 44ccc44..0000000
--- a/git-commit.sh
+++ /dev/null
@@ -1,627 +0,0 @@
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
-	if test "$status_only" =3D "t" -o "$use_status_color" =3D "t"; then
-		color=3D
-	else
-		color=3D--nocolor
-	fi
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
-while test $# !=3D 0
-do
-	case "$1" in
-	-F|--F|-f|--f|--fi|--fil|--file)
-		case "$#" in 1) usage ;; esac
-		shift
-		no_edit=3Dt
-		log_given=3Dt$log_given
-		logfile=3D"$1"
-		;;
-	-F*|-f*)
-		no_edit=3Dt
-		log_given=3Dt$log_given
-		logfile=3D"${1#-[Ff]}"
-		;;
-	--F=3D*|--f=3D*|--fi=3D*|--fil=3D*|--file=3D*)
-		no_edit=3Dt
-		log_given=3Dt$log_given
-		logfile=3D"${1#*=3D}"
-		;;
-	-a|--a|--al|--all)
-		all=3Dt
-		;;
-	--au=3D*|--aut=3D*|--auth=3D*|--autho=3D*|--author=3D*)
-		force_author=3D"${1#*=3D}"
-		;;
-	--au|--aut|--auth|--autho|--author)
-		case "$#" in 1) usage ;; esac
-		shift
-		force_author=3D"$1"
-		;;
-	-e|--e|--ed|--edi|--edit)
-		edit_flag=3Dt
-		;;
-	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
-		also=3Dt
-		;;
-	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
-	--interactiv|--interactive)
-		interactive=3Dt
-		;;
-	-o|--o|--on|--onl|--only)
-		only=3Dt
-		;;
-	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dm$log_given
-		log_message=3D"${log_message:+${log_message}
-
-}$1"
-		no_edit=3Dt
-		;;
-	-m*)
-		log_given=3Dm$log_given
-		log_message=3D"${log_message:+${log_message}
-
-}${1#-m}"
-		no_edit=3Dt
-		;;
-	--m=3D*|--me=3D*|--mes=3D*|--mess=3D*|--messa=3D*|--messag=3D*|--mess=
age=3D*)
-		log_given=3Dm$log_given
-		log_message=3D"${log_message:+${log_message}
-
-}${1#*=3D}"
-		no_edit=3Dt
-		;;
-	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
-	--no-verify)
-		verify=3D
-		;;
-	--a|--am|--ame|--amen|--amend)
-		amend=3Dt
-		use_commit=3DHEAD
-		;;
-	-c)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3D
-		;;
-	--ree=3D*|--reed=3D*|--reedi=3D*|--reedit=3D*|--reedit-=3D*|--reedit-=
m=3D*|\
-	--reedit-me=3D*|--reedit-mes=3D*|--reedit-mess=3D*|--reedit-messa=3D*=
|\
-	--reedit-messag=3D*|--reedit-message=3D*)
-		log_given=3Dt$log_given
-		use_commit=3D"${1#*=3D}"
-		no_edit=3D
-		;;
-	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
-	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
-	--reedit-message)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3D
-		;;
-	-C)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3Dt
-		;;
-	--reu=3D*|--reus=3D*|--reuse=3D*|--reuse-=3D*|--reuse-m=3D*|--reuse-m=
e=3D*|\
-	--reuse-mes=3D*|--reuse-mess=3D*|--reuse-messa=3D*|--reuse-messag=3D*=
|\
-	--reuse-message=3D*)
-		log_given=3Dt$log_given
-		use_commit=3D"${1#*=3D}"
-		no_edit=3Dt
-		;;
-	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
-	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
-		case "$#" in 1) usage ;; esac
-		shift
-		log_given=3Dt$log_given
-		use_commit=3D"$1"
-		no_edit=3Dt
-		;;
-	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
-		signoff=3Dt
-		;;
-	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
-		case "$#" in 1) usage ;; esac
-		shift
-		templatefile=3D"$1"
-		no_edit=3D
-		;;
-	-q|--q|--qu|--qui|--quie|--quiet)
-		quiet=3Dt
-		;;
-	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-		verbose=3Dt
-		;;
-	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
-	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil=
|\
-	--untracked-file|--untracked-files)
-		untracked_files=3Dt
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
-	shift
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
-
-		TMP_INDEX=3D"$GIT_DIR/tmp-index$$"
-		W=3D
-		test -z "$initial_commit" && W=3D--with-tree=3DHEAD
-		commit_only=3D`git ls-files --error-unmatch $W -- "$@"` || exit
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
-			git update-index --add --remove --stdin
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
-    GIT_INDEX_FILE=3D"${TMP_INDEX:-${USE_INDEX}}" "$GIT_DIR"/hooks/pre=
-commit \
-    || exit
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
-if [ "$?" !=3D "0" -a ! -f "$GIT_DIR/MERGE_HEAD" ]
-then
-	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
-	use_status_color=3Dt
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
-	git gc --auto
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
index d7c6bca..9565555 100644
--- a/git.c
+++ b/git.c
@@ -320,6 +320,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
@@ -368,10 +369,10 @@ static void handle_internal_command(int argc, con=
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
diff --git a/strbuf.h b/strbuf.h
index 5657e3d..eef4e6d 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -113,5 +113,6 @@ extern int strbuf_read_file(struct strbuf *sb, cons=
t char *path);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
=20
 extern void stripspace(struct strbuf *buf, int skip_comments);
+extern void launch_editor(const char *path, struct strbuf *buffer);
=20
 #endif /* STRBUF_H */
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index 552af1c..2dbe04f 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -44,7 +44,7 @@ test_expect_success setup '
 test_expect_success 'cherry-pick after renaming branch' '
=20
 	git checkout rename2 &&
-	EDITOR=3D: VISUAL=3D: git cherry-pick added &&
+	git cherry-pick added &&
 	test -f opos &&
 	grep "Add extra line at the end" opos
=20
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick after renaming branc=
h' '
 test_expect_success 'revert after renaming branch' '
=20
 	git checkout rename1 &&
-	EDITOR=3D: VISUAL=3D: git revert added &&
+	git revert added &&
 	test -f spoo &&
 	! grep "Add extra line at the end" spoo
=20
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 28e9e37..235f372 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -154,7 +154,7 @@ test_expect_success 'cherry-pick(U/U)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3
 '
@@ -169,7 +169,7 @@ test_expect_success 'cherry-pick(L/L)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3 8859
 '
@@ -184,7 +184,7 @@ test_expect_success 'cherry-pick(U/L)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3
 '
@@ -200,7 +200,7 @@ test_expect_success 'cherry-pick(L/U)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3 8859
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index cc1253c..a232bd6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -9,8 +9,8 @@ LC_ALL=3DC
 PAGER=3Dcat
 TZ=3DUTC
 export LANG LC_ALL PAGER TZ
-EDITOR=3D:
-VISUAL=3D:
+EDITOR=3D/bin/true
+VISUAL=3D/bin/true
 unset GIT_EDITOR
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
--=20
1.5.2.GIT
