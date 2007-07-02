From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [RFC] Update on builtin-commit
Date: Mon,  2 Jul 2007 10:22:43 -0400
Message-ID: <11833861634103-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 16:23:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5MoX-0005GP-Mt
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760011AbXGBOW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:22:56 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759988AbXGBOW4
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:22:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758882AbXGBOWx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:22:53 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l62EMqMc016898
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 10:22:52 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62EMpnH031514
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 10:22:51 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62EMnFO031611
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 10:22:49 -0400
X-Mailer: git-send-email 1.5.2.1.160.g29b15-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51366>

Hi,

Here's an update on the work so far, and I've attached the current stat=
e
of the work as a patch.  I'm pretty close to making my first commit wit=
h
this, and some of the work here is ready to be factored out into a few
stand-alone patches.  I'm thinking of the wt-status.[ch] changes and th=
e
read_fd and read_path changes.  My plan is to finish this first-pass
porting of the script and then go back and review and split the patch i=
nto
a series of commits, but if somebody wants to pick that up now, that'd =
be
great.

The only steps missing here are

	1) Call git-write-tree with the new index
	2) Run the post-commit hook

and I need to look into the reflog stuff.  But other than that, the por=
t is
mostly complete.

Kristian

---
 Makefile         |    9 +-
 builtin-commit.c |  567 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h        |    3 +-
 cache.h          |    3 +-
 color.c          |   18 +-
 color.h          |    4 +-
 git.c            |    3 +-
 mktag.c          |    8 +-
 sha1_file.c      |   44 +++--
 wt-status.c      |   84 ++++----
 wt-status.h      |    4 +
 11 files changed, 667 insertions(+), 80 deletions(-)
 create mode 100644 builtin-commit.c

diff --git a/Makefile b/Makefile
index 0f75955..967d5a5 100644
--- a/Makefile
+++ b/Makefile
@@ -198,7 +198,7 @@ BASIC_LDFLAGS =3D
=20
 SCRIPT_SH =3D \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clean.sh git-clone.sh \
 	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
@@ -257,7 +257,7 @@ EXTRA_PROGRAMS =3D
 BUILT_INS =3D \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X git-cherry-pick$X \
+	git-fsck-objects$X git-cherry-pick$X git-status$X\
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
=20
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -332,6 +332,7 @@ BUILTIN_OBJS =3D \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
@@ -367,7 +368,6 @@ BUILTIN_OBJS =3D \
 	builtin-rev-parse.o \
 	builtin-revert.o \
 	builtin-rm.o \
-	builtin-runstatus.o \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
@@ -791,9 +791,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	chmod +x $@+ && \
 	mv $@+ $@
