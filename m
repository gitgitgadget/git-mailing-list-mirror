From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v6 2/2] worktree: add 'list' command
Date: Sun, 30 Aug 2015 15:10:39 -0400
Message-ID: <1440961839-40575-3-git-send-email-rappazzo@gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sun Aug 30 21:11:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW808-0007Wd-Rd
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 21:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbbH3TKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 15:10:47 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35600 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbbH3TKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 15:10:45 -0400
Received: by qgj40 with SMTP id 40so4387622qgj.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V9R98AHXrKfjt5i2v0JGrXdkIoKuPtcHW1ly6Kt2Nw8=;
        b=cQYtYrGo24Np94XBEKDK67rRk8wmHoVu/aX0qQqyT9ft6DrMtBA5dFzN34RMhaPqYw
         TnpPk13Jak/uz2m65B7+U2VFUsy8ThCEmF+GMuHy4JbG1QNs7KNBGmXzyG4dyL37e/UG
         U32EhM6LZDnBqAgUDi2q4MXx1SmOAaKrEkt32/4s8AVSlz8FOwVvcQkE0kzNaZ5t/KFU
         blzB6Rydd+peHRQi3C817AjkjsbiRgTDPwGgm1ajP2SxNlDytH0QAeNy4eUyK1lM1zvx
         pH8PTU05ybUN/YRZeGrW4IAnxmiwKaXnUc3RQRtV0ukBSr28nDXGB1KMWOHkcqoqWCiZ
         ejUg==
X-Received: by 10.140.147.69 with SMTP id 66mr33847567qht.57.1440961843859;
        Sun, 30 Aug 2015 12:10:43 -0700 (PDT)
Received: from MRappazzo.local.com (cpe-74-76-66-5.nycap.res.rr.com. [74.76.66.5])
        by smtp.gmail.com with ESMTPSA id 100sm7449213qky.6.2015.08.30.12.10.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2015 12:10:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276831>

'git worktree list' uses the for_each_worktree function to iterate,
and outputs the worktree dir.  With the verbose option set, it also
shows the branch or revision currently checked out in that worktree.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-worktree.txt |  10 ++++-
 builtin/worktree.c             |  42 +++++++++++++++++
 t/t2027-worktree-list.sh       | 100 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index fb68156..867a24a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree list' [-v|--verbose]
 
 DESCRIPTION
 -----------
@@ -59,6 +60,10 @@ prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
 
+list::
+
+List the main worktree followed by all of the linked worktrees.
+
 OPTIONS
 -------
 
@@ -88,11 +93,13 @@ OPTIONS
 
 -v::
 --verbose::
-	With `prune`, report all removals.
+	With `prune`, report all removals.  
+	With `list` show the branch or revision currently checked out in that worktree.
 
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
 
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
@@ -167,7 +174,6 @@ performed manually, such as:
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
 - `mv` to move or rename a working tree and update its administrative files
-- `list` to list linked working trees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a working tree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7b3cb96..6d96cdf 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -12,6 +12,7 @@
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> <branch>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree list [<options>]"),
 	NULL
 };
 
@@ -442,6 +443,45 @@ done:
 	return ret;
 }
 
+static int print_worktree_details(const char *path, const char *git_dir, void *cb_data)
+{
+	printf("%s", path);
+
+	if (verbose) {
+		enter_repo(git_dir, 1);
+		printf("  [");
+		unsigned char sha1[20];
+		int flag;
+
+		const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+		if (!(flag & REF_ISSYMREF)) {
+			printf("%s", find_unique_abbrev(sha1, DEFAULT_ABBREV));
+		} else {
+			refname = shorten_unambiguous_ref(refname, 0);
+			printf("%s", refname);
+		}
+
+		printf("]");
+	}
+	printf("\n");
+
+	return 0;
+}
+
+static int list(int ac, const char **av, const char *prefix)
+{
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("show the branch or revision currently checked out")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+
+	return for_each_worktree(&print_worktree_details, NULL);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -454,5 +494,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "list"))
+		return list(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
new file mode 100755
index 0000000..85bd243
--- /dev/null
+++ b/t/t2027-worktree-list.sh
@@ -0,0 +1,100 @@
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
+test_expect_success '"list" all worktrees from main' '
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	git -C here rev-parse --show-toplevel >>expect &&
+	git worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success '"list" all worktrees from linked' '
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	git -C here rev-parse --show-toplevel >>expect &&
+	git -C here worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success '"list" all worktrees --verbose from main' '
+	echo "$(git rev-parse --show-toplevel)  [$(git symbolic-ref --short HEAD)]" >expect &&
+	git worktree add --detach here master &&
+	echo "$(git -C here rev-parse --show-toplevel)  [$(git -C here rev-parse --short HEAD)]" >>expect &&
+	git worktree list --verbose >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success '"list" all worktrees --verbose from linked' '
+	echo "$(git rev-parse --show-toplevel)  [$(git symbolic-ref --short HEAD)]" >expect &&
+	git worktree add --detach here master &&
+	echo "$(git -C here rev-parse --show-toplevel)  [$(git -C here rev-parse --short HEAD)]" >>expect &&
+	git -C here worktree list --verbose >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success 'bare repo setup' '
+	git init --bare bare1 &&
+	echo "data" > file1 &&
+	git add file1 &&
+	git commit -m"File1: add data" &&
+	git push bare1 master &&
+	git reset --hard HEAD^
+'
+
+test_expect_success '"list" all worktrees from bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel)" >expect &&
+	git -C bare1 worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees from worktree with a bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel)" >expect &&
+	git -C there worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees --verbose from bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel)  [$(git -C there rev-parse --short HEAD)]" >expect &&
+	git -C bare1 worktree list --verbose >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees --verbose from worktree with a bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel)  [$(git -C there rev-parse --short HEAD)]" >expect &&
+	git -C there worktree list --verbose >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success 'bare repo cleanup' '
+	rm -rf bare1
+'
+
+test_done
-- 
2.5.0
