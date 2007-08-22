From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 14:48:16 +0200
Message-ID: <46CC3090.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 14:48:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INpdZ-0001TV-Bs
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 14:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759026AbXHVMsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 08:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758728AbXHVMsf
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 08:48:35 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:28576 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758351AbXHVMsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 08:48:33 -0400
Received: by an-out-0708.google.com with SMTP id d31so10941and
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 05:48:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ii9Y5PJtCLdNRqGAvjKLFwt30f652uJXYsc24b87p5Z7GBDKZch1/xlR4XPypJM5Xs4TKR5Z1V4qNWXQwqZEO+X6GgV8H6Lo+hUUxmjLltCorDG8qC33B2tlRnZiL9WiiXcuO3q+d2t1BeMdktC5vZyc3eokWKnpx0m67977cG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=djlxoyK6TB1rnIa6o1ekVODNPYj9UwygTra3ajtK2h4EUkAhU6fo4rF0BYrIl+iGY0VPvKo0kdAlcknqE34V0TawWGucsGZYj2aQQ6zT/FYzDP5IWPWxSJ+CiZKguPlnSShCw65GAVtR8rU6GtcPE9marpclqacaZYQNJyBgl1M=
Received: by 10.90.52.18 with SMTP id z18mr4353638agz.1187786911622;
        Wed, 22 Aug 2007 05:48:31 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id f4sm172219nfh.2007.08.22.05.48.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Aug 2007 05:48:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56375>

This is the first version of the program "builtin-reset.c",
intended for replacing the script "git-reset.sh".

The --mixed option with -- paths is not implemented yet.

The tests I made for it are not finished so they are not included,
but it seems to pass the rest of the test suite.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 Makefile                                      |    3 +-
 builtin-reset.c                               |  216 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-reset.sh => contrib/examples/git-reset.sh |    0
 git.c                                         |    1 +
 5 files changed, 220 insertions(+), 1 deletions(-)
 create mode 100644 builtin-reset.c
 rename git-reset.sh => contrib/examples/git-reset.sh (100%)

diff --git a/Makefile b/Makefile
index 4eb4637..4f70993 100644
--- a/Makefile
+++ b/Makefile
@@ -206,7 +206,7 @@ SCRIPT_SH = \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
-	git-repack.sh git-request-pull.sh git-reset.sh \
+	git-repack.sh git-request-pull.sh \
 	git-sh-setup.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
@@ -353,6 +353,7 @@ BUILTIN_OBJS = \
 	builtin-reflog.o \
 	builtin-config.o \
 	builtin-rerere.o \
+	builtin-reset.o \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
 	builtin-revert.o \
