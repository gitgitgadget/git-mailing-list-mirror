From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Implement git commit as a builtin.
Date: Wed, 18 Jul 2007 15:19:39 -0400
Message-ID: <11847863792344-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 21:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBF7I-0003zl-0D
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 21:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbXGRTXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 15:23:12 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbXGRTXL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 15:23:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbXGRTXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 15:23:07 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6IJN2oP003506
	for <git@vger.kernel.org>; Wed, 18 Jul 2007 15:23:04 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6IJN1rF026454;
	Wed, 18 Jul 2007 15:23:01 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6IJN09i020817;
	Wed, 18 Jul 2007 15:23:00 -0400
X-Mailer: git-send-email 1.5.2.1.160.g3463d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52892>

---
Here's another update on the work in progress.  At this point, the C
version is almost complete, there's only a few issues left (look for
=46IXME in builtin-commit.c).  I've added a commit test case which shou=
ld
be split out in a patch on its own, but the good news is that it
successfully exercises most of the command line options and the C versi=
on
passes.

My plan for the remainder of the work is still to wrap up the last few
pieces of functionality and then start taking this big patch apart in a
number of more manageable pieces.  However, the bulk of this work will
still be a big patch that removes git-commit.sh and adds builtin-commit
in one swoop.

Kristian


 Makefile              |    9 +-
 builtin-add.c         |   14 +-
 builtin-commit-tree.c |  120 +++++---
 builtin-commit.c      |  746 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h             |    3 +-
 cache.h               |    3 +-
 color.c               |   18 +-
 color.h               |    4 +-
 commit.h              |    9 +
 git-commit.sh         |  658 -----------------------------------------=
--
 git.c                 |    3 +-
 mktag.c               |    8 +-
 sha1_file.c           |   44 ++-
 t/t7800-commit.sh     |  126 +++++++++
 wt-status.c           |   86 +++---
 wt-status.h           |    4 +
 16 files changed, 1066 insertions(+), 789 deletions(-)
 create mode 100644 builtin-commit.c
 delete mode 100755 git-commit.sh
 create mode 100644 t/t7800-commit.sh

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
diff --git a/builtin-add.c b/builtin-add.c
index 1591171..bcd796d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -8,6 +8,7 @@
 #include "dir.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
+#include "run-command.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "commit.h"
@@ -148,6 +149,13 @@ static int git_add_config(const char *var, const c=
har *value)
 	return git_default_config(var, value);
 }
=20
+int interactive_add(void)
+{
+	const char *argv[2] =3D { "add--interactive", NULL };
+
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
 static struct lock_file lock_file;
=20
 static const char ignore_warning[] =3D
@@ -167,11 +175,9 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 			add_interactive++;
 	}
 	if (add_interactive) {
-		const char *args[] =3D { "add--interactive", NULL };
-
-		if (add_interactive !=3D 1 || argc !=3D 2)
+		if (argc !=3D 2)
 			die("add --interactive does not take any parameters");
-		execv_git_cmd(args);
+		interactive_add();
 		exit(1);
 	}
=20
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index ccbcbe3..bb20470 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -20,17 +20,11 @@ static void init_buffer(char **bufp, unsigned int *=
sizep)
 	*sizep =3D 0;
 }
=20
-static void add_buffer(char **bufp, unsigned int *sizep, const char *f=
mt, ...)
+static void add_chunk(char **bufp, unsigned int *sizep, const char *da=
ta, int len)
 {
-	char one_line[2048];
-	va_list args;
-	int len;
 	unsigned long alloc, size, newsize;
 	char *buf;
=20
-	va_start(args, fmt);
-	len =3D vsnprintf(one_line, sizeof(one_line), fmt, args);
-	va_end(args);
 	size =3D *sizep;
 	newsize =3D size + len + 1;
 	alloc =3D (size + 32767) & ~32767;
@@ -41,7 +35,19 @@ static void add_buffer(char **bufp, unsigned int *si=
zep, const char *fmt, ...)
 		*bufp =3D buf;
 	}
 	*sizep =3D newsize - 1;
