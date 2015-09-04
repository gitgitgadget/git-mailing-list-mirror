From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v7 3/3] worktree: add 'list' command
Date: Fri,  4 Sep 2015 17:39:29 -0400
Message-ID: <1441402769-35897-4-git-send-email-rappazzo@gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 04 23:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXyi6-0000FJ-PB
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933933AbbIDVjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:39:47 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35898 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933918AbbIDVjp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:39:45 -0400
Received: by igcrk20 with SMTP id rk20so21713936igc.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooOxjK8NZAfx/ss9VDsR50r11u6ma2VFYyA4soGi8Rg=;
        b=PryuwRThRMFLG9DLcZm7G4i+fK2Cb56Aqs9u6UpBwkCB4hrlPdboEtwgNp7UKwFkoa
         cBaLHT3qzaN8q8MaLddKiDv2kDHiakuXKhqaP3v4JQ3lDE9w8HMxJRpB/orICoelhpB7
         hhUTSaUPbe7afjlDD6BqfcrJvIrzwETKODTaQ903dORUKyjoO06h23U9IxoINWYQFhTk
         qQDbABJosn9OKi3ZKstVuzQqN8wkVVcJ6mhef+/MPiByl+Owd4gK/c4JhLnU3+DuYn12
         +0sK6ouALIw4mCessCDt3MWLWRRNr6secw1uUmoM4w9nbJ7W8FR/y5pq8v68UJBLSxfp
         9mRg==
X-Received: by 10.50.138.69 with SMTP id qo5mr10715308igb.33.1441402784858;
        Fri, 04 Sep 2015 14:39:44 -0700 (PDT)
Received: from localhost.localdomain (155.sub-70-208-71.myvzw.com. [70.208.71.155])
        by smtp.gmail.com with ESMTPSA id vk8sm2325936igb.4.2015.09.04.14.39.43
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Sep 2015 14:39:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277337>

'git worktree list' iterates through the worktree list, and outputs
the worktree dir.  By default, only the worktree path is output.

Supported options include:
	--skip-bare: do not output bare worktrees
	--verbose: include the current head and ref (if applicable), also
		decorate bare worktrees

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-worktree.txt |  10 +++-
 builtin/worktree.c             |  63 +++++++++++++++++++++
 t/t2027-worktree-list.sh       | 122 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index fb68156..b9339ed 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree list' [-v] [--skip-bare]
 
 DESCRIPTION
 -----------
@@ -59,6 +60,10 @@ prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
 
+list::
+
+List the main worktree followed by each of the linked worktrees.
+
 OPTIONS
 -------
 
@@ -89,10 +94,14 @@ OPTIONS
 -v::
 --verbose::
 	With `prune`, report all removals.
+	With `list`, show more information about each worktree.  This includes
+	if the worktree is bare, the revision currently checked out, and the
+	branch currently checked out (or 'detached HEAD' if none).
 
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
 
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
@@ -167,7 +176,6 @@ performed manually, such as:
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
 - `mv` to move or rename a working tree and update its administrative files
-- `list` to list linked working trees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a working tree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 71bb770..a0c0fe8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -8,10 +8,13 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "refs.h"
+#include "utf8.h"
+#include "worktree.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> <branch>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree list [<options>]"),
 	NULL
 };
 
@@ -359,6 +362,64 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, branch, &opts);
 }
 
+static int list(int ac, const char **av, const char *prefix)
+{
+	int no_bare = 0;
+
+	struct option options[] = {
+		OPT_BOOL(0, "skip-bare", &no_bare,  N_("exclude bare worktrees from the list")),
+		OPT__VERBOSE(&verbose, N_("include more worktree details")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+	else {
+		struct worktree_list *worktree_list = get_worktree_list();
+		struct worktree_list *orig = worktree_list;
+		struct strbuf sb = STRBUF_INIT;
+		int path_maxlen = 0;
+
+		if (verbose) {
+			while (worktree_list) {
+				int cur_len = strlen(worktree_list->worktree->path);
+				if (cur_len > path_maxlen)
+					path_maxlen = cur_len;
+				worktree_list = worktree_list->next ? worktree_list->next : NULL;
+			}
+			worktree_list = orig;
+		}
+		while (worktree_list) {
+			/* if this work tree is not bare OR if bare repos are to be shown (default) */
+			if (!worktree_list->worktree->is_bare || !no_bare) {
+				strbuf_reset(&sb);
+				if (!verbose)
+					strbuf_addstr(&sb, worktree_list->worktree->path);
+				else {
+					int cur_len = strlen(worktree_list->worktree->path);
+					int utf8_adj = cur_len - utf8_strwidth(worktree_list->worktree->path);
+					strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + utf8_adj, worktree_list->worktree->path);
+					if (worktree_list->worktree->is_bare)
+						strbuf_addstr(&sb, "(bare)");
+					else {
+						strbuf_addf(&sb, "%s ", find_unique_abbrev(worktree_list->worktree->head_sha1, DEFAULT_ABBREV));
+						if (!worktree_list->worktree->is_detached)
+							strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(worktree_list->worktree->head_ref, 0));
+						else
+							strbuf_addstr(&sb, "(detached HEAD)");
+					}
+				}
+				printf("%s\n", sb.buf);
+			}
+			worktree_list = worktree_list->next ? worktree_list->next : NULL;
+		}
+		worktree_list_release(orig);
+		strbuf_release(&sb);
+	}
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -371,5 +432,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "list"))
+		return list(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
new file mode 100755
index 0000000..246890c
--- /dev/null
+++ b/t/t2027-worktree-list.sh
@@ -0,0 +1,122 @@
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
+	echo "$(git rev-parse --show-toplevel)       $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	git worktree add --detach here master &&
+   echo "$(git -C here rev-parse --show-toplevel)  $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git worktree list --verbose >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success '"list" all worktrees --verbose from linked' '
+	echo "$(git rev-parse --show-toplevel)       $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	git worktree add --detach here master &&
+   echo "$(git -C here rev-parse --show-toplevel)  $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
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
+	echo "$(cd bare1 && pwd)" >expect &&
+	echo "$(git -C there rev-parse --show-toplevel)" >>expect &&
+	git -C bare1 worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees from bare main --skip-bare' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel)" >expect &&
+	git -C bare1 worktree list --skip-bare >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees from worktree with a bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(cd bare1 && pwd)" >expect &&
+	echo "$(git -C there rev-parse --show-toplevel)" >>expect &&
+	git -C there worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees from worktree with a bare main --skip-bare' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel)" >expect &&
+	git -C there worktree list --skip-bare >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees --verbose from bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+   echo "$(cd bare1 && pwd)  (bare)" >expect &&
+   echo "$(git -C there rev-parse --show-toplevel)  $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C bare1 worktree list --verbose >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+
+test_expect_success '"list" all worktrees --verbose from worktree with a bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+   echo "$(cd bare1 && pwd)  (bare)" >expect &&
+   echo "$(git -C there rev-parse --show-toplevel)  $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
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
