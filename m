From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] worktree:  list operation
Date: Sat,  8 Aug 2015 16:34:57 -0400
Message-ID: <1439066097-85217-2-git-send-email-rappazzo@gmail.com>
References: <1439066097-85217-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 08 22:35:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOApp-0000TQ-0l
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 22:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992704AbbHHUfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 16:35:10 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35221 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992525AbbHHUfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 16:35:07 -0400
Received: by qkbm65 with SMTP id m65so47473368qkb.2
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vqkR7rkarOzEIKL9wd0x9IBH7ir1MeWxgNGDTG7Q6Qw=;
        b=wxzOCMPc9EChhBO8Q96M1pPd1LugyVWonFS35c1pQEsX4JbRC0zxz7kZML9+gRjoUX
         +81QkjL1qTLW1l7HQPFa/FRtNDRSmGBl9Q9Y7QL/uKrHEHa18gxW5KbUKeUmygUKFREf
         F7GrRrOp2uhfVsSXDytlTbXP7mUvafKh0baKLwluJs/5uzjgZ0myXARIw452I2qXou5P
         OGgdRuwWNvuLAcyk1h6hPWoFOLfpM7xEialDV5He423ohd2KfBrKSiMTCR0PzFFrpYIl
         WM/+KwMBTx9jNreO5emVeul86gpeTJynanmbkYTC5gr7yphtmyHzUa9gM3qRw5Z9wzK5
         E3Bw==
X-Received: by 10.55.54.10 with SMTP id d10mr21999813qka.88.1439066106916;
        Sat, 08 Aug 2015 13:35:06 -0700 (PDT)
Received: from Macbook-wireless.gtnexus.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by smtp.gmail.com with ESMTPSA id 126sm7034451qhc.49.2015.08.08.13.35.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Aug 2015 13:35:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439066097-85217-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275517>

'git worktree list' will list the main worktree followed by any linked
worktrees which were created using 'git worktree add'.  The option
'--main-only' will restrict the list to only the main worktree.
---
 Documentation/git-worktree.txt |  9 ++++-
 builtin/worktree.c             | 80 ++++++++++++++++++++++++++++++++++++++----
 t/t2027-worktree-list.sh       | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 7 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3387e2f..39b1330 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree list' [--primary]
 
 DESCRIPTION
 -----------
@@ -59,6 +60,10 @@ prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
 
+list::
+
+List the primary worktree followed by all of the linked worktrees.
+
 OPTIONS
 -------
 
@@ -86,6 +91,9 @@ OPTIONS
 	With `prune`, do not remove anything; just report what it would
 	remove.
 
+--primary::
+	With `list`, only list the primary worktree.
+
 -v::
 --verbose::
 	With `prune`, report all removals.
@@ -167,7 +175,6 @@ performed manually, such as:
 - `remove` to remove a linked worktree and its administrative files (and
   warn if the worktree is dirty)
 - `mv` to move or rename a worktree and update its administrative files
-- `list` to list linked worktrees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a worktree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6a264ee..1ac1776 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -10,6 +10,7 @@
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> <branch>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree list [<options>]"),
 	NULL
 };
 
@@ -36,7 +37,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
 	if (fd < 0) {
 		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
-			    id, strerror(errno));
+				 id, strerror(errno));
 		return 1;
 	}
 	len = st.st_size;
@@ -59,7 +60,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 		 * accessed since?
 		 */
 		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
-		    st_link.st_nlink > 1)
+			 st_link.st_nlink > 1)
 			return 0;
 		if (st.st_mtime <= expire) {
 			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
@@ -187,7 +188,7 @@ static int add_worktree(const char *path, const char **child_argv)
 
 	name = worktree_basename(path, &len);
 	strbuf_addstr(&sb_repo,
-		      git_path("worktrees/%.*s", (int)(path + len - name), name));
+				git_path("worktrees/%.*s", (int)(path + len - name), name));
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -225,7 +226,7 @@ static int add_worktree(const char *path, const char **child_argv)
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
 	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
-		   real_path(get_git_common_dir()), name);
+			real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
 	 * or is_git_directory() will reject the directory. Moreover, HEAD
