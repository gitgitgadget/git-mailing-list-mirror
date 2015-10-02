From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v9 5/5] worktree: add 'list' command
Date: Fri,  2 Oct 2015 07:55:35 -0400
Message-ID: <1443786935-81131-6-git-send-email-rappazzo@gmail.com>
References: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Oct 02 13:56:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhywq-00027e-6l
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 13:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbbJBL4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 07:56:12 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33351 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbJBLzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 07:55:51 -0400
Received: by ykft14 with SMTP id t14so107993545ykf.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9I2sAt1HASEyyI0OjJ2fgYm5z2Rlay0Mjf3GxTmQu+w=;
        b=p5viKwJlFNijjcM0taMG2fjm1WBys5AVk+wqeXDYt4T1N3fPJT2Qx6JG2Wyz/YWbiK
         3U/wmtvmgHeDV2tagaT5grlor3msaZadZIVhMryYr3/DR3jzLGrbA8bUhWwrj4fTqnd1
         dGMZkwfTXwzDzver4rinJ7o+kQfpgnVXkXexvDRONRDelS+Y7dQcIIaBZytWjLWOHVFO
         nTMyrnlnonis79m1q4oKlYqaCqzqjsgsz357rpSiOvd1KgG5HkQi0AerAZ33EIlpe/dL
         YWeNzzDauBL9wcflUR9ah7M35AHTVV2trG1n4QuU0JZo6Xka/2TM4jO1v/9VVSYN3BX8
         7xZw==
X-Received: by 10.170.141.215 with SMTP id i206mr11860069ykc.51.1443786950645;
        Fri, 02 Oct 2015 04:55:50 -0700 (PDT)
Received: from localhost.localdomain (113.sub-70-208-69.myvzw.com. [70.208.69.113])
        by smtp.gmail.com with ESMTPSA id v4sm7550431ywf.5.2015.10.02.04.55.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 04:55:50 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278916>

'git worktree list' iterates through the worktree list, and outputs
details of the worktree including the path to the worktree, the currently
checked out revision and branch, and if the work tree is bare.  There is
also porcelain format option available.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-worktree.txt | 49 ++++++++++++++++++++++-
 builtin/worktree.c             | 82 ++++++++++++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       | 89 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index fb68156..5b9ad04 100644
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
+	configuration.  See below for details.
+
 -v::
 --verbose::
 	With `prune`, report all removals.
@@ -134,6 +147,41 @@ to `/path/main/.git/worktrees/test-next` then a file named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
 
+LIST OUTPUT FORMAT
+------------------
+The worktree list command has two output formats.  The default format shows the
+details on a single line with columns.  For example:
+
+------------
+S git worktree list
+/path/to/bare-source            (bare)
+/path/to/linked-worktree        abcd1234 [master]
+/path/to/other-linked-worktree  1234abc  (detached HEAD)
+------------
+
+Porcelain Format
+~~~~~~~~~~~~~~~~
+The porcelain format has a line per attribute.  Attributes are listed with a
+label and value separated by a single space.  Boolean attributes (like 'bare'
+and 'detached') are listed as a label only, and are only present if and only
+if the value is true.  An empty line indicates the end of a worktree.  For
+example:
+
+------------
+S git worktree list --porcelain
+worktree /path/to/bare-source
+bare
+
+worktree /path/to/linked-worktree
+HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
+branch refs/heads/master
+
+worktree /path/to/other-linked-worktree
+HEAD 1234abc1234abc1234abc1234abc1234abc1234a
+detached
+
+------------
+
 EXAMPLES
 --------
 You are in the middle of a refactoring session and your boss comes in and
@@ -167,7 +215,6 @@ performed manually, such as:
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
 - `mv` to move or rename a working tree and update its administrative files
-- `list` to list linked working trees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a working tree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 71bb770..268f9bf 100644
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
 
@@ -359,6 +362,83 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, branch, &opts);
 }
 
+static void show_worktree_porcelain(struct worktree *worktree)
+{
+	printf("worktree %s\n", worktree->path);
+	if (worktree->is_bare)
+		printf("bare\n");
+	else {
+		printf("HEAD %s\n", sha1_to_hex(worktree->head_sha1));
+		if (worktree->is_detached)
+			printf("detached\n");
+		else
+			printf("branch %s\n", worktree->head_ref);
+	}
+	printf("\n");
+}
+static void show_worktree(
+		struct worktree *worktree, int path_maxlen, int abbrev_len)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int cur_path_len = strlen(worktree->path);
+	int path_adj = cur_path_len - utf8_strwidth(worktree->path);
+
+	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, worktree->path);
+	if (worktree->is_bare)
+		strbuf_addstr(&sb, "(bare)");
+	else {
+		strbuf_addf(&sb, "%-*s ", abbrev_len,
+				find_unique_abbrev(worktree->head_sha1, DEFAULT_ABBREV));
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
+		int abbrev = 0;
+		int i;
+
+		if (!porcelain) {
+			for (i = 0; worktrees[i]; i++) {
+				int path_len = strlen(worktrees[i]->path);
+				if (path_len > path_maxlen)
+					path_maxlen = path_len;
+				int sha1_len = strlen(
+						find_unique_abbrev(worktrees[i]->head_sha1, DEFAULT_ABBREV));
+				if (sha1_len > abbrev)
+					abbrev = sha1_len;
+			}
+		}
+		for (i = 0; worktrees[i]; i++) {
+			if (porcelain)
+				show_worktree_porcelain(worktrees[i]);
+			else
+				show_worktree(worktrees[i], path_maxlen, abbrev);
+		}
+		free_worktrees(worktrees);
+	}
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -371,5 +451,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "list"))
+		return list(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
new file mode 100755
index 0000000..75ebb1b
--- /dev/null
+++ b/t/t2027-worktree-list.sh
@@ -0,0 +1,89 @@
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
+	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	test_when_finished "rm -rf here && git worktree prune" &&
+	git worktree add --detach here master &&
+	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git worktree list | sed "s/  */ /g" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees from linked' '
+	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	test_when_finished "rm -rf here && git worktree prune" &&
+	git worktree add --detach here master &&
+	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C here worktree list | sed "s/  */ /g" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain' '
+	echo "worktree $(git rev-parse --show-toplevel)" >expect &&
+	echo "HEAD $(git rev-parse HEAD)" >>expect &&
+	echo "branch $(git symbolic-ref HEAD)" >>expect &&
+	echo >>expect &&
+	test_when_finished "rm -rf here && git worktree prune" &&
+	git worktree add --detach here master &&
+	echo "worktree $(git -C here rev-parse --show-toplevel)" >>expect &&
+	echo "HEAD $(git rev-parse HEAD)" >>expect &&
+	echo "detached" >>expect &&
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
+	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(pwd)/bare1 (bare)" >expect &&
+	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain from bare main' '
+	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	git -C bare1 worktree add --detach ../there master &&
+	echo "worktree $(pwd)/bare1" >expect &&
+	echo "bare" >>expect &&
+	echo >>expect &&
+	echo "worktree $(git -C there rev-parse --show-toplevel)" >>expect &&
+	echo "HEAD $(git -C there rev-parse HEAD)" >>expect &&
+	echo "detached" >>expect &&
+	echo >>expect &&
+	git -C bare1 worktree list --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees from linked with a bare main' '
+	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(pwd)/bare1 (bare)" >expect &&
+	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C there worktree list | sed "s/  */ /g" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bare repo cleanup' '
+	rm -rf bare1
+'
+
+test_done
-- 
2.6.0