=20
-git-status: git-commit
-	$(QUIET_GEN)cp $< $@+ && mv $@+ $@
-
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
diff --git a/builtin-commit.c b/builtin-commit.c
new file mode 100644
index 0000000..4a68cc0
--- /dev/null
+++ b/builtin-commit.c
@@ -0,0 +1,567 @@
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
+#include "builtin.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "commit.h"
+#include "revision.h"
+#include "wt-status.h"
+#include "run-command.h"
+
+static const char builtin_commit_usage[] =3D
+	"[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <log=
file> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i =
| -o] <path>...]";
+
+static unsigned char head_sha1[20];
+static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
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
+static char *logfile, *force_author, *message;
+static char *edit_message, *use_message;
+static int all, edit_flag, also, interactive, only, no_verify, amend, =
signoff;
+static int quiet, verbose, untracked_files;
+
+static int no_edit;
+const char *only_include_assumed;
+
+static struct option commit_options[] =3D {
+	{ OPTION_STRING, "file", 'F', (void *) &logfile },
+	{ OPTION_NONE, "all", 'a', &all },
+	{ OPTION_STRING, "author", 0, (void *) &force_author },
+	{ OPTION_NONE, "edit", 0, &edit_flag },
+	{ OPTION_NONE, "include", 'i', &also },
+	{ OPTION_NONE, "interactive", 0, &interactive },
+	{ OPTION_NONE, "only", 'o', &only },
+	{ OPTION_STRING, "message", 'm', &message },
+	{ OPTION_NONE, "no-verify", 'n', &no_verify },
+	{ OPTION_NONE, "amend", 0, &amend },
+	{ OPTION_STRING, "reedit-message", 'c', &edit_message },
+	{ OPTION_STRING, "reuse-message", 'C', &use_message },
+	{ OPTION_NONE, "signoff", 's', &signoff },
+	{ OPTION_NONE, "quiet", 'q', &signoff },
+	{ OPTION_NONE, "verbose", 'v', &verbose },
+	{ OPTION_NONE, "untracked-files", 0, &untracked_files },
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
+			add_file_to_cache(path, verbose);
+			break;
+		case DIFF_STATUS_DELETED:
+			remove_file_from_cache(path);
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
+
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+	    die("unable to write new index file");
+}
+
+static char *
+prepare_index(const char **files, struct lock_file *lk, const char *pr=
efix)
+{
+	int fd;
+	struct tree *tree;
+	struct lock_file *next_index_lock;
+
+	fd =3D hold_locked_index(lk, 1);
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	if (all) {
+		add_files_to_cache(fd, files, NULL);
+		return lk->filename;
+	} else if (also) {
+		add_files_to_cache(fd, files, prefix);
+		return lk->filename;
+	}
+
+	if (interactive)
+		/* launch git-add --interactive */;
+
+	if (*files =3D=3D NULL) {
+		rollback_lock_file(lk);
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
+	tree =3D parse_tree_indirect(head_sha1);
+	if (!tree)
+		die("failed to unpack HEAD tree object");
+	if (read_tree(tree, 0, NULL))
+		die("failed to read HEAD tree object");
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
+static int strip_lines(char *buffer, int len)
+{
+	int blank_lines, i, j;
+	char *eol;
+
+	blank_lines =3D 1;
+	for (i =3D 0, j =3D 0; i < len; i++) {
+		if (blank_lines > 0 && buffer[i] =3D=3D '#') {
+			eol =3D strchr(buffer + i, '\n');
+			if (!eol)
+				break;
+
+			i =3D eol - buffer;
+			continue;
+		}
+
+		if (buffer[i] =3D=3D '\n') {
+			blank_lines++;
+			if (blank_lines > 1)
+				continue;
+		} else {
+			if (blank_lines > 2)
+				buffer[j++] =3D '\n';
+			blank_lines =3D 0;
+		}
+
+		buffer[j++] =3D buffer[i];
+	}
+
+	if (buffer[j - 1] !=3D '\n')
+               buffer[j++] =3D '\n';
+
+	return j;
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
+	char *buffer =3D NULL, *commit;
+	struct stat statbuf;
+	int type, commitable;
+	unsigned long len, size;
+	unsigned char sha1[20];
+	FILE *fp;
+
+	if (message) {
+		buffer =3D message;
+		len =3D strlen(message);
+	} else if (logfile && !strcmp(logfile, "-")) {
+		if (isatty(0))
+			fprintf(stderr, "(reading log message from standard input)\n");
+		if (read_fd(0, &buffer, &len))
+			die("could not read log from standard input");
+	} else if (logfile) {
+		if (read_path(logfile, &buffer, &len))
+			die("could not read log file '%s': %s",
+			    logfile, strerror(errno));
+	} else if (use_message) {
+		/* git-show unrolled here... or split out to another
+		 * function */
+		/* encoding */
+		if (get_sha1(use_message, sha1))
+			die("could not lookup commit %s", use_message);
+		/* check it's a commit */
+		commit =3D read_sha1_file(sha1, &type, &size);
+		/* filter out headers, write to msg fd */
+	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
+		if (read_path(git_path("MERGE_MSG"), &buffer, &len))
+			die("could not read MERGE_MSG: %s", strerror(errno));
+	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
+		if (read_path(git_path("SQUASH_MSG"), &buffer, &len))
+			die("could not read SQUASH_MSG: %s", strerror(errno));
+	}
+
+	if (buffer)
+		len =3D strip_lines(buffer, len);
+
+	fp =3D fopen(git_path(commit_editmsg), "w");
+	if (fp =3D=3D NULL)
+		die("could not open %s\n", git_path(commit_editmsg));
+	=09
+	if (fwrite(buffer, 1, len, fp) < len)
+		die("could not write commit template: %s\n", strerror(errno));
+
+	if (buffer && signoff) {
+		char *bol =3D strrchr(buffer + len - 1, '\n');
+		const char *info;
+
+		info =3D git_committer_info(1);
+		if (!bol || prefixcmp(bol, sign_off_header))
+			fprintf(fp, "\n");
+		fprintf(fp, "Signed-off-by: %s\n", git_committer_info(1));
+	}
+
+	if (!stat(git_path("MERGE_HEAD"), &statbuf) && !no_edit) {
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
+void
+determine_author(char **name, char **email)
+{
+	if (use_message) {
+		/* Get author from commit use_message
+		 * parse "author Name <email> date"
+		 */
+	} else if (force_author) {
+		/* parse "Author <email>" get from force_author */
+	}
+}
+
+static void parse_and_validate_options(const char ***argv)
+{
+	int initial_commit =3D 0, f =3D 0;
+	struct stat statbuf;
+
+	git_config(git_status_config);
+
+	(*argv)++;
+	while (scan_options(argv, commit_options))
+		;
+
+	if (logfile || message || use_message)
+		no_edit =3D 1;
+
+	if (get_sha1("HEAD", head_sha1))
+		initial_commit =3D 1;
+
+	/* Sanity check options */
+	if (amend && initial_commit)
+		die("You have nothing to amend.");
+	if (amend && !stat(git_path("MERGE_HEAD"), &statbuf))
+		die("You are in the middle of a merger -- cannot amend.");
+
+	if (use_message)
+		f++;
+	if (edit_message)
+		f++;
+	if (logfile)
+		f++;
+	if (amend)
+		f++;
+	if (f > 1)
+		die("Only one of -c/-C/-F/--amend can be used.");
+	if (message && f > 0)
+		die("Option -m cannot be combined with -c/-C/-F/--amend.");
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
+	struct lock_file lk;
+	int commitable;
+
+	parse_and_validate_options(&argv);
+
+	index_file =3D prepare_index(argv, &lk, prefix);
+
+	commitable =3D run_status(stdout, index_file);
+
+	rollback_lock_file(&lk);
+
+	return commitable ? 0 : 1;
+}
+
+static void launch_editor(const char *path, char **buffer, unsigned lo=
ng *len)
+{
+	const char *editor, *terminal;
+	struct child_process child;
+	const char *args[3];
+
+	editor =3D getenv("VISUAL");
+	if (!editor)
+		editor =3D getenv("EDITOR");
+
+	terminal =3D getenv("TERM");
+	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
+		fprintf(stderr,=20
+			"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
+			"Please supply the commit log message using either\n"
+			"-m or -F option.  A boilerplate log message has\n"
+			"been prepared in $GIT_DIR/COMMIT_EDITMSG\n");
+		exit(1);
+	}
+
+	if (!editor)
+		editor =3D "vi";
+	   =20
+	memset(&child, 0, sizeof(child));
+	child.argv =3D args;
+	args[0] =3D editor;
+	args[1] =3D path;
+	args[2] =3D NULL;
+
+	if (run_command(&child))
+		die("could not launch editor %s.", editor);
+
+	if (read_path(path, buffer, len))
+		die("could not read commit message file '%s': %s",
+		    logfile, strerror(errno));
+
+	*len =3D strip_lines(*buffer, *len);
+
+	fwrite(*buffer, 1, *len, stderr);
+}
+
+static int run_pre_commit_hook(const char *index_file)
+{
+	static const char pre_commit_hook[] =3D "hooks/pre-commit";
+	struct child_process hook;
+	const char *argv[2], *env[2];
+	char index[MAXPATH];
+
+	if (access(git_path(pre_commit_hook), X_OK) < 0)
+		return 0;
+
+	argv[0] =3D git_path(update_hook);
+	argv[1] =3D NULL;
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file);
+	env[0] =3D index;
+	env[1] =3D NULL;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv =3D argv;
+	hook.no_stdin =3D 1;
+	hook.stdout_to_stderr =3D 1;
+	hook.env =3D env;
+
+	return run_command(&proc);
+}
+
+int cmd_commit(int argc, const char **argv, const char *prefix)
+{
+	int fd;
+	unsigned long len;
+	char *name, *email, *buffer;
+	const char *index_file;
+	struct lock_file lk;
+	struct stat statbuf;
+
+	parse_and_validate_options(&argv);
+
+	index_file =3D prepare_index(argv, &lk, prefix);
+
+	if (!prepare_log_message(index_file)) {
+		run_status(stdout, index_file);
+		unlink(commit_editmsg);
+		return 1;
+	}
+
+	determine_author(&name, &email);
+
+	if (!no_edit)
+		launch_editor(commit_editmsg, &buffer, &len);
+
+	if (!no_verify && !stat(git_path("hooks/pre-commit"), &statbuf) &&
+	    (statbuf.st_mode & S_IFMT) =3D=3D=20
+				) {
+	=09
+	}
+
+	if (commit_locked_index(&lk))
+		die("failed to write new index");
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index da4834c..7f395da 100644
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
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefi=
x);
diff --git a/cache.h b/cache.h
index 5e7381e..0403ada 100644
--- a/cache.h
+++ b/cache.h
@@ -245,7 +245,8 @@ extern int ie_match_stat(struct index_state *, stru=
ct cache_entry *, struct stat
 extern int ie_modified(struct index_state *, struct cache_entry *, str=
uct stat *, int);
 extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
-extern int read_pipe(int fd, char** return_buf, unsigned long* return_=
size);
+extern int read_fd(int fd, char** return_buf, unsigned long* return_si=
ze);
+extern int read_path(const char *path, char** return_buf, unsigned lon=
g* return_size);
 extern int index_pipe(unsigned char *sha1, int fd, const char *type, i=
nt write_object);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *=
st);
diff --git a/color.c b/color.c
index 09d82ee..124ba33 100644
--- a/color.c
+++ b/color.c
@@ -135,39 +135,39 @@ int git_config_colorbool(const char *var, const c=
har *value)
 	return git_config_bool(var, value);
 }
=20
-static int color_vprintf(const char *color, const char *fmt,
+static int color_vfprintf(FILE *fp, const char *color, const char *fmt=
,
 		va_list args, const char *trail)
 {
 	int r =3D 0;
=20
 	if (*color)
-		r +=3D printf("%s", color);
-	r +=3D vprintf(fmt, args);
+		r +=3D fprintf(fp, "%s", color);
+	r +=3D vfprintf(fp, fmt, args);
 	if (*color)
-		r +=3D printf("%s", COLOR_RESET);
+		r +=3D fprintf(fp, "%s", COLOR_RESET);
 	if (trail)
-		r +=3D printf("%s", trail);
+		r +=3D fprintf(fp, "%s", trail);
 	return r;
 }
=20
=20
=20
-int color_printf(const char *color, const char *fmt, ...)
+int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 {
 	va_list args;
 	int r;
 	va_start(args, fmt);
-	r =3D color_vprintf(color, fmt, args, NULL);
+	r =3D color_vfprintf(fp, color, fmt, args, NULL);
 	va_end(args);
 	return r;
 }
=20
-int color_printf_ln(const char *color, const char *fmt, ...)
+int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...=
)
 {
 	va_list args;
 	int r;
 	va_start(args, fmt);
-	r =3D color_vprintf(color, fmt, args, "\n");
+	r =3D color_vfprintf(fp, color, fmt, args, "\n");
 	va_end(args);
 	return r;
 }
diff --git a/color.h b/color.h
index 88bb8ff..6809800 100644
--- a/color.h
+++ b/color.h
@@ -6,7 +6,7 @@
=20
 int git_config_colorbool(const char *var, const char *value);
 void color_parse(const char *var, const char *value, char *dst);
-int color_printf(const char *color, const char *fmt, ...);
-int color_printf_ln(const char *color, const char *fmt, ...);
+int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
+int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...=
);
=20
 #endif /* COLOR_H */
