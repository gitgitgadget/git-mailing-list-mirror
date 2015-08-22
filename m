From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v5 2/2] worktree: add 'list' command
Date: Sat, 22 Aug 2015 17:51:34 -0400
Message-ID: <1440280294-50679-3-git-send-email-rappazzo@gmail.com>
References: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Aug 22 23:51:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTGhi-0001LV-CE
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 23:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbbHVVvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 17:51:42 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33817 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbHVVvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 17:51:41 -0400
Received: by qgeg42 with SMTP id g42so66263829qge.1
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwHKHSm2Nn14UbxMLDy8DIWqYPlmVqtGR34AKRP/mMA=;
        b=kWAhg6N+EGddPXfRWjMHUJ46DjzF2AkURFNbH/9F1nTZa1Zqf27w7f9duUGQUnh2m/
         KCuxrPAo1XoAY3Is2PvaaDloJQVYx6mhUzsoFj6ROG1sgDsR0O070LHCECYga5tJfwZA
         aOUj0F4pml+PmLBL2jUnJ90Z8YysTU5M8TtgSzuidiWW5U13ClcQiHzGm2huHzrad7wy
         npdJ+ACKNfI4wqWsTuLmIGJE6Qh/PMVL/q/Y1yRPOW9VrHH7pQgvX7Zeg03qJJ75bNDX
         EfVu30mSh3+TM5X2Qp8XQ6LgBw36L0nCb3GrnXTLkTdtXtvkiZLp9WaBK3MSZQ8nv8lz
         nXwQ==
X-Received: by 10.140.201.66 with SMTP id w63mr37237628qha.36.1440280300444;
        Sat, 22 Aug 2015 14:51:40 -0700 (PDT)
Received: from Macbook-wireless.gtnexus.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by smtp.gmail.com with ESMTPSA id v22sm982607qkv.45.2015.08.22.14.51.39
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Aug 2015 14:51:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276398>

'git worktree list' uses the for_each_worktree function to iterate,
and outputs in the format: '<worktree>  (<short-ref>)'

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-worktree.txt | 11 +++++-
 builtin/worktree.c             | 55 ++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       | 81 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index fb68156..e953b4e 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree list' [--path-only]
 
 DESCRIPTION
 -----------
@@ -59,6 +60,12 @@ prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
 
+list::
+
+List the main worktree followed by all of the linked worktrees.  The default
+format of the list includes the full path to the worktree and the branch or
+revision that the head of that worktree is currently pointing to.
+
 OPTIONS
 -------
 
@@ -93,6 +100,9 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
 
+--path-only
+	With `list`, only show the worktree path
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
@@ -167,7 +177,6 @@ performed manually, such as:
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
 - `mv` to move or rename a working tree and update its administrative files
-- `list` to list linked working trees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a working tree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7b3cb96..673f292 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -12,6 +12,7 @@
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> <branch>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree list [<options>]"),
 	NULL
 };
 
@@ -442,6 +443,58 @@ done:
 	return ret;
 }
 
+/* list callback data */
+struct list_opts {
+	int path_only;
+};
+
+static int print_worktree_details(const char *path, const char *git_dir, void *cb_data)
+{
+	struct strbuf head_file = STRBUF_INIT;
+	struct strbuf head_ref = STRBUF_INIT;
+	struct stat st;
+	struct list_opts *opts = cb_data;
+	const char *ref_prefix = "ref: refs/heads/";
+
+	strbuf_addf(&head_file, "%s/HEAD", git_dir);
+	if (!opts->path_only && !stat(head_file.buf, &st)) {
+		strbuf_read_file(&head_ref, head_file.buf, st.st_size);
+		strbuf_strip_suffix(&head_ref, "\n");
+
+		if (starts_with(head_ref.buf, ref_prefix)) {
+			/* branch checked out */
+			strbuf_remove(&head_ref, 0, strlen(ref_prefix));
+		/* } else {
+		 *  headless -- no-op
+		 */
+		}
+		printf("%s  (%s)\n", path, head_ref.buf);
+	} else {
+		printf("%s\n", path);
+	}
+
+	strbuf_release(&head_ref);
+	strbuf_release(&head_file);
+	return 0;
+}
+
+static int list(int ac, const char **av, const char *prefix)
+{
+	struct list_opts opts;
+	struct option options[] = {
+		OPT_BOOL(0, "path-only", &opts.path_only, N_("only show the path of the worktree")),
+		OPT_END()
+	};
+
+	opts.path_only = 0;
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+
+	return for_each_worktree(&print_worktree_details, &opts);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -454,5 +507,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "list"))
+		return list(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
new file mode 100755
index 0000000..66a635a
--- /dev/null
+++ b/t/t2027-worktree-list.sh
@@ -0,0 +1,81 @@
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
+	echo "$(git rev-parse --show-toplevel)  ($(git symbolic-ref --short HEAD))" >expect &&
+	git worktree add --detach here master &&
+	echo "$(git -C here rev-parse --show-toplevel)  ($(git -C here rev-parse HEAD))" >>expect &&
+	git worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success '"list" all worktrees from linked' '
+	echo "$(git rev-parse --show-toplevel)  ($(git symbolic-ref --short HEAD))" >expect &&
+	git worktree add --detach here master &&
+	echo "$(git -C here rev-parse --show-toplevel)  ($(git -C here rev-parse HEAD))" >>expect &&
+	git -C here worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success '"list" all worktrees from main --path-only' '
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	git -C here rev-parse --show-toplevel >>expect &&
+	git worktree list --path-only >actual &&
+	test_cmp expect actual &&
+	rm -rf here &&
+	git worktree prune
+'
+
+test_expect_success '"list" all worktrees from linked --path-only' '
+	git rev-parse --show-toplevel >expect &&
+	git worktree add --detach here master &&
+	git -C here rev-parse --show-toplevel >>expect &&
+	git -C here worktree list --path-only >actual &&
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
+	echo "$(git -C there rev-parse --show-toplevel)  ($(git -C there rev-parse HEAD))" >expect &&
+	git -C bare1 worktree list >actual &&
+	test_cmp expect actual &&
+	rm -rf there &&
+	git -C bare1 worktree prune
+'
+test_expect_success '"list" all worktrees from worktree with a bare main' '
+	git -C bare1 worktree add --detach ../there master &&
+	echo "$(git -C there rev-parse --show-toplevel)  ($(git -C there rev-parse HEAD))" >expect &&
+	git -C there worktree list >actual &&
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
