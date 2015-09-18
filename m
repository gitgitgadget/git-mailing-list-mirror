From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v8 4/4] worktree: add 'list' command
Date: Fri, 18 Sep 2015 09:30:27 -0400
Message-ID: <1442583027-47653-5-git-send-email-rappazzo@gmail.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 18 15:31:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcvl1-0005du-GC
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 15:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbbIRNbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 09:31:13 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:32829 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbbIRNbK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 09:31:10 -0400
Received: by qgev79 with SMTP id v79so38308854qge.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DZ0YrK+VoOIzzWT8jueX+HP4IZXBDRCFWCnEgGrK+xc=;
        b=Ph3/WfDt94M7xKq77cD/v58Lnm5XzjYmONkl+vP4MTtBGO/5WEE5As3SOlr/qgFarP
         p+3+6FKt0zjdc0f9Ph/POSrDN/1sXuXUD5TrmDGXD+rrIKpJtwuZHLLhjEpthfdreGy6
         GBeoS3cZAlKDnYaxZuz6+adP8JuXAkZnO/5q4sJIgUOu4rEKqAc5Lv4gxgk5lRlz3HcI
         ERFm/ul4/gHKYpLOlNk29z4OiQg3RiC1iRAzzDZxkViAqOhhgWu7JacPiPmph/mNNKIV
         2r6f4L7GrdD9aB/oJ5hSiZjjREEnJCzI0vjMJzZsmF8QOX1FUeLfE5eLaLs1GOLwhJgP
         c1cA==
X-Received: by 10.141.23.69 with SMTP id z66mr6718171qhd.55.1442583069209;
        Fri, 18 Sep 2015 06:31:09 -0700 (PDT)
Received: from localhost.localdomain (109.sub-70-199-70.myvzw.com. [70.199.70.109])
        by smtp.gmail.com with ESMTPSA id i19sm3586051qkh.13.2015.09.18.06.31.07
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2015 06:31:08 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278192>

'git worktree list' iterates through the worktree list, and outputs
details of the worktree including the path to the worktree, the currently
checked out revision and branch, and if the work tree is bare.  There is
also porcelain format option available.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-worktree.txt | 15 +++++++-
 builtin/worktree.c             | 78 ++++++++++++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       | 86 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index fb68156..8ee65c6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree list' [--porcelain]
 
 DESCRIPTION
 -----------
@@ -59,6 +60,13 @@ prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
 
+list::
+
+List details of each worktree.  The main worktree is listed first, followed by
+each of the linked worktrees.  The output details include if the worktree is
+bare, the revision currently checked out, and the branch currently checked out
+(or 'detached HEAD' if none).
+
 OPTIONS
 -------
 
@@ -86,6 +94,11 @@ OPTIONS
 	With `prune`, do not remove anything; just report what it would
 	remove.
 
+--porcelain::
+	With `list`, output in an easy-to-parse format for scripts.
+	This format will remain stable across Git versions and regardless of user
+	configuration.
+
 -v::
 --verbose::
 	With `prune`, report all removals.
@@ -93,6 +106,7 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
 
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
@@ -167,7 +181,6 @@ performed manually, such as:
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
 - `mv` to move or rename a working tree and update its administrative files
-- `list` to list linked working trees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a working tree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 71bb770..e6e36ac 100644
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
 
@@ -359,6 +362,79 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, branch, &opts);
 }
 