diff --git a/git.c b/git.c
index 29b55a1..4018e3c 100644
--- a/git.c
+++ b/git.c
@@ -237,6 +237,7 @@ static void handle_internal_command(int argc, const=
 char **argv, char **envp)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NOT_BARE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NOT_BARE },
+		{ "commit", cmd_commit, RUN_SETUP },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
@@ -279,10 +280,10 @@ static void handle_internal_command(int argc, con=
st char **argv, char **envp)
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "revert", cmd_revert, RUN_SETUP | NOT_BARE },
 		{ "rm", cmd_rm, RUN_SETUP | NOT_BARE },
-		{ "runstatus", cmd_runstatus, RUN_SETUP | NOT_BARE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "status", cmd_status, RUN_SETUP | NOT_BARE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
diff --git a/mktag.c b/mktag.c
index b82e377..26b9ebf 100644
--- a/mktag.c
+++ b/mktag.c
@@ -111,8 +111,8 @@ static int verify_tag(char *buffer, unsigned long s=
ize)
=20
 int main(int argc, char **argv)
 {
-	unsigned long size =3D 4096;
-	char *buffer =3D xmalloc(size);
+	unsigned long size;
+	char *buffer;
 	unsigned char result_sha1[20];
=20
 	if (argc !=3D 1)
@@ -120,10 +120,8 @@ int main(int argc, char **argv)
=20
 	setup_git_directory();
=20
-	if (read_pipe(0, &buffer, &size)) {
-		free(buffer);
+	if (read_fd(0, &buffer, &size))
 		die("could not read from stdin");
-	}
=20
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
diff --git a/sha1_file.c b/sha1_file.c
index 2b86086..91e8854 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2286,18 +2286,17 @@ int has_sha1_file(const unsigned char *sha1)
 }
=20
 /*
- * reads from fd as long as possible into a supplied buffer of size by=
tes.
- * If necessary the buffer's size is increased using realloc()
+ * reads from fd as long as possible and allocates a buffer to hold
+ * the contents.  The buffer and size of the contents is returned in
+ * *return_buf and *return_size.  In case of failure, the allocated
+ * buffers are freed, otherwise, the buffer must be freed using xfree.
  *
  * returns 0 if anything went fine and -1 otherwise
- *
- * NOTE: both buf and size may change, but even when -1 is returned
- * you still have to free() it yourself.
  */
-int read_pipe(int fd, char** return_buf, unsigned long* return_size)
+int read_fd(int fd, char** return_buf, unsigned long* return_size)
 {
-	char* buf =3D *return_buf;
-	unsigned long size =3D *return_size;
+	unsigned long size =3D 4096;
+	char* buf =3D xmalloc(size);
 	ssize_t iret;
 	unsigned long off =3D 0;
=20
@@ -2315,21 +2314,38 @@ int read_pipe(int fd, char** return_buf, unsign=
ed long* return_size)
 	*return_buf =3D buf;
 	*return_size =3D off;
=20
-	if (iret < 0)
+	if (iret < 0) {
+		free(buf);
+		return -1;
+	}
+
+	return 0;
+}
+
+int read_path(const char *path, char** return_buf, unsigned long* retu=
rn_size)
+{
+	int fd;=20
+
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	if (read_fd(fd, return_buf, return_size)) {
+		close(fd);
 		return -1;
+	}
+	close(fd);
+
 	return 0;
 }
=20
 int index_pipe(unsigned char *sha1, int fd, const char *type, int writ=
e_object)
 {
-	unsigned long size =3D 4096;
-	char *buf =3D xmalloc(size);
+	unsigned long size;
+	char *buf;
 	int ret;
=20
-	if (read_pipe(fd, &buf, &size)) {
-		free(buf);
+	if (read_fd(fd, &buf, &size))
 		return -1;
-	}
=20
 	if (!type)
 		type =3D blob_type;
diff --git a/wt-status.c b/wt-status.c
index 5205420..463ecd7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -54,29 +54,30 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference =3D "HEAD";
 }
=20
-static void wt_status_print_cached_header(const char *reference)
+static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# Changes to be committed:");
-	if (reference) {
-		color_printf_ln(c, "#   (use \"git reset %s <file>...\" to unstage)"=
, reference);
+	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	if (s->reference) {
+		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
 	} else {
-		color_printf_ln(c, "#   (use \"git rm --cached <file>...\" to unstag=
e)");
+		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
 	}
-	color_printf_ln(c, "#");
+	color_fprintf_ln(s->fp, c, "#");
 }
=20
-static void wt_status_print_header(const char *main, const char *sub)
+static void wt_status_print_header(struct wt_status *s,
+				   const char *main, const char *sub)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# %s:", main);
-	color_printf_ln(c, "#   (%s)", sub);
-	color_printf_ln(c, "#");
+	color_fprintf_ln(s->fp, c, "# %s:", main);
+	color_fprintf_ln(s->fp, c, "#   (%s)", sub);
+	color_fprintf_ln(s->fp, c, "#");
 }