@@ -280,9 +281,9 @@ static int add(int ac, const char **av, const char *prefix)
 	struct option options[] = {
 		OPT__FORCE(&force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &new_branch, N_("branch"),
-			   N_("create a new branch")),
+				N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
-			   N_("create or reset a branch")),
+				N_("create or reset a branch")),
 		OPT_BOOL(0, "detach", &detach, N_("detach HEAD at named commit")),
 		OPT_END()
 	};
@@ -316,6 +317,71 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, cmd.argv);
 }
 
+static int list(int ac, const char **av, const char *prefix)
+{
+	int primary = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "primary", &primary, N_("only list the primary worktree")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+
+	const char *work_tree;
+	work_tree = get_git_work_tree();
+	if (!work_tree)
+		die("This operation must be run in a work tree");
+
+	struct strbuf worktree_git_path = STRBUF_INIT;
+	strbuf_addf(&worktree_git_path, _("%s/.git"), work_tree);
+
+	struct strbuf primary_work_tree = STRBUF_INIT;
+	if (is_directory(worktree_git_path.buf)) {
+		/* This is the primary tree */
+		strbuf_addstr(&primary_work_tree, work_tree);
+	} else {
+		const char *git_dir = get_git_dir();
+		strbuf_addf(&primary_work_tree, "%.*s", (int)(strstr(git_dir, "/.git/") - git_dir), git_dir);
+	}
+	printf("%s\n", primary_work_tree.buf);
+
+	if (!primary) {
+		chdir( primary_work_tree.buf );
+		if ( is_directory(git_path("worktrees")) ) {
+			DIR *dir = opendir( git_path("worktrees") );
+			if (dir != NULL) {
+		   	struct dirent *d;
+				struct stat st;
+				char *path;
+				int fd, len;
+				while ((d = readdir(dir)) != NULL) {
+					if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+						continue;
+					if (stat(git_path("worktrees/%s/gitdir", d->d_name), &st))
+						continue;
+					fd = open(git_path("worktrees/%s/gitdir", d->d_name), O_RDONLY);
+					if (fd < 0)
+						continue;
+	
+					len = st.st_size;
+					path = xmalloc(len + 1);
+					read_in_full(fd, path, len);
+					close(fd);
+
+					printf("%.*s\n", (int)(strstr(path, "/.git") - path), path);
+					free(path);
+				}
+			}
+			closedir(dir);
+		}
+	}
+	strbuf_release(&primary_work_tree);
+	strbuf_release(&worktree_git_path);
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -328,5 +394,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "list"))
+		return list(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
new file mode 100755
index 0000000..ff48d72
--- /dev/null
+++ b/t/t2027-worktree-list.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='test git worktree list'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init
+'
+
+
+test_expect_success '"list" all worktrees from primary' '
+	orig_path=$PWD &&
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	(
+		cd here &&
+		git rev-parse --show-toplevel >>"$orig_path/expect" &&
+		cd "$orig_path" &&
+		git worktree list >actual &&
+		test_cmp expect actual &&
+		rm -rf here &&
+		git worktree prune
+	)
+'
+test_expect_success '"list" all worktrees from linked' '
+	orig_path=$PWD &&
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	(
+		cd here &&
+		git rev-parse --show-toplevel >>"$orig_path/expect" &&
+		git worktree list >actual &&
+		test_cmp "$orig_path/expect" actual &&
+		cd "$orig_path" &&
+		rm -rf here &&
+		git worktree prune
+	)
+'
+
+test_expect_success '"list" main worktree from primary' '
+	orig_path=$PWD &&
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	(
+		cd here &&
+		cd "$orig_path" &&
+		git worktree list --primary >actual &&
+		test_cmp expect actual &&
+		rm -rf here &&
+		git worktree prune
+	)
+'
+test_expect_success '"list" main worktree from linked' '
+	orig_path=$PWD &&
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	(
+		cd here &&
+		git worktree list --primary >actual &&
+		test_cmp "$orig_path/expect" actual &&
+		cd "$orig_path" &&
+		rm -rf here &&
+		git worktree prune
+	)
+'
+
+test_done
-- 
2.5.0