-	memcpy(buf + size, one_line, len);
+	memcpy(buf + size, data, len);
+}
+
+static void add_buffer(char **bufp, unsigned int *sizep, const char *f=
mt, ...)
+{
+	char one_line[2048];
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len =3D vsnprintf(one_line, sizeof(one_line), fmt, args);
+	va_end(args);
+	add_chunk(bufp, sizep, one_line, len);
 }
=20
 static void check_valid(unsigned char *sha1, enum object_type expect)
@@ -81,39 +87,16 @@ static const char commit_utf8_warn[] =3D
 "You may want to amend it after fixing the message, or set the config\=
n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
=20
-int cmd_commit_tree(int argc, const char **argv, const char *prefix)
+const unsigned char *
+create_commit(const unsigned char *tree_sha1,
+	      unsigned char parent_sha1[][20], int parents,
+	      const char *author_info, const char *committer_info,
+	      const char *message, int length)
 {
-	int i;
-	int parents =3D 0;
-	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
-	char comment[1000];
+	static unsigned char commit_sha1[20];
+	int encoding_is_utf8, i;
 	char *buffer;
 	unsigned int size;
-	int encoding_is_utf8;
-
-	git_config(git_default_config);
-
-	if (argc < 2)
-		usage(commit_tree_usage);
-	if (get_sha1(argv[1], tree_sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	check_valid(tree_sha1, OBJ_TREE);
-	for (i =3D 2; i < argc; i +=3D 2) {
-		const char *a, *b;
-		a =3D argv[i]; b =3D argv[i+1];
-		if (!b || strcmp(a, "-p"))
-			usage(commit_tree_usage);
-
-		if (parents >=3D MAXPARENT)
-			die("Too many parents (%d max)", MAXPARENT);
-		if (get_sha1(b, parent_sha1[parents]))
-			die("Not a valid object name %s", b);
-		check_valid(parent_sha1[parents], OBJ_COMMIT);
-		if (new_parent(parents))
-			parents++;
-	}
=20
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
@@ -130,26 +113,71 @@ int cmd_commit_tree(int argc, const char **argv, =
const char *prefix)
 		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]=
));
=20
 	/* Person/date information */
-	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
-	add_buffer(&buffer, &size, "committer %s\n", git_committer_info(1));
+	add_buffer(&buffer, &size, "author %s\n", author_info);
+	add_buffer(&buffer, &size, "committer %s\n", committer_info);
 	if (!encoding_is_utf8)
 		add_buffer(&buffer, &size,
 				"encoding %s\n", git_commit_encoding);
 	add_buffer(&buffer, &size, "\n");
=20
 	/* And add the comment */
-	while (fgets(comment, sizeof(comment), stdin) !=3D NULL)
-		add_buffer(&buffer, &size, "%s", comment);
+	add_chunk(&buffer, &size, message, length);
=20
 	/* And check the encoding */
 	buffer[size] =3D '\0';
 	if (encoding_is_utf8 && !is_utf8(buffer))
 		fprintf(stderr, commit_utf8_warn);
=20
-	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
-		printf("%s\n", sha1_to_hex(commit_sha1));
-		return 0;
+	if (!write_sha1_file(buffer, size, commit_type, commit_sha1))
+		return commit_sha1;
+
+	return NULL;
+}
+
+int cmd_commit_tree(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	int parents =3D 0;
+	unsigned char tree_sha1[20];
+	char *buffer;
+	const unsigned char *commit_sha1;
+	unsigned long length;
+
+	git_config(git_default_config);
+
+	if (argc < 2)
+		usage(commit_tree_usage);
+	if (get_sha1(argv[1], tree_sha1))
+		die("Not a valid object name %s", argv[1]);
+
+	check_valid(tree_sha1, OBJ_TREE);
+	for (i =3D 2; i < argc; i +=3D 2) {
+		const char *a, *b;
+		a =3D argv[i]; b =3D argv[i+1];
+		if (!b || strcmp(a, "-p"))
+			usage(commit_tree_usage);
+
+		if (parents >=3D MAXPARENT)
+			die("Too many parents (%d max)", MAXPARENT);
+		if (get_sha1(b, parent_sha1[parents]))
+			die("Not a valid object name %s", b);
+		check_valid(parent_sha1[parents], OBJ_COMMIT);
+		if (new_parent(parents))
+			parents++;
 	}
-	else
+
+	if (read_fd(0, &buffer, &length))
+		die("Could not read commit message from standard input");
+
+	commit_sha1 =3D create_commit(tree_sha1,
+				    parent_sha1, parents,
+				    git_author_info(1),	   =20
+				    git_committer_info(1),	   =20
+				    buffer, length);
+
+	if (!commit_sha1)
 		return 1;
+
+	printf("%s\n", sha1_to_hex(commit_sha1));
+	return 0;
 }