=20
-static void wt_status_print_trailer(void)
+static void wt_status_print_trailer(struct wt_status *s)
 {
-	color_printf_ln(color(WT_STATUS_HEADER), "#");
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
=20
 static const char *quote_crlf(const char *in, char *buf, size_t sz)
@@ -108,7 +109,8 @@ static const char *quote_crlf(const char *in, char =
*buf, size_t sz)
 	return ret;
 }
=20
-static void wt_status_print_filepair(int t, struct diff_filepair *p)
+static void wt_status_print_filepair(struct wt_status *s,
+				     int t, struct diff_filepair *p)
 {
 	const char *c =3D color(t);
 	const char *one, *two;
@@ -117,36 +119,36 @@ static void wt_status_print_filepair(int t, struc=
t diff_filepair *p)
 	one =3D quote_crlf(p->one->path, onebuf, sizeof(onebuf));
 	two =3D quote_crlf(p->two->path, twobuf, sizeof(twobuf));
=20
-	color_printf(color(WT_STATUS_HEADER), "#\t");
+	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 	switch (p->status) {
 	case DIFF_STATUS_ADDED:
-		color_printf(c, "new file:   %s", one);
+		color_fprintf(s->fp, c, "new file:   %s", one);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_printf(c, "copied:     %s -> %s", one, two);
+		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_printf(c, "deleted:    %s", one);
+		color_fprintf(s->fp, c, "deleted:    %s", one);
 		break;
 	case DIFF_STATUS_MODIFIED:
-		color_printf(c, "modified:   %s", one);
+		color_fprintf(s->fp, c, "modified:   %s", one);
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_printf(c, "renamed:    %s -> %s", one, two);
+		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		color_printf(c, "typechange: %s", one);
+		color_fprintf(s->fp, c, "typechange: %s", one);
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		color_printf(c, "unknown:    %s", one);
+		color_fprintf(s->fp, c, "unknown:    %s", one);
 		break;
 	case DIFF_STATUS_UNMERGED:
-		color_printf(c, "unmerged:   %s", one);
+		color_fprintf(s->fp, c, "unmerged:   %s", one);
 		break;
 	default:
 		die("bug: unhandled diff status %c", p->status);
 	}
-	printf("\n");
+	fprintf(s->fp, "\n");
 }
