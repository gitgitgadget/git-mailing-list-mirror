From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make git-revert & git-cherry-pick a builtin
Date: Thu, 1 Mar 2007 05:26:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703010526080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Mar 01 05:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMcsG-0005Qk-23
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 05:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbXCAE0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 23:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbXCAE0e
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 23:26:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:56123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752171AbXCAE0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 23:26:33 -0500
Received: (qmail invoked by alias); 01 Mar 2007 04:26:31 -0000
X-Provags-ID: V01U2FsdGVkX1+bZ+1UglObs7XgG92tMCwb9wcw7EOHGm8Zhi4TWt
	V1AA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41035>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile         |   11 +-
 builtin-revert.c |  406 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h        |    2 +
 git-revert.sh    |  197 --------------------------
 git.c            |    2 +
 5 files changed, 414 insertions(+), 204 deletions(-)
 create mode 100644 builtin-revert.c
 delete mode 100755 git-revert.sh

diff --git a/Makefile b/Makefile
index e4bb865..6060b48 100644
--- a/Makefile
+++ b/Makefile
@@ -177,7 +177,7 @@ SCRIPT_SH = \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
-	git-revert.sh git-sh-setup.sh \
+	git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
@@ -193,7 +193,7 @@ SCRIPT_PERL = \
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
-	  git-cherry-pick git-status git-instaweb
+	  git-status git-instaweb
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
@@ -220,7 +220,7 @@ EXTRA_PROGRAMS =
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X \
+	git-fsck-objects$X git-cherry-pick$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -313,6 +313,7 @@ BUILTIN_OBJS = \
 	builtin-rerere.o \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
+	builtin-revert.o \
 	builtin-rm.o \
 	builtin-runstatus.o \
 	builtin-shortlog.o \
@@ -684,10 +685,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	chmod +x $@+
 	mv $@+ $@
 
-git-cherry-pick: git-revert
-	cp $< $@+
-	mv $@+ $@
-
 git-status: git-commit
 	cp $< $@+
 	mv $@+ $@
