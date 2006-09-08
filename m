From: Jeff King <peff@peff.net>
Subject: [PATCH] git-commit.sh: convert run_status to a C builtin
Date: Fri, 8 Sep 2006 04:05:34 -0400
Message-ID: <20060908080534.GB3771@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:05:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLbMr-0001S8-LB
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWIHIFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWIHIFi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:05:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:33240 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750948AbWIHIFg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 04:05:36 -0400
Received: (qmail 3389 invoked from network); 8 Sep 2006 04:05:00 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Sep 2006 04:05:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  8 Sep 2006 04:05:34 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26682>

This creates a new git-runstatus which should do roughly the same thing
as the run_status function from git-commit.sh. Except for color support,
the main focus has been to keep the output identical, so that it can be
verified as correct and then used as a C platform for other improvements to
the status printing code.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a resend with:
 - formatting cleanups
 - s/status/wt_status/
 - avoid letting colored sections cross newlines

 .gitignore          |    1 
 Makefile            |    3 -
 builtin-runstatus.c |   34 ++++++
 builtin.h           |    1 
 dir.c               |    7 +
 dir.h               |    1 
 git-commit.sh       |  106 +-------------------
 git.c               |    1 
 wt-status.c         |  271 +++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h         |   24 +++++
 10 files changed, 349 insertions(+), 100 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78cb671..f014ad3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -94,6 +94,7 @@ git-rev-list
 git-rev-parse
 git-revert
 git-rm
+git-runstatus
 git-send-email
 git-send-pack
 git-sh-setup
diff --git a/Makefile b/Makefile
index 78748cb..a9314ac 100644
--- a/Makefile
+++ b/Makefile
@@ -252,7 +252,7 @@ LIB_OBJS = \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o
+	color.o wt-status.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -286,6 +286,7 @@ BUILTIN_OBJS = \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
 	builtin-rm.o \