=20
 static void wt_status_print_updated_cb(struct diff_queue_struct *q,
@@ -160,14 +162,14 @@ static void wt_status_print_updated_cb(struct dif=
f_queue_struct *q,
 		if (q->queue[i]->status =3D=3D 'U')
 			continue;
 		if (!shown_header) {
-			wt_status_print_cached_header(s->reference);
+			wt_status_print_cached_header(s);
 			s->commitable =3D 1;
 			shown_header =3D 1;
 		}
-		wt_status_print_filepair(WT_STATUS_UPDATED, q->queue[i]);
+		wt_status_print_filepair(s, WT_STATUS_UPDATED, q->queue[i]);
 	}
 	if (shown_header)
-		wt_status_print_trailer();
+		wt_status_print_trailer(s);
 }
=20
 static void wt_status_print_changed_cb(struct diff_queue_struct *q,
@@ -184,18 +186,18 @@ static void wt_status_print_changed_cb(struct dif=
f_queue_struct *q,
 				msg =3D use_add_rm_msg;
 				break;
 			}
-		wt_status_print_header("Changed but not updated", msg);
+		wt_status_print_header(s, "Changed but not updated", msg);
 	}
 	for (i =3D 0; i < q->nr; i++)
-		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
+		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
 	if (q->nr)