diff --git a/builtin-reset.c b/builtin-reset.c
new file mode 100644
index 0000000..66aac45
--- /dev/null
+++ b/builtin-reset.c
@@ -0,0 +1,216 @@
+/*
+ * "git reset" builtin command
+ *
+ * Copyright (c) 2007 Carlos Rica
+ *
+ * Based on git-reset.sh, which is
+ *
+ * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
+ */
+#include "cache.h"
+#include "tag.h"
+#include "object.h"
+#include "run-command.h"
+#include "refs.h"
+
+static const char builtin_reset_usage[] =
+"git-reset [--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]";
+
+static char *args_to_str(const char **argv)
+{
+	char *buf = NULL;
+	unsigned long len, space = 0, nr = 0;
+
+	for (; *argv; argv++) {
+		len = strlen(*argv);
+		ALLOC_GROW(buf, nr + 1 + len, space);
+		if (nr)
+			buf[nr++] = ' ';
+		memcpy(buf + nr, *argv, len);
+		nr += len;
+	}
+	ALLOC_GROW(buf, nr + 1, space);
+	buf[nr] = '\0';
+
+	return buf;
+}
+
+static inline int is_merge(void)
+{
+	return !access(git_path("MERGE_HEAD"), F_OK);
+}
+
+static int unmerged_files(void)
+{
+	char b;
+	ssize_t len;
+	struct child_process cmd;
+	const char *argv_ls_files[] = {"ls-files", "--unmerged", NULL};
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = argv_ls_files;
+	cmd.git_cmd = 1;
+	cmd.out = -1;
+
+	if (start_command(&cmd))
+		die("Could not run sub-command: git ls-files");
+
+	len = xread(cmd.out, &b, 1);
+	if (len < 0)
+		die("Could not read output from git ls-files: %s",
+						strerror(errno));
+	finish_command(&cmd);
+
+	return len;
+}
+
+static int reset_index_file(const unsigned char *sha1, int is_hard_reset)
+{
+	int i = 0;
+	const char *args[6];
+
+	args[i++] = "read-tree";
+	args[i++] = "-v";
+	args[i++] = "--reset";
+	if (is_hard_reset)
+		args[i++] = "-u";
+	args[i++] = sha1_to_hex(sha1);
+	args[i] = NULL;
+
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
+
+static int print_line_current_head(void)
+{
+	const char *argv_log[] = {"log", "--max-count=1", "--pretty=oneline",
+					"--abbrev-commit", "HEAD", NULL};
+	printf("HEAD is now at ");
+	unsetenv("GIT_PAGER");
+	return run_command_v_opt(argv_log, RUN_GIT_CMD);
+}
+
+static int update_index_refresh(void)
+{
+	const char *argv_update_index[] = {"update-index", "--refresh", NULL};
+	return run_command_v_opt(argv_update_index, RUN_GIT_CMD);
+}
+
+static int update_ref(const char *action, const char *refname,
+		const unsigned char *sha1, const unsigned char *oldval)
+{
+	static struct ref_lock *lock;
+
+	lock = lock_any_ref_for_update(refname, oldval, 0);
+	if (!lock)
+		return error("Cannot lock the ref: '%s'.", refname);
+	if (write_ref_sha1(lock, sha1, action) < 0)
+		return error("Cannot update the ref: '%s'.", refname);
+	return 0;
+}
+
+enum reset_type { MIXED, SOFT, HARD };
+
+int cmd_reset(int argc, const char **argv, const char *prefix)
+{
+	int i = 1, reset_type = MIXED, update_ref_status = 0;
+	const char *rev = "HEAD";
+	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
+				*old_orig = NULL, sha1_old_orig[20];
+	struct object *obj;
+	char *reflog_action;
+
+	git_config(git_default_config);
+
+	reflog_action = args_to_str(argv);
+	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
+
+	if (i < argc) {
+		if (!strcmp(argv[i], "--mixed")) {
+			reset_type = MIXED;
+			i++;
+		}
+		else if (!strcmp(argv[i], "--soft")) {
+			reset_type = SOFT;
+			i++;
+		}
+		else if (!strcmp(argv[i], "--hard")) {
+			reset_type = HARD;
+			i++;
+		}
+	}
+
+	if (i < argc && argv[i][0] != '-')
+		rev = argv[i++];
+
+	if (get_sha1(rev, sha1))
+		die("Failed to resolve '%s' as a valid ref.", rev);
+
+	obj = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
+	if (!obj)
+		die("Could not parse object '%s'.", rev);
+	memcpy(sha1, obj->sha1, sizeof(sha1));
+
+	if (i < argc && argv[i][0] == '-') {
+		if (strcmp(argv[i], "--"))
+			usage(builtin_reset_usage);
+		else
+			i++;
+	}
+
+	/* git reset --mixed tree [--] paths... can be used to
+	 * load chosen paths from the tree into the index without
+	 * affecting the working tree nor HEAD. */
+	if (i < argc) {
+		if (reset_type != MIXED)
+			die("Cannot do partial %s reset.", argv[1]);
+		/*
+		git diff-index --cached $rev -- "$@" |
+		sed -e 's/^:\([0-7][0-7]*\) [0-7][0-7]* \([0-9a-f][0-9a-f]*\) [0-9a-f][0-9a-f]* [A-Z]	\(.*\)$/\1 \2	\3/' |
+		git update-index --add --remove --index-info || exit
+		*/
+		update_index_refresh();
+		return 0;
+	}
+
+	/* Soft reset does not touch the index file nor the working tree
+	 * at all, but requires them in a good order.  Other resets reset
+	 * the index file to the tree object we are switching to. */
+	if (reset_type == SOFT) {
+		if (is_merge() || unmerged_files())
+			die("Cannot do a soft reset in the middle of a merge.");
+	}
+	else if (reset_index_file(sha1, (reset_type == HARD)))
+		die("Could not reset index file to revision '%s'.", rev);
+
+	/* Any resets update HEAD to the head being switched to,
+	 * saving the previous head in ORIG_HEAD before. */
+	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
+		old_orig = sha1_old_orig;
+	if (!get_sha1("HEAD", sha1_orig)) {
+		orig = sha1_orig;
+		update_ref("updating ORIG_HEAD", "ORIG_HEAD", orig, old_orig);
+	}
+	else if (old_orig)
+		delete_ref("ORIG_HEAD", old_orig);
+	update_ref_status = update_ref(reflog_action, "HEAD", sha1, orig);
+	free(reflog_action);
+
+	switch (reset_type) {
+	case HARD:
+		if (!update_ref_status)
+			print_line_current_head();
+		break;
+	case SOFT: /* Nothing else to do. */
+		break;
+	case MIXED: /* Report what has not been updated. */
+		update_index_refresh();
+		break;
+	}
+
+	unlink(git_path("MERGE_HEAD"));
+	unlink(git_path("rr-cache/MERGE_RR"));
+	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("SQUASH_MSG"));
+
+	return update_ref_status;
+}
diff --git a/builtin.h b/builtin.h
index bb72000..03ee7bf 100644
--- a/builtin.h
+++ b/builtin.h
@@ -60,6 +60,7 @@ extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
+extern int cmd_reset(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
diff --git a/git-reset.sh b/contrib/examples/git-reset.sh
similarity index 100%
rename from git-reset.sh
rename to contrib/examples/git-reset.sh
diff --git a/git.c b/git.c
index cab0e72..26720f4 100644
--- a/git.c
+++ b/git.c
@@ -359,6 +359,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
+		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-- 
1.5.0