+static void show_worktree_porcelain(struct worktree *worktree)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addf(&sb, "worktree %s\n", worktree->path);
+	if (worktree->is_bare)
+		strbuf_addstr(&sb, "bare");
+	else {
+		if (worktree->is_detached)
+			strbuf_addf(&sb, "detached at %s", find_unique_abbrev(worktree->head_sha1, DEFAULT_ABBREV));
+		else
+			strbuf_addf(&sb, "branch %s", shorten_unambiguous_ref(worktree->head_ref, 0));
+	}
+
+	printf("%s\n\n", sb.buf);
+
+	strbuf_release(&sb);
+}
+static void show_worktree(struct worktree *worktree, int path_maxlen)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	int cur_len = strlen(worktree->path);
+	int utf8_adj = cur_len - utf8_strwidth(worktree->path);
+	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + utf8_adj, worktree->path);
+	if (worktree->is_bare)
+		strbuf_addstr(&sb, "(bare)");
+	else {
+		strbuf_addf(&sb, "%s ", find_unique_abbrev(worktree->head_sha1, DEFAULT_ABBREV));
+		if (!worktree->is_detached)
+			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(worktree->head_ref, 0));
+		else
+			strbuf_addstr(&sb, "(detached HEAD)");
+	}
+	printf("%s\n", sb.buf);
+
+	strbuf_release(&sb);
+}
+
+static int list(int ac, const char **av, const char *prefix)
+{
+	int porcelain = 0;
+
+	struct option options[] = {
+		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+	else {
+		struct worktree **worktrees = get_worktrees();
+		int path_maxlen = 0;
+
+		if (!porcelain) {
+			for (int i = 0; worktrees[i]; i++) {
+				int len = strlen(worktrees[i]->path);
+				if (len > path_maxlen)
+					path_maxlen = len;
+			}
+		}
+		for (int i = 0; worktrees[i]; i++) {
+			if (porcelain)
+				show_worktree_porcelain(worktrees[i]);
+			else
+				show_worktree(worktrees[i], path_maxlen);
+		}
+		free_worktrees(worktrees);
+	}
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -371,5 +447,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "list"))
+		return list(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
new file mode 100755
index 0000000..b68dfb4
--- /dev/null
+++ b/t/t2027-worktree-list.sh
@@ -0,0 +1,86 @@
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
+	echo "$(git rev-parse --show-toplevel)       $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	git worktree add --detach here master &&
+	test_when_finished "rm -rf here && git worktree prune" &&
+	echo "$(git -C here rev-parse --show-toplevel)  $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git worktree list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees from linked' '
+	echo "$(git rev-parse --show-toplevel)       $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	git worktree add --detach here master &&
+	test_when_finished "rm -rf here && git worktree prune" &&
+	echo "$(git -C here rev-parse --show-toplevel)  $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C here worktree list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain' '
+	echo "worktree $(git rev-parse --show-toplevel)" >expect &&
+	echo "branch $(git symbolic-ref --short HEAD)" >>expect &&
+	echo >>expect &&
+	git worktree add --detach here master &&
+	test_when_finished "rm -rf here && git worktree prune" &&
+	echo "worktree $(git -C here rev-parse --show-toplevel)" >>expect &&
+	echo "detached at $(git rev-parse --short HEAD)" >>expect &&
+	echo >>expect &&
+	git worktree list --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bare repo setup' '
+	git init --bare bare1 &&
+	echo "data" >file1 &&
+	git add file1 &&
+	git commit -m"File1: add data" &&
+	git push bare1 master &&
+	git reset --hard HEAD^
+'
+
+test_expect_success '"list" all worktrees from bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	echo "$(pwd)/bare1  (bare)" >expect &&
+	echo "$(git -C there rev-parse --show-toplevel)  $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C bare1 worktree list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain from bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	echo "worktree $(pwd)/bare1" >expect &&
+	echo "bare" >>expect &&
+	echo >>expect &&
+	echo "worktree $(git -C there rev-parse --show-toplevel)" >>expect &&
+	echo "detached at $(git -C there rev-parse --short HEAD)" >>expect &&
+	echo >>expect &&
+	git -C bare1 worktree list --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees from linked with a bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	echo "$(pwd)/bare1  (bare)" >expect &&
+	echo "$(git -C there rev-parse --show-toplevel)  $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C there worktree list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bare repo cleanup' '
+	rm -rf bare1
+'
+
+test_done
-- 
2.5.0