-		wt_status_print_trailer();
+		wt_status_print_trailer(s);
 }
=20
 static void wt_read_cache(struct wt_status *s)
 {
 	discard_cache();
-	read_cache();
+	read_cache_from(s->index_file);
 }
=20
 static void wt_status_print_initial(struct wt_status *s)
@@ -209,13 +211,13 @@ static void wt_status_print_initial(struct wt_sta=
tus *s)
 		wt_status_print_cached_header(NULL);
 	}
 	for (i =3D 0; i < active_nr; i++) {
-		color_printf(color(WT_STATUS_HEADER), "#\t");
-		color_printf_ln(color(WT_STATUS_UPDATED), "new file: %s",
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_UPDATED), "new file: %s",
 				quote_crlf(active_cache[i]->name,
 					   buf, sizeof(buf)));
 	}
 	if (active_nr)
-		wt_status_print_trailer();
+		wt_status_print_trailer(s);
 }
=20
 static void wt_status_print_updated(struct wt_status *s)
@@ -281,12 +283,12 @@ static void wt_status_print_untracked(struct wt_s=
tatus *s)
 		}
 		if (!shown_header) {
 			s->workdir_untracked =3D 1;
-			wt_status_print_header("Untracked files",
+			wt_status_print_header(s, "Untracked files",
 					       use_add_to_include_msg);
 			shown_header =3D 1;
 		}
-		color_printf(color(WT_STATUS_HEADER), "#\t");
-		color_printf_ln(color(WT_STATUS_UNTRACKED), "%.*s",
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%.*s",
 				ent->len, ent->name);
 	}
 }