diff --git a/builtin-revert.c b/builtin-revert.c
new file mode 100644
index 0000000..bc3cfcb
--- /dev/null
+++ b/builtin-revert.c
@@ -0,0 +1,406 @@
+#include "cache.h"
+#include "builtin.h"
+#include "object.h"
+#include "commit.h"
+#include "tag.h"
+#include "wt-status.h"
+#include "run-command.h"
+#include "exec_cmd.h"
+#include "utf8.h"
+
+/*
+ * This implements the builtins revert and cherry-pick.
+ *
+ * Copyright (c) 2007 Johannes E. Schindelin
+ *
+ * Based on git-revert.sh, which is
+ *
+ * Copyright (c) 2005 Linus Torvalds
+ * Copyright (c) 2005 Junio C Hamano
+ */
+
+static const char *revert_usage = "git-revert [--edit | --no-edit] [-n] <commit-ish>";
+
+static const char *cherry_pick_usage = "git-cherry-pick [--edit] [-n] [-r] [-x] <commit-ish>";
+
+static int edit;
+static int replay;
+enum { REVERT, CHERRY_PICK } action;
+static int no_commit;
+static struct commit *commit;
+static int needed_deref;
+
+static const char *me;
+
+#define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
+
+static void parse_options(int argc, const char **argv)
+{
+	const char *usage_str = action == REVERT ?
+		revert_usage : cherry_pick_usage;
+	unsigned char sha1[20];
+	const char *arg;
+	int i;
+
+	if (argc < 2)
+		usage(usage_str);
+
+	for (i = 1; i < argc - 1; i++) {
+		arg = argv[i];
+		if (!strcmp(arg, "-n") || !strcmp(arg, "--no-commit"))
+			no_commit = 1;
+		else if (!strcmp(arg, "-e") || !strcmp(arg, "--edit"))
+			edit = 1;
+		else if (!strcmp(arg, "--no-edit"))
+			edit = 0;
+		else if (!strcmp(arg, "-x") || !strcmp(arg, "--i-really-want-"
+				"to-expose-my-private-commit-object-name"))
+			replay = 0;
+		else if (strcmp(arg, "-r"))
+			usage(usage_str);
+	}
+
+	arg = argv[argc - 1];
+	if (get_sha1(arg, sha1))
+		die ("Cannot find '%s'", arg);
+	commit = (struct commit *)parse_object(sha1);
+	if (!commit)
+		die ("Could not find %s", sha1_to_hex(sha1));
+	if (commit->object.type == OBJ_TAG) {
+		commit = (struct commit *)
+			deref_tag((struct object *)commit, arg, strlen(arg));
+		needed_deref = 1;
+	}
+	if (commit->object.type != OBJ_COMMIT)
+		die ("'%s' does not point to a commit", arg);
+}
+
+static char *get_oneline(const char *message)
+{
+	char *result;
+	const char *p = message, *abbrev, *eol;
+	int abbrev_len, oneline_len;
+
+	if (!p)
+		die ("Could not read commit message of %s",
+				sha1_to_hex(commit->object.sha1));
+	while (*p && (*p != '\n' || p[1] != '\n'))
+		p++;
+
+	if (*p) {
+		p += 2;
+		for (eol = p + 1; *eol && *eol != '\n'; eol++)
+			; /* do nothing */
+	} else
+		eol = p;
+	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	abbrev_len = strlen(abbrev);
+	oneline_len = eol - p;
+	result = xmalloc(abbrev_len + 5 + oneline_len);
+	memcpy(result, abbrev, abbrev_len);
+	memcpy(result + abbrev_len, "... ", 4);
+	memcpy(result + abbrev_len + 4, p, oneline_len);
+	result[abbrev_len + 4 + oneline_len] = '\0';
+	return result;
+}
+
+char *get_encoding(const char *message)
+{
+	const char *p = message, *eol;
+
+	if (!p)
+		die ("Could not read commit message of %s",
+				sha1_to_hex(commit->object.sha1));
+	while (*p && *p != '\n') {
+		for (eol = p + 1; *eol && *eol != '\n'; eol++)
+			; /* do nothing */
+		if (!prefixcmp(p, "encoding ")) {
+			char *result = xmalloc(eol - 8 - p);
+			strlcpy(result, p + 9, eol - 8 - p);
+			return result;
+		}
+		p = eol;
+		if (*p == '\n')
+			p++;
+	}
+	return NULL;
+}
+
+struct lock_file msg_file;
+static int msg_fd;
+
+static void add_to_msg(const char *string)
+{
+	int len = strlen(string);
+	if (write_in_full(msg_fd, string, len) < 0)
+		die ("Could not write to .msg");
+}
+
+static void add_message_to_msg(const char *message)
+{
+	const char *p = message;
+	while (*p && (*p != '\n' || p[1] != '\n'))
+		p++;
+
+	if (!*p)
+		add_to_msg(sha1_to_hex(commit->object.sha1));
+
+	p += 2;
+	add_to_msg(p);
+	return;
+}
+
+static void set_author_ident_env(const char *message)
+{
+	const char *p = message;
+	if (!p)
+		die ("Could not read commit message of %s",
+				sha1_to_hex(commit->object.sha1));
+	while (*p && *p != '\n') {
+		const char *eol;
+
+		for (eol = p; *eol && *eol != '\n'; eol++)
+			; /* do nothing */
+		if (!prefixcmp(p, "author ")) {
+			char *line, *pend, *email, *timestamp;
+
+			p += 7;
+			line = xmalloc(eol + 1 - p);
+			memcpy(line, p, eol - p);
+			line[eol - p] = '\0';
+			email = strchr(line, '<');
+			if (!email)
+				die ("Could not extract author email from %s",
+					sha1_to_hex(commit->object.sha1));
+			if (email == line)
+				pend = line;
+			else
+				for (pend = email; pend != line + 1 &&
+						isspace(pend[-1]); pend--);
+					; /* do nothing */
+			*pend = '\0';
+			email++;
+			timestamp = strchr(email, '>');
+			if (!timestamp)
+				die ("Could not extract author email from %s",
+					sha1_to_hex(commit->object.sha1));
+			*timestamp = '\0';
+			for (timestamp++; *timestamp && isspace(*timestamp);
+					timestamp++)
+				; /* do nothing */
+			setenv("GIT_AUTHOR_NAME", line, 1);
+			setenv("GIT_AUTHOR_EMAIL", email, 1);
+			setenv("GIT_AUTHOR_DATE", timestamp, 1);
+			free(line);
+			return;
+		}
+		p = eol;
+		if (*p == '\n')
+			p++;
+	}
+	die ("No author information found in %s",
+			sha1_to_hex(commit->object.sha1));
+}
+
+static int merge_recursive(const char *base_sha1,
+		const char *head_sha1, const char *head_name,
+		const char *next_sha1, const char *next_name)
+{
+	char buffer[256];
+
+	sprintf(buffer, "GITHEAD_%s", head_sha1);
+	setenv(buffer, head_name, 1);
+	sprintf(buffer, "GITHEAD_%s", next_sha1);
+	setenv(buffer, next_name, 1);
+
+	/*
+	 * This three way merge is an interesting one.  We are at
+	 * $head, and would want to apply the change between $commit
+	 * and $prev on top of us (when reverting), or the change between
+	 * $prev and $commit on top of us (when cherry-picking or replaying).
+	 */
+
+	return run_command_opt(RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
+			"merge-recursive", base_sha1, "--",
+			head_sha1, next_sha1, NULL);
+}
+
+static int revert_or_cherry_pick(int argc, const char **argv)
+{
+	unsigned char head[20];
+	struct commit *base, *next;
+	int i;
+	char *oneline, *encoding, *reencoded_message = NULL;
+	const char *message;
+
+	git_config(git_default_config);
+	me = action == REVERT ? "revert" : "cherry-pick";
+	setenv(GIT_REFLOG_ACTION, me, 0);
+	parse_options(argc, argv);
+
+	/* this is copied from the shell script, but it's never triggered... */
+	if (action == REVERT && replay)
+		die("revert is incompatible with replay");
+
+	if (no_commit) {
+		/*
+		 * We do not intend to commit immediately.  We just want to
+		 * merge the differences in.
+		 */
+		if (write_tree(head, 0, NULL))
+			die ("Your index file is unmerged.");
+	} else {
+		struct wt_status s;
+
+		if (get_sha1("HEAD", head))
+			die ("You do not have a valid HEAD");
+		wt_status_prepare(&s);
+		if (s.commitable || s.workdir_dirty)
+			die ("Dirty index: cannot %s", me);
+		discard_cache();
+	}
+
+	if (!commit->parents)
+		die ("Cannot %s a root commit", me);
+	if (commit->parents->next)
+		die ("Cannot %s a multi-parent commit.", me);
+	if (!(message = commit->buffer))
+		die ("Cannot get commit message for %s",
+				sha1_to_hex(commit->object.sha1));
+
+	/*
+	 * "commit" is an existing commit.  We would want to apply
+	 * the difference it introduces since its first parent "prev"
+	 * on top of the current HEAD if we are cherry-pick.  Or the
+	 * reverse of it if we are revert.
+	 */
+
+	msg_fd = hold_lock_file_for_update(&msg_file, ".msg", 1);
+
+	encoding = get_encoding(message);
+	if (!encoding)
+		encoding = "utf-8";
+	if (!git_commit_encoding)
+		git_commit_encoding = "utf-8";
+	if ((reencoded_message = reencode_string(message,
+					git_commit_encoding, encoding)))
+		message = reencoded_message;
+
+	oneline = get_oneline(message);
+
+	if (action == REVERT) {
+		base = commit;
+		next = commit->parents->item;
+		add_to_msg("Revert ");
+		add_to_msg(find_unique_abbrev(commit->object.sha1,
+					DEFAULT_ABBREV));
+		add_to_msg(oneline);
+		add_to_msg("\nThis reverts commit ");
+		add_to_msg(sha1_to_hex(commit->object.sha1));
+		add_to_msg(".\n");
+	} else {
+		base = commit->parents->item;
+		next = commit;
+		set_author_ident_env(message);
+		add_message_to_msg(message);
+		if (replay) {
+			add_to_msg("\n(cherry picked from commit ");
+			add_to_msg(sha1_to_hex(commit->object.sha1));
+			add_to_msg(")\n");
+		}
+	}
+	if (needed_deref) {
+		add_to_msg("(original 'git ");
+		add_to_msg(me);
+		add_to_msg("' arguments: ");
+		for (i = 0; i < argc; i++) {
+			if (i)
+				add_to_msg(" ");
+			add_to_msg(argv[i]);
+		}
+		add_to_msg(")\n");
+	}
+
+	if (merge_recursive(sha1_to_hex(base->object.sha1),
+				sha1_to_hex(head), "HEAD",
+				sha1_to_hex(next->object.sha1), oneline))
+		exit(1);
+	if (write_tree(head, 0, NULL)) {
+		const char *target = git_path("MERGE_MSG");
+		add_to_msg("\nConflicts:\n\n");
+		read_cache();
+		for (i = 0; i < active_nr;) {
+			struct cache_entry *ce = active_cache[i++];
+			if (ce_stage(ce)) {
+				add_to_msg("\t");
+				add_to_msg(ce->name);
+				add_to_msg("\n");
+				while (i < active_nr && !strcmp(ce->name,
+						active_cache[i]->name))
+					i++;
+			}
+		}
+		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
+			die ("Error wrapping up .msg");
+		unlink(target);
+		if (rename(".msg", target))
+			die ("Could not move .msg to %s", target);
+		fprintf(stderr, "Automatic %s failed.  "
+			"After resolving the conflicts,\n"
+			"mark the corrected paths with 'git-add <paths>'\n"
+			"and commit the result.\n", me);
+		if (action == CHERRY_PICK) {
+			fprintf(stderr, "You may choose to use the following "
+				"when making the commit:\n"
+				"GIT_AUTHOR_NAME=\"%s\"\n",
+				getenv("GIT_AUTHOR_NAME"));
+			fprintf(stderr, "GIT_AUTHOR_EMAIL=\"%s\"\n",
+				getenv("GIT_AUTHOR_EMAIL"));
+			fprintf(stderr, "GIT_AUTHOR_DATE=\"%s\"\n"
+				"export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL "
+				"GIT_AUTHOR_DATE\n",
+				getenv("GIT_AUTHOR_DATE"));
+		}
+		exit(1);
+	}
+	if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
+		die ("Error wrapping up .msg");
+	fprintf(stderr, "Finished one %s.\n", me);
+
+	/*
+	 *
+	 * If we are cherry-pick, and if the merge did not result in
+	 * hand-editing, we will hit this commit and inherit the original
+	 * author date and name.
+	 * If we are revert, or if our cherry-pick results in a hand merge,
+	 * we had better say that the current user is responsible for that.
+	 */
+
+	if (!no_commit) {
+		if (edit)
+			return execl_git_cmd("commit", "-n", "-F", ".msg",
+				"-e", NULL);
+		else
+			return execl_git_cmd("commit", "-n", "-F", ".msg",
+				NULL);
+	}
+	if (reencoded_message)
+		free(reencoded_message);
+
+	return 0;
+}
+
+int cmd_revert(int argc, const char **argv, const char *prefix)
+{
+	if (isatty(0))
+		edit = 1;
+	action = REVERT;
+	return revert_or_cherry_pick(argc, argv);
+}
+
+int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
+{
+	replay = 1;
+	action = CHERRY_PICK;
+	return revert_or_cherry_pick(argc, argv);
+}
diff --git a/builtin.h b/builtin.h
index 48d68c8..1cb64b7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,6 +24,7 @@ extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
+extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
@@ -61,6 +62,7 @@ extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
+extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
diff --git a/git-revert.sh b/git-revert.sh
deleted file mode 100755
index 49f0032..0000000
--- a/git-revert.sh
+++ /dev/null
@@ -1,197 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-# Copyright (c) 2005 Junio C Hamano
-#
-
-case "$0" in
-*-revert* )
-	test -t 0 && edit=-e
-	replay=
-	me=revert
-	USAGE='[--edit | --no-edit] [-n] <commit-ish>' ;;
-*-cherry-pick* )
-	replay=t
-	edit=
-	me=cherry-pick
-	USAGE='[--edit] [-n] [-r] [-x] <commit-ish>'  ;;
-* )
-	echo >&2 "What are you talking about?"
-	exit 1 ;;
-esac
-
-SUBDIRECTORY_OK=Yes ;# we will cd up
-. git-sh-setup
-require_work_tree
-cd_to_toplevel
-
-no_commit=
-while case "$#" in 0) break ;; esac
-do
-	case "$1" in
-	-n|--n|--no|--no-|--no-c|--no-co|--no-com|--no-comm|\
-	    --no-commi|--no-commit)
-		no_commit=t
-		;;
-	-e|--e|--ed|--edi|--edit)
-		edit=-e
-		;;
-	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
-		edit=
-		;;
-	-r)
-		: no-op ;;
-	-x|--i-really-want-to-expose-my-private-commit-object-name)
-		replay=
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
-
-set_reflog_action "$me"
-
-test "$me,$replay" = "revert,t" && usage
-
-case "$no_commit" in
-t)
-	# We do not intend to commit immediately.  We just want to
-	# merge the differences in.
-	head=$(git-write-tree) ||
-		die "Your index file is unmerged."
-	;;
-*)
-	head=$(git-rev-parse --verify HEAD) ||
-		die "You do not have a valid HEAD"
-	files=$(git-diff-index --cached --name-only $head) || exit
-	if [ "$files" ]; then
-		die "Dirty index: cannot $me (dirty: $files)"
-	fi
-	;;
-esac
-
-rev=$(git-rev-parse --verify "$@") &&
-commit=$(git-rev-parse --verify "$rev^0") ||
-	die "Not a single commit $@"
-prev=$(git-rev-parse --verify "$commit^1" 2>/dev/null) ||
-	die "Cannot run $me a root commit"
-git-rev-parse --verify "$commit^2" >/dev/null 2>&1 &&
-	die "Cannot run $me a multi-parent commit."
-
-encoding=$(git config i18n.commitencoding || echo UTF-8)
-
-# "commit" is an existing commit.  We would want to apply
-# the difference it introduces since its first parent "prev"
-# on top of the current HEAD if we are cherry-pick.  Or the
-# reverse of it if we are revert.
-
-case "$me" in
-revert)
-	git show -s --pretty=oneline --encoding="$encoding" $commit |
-	sed -e '
-		s/^[^ ]* /Revert "/
-		s/$/"/
-	'
-	echo
-	echo "This reverts commit $commit."
-	test "$rev" = "$commit" ||
-	echo "(original 'git revert' arguments: $@)"
-	base=$commit next=$prev
-	;;
-
-cherry-pick)
-	pick_author_script='
-	/^author /{
-		s/'\''/'\''\\'\'\''/g
-		h
-		s/^author \([^<]*\) <[^>]*> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
-
-		g
-		s/^author [^<]* <\([^>]*\)> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
-
-		g
-		s/^author [^<]* <[^>]*> \(.*\)$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
-
-		q
-	}'
-
-	logmsg=`git show -s --pretty=raw --encoding="$encoding" "$commit"`
-	set_author_env=`echo "$logmsg" |
-	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
-	eval "$set_author_env"
-	export GIT_AUTHOR_NAME
-	export GIT_AUTHOR_EMAIL
-	export GIT_AUTHOR_DATE
-
-	echo "$logmsg" |
-	sed -e '1,/^$/d' -e 's/^    //'
-	case "$replay" in
-	'')
-		echo "(cherry picked from commit $commit)"
-		test "$rev" = "$commit" ||
-		echo "(original 'git cherry-pick' arguments: $@)"
-		;;
-	esac
-	base=$prev next=$commit
-	;;
-
-esac >.msg
-
-eval GITHEAD_$head=HEAD
-eval GITHEAD_$next='`git show -s \
-	--pretty=oneline --encoding="$encoding" "$commit" |
-	sed -e "s/^[^ ]* //"`'
-export GITHEAD_$head GITHEAD_$next
-
-# This three way merge is an interesting one.  We are at
-# $head, and would want to apply the change between $commit
-# and $prev on top of us (when reverting), or the change between
-# $prev and $commit on top of us (when cherry-picking or replaying).
-
-git-merge-recursive $base -- $head $next &&
-result=$(git-write-tree 2>/dev/null) || {
-	mv -f .msg "$GIT_DIR/MERGE_MSG"
-	{
-	    echo '
-Conflicts:
-'
-		git ls-files --unmerged |
-		sed -e 's/^[^	]*	/	/' |
-		uniq
-	} >>"$GIT_DIR/MERGE_MSG"
-	echo >&2 "Automatic $me failed.  After resolving the conflicts,"
-	echo >&2 "mark the corrected paths with 'git-add <paths>'"
-	echo >&2 "and commit the result."
-	case "$me" in
-	cherry-pick)
-		echo >&2 "You may choose to use the following when making"
-		echo >&2 "the commit:"
-		echo >&2 "$set_author_env"
-	esac
-	exit 1
-}
-echo >&2 "Finished one $me."
-
-# If we are cherry-pick, and if the merge did not result in
-# hand-editing, we will hit this commit and inherit the original
-# author date and name.
-# If we are revert, or if our cherry-pick results in a hand merge,
-# we had better say that the current user is responsible for that.
-
-case "$no_commit" in
-'')
-	git-commit -n -F .msg $edit
-	rm -f .msg
-	;;
-esac
diff --git a/git.c b/git.c
index 008e016..fe0ce61 100644
--- a/git.c
+++ b/git.c
@@ -234,6 +234,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "cherry", cmd_cherry, RUN_SETUP },
+		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NOT_BARE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
@@ -273,6 +274,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
+		{ "revert", cmd_revert, RUN_SETUP | NOT_BARE },
 		{ "rm", cmd_rm, RUN_SETUP | NOT_BARE },
 		{ "runstatus", cmd_runstatus, RUN_SETUP | NOT_BARE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
-- 
1.5.0.2.809.g0f936-dirty
