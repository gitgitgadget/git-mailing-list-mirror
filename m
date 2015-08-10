From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3] worktree: add 'list' command
Date: Mon, 10 Aug 2015 16:53:02 -0400
Message-ID: <1439239982-42826-2-git-send-email-rappazzo@gmail.com>
References: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Aug 10 22:53:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOu4c-0001SF-4k
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 22:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbbHJUxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 16:53:24 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35291 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757AbbHJUxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 16:53:03 -0400
Received: by qgj62 with SMTP id 62so101440473qgj.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/zCPLuMdCZEDIq2oc4j8rOT/9qeOoLZjJ2M4GtxyLIc=;
        b=iv4TYVjBKEi6O7cLTPduEV18lyuqCgmqpqOdW0zLr5aVhpN7eDme3UWBG1bfDN2HLE
         rsec1TxDDk1r+k9mS6YgEXBZXYUJIzNGJ7GnNAydy7ShzrDqg27ZRMG7GzxK37hkc/UF
         EHIe9cDsGofwjPnZnuehDHfCJxSvSTW+0khuwhupZ16A8qAymOIVbAd+EdcxpYTJUR1o
         QRkbFj0NfPc2qvsAKIHMK/QHk5Yg6jT7Gz/C12jl+66cOUYBkYWLH365Wo/E79iJKVgx
         qwjYNdp58XuftAVi9i2WZ+lgvBOj39OaMKRpn3qX37MHG38NiH6Ecdt49jxTg+wLcVDC
         vQuw==
X-Received: by 10.140.132.133 with SMTP id 127mr38164305qhe.6.1439239982777;
        Mon, 10 Aug 2015 13:53:02 -0700 (PDT)
Received: from MRappazzo.local.info (ool-45729006.dyn.optonline.net. [69.114.144.6])
        by smtp.gmail.com with ESMTPSA id d70sm8704784qkh.45.2015.08.10.13.53.01
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 13:53:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275654>

'git worktree list' will list the main worktree followed by any linked
worktrees which were created using 'git worktree add'.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-worktree.txt |  6 +++-
 builtin/worktree.c             | 67 ++++++++++++++++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       | 30 +++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3387e2f..efb8e9d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree list'
 
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
 
@@ -167,7 +172,6 @@ performed manually, such as:
 - `remove` to remove a linked worktree and its administrative files (and
   warn if the worktree is dirty)
 - `mv` to move or rename a worktree and update its administrative files
-- `list` to list linked worktrees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a worktree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6a264ee..d90bdee 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -10,6 +10,7 @@
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> <branch>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree list [<options>]"),
 	NULL
 };
 
@@ -316,6 +317,70 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, cmd.argv);
 }
 
+static int list(int ac, const char **av, const char *prefix)
+{
+	int main_only = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "main-only", &main_only, N_("only list the main worktree")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+
+	struct strbuf main_path = STRBUF_INIT;
+	const char* common_dir = get_git_common_dir();
+	int is_bare = is_bare_repository();
+	if (is_bare) {
+		strbuf_addstr(&main_path, absolute_path(common_dir));
+		strbuf_strip_suffix(&main_path, "/.");
+	} else if (!strcmp(common_dir, ".git")) {
+		/* within a worktree, the common dir only returns ".git" */
+		strbuf_addstr(&main_path, get_git_work_tree());
+	} else {
+		strbuf_addstr(&main_path, common_dir);
+		strbuf_strip_suffix(&main_path, "/.git");
+	}
+
+	printf("%s\n", main_path.buf);
+
+	if (!is_bare) {
+		strbuf_addstr(&main_path, "/.git");
+	}
+	strbuf_addstr(&main_path, "/worktrees");
+
+	if (is_directory(main_path.buf)) {
+		DIR *dir = opendir(main_path.buf);
+		if (dir) {
+			struct dirent *d;
+			struct stat st;
+			struct strbuf path = STRBUF_INIT;
+			struct strbuf other_worktree_path = STRBUF_INIT;
+			while ((d = readdir(dir)) != NULL) {
+				if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+					continue;
+				strbuf_reset(&other_worktree_path);
+				strbuf_addf(&other_worktree_path, "%s/%s/gitdir", main_path.buf, d->d_name);
+
+				if (stat(other_worktree_path.buf, &st))
+					continue;
+
+				strbuf_reset(&path);
+				strbuf_read_file(&path, other_worktree_path.buf, st.st_size);
+				strbuf_strip_suffix(&path, "/.git\n");
+
+				printf("%s\n", path.buf);
+			}
+			strbuf_release(&other_worktree_path);
+			strbuf_release(&path);
+		}
+		closedir(dir);
+	}
+	strbuf_release(&main_path);
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -328,5 +393,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "list"))
+		return list(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
new file mode 100755
index 0000000..8e3dbbc
--- /dev/null
+++ b/t/t2027-worktree-list.sh
@@ -0,0 +1,30 @@
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
+test_done
-- 
2.5.0