@@ -316,14 +318,14 @@ void wt_status_print(struct wt_status *s)
 			branch_name =3D "";
 			on_what =3D "Not currently on any branch.";
 		}
-		color_printf_ln(color(WT_STATUS_HEADER),
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
 			"# %s%s", on_what, branch_name);
 	}
=20
 	if (s->is_initial) {
-		color_printf_ln(color(WT_STATUS_HEADER), "#");
-		color_printf_ln(color(WT_STATUS_HEADER), "# Initial commit");
-		color_printf_ln(color(WT_STATUS_HEADER), "#");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit")=
;
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		wt_status_print_initial(s);
 	}
 	else {
@@ -337,7 +339,7 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
-			printf("# No changes\n");
+			fprintf(s->fp, "# No changes\n");
 		else if (s->workdir_dirty)
 			printf("no changes added to commit (use \"git add\" and/or \"git co=
mmit -a\")\n");
 		else if (s->workdir_untracked)
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..7744932 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -1,6 +1,8 @@
 #ifndef STATUS_H
 #define STATUS_H
=20
+#include <stdio.h>
+
 enum color_wt_status {
 	WT_STATUS_HEADER,
 	WT_STATUS_UPDATED,
@@ -19,6 +21,8 @@ struct wt_status {
 	int commitable;
 	int workdir_dirty;
 	int workdir_untracked;
+	const char *index_file;
+	FILE *fp;
 };
=20
 int git_status_config(const char *var, const char *value);
--=20
1.5.2.2