+	builtin-runstatus.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
new file mode 100644
index 0000000..7979d61
--- /dev/null
+++ b/builtin-runstatus.c
@@ -0,0 +1,34 @@
+#include "wt-status.h"
+#include "cache.h"
+
+extern int wt_status_use_color;
+
+static const char runstatus_usage[] =
+"git-runstatus [--color|--nocolor] [--amend] [--verbose]";
+
+int cmd_runstatus(int argc, const char **argv, const char *prefix)
+{
+	struct wt_status s;
+	int i;
+
+	git_config(git_status_config);
+	wt_status_prepare(&s);
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--color"))
+			wt_status_use_color = 1;
+		else if (!strcmp(argv[i], "--nocolor"))
+			wt_status_use_color = 0;
+		else if (!strcmp(argv[i], "--amend")) {
+			s.amend = 1;
+			s.reference = "HEAD^1";
+		}
+		else if (!strcmp(argv[i], "--verbose"))
+			s.verbose = 1;
+		else
+			usage(runstatus_usage);
+	}
+
+	wt_status_print(&s);
+	return s.commitable ? 0 : 1;
+}
diff --git a/builtin.h b/builtin.h
index 25431d7..53a896c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -47,6 +47,7 @@ extern int cmd_repo_config(int argc, con
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
+extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
diff --git a/dir.c b/dir.c
index 5a40d8f..e2f472b 100644
--- a/dir.c
+++ b/dir.c
@@ -397,3 +397,10 @@ int read_directory(struct dir_struct *di
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
 }
+
+int
+file_exists(const char *f)
+{
+  struct stat sb;
+  return stat(f, &sb) == 0;
+}
diff --git a/dir.h b/dir.h
index 56a1b7f..313f8ab 100644
--- a/dir.h
+++ b/dir.h
@@ -47,5 +47,6 @@ extern int excluded(struct dir_struct *,
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
+extern int file_exists(const char *);
 
 #endif
diff --git a/git-commit.sh b/git-commit.sh
index 4cf3fab..10c269a 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -60,26 +60,6 @@ #
 }
 
 run_status () {
-    (
-	# We always show status for the whole tree.
-	cd "$TOP"
-
-	IS_INITIAL="$initial_commit"
-	REFERENCE=HEAD
-	case "$amend" in
-	t)
-		# If we are amending the initial commit, there
-		# is no HEAD^1.
-		if git-rev-parse --verify "HEAD^1" >/dev/null 2>&1
-		then
-			REFERENCE="HEAD^1"
-			IS_INITIAL=
-		else
-			IS_INITIAL=t
-		fi
-		;;
-	esac
-
 	# If TMP_INDEX is defined, that means we are doing
 	# "--only" partial commit, and that index file is used
 	# to build the tree for the commit.  Otherwise, if
@@ -96,85 +76,13 @@ run_status () {
 	    export GIT_INDEX_FILE
 	fi
 
-	case "$branch" in
-	refs/heads/master) ;;
-	*)  echo "# On branch $branch" ;;
-	esac
-
-	if test -z "$IS_INITIAL"
-	then
-	    git-diff-index -M --cached --name-status \
-		--diff-filter=MDTCRA $REFERENCE |
-	    sed -e '
-		    s/\\/\\\\/g
-		    s/ /\\ /g
-	    ' |
-	    report "Updated but not checked in" "will commit"
-	    committable="$?"
-	else
-	    echo '#
-# Initial commit
-#'
-	    git-ls-files |
-	    sed -e '
-		    s/\\/\\\\/g
-		    s/ /\\ /g
-		    s/^/A /
-	    ' |
-	    report "Updated but not checked in" "will commit"
-
-	    committable="$?"
-	fi
-
-	git-diff-files  --name-status |
-	sed -e '
-		s/\\/\\\\/g
-		s/ /\\ /g
-	' |
-	report "Changed but not updated" \
-	    "use git-update-index to mark for commit"
-
-        option=""
-        if test -z "$untracked_files"; then
-            option="--directory --no-empty-directory"
-        fi
-	hdr_shown=
-	if test -f "$GIT_DIR/info/exclude"
-	then
-	    git-ls-files --others $option \
-		--exclude-from="$GIT_DIR/info/exclude" \
-		--exclude-per-directory=.gitignore
-	else
-	    git-ls-files --others $option \
-		--exclude-per-directory=.gitignore
-	fi |
-	while read line; do
-	    if [ -z "$hdr_shown" ]; then
-		echo '#'
-		echo '# Untracked files:'
-		echo '#   (use "git add" to add to commit)'
-		echo '#'
-		hdr_shown=1
-	    fi
-	    echo "#	$line"
-	done
-
-	if test -n "$verbose" -a -z "$IS_INITIAL"
-	then
-	    git-diff-index --cached -M -p --diff-filter=MDTCRA $REFERENCE
-	fi
-	case "$committable" in
-	0)
-		case "$amend" in
-		t)
-			echo "# No changes" ;;
-		*)
-			echo "nothing to commit" ;;
-		esac
-		exit 1 ;;
-	esac
-	exit 0
-    )
+  case "$status_only" in
+    t) color= ;;
+    *) color=--nocolor ;;
+  esac
+  git-runstatus ${color} \
+                ${verbose:+--verbose} \
+                ${amend:+--amend}
 }
 
 trap '