diff --git a/builtin-commit.c b/builtin-commit.c
new file mode 100644
index 0000000..198d5af
--- /dev/null
+++ b/builtin-commit.c
@@ -0,0 +1,746 @@
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
+
+static const char builtin_commit_usage[] =3D
+	"[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <log=
file> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i =
| -o] <path>...]";
+
+static unsigned char head_sha1[20], merge_head_sha1[20];
+static struct commit *use_message_commit;
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
+static char *logfile, *force_author, *message;
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
+	{ OPTION_NONE, "quiet", 'q', &quiet },
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
+	char *buffer =3D NULL;
+	struct stat statbuf;
+	int commitable;
+	unsigned long len;
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
+		/* FIXME: encoding */
+		buffer =3D strstr(use_message_commit->buffer, "\n\n");
+		if (!buffer || buffer[2] =3D=3D '\0')
+			die("commit has empty message");
+		buffer +=3D 2;
+		len =3D strlen(buffer);
+	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
+		if (read_path(git_path("MERGE_MSG"), &buffer, &len))
+			die("could not read MERGE_MSG: %s", strerror(errno));
+	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
+		if (read_path(git_path("SQUASH_MSG"), &buffer, &len))
+			die("could not read SQUASH_MSG: %s", strerror(errno));
+	}
+
+	fp =3D fopen(git_path(commit_editmsg), "w");
+	if (fp =3D=3D NULL)
+		die("could not open %s\n", git_path(commit_editmsg));
+	=09
+	if (buffer) {
+		len =3D strip_lines(buffer, len);
+
+		if (fwrite(buffer, 1, len, fp) < len)
+			die("could not write commit template: %s\n",
+			    strerror(errno));
+	}
+
+	if (signoff) {
+		const char *info, *bol;
+
+		info =3D git_committer_info(1);
+		if (buffer) {
+			bol =3D strrchr(buffer + len - 1, '\n');
+			if (!bol || prefixcmp(bol, sign_off_header))
+				fprintf(fp, "\n");
+		}
+		fprintf(fp, "Signed-off-by: %s\n", git_committer_info(1));
+	}
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
+struct commit_info_strings {
+	const char *header, *name_env, *email_env, *date_env;
+} author_info_strings =3D {
+	"\nauthor ",
+	"GIT_AUTHOR_NAME", "GIT_AUTHOR_EMAIL", "GIT_AUTHOR_DATE"
+}, committer_info_strings =3D {
+	"\ncommitter ",
+	"GIT_COMMITTER_NAME", "GIT_COMMITER_EMAIL", "GIT_COMMITTER_DATE"
+};
+
+static char *determine_info(struct commit_info_strings *strings)
+{
+	char *p, *eol;
+	char *name =3D NULL, *email =3D NULL, *date =3D NULL;
+
+	if (use_message) {
+		p =3D strstr(use_message_commit->buffer, strings->header);
+		if (!p)
+			die("invalid commit: %s\n", use_message);
+		p +=3D strlen(strings->header);
+		eol =3D strchr(p, '\n');
+		if (!eol)
+			die("invalid commit: %s\n", use_message);
+
+		return xstrndup(p, eol - p);
+	} else if (force_author && strings =3D=3D &author_info_strings) {
+		const char *eoname =3D strstr(force_author, " <");
+		const char *eomail =3D strchr(force_author, '>');
+
+		if (!eoname || !eomail)
+			die("malformed --author parameter\n");
+		name =3D xstrndup(force_author, eoname - force_author);
+		email =3D xstrndup(eoname + 2, eomail - eoname - 2);
+	}
+
+	if (name =3D=3D NULL)
+		name =3D getenv(strings->name_env);
+	if (email =3D=3D NULL)
+		email =3D getenv(strings->email_env);
+	if (date =3D=3D NULL)
+		date =3D getenv(strings->date_env);
+
+	return xstrdup(fmt_ident(name, email, date, 1));
+}
+
+static void parse_and_validate_options(const char ***argv)
+{
+	int f =3D 0;
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
+	if (amend)
+		f++;
+	if (f > 1)
+		die("Only one of -c/-C/-F/--amend can be used.");
+	if (message && f > 0)
+		die("Option -m cannot be combined with -c/-C/-F/--amend.");
+	if (edit_message)
+		use_message =3D edit_message;
+	if (amend)
+		use_message =3D "HEAD";
+	if (use_message) {
+		unsigned char sha1[20];
+
+		if (get_sha1(use_message, sha1))
+			die("could not lookup commit %s", use_message);
+		use_message_commit =3D lookup_commit(sha1);
+		if (!use_message_commit || parse_commit(use_message_commit))
+			die("could not parse commit %s", use_message);
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
+static void launch_editor(const char *path)
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
+}
+
+static int message_is_empty(const char *buffer, int len)
+{
+	static const char signed_off_by[] =3D "Signed-off-by: ";
+	const char *nl;
+	int eol, i;
+
+	for (i =3D 0; i < len; i++) {
+		nl =3D memchr(buffer + i, '\n', len - i);
+		if (nl)
+			eol =3D nl - buffer;
+		else
+			eol =3D len;
+
+		if (strlen(signed_off_by) <=3D eol - i &&
+		    !prefixcmp(buffer + i, signed_off_by)) {
+			i =3D eol;
+			continue;
+		}
+		while (i < eol)
+			if (!isspace(buffer[i++]))
+			    return 0;
+	}
+
+	return 1;
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
+#define MAXPARENT (16)
+static unsigned char parent_sha1[MAXPARENT][20];
+
+int cmd_commit(int argc, const char **argv, const char *prefix)
+{
+	int parent_count =3D 0;
+	unsigned long len;
+	char *buffer;
+	const char *index_file, *reflog_msg;
+	const unsigned char *commit_sha1;
+	struct ref_lock *ref_lock;
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
+	if (!no_edit)
+		launch_editor(git_path(commit_editmsg));
+
+	if (run_hook(index_file, "commit-msg", commit_editmsg))
+		exit(1);
+
+	if (read_path(git_path(commit_editmsg), &buffer, &len))
+		die("could not read commit message file '%s': %s",
+		    git_path(commit_editmsg), strerror(errno));
+
+	len =3D strip_lines(buffer, len);
+
+	if (message_is_empty(buffer, len))
+		die("* no commit message?  aborting commit.");
+
+	/* Determine parents */
+	if (initial_commit) {
+		reflog_msg =3D "commit (initial)";=20
+		parent_count =3D 0;
+	} else if (amend) {
+		struct commit_list *c;
+		struct commit *commit;
+		int i =3D 0;
+
+		reflog_msg =3D "commit (amend)";
+		commit =3D lookup_commit(head_sha1);
+		if (!commit || parse_commit(commit))
+			die("could not parse HEAD commit");
+
+		for (c =3D commit->parents; c; c =3D c->next) {
+			hashcpy(parent_sha1[i++], c->item->object.sha1);
+			if (i =3D=3D MAXPARENT)
+				die("Too many parents (%d max)", MAXPARENT);
+		}
+		parent_count =3D i;
+	} else if (in_merge) {
+		/* FIXME: how are merges with more than two parents handled? */
+		reflog_msg =3D "commit (merge)";
+		hashcpy(parent_sha1[0], head_sha1);
+		hashcpy(parent_sha1[1], merge_head_sha1);
+		parent_count =3D 2;
+	} else {
+		reflog_msg =3D "commit";
+		hashcpy(parent_sha1[0], head_sha1);
+		parent_count =3D 1;
+	}
+
+	read_cache_from(index_file);
+	active_cache_tree =3D cache_tree();
+	if (cache_tree_update(active_cache_tree,
+			      active_cache, active_nr, 0, 0) < 0)
+		die("Error building trees");
+
+	commit_sha1 =3D create_commit(active_cache_tree->sha1,
+				    parent_sha1, parent_count,
+				    determine_info(&author_info_strings),
+				    determine_info(&committer_info_strings),
+				    buffer, len);
+		      =20
+	ref_lock =3D lock_any_ref_for_update("HEAD",
+					   initial_commit ? NULL : head_sha1,
+					   0);
+	if (!ref_lock)
+		die("cannot lock HEAD ref");
+	if (write_ref_sha1(ref_lock, commit_sha1, reflog_msg) < 0)
+		die("cannot update HEAD ref");
+
+	unlink(git_path("MERGE_HEAD"));
+	unlink(git_path("MERGE_MSG"));
+
+	if (lock_file.filename[0] && commit_locked_index(&lock_file))
+		die("failed to write new index");
+
+	/*
+	 * FIXME:
+	 *	if test -d "$GIT_DIR/rr-cache"
+	 *	then
+	 *		git-rerere
+	 *	fi
+	 */
+
+	run_hook(index_file, "post-commit", NULL);
+
+	if (!quiet)
+		print_summary(prefix, commit_sha1);
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
diff --git a/commit.h b/commit.h
index a313b53..a07e379 100644
--- a/commit.h
+++ b/commit.h
@@ -122,4 +122,13 @@ extern struct commit_list *get_shallow_commits(str=
uct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
=20
 int in_merge_bases(struct commit *, struct commit **, int);
+
+const unsigned char *
+create_commit(const unsigned char *tree_sha1,
+	      unsigned char parent_sha1[][20], int parents,
+	      const char *author_info, const char *committer_info,
+	      const char *message, int length);
+
+int interactive_add(void);
+
 #endif /* COMMIT_H */
diff --git a/git-commit.sh b/git-commit.sh
deleted file mode 100755
index 5547a02..0000000
--- a/git-commit.sh
+++ /dev/null
@@ -1,658 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-# Copyright (c) 2006 Junio C Hamano
-
-USAGE=3D'[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | =
-F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>=
] [[-i | -o] <path>...]'
-SUBDIRECTORY_OK=3DYes
-. git-sh-setup
-require_work_tree
-
-git-rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=3Dt
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
-	git-runstatus ${color} \
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
-		log_given=3Dt$log_given
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
-	die "Only one of -c/-C/-F/--amend can be used." ;;
-*tm*|*mt*)
-	die "Option -m cannot be combined with -c/-C/-F/--amend." ;;
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
-		git-diff-files --name-only -z |
-		git-update-index --remove -z --stdin
-	) || exit
-	;;
-,t)
-	save_index &&
-	git-ls-files --error-unmatch -- "$@" >/dev/null || exit
-
-	git-diff-files --name-only -z -- "$@"  |
-	(
-		cd_to_toplevel &&
-		GIT_INDEX_FILE=3D"$NEXT_INDEX" &&
-		export GIT_INDEX_FILE &&
-		git-update-index --remove -z --stdin
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
-		commit_only=3D`git-ls-files --error-unmatch -- "$@"` || exit
-
-		# Build a temporary index and update the real index
-		# the same way.
-		if test -z "$initial_commit"
-		then
-			GIT_INDEX_FILE=3D"$THIS_INDEX" \
-			git-read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD
-		else
-			rm -f "$TMP_INDEX"
-		fi || exit
-
-		printf '%s\n' "$commit_only" |
-		GIT_INDEX_FILE=3D"$TMP_INDEX" \
-		git-update-index --add --remove --stdin &&
-
-		save_index &&
-		printf '%s\n' "$commit_only" |
-		(
-			GIT_INDEX_FILE=3D"$NEXT_INDEX"
-			export GIT_INDEX_FILE
-			git-update-index --remove --stdin
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
-	GIT_INDEX_FILE=3D"$USE_INDEX" git-update-index -q --unmerged --refres=
h
-	run_status
-	exit $?
-	;;
-'')
-	GIT_INDEX_FILE=3D"$USE_INDEX" git-update-index -q --refresh || exit
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
-fi | git-stripspace >"$GIT_DIR"/COMMIT_EDITMSG
-
-case "$signoff" in
-t)
-	need_blank_before_signoff=3D
-	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
-	grep 'Signed-off-by:' >/dev/null || need_blank_before_signoff=3Dyes
-	{
-		test -z "$need_blank_before_signoff" || echo
-		git-var GIT_COMMITTER_IDENT | sed -e '
-			s/>.*/>/
-			s/^/Signed-off-by: /
-		'
-	} >>"$GIT_DIR"/COMMIT_EDITMSG
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
-	pick_author_script=3D'
-	/^author /{
-		s/'\''/'\''\\'\'\''/g
-		h
-		s/^author \([^<]*\) <[^>]*> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p
-
-		g
-		s/^author [^<]* <\([^>]*\)> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_EMAIL=3D'\''&'\''/p
-
-		g
-		s/^author [^<]* <[^>]*> \(.*\)$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_DATE=3D'\''&'\''/p
-
-		q
-	}
-	'
-	encoding=3D$(git config i18n.commitencoding || echo UTF-8)
-	set_author_env=3D`git show -s --pretty=3Draw --encoding=3D"$encoding"=
 "$use_commit" |
-	LANG=3DC LC_ALL=3DC sed -ne "$pick_author_script"`
-	eval "$set_author_env"
-	export GIT_AUTHOR_NAME
-	export GIT_AUTHOR_EMAIL
-	export GIT_AUTHOR_DATE
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
-		PARENTS=3D$(git-cat-file commit HEAD |
-			sed -n -e '/^$/q' -e 's/^parent /-p /p')
-	fi
-	current=3D"$(git-rev-parse --verify HEAD)"
-else
-	if [ -z "$(git-ls-files)" ]; then
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
-	case "${VISUAL:-$EDITOR},$TERM" in
-	,dumb)
-		echo >&2 "Terminal is dumb but no VISUAL nor EDITOR defined."
-		echo >&2 "Please supply the commit log message using either"
-		echo >&2 "-m or -F option.  A boilerplate log message has"
-		echo >&2 "been prepared in $GIT_DIR/COMMIT_EDITMSG"
-		exit 1
-		;;
-	esac
-	git-var GIT_AUTHOR_IDENT > /dev/null  || die
-	git-var GIT_COMMITTER_IDENT > /dev/null  || die
-	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
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
-git-stripspace >"$GIT_DIR"/COMMIT_MSG
-
-if cnt=3D`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
-	git-stripspace |
-	wc -l` &&
-   test 0 -lt $cnt
-then
-	if test -z "$TMP_INDEX"
-	then
-		tree=3D$(GIT_INDEX_FILE=3D"$USE_INDEX" git-write-tree)
-	else
-		tree=3D$(GIT_INDEX_FILE=3D"$TMP_INDEX" git-write-tree) &&
-		rm -f "$TMP_INDEX"
-	fi &&
-	commit=3D$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS=
) &&
-	rlogm=3D$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
-	git-update-ref -m "$GIT_REFLOG_ACTION: $rlogm" HEAD $commit "$current=
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
-if test -d "$GIT_DIR/rr-cache"
-then
-	git-rerere
-fi
-
-if test "$ret" =3D 0
-then
-	if test -x "$GIT_DIR"/hooks/post-commit
-	then
-		"$GIT_DIR"/hooks/post-commit
-	fi
-	if test -z "$quiet"
-	then
-		commit=3D`git-diff-tree --always --shortstat --pretty=3D"format:%h: =
%s"\
-		       --summary --root HEAD --`
-		echo "Created${initial_commit:+ initial} commit $commit"
-	fi
-fi
-
-exit "$ret"
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
diff --git a/t/t7800-commit.sh b/t/t7800-commit.sh
new file mode 100644
index 0000000..1f97caa
--- /dev/null
+++ b/t/t7800-commit.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+#
+
+# FIXME: Test the various index usages, -i and -o, test reflog,
+# signoff, hooks
+
+test_description=3D'git-commit'
+. ./test-lib.sh
+
+# Pick a date so we get consistent commits. 7/7/07 means good luck!
+export GIT_AUTHOR_DATE=3D"July 7, 2007"
+export GIT_COMMITTER_DATE=3D"July 7, 2007"
+
+echo "bongo bongo" >file
+test_expect_success \
+	"initial status" \
+	"git-add file && \
+	 git-status | grep 'Initial commit'"
+
+test_expect_failure \
+	"fail initial amend" \
+	"git-commit -m initial --amend"
+
+test_expect_success \
+	"initial commit" \
+	"git-commit -m initial"
+
+test_expect_failure \
+	"testing nothing to commit" \
+	"git-commit -m initial"
+
+echo "bongo bongo bongo" >file
+
+test_expect_success \
+	"next commit" \
+	"git-commit -m next -a"
+
+echo "more bongo: bongo bongo bongo bongo" >file
+
+test_expect_failure \
+	"commit message from non-existing file" \
+	"git-commit -F gah -a"
+
+cat >msg <<EOF
+	=09
+
+ =20
+Signed-off-by: hula
+EOF
+test_expect_failure \
+	"empty commit message" \
+	"git-commit -F msg -a"
+
+echo "this is the commit message, coming from a file" >msg
+test_expect_success \
+	"commit message from file" \
+	"git-commit -F msg -a"
+
+cat >editor <<\EOF
+#!/bin/sh
+sed -i -e "s/a file/an amend commit/g" $1
+EOF
+chmod 755 editor
+
+test_expect_success \
+	"amend commit" \
+	"VISUAL=3D./editor git-commit --amend"
+
+echo "enough with the bongos" >file
+test_expect_failure \
+	"passing --amend and -F" \
+	"git-commit -F msg --amend ."
+
+test_expect_success \
+	"using message from other commit" \
+	"git-commit -C HEAD^ ."
+
+cat >editor <<\EOF
+#!/bin/sh
+sed -i -e "s/amend/older/g" $1
+EOF
+chmod 755 editor
+
+echo "hula hula" >file
+test_expect_success \
+	"editing message from other commit" \
+	"VISUAL=3D./editor git-commit -c HEAD^ -a"
+
+echo "silly new contents" >file
+test_expect_success \
+	"message from stdin" \
+	"echo commit message from stdin | git-commit -F - -a"
+
+echo "gak" >file
+test_expect_success \
+	"overriding author from command line" \
+	"git-commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
+
+test_expect_success \
+	"interactive add" \
+	"echo 7 | git-commit --interactive | grep 'What now'"
+
+test_expect_success \
+	"showing committed revisions" \
+	"git-rev-list HEAD >current"
+
+# We could just check the head sha1, but checking each commit makes it
+# easier to isolate bugs.
+
+cat >expected <<\EOF
+9a7ad90c32f43aecc081722a72f26ead981bd6fa
+d5c6c34f0361d64d3d1b1f26736b1ae98e2baa90
+ca0ddb06fc90f3f857dd623f8418804aad75d9fa
+9cc5d9b9e5a29f1c46d0d0cf2dd716fb8241316a
+ca750e97c137587aa181b6b9526b3b04fb9db667
+4515202a60be41cb1b8f6b89edb3f6948130ac1c
+7cc9a125522fe28b84cd3f6c7aeef6e5c62b3f8b
+EOF
+
+test_expect_success \
+    'validate git-rev-list output.' \
+    'diff current expected'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 5205420..5bf800a 100644
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
@@ -206,16 +208,16 @@ static void wt_status_print_initial(struct wt_sta=
tus *s)
 	wt_read_cache(s);
 	if (active_nr) {
 		s->commitable =3D 1;
-		wt_status_print_cached_header(NULL);
+		wt_status_print_cached_header(s);
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
1.5.2.GIT