diff --git a/git.c b/git.c
index 335f405..495b39a 100644
--- a/git.c
+++ b/git.c
@@ -252,6 +252,7 @@ static void handle_internal_command(int 
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "rm", cmd_rm, RUN_SETUP },
+		{ "runstatus", cmd_runstatus, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
diff --git a/wt-status.c b/wt-status.c
new file mode 100644
index 0000000..ec2c728
--- /dev/null
+++ b/wt-status.c
@@ -0,0 +1,271 @@
+#include "wt-status.h"
+#include "color.h"
+#include "cache.h"
+#include "object.h"
+#include "dir.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "diffcore.h"
+
+int wt_status_use_color = 0;
+static char wt_status_colors[][COLOR_MAXLEN] = {
+	"",         /* WT_STATUS_HEADER: normal */
+	"\033[32m", /* WT_STATUS_UPDATED: green */
+	"\033[31m", /* WT_STATUS_CHANGED: red */
+	"\033[31m", /* WT_STATUS_UNTRACKED: red */
+};
+
+static int parse_status_slot(const char *var, int offset)
+{
+	if (!strcasecmp(var+offset, "header"))
+		return WT_STATUS_HEADER;
+	if (!strcasecmp(var+offset, "updated"))
+		return WT_STATUS_UPDATED;
+	if (!strcasecmp(var+offset, "changed"))
+		return WT_STATUS_CHANGED;
+	if (!strcasecmp(var+offset, "untracked"))
+		return WT_STATUS_UNTRACKED;
+	die("bad config variable '%s'", var);
+}
+
+static const char* color(int slot)
+{
+	return wt_status_use_color ? wt_status_colors[slot] : "";
+}
+
+void wt_status_prepare(struct wt_status *s)
+{
+	unsigned char sha1[20];
+	const char *head;
+
+	s->is_initial = get_sha1("HEAD", sha1) ? 1 : 0;
+
+	head = resolve_ref(git_path("HEAD"), sha1, 0);
+	s->branch = head ?
+		    strdup(head + strlen(get_git_dir()) + 1) :
+		    NULL;
+
+	s->reference = "HEAD";
+	s->amend = 0;
+	s->verbose = 0;
+	s->commitable = 0;
+}
+
+static void wt_status_print_header(const char *main, const char *sub)
+{
+	const char *c = color(WT_STATUS_HEADER);
+	color_printf_ln(c, "# %s:", main);
+	color_printf_ln(c, "#   (%s)", sub);
+	color_printf_ln(c, "#");
+}
+
+static void wt_status_print_trailer(void)
+{
+	color_printf_ln(color(WT_STATUS_HEADER), "#");
+}
+
+static void wt_status_print_filepair(int t, struct diff_filepair *p)
+{
+	const char *c = color(t);
+	color_printf(color(WT_STATUS_HEADER), "#\t");
+	switch (p->status) {
+	case DIFF_STATUS_ADDED:
+		color_printf(c, "new file: %s", p->one->path); break;
+	case DIFF_STATUS_COPIED:
+		color_printf(c, "copied: %s -> %s",
+				p->one->path, p->two->path);
+		break;
+	case DIFF_STATUS_DELETED:
+		color_printf_ln(c, "deleted: %s", p->one->path); break;
+	case DIFF_STATUS_MODIFIED:
+		color_printf(c, "modified: %s", p->one->path); break;
+	case DIFF_STATUS_RENAMED:
+		color_printf(c, "renamed: %s -> %s",
+				p->one->path, p->two->path);
+		break;
+	case DIFF_STATUS_TYPE_CHANGED:
+		color_printf(c, "typechange: %s", p->one->path); break;
+	case DIFF_STATUS_UNKNOWN:
+		color_printf(c, "unknown: %s", p->one->path); break;
+	case DIFF_STATUS_UNMERGED:
+		color_printf(c, "unmerged: %s", p->one->path); break;
+	default:
+		die("bug: unhandled diff status %c", p->status);
+	}
+	printf("\n");
+}
+
+static void wt_status_print_updated_cb(struct diff_queue_struct *q,
+		struct diff_options *options,
+		void *data)
+{
+	struct wt_status *s = data;
+	int shown_header = 0;
+	int i;
+	if (q->nr) {
+	}
+	for (i = 0; i < q->nr; i++) {
+		if (q->queue[i]->status == 'U')
+			continue;
+		if (!shown_header) {
+			wt_status_print_header("Updated but not checked in",
+					"will commit");
+			s->commitable = 1;
+			shown_header = 1;
+		}
+		wt_status_print_filepair(WT_STATUS_UPDATED, q->queue[i]);
+	}
+	if (shown_header)
+		wt_status_print_trailer();
+}
+
+static void wt_status_print_changed_cb(struct diff_queue_struct *q,
+                        struct diff_options *options,
+                        void *data)
+{
+	int i;
+	if (q->nr)
+		wt_status_print_header("Changed but not updated",
+				"use git-update-index to mark for commit");
+	for (i = 0; i < q->nr; i++)
+		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
+	if (q->nr)
+		wt_status_print_trailer();
+}
+
+void wt_status_print_initial(struct wt_status *s)
+{
+	int i;
+	read_cache();
+	if (active_nr) {
+		s->commitable = 1;
+		wt_status_print_header("Updated but not checked in",
+				"will commit");
+	}
+	for (i = 0; i < active_nr; i++) {
+		color_printf(color(WT_STATUS_HEADER), "#\t");
+		color_printf_ln(color(WT_STATUS_UPDATED), "new file: %s",
+				active_cache[i]->name);
+	}
+	if (active_nr)
+		wt_status_print_trailer();
+}
+
+static void wt_status_print_updated(struct wt_status *s)
+{
+	struct rev_info rev;
+	const char *argv[] = { NULL, NULL, NULL };
+	argv[1] = s->reference;
+	init_revisions(&rev, NULL);
+	setup_revisions(2, argv, &rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = wt_status_print_updated_cb;
+	rev.diffopt.format_callback_data = s;
+	rev.diffopt.detect_rename = 1;
+	run_diff_index(&rev, 1);
+}
+
+static void wt_status_print_changed(struct wt_status *s)
+{
+	struct rev_info rev;
+	const char *argv[] = { NULL, NULL };
+	init_revisions(&rev, "");
+	setup_revisions(1, argv, &rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = wt_status_print_changed_cb;
+	rev.diffopt.format_callback_data = s;
+	run_diff_files(&rev, 0);
+}
+
+static void wt_status_print_untracked(const struct wt_status *s)
+{
+	struct dir_struct dir;
+	const char *x;
+	int i;
+	int shown_header = 0;
+
+	memset(&dir, 0, sizeof(dir));
+
+	dir.exclude_per_dir = ".gitignore";
+	x = git_path("info/exclude");
+	if (file_exists(x))
+		add_excludes_from_file(&dir, x);
+
+	read_directory(&dir, ".", "", 0);
+	for(i = 0; i < dir.nr; i++) {
+		/* check for matching entry, which is unmerged; lifted from
+		 * builtin-ls-files:show_other_files */
+		struct dir_entry *ent = dir.entries[i];
+		int pos = cache_name_pos(ent->name, ent->len);
+		struct cache_entry *ce;
+		if (0 <= pos)
+			die("bug in wt_status_print_untracked");
+		pos = -pos - 1;
+		if (pos < active_nr) {
+			ce = active_cache[pos];
+			if (ce_namelen(ce) == ent->len &&
+			    !memcmp(ce->name, ent->name, ent->len))
+				continue;
+		}
+		if (!shown_header) {
+			wt_status_print_header("Untracked files",
+				"use \"git add\" to add to commit");
+			shown_header = 1;
+		}
+		color_printf(color(WT_STATUS_HEADER), "#\t");
+		color_printf_ln(color(WT_STATUS_UNTRACKED), "%.*s",
+				ent->len, ent->name);
+	}
+}
+
+static void wt_status_print_verbose(struct wt_status *s)
+{
+	struct rev_info rev;
+	const char *argv[] = { NULL, NULL, NULL };
+	argv[1] = s->reference;
+	init_revisions(&rev, NULL);
+	setup_revisions(2, argv, &rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+	rev.diffopt.detect_rename = 1;
+	run_diff_index(&rev, 1);
+}
+
+void wt_status_print(struct wt_status *s)
+{
+	if (s->branch && strcmp(s->branch, "refs/heads/master"))
+		color_printf_ln(color(WT_STATUS_HEADER),
+			"# On branch %s", s->branch);
+
+	if (s->is_initial) {
+		color_printf_ln(color(WT_STATUS_HEADER), "#");
+		color_printf_ln(color(WT_STATUS_HEADER), "# Initial commit");
+		color_printf_ln(color(WT_STATUS_HEADER), "#");
+		wt_status_print_initial(s);
+	}
+	else {
+		wt_status_print_updated(s);
+		discard_cache();
+	}
+
+	wt_status_print_changed(s);
+	wt_status_print_untracked(s);
+
+	if (s->verbose && !s->is_initial)
+		wt_status_print_verbose(s);
+	if (!s->commitable)
+		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
+}
+
+int git_status_config(const char *k, const char *v)
+{
+	if (!strcmp(k, "status.color")) {
+		wt_status_use_color = git_config_colorbool(k, v);
+		return 0;
+	}
+	if (!strncmp(k, "status.color.", 13)) {
+		int slot = parse_status_slot(k, 13);
+		color_parse(v, k, wt_status_colors[slot]);
+	}
+	return git_default_config(k, v);
+}
diff --git a/wt-status.h b/wt-status.h
new file mode 100644
index 0000000..75d3cfe
--- /dev/null
+++ b/wt-status.h
@@ -0,0 +1,24 @@
+#ifndef STATUS_H
+#define STATUS_H
+
+enum color_wt_status {
+	WT_STATUS_HEADER,
+	WT_STATUS_UPDATED,
+	WT_STATUS_CHANGED,
+	WT_STATUS_UNTRACKED,
+};
+
+struct wt_status {
+	int is_initial;
+	char *branch;
+	const char *reference;
+	int commitable;
+	int verbose;
+	int amend;
+};
+
+int git_status_config(const char *var, const char *value);
+void wt_status_prepare(struct wt_status *s);
+void wt_status_print(struct wt_status *s);
+
+#endif /* STATUS_H */
-- 
1.4.2.g5290b
