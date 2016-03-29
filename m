From: Ray Zhang <zhanglei002@gmail.com>
Subject: [PATCH v5] worktree: add: introduce --checkout option
Date: Tue, 29 Mar 2016 10:11:01 +0000
Message-ID: <01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 12:20:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akqlS-00033T-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 12:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbcC2KUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 06:20:42 -0400
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:48630
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752585AbcC2KUl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 06:20:41 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Mar 2016 06:20:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459246261;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=SZ41MArShhg6LVzfieMl6Y91mOQEA9/XCe/3N/M91BU=;
	b=AVP995FnHXpcFt3MsMZ7N+wbVULLr9MEfM/iFkdVQ/r0/2owCWD6adMBzGZw/tm5
	iTGjUxWEjj4x+9+IW3lSNTJtF3YNdRjKnQA2al3+FdZROyRXasq91LdngUiFh+g5NSZ
	DSVVRl8DBzi8P466uq4Os35x21lgj4dhgvofYT+4=
In-Reply-To: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.29-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290112>

By adding this option which defaults to true, we can use the
corresponding --no-checkout to make some customizations before
the checkout, like sparse checkout, etc.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
---
Changes since last version of this patch[v4]:
	t/t2025-worktree-add.sh: use test -e to test file existence.
	builtin/worktree.c: refactor the code a little bit.

[v4]: http://article.gmane.org/gmane.comp.version-control.git/290030
[v3]: http://article.gmane.org/gmane.comp.version-control.git/289877
[v2]: http://article.gmane.org/gmane.comp.version-control.git/289713
[v1]: http://article.gmane.org/gmane.comp.version-control.git/289659
---
 Documentation/git-worktree.txt |  8 +++++++-
 builtin/worktree.c             | 29 ++++++++++++++++++-----------
 t/t2025-worktree-add.sh        | 12 ++++++++++++
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 62c76c1..c622345 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree list' [--porcelain]
 
@@ -87,6 +87,12 @@ OPTIONS
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
+--[no-]checkout::
+	By default, `add` checks out `<branch>`, however, `--no-checkout` can
+	be used to suppress checkout in order to make customizations,
+	such as configuring sparse-checkout. See "Sparse checkout"
+	in linkgit:git-read-tree[1].
+
 -n::
 --dry-run::
 	With `prune`, do not remove anything; just report what it would
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 38b5609..d8e3795 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -21,6 +21,7 @@ static const char * const worktree_usage[] = {
 struct add_opts {
 	int force;
 	int detach;
+	int checkout;
 	const char *new_branch;
 	int force_new_branch;
 };
@@ -284,18 +285,22 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	cp.argv = NULL;
-	argv_array_clear(&cp.args);
-	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
-	cp.env = child_env.argv;
-	ret = run_command(&cp);
-	if (!ret) {
-		is_junk = 0;
-		free(junk_work_tree);
-		free(junk_git_dir);
-		junk_work_tree = NULL;
-		junk_git_dir = NULL;
+	if (opts->checkout) {
+		cp.argv = NULL;
+		argv_array_clear(&cp.args);
+		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		cp.env = child_env.argv;
+		ret = run_command(&cp);
+		if (ret)
+			goto done;
 	}
+
+	is_junk = 0;
+	free(junk_work_tree);
+	free(junk_git_dir);
+	junk_work_tree = NULL;
+	junk_git_dir = NULL;
+
 done:
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
@@ -320,10 +325,12 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
+		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_END()
 	};
 
 	memset(&opts, 0, sizeof(opts));
+	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index cbfa41e..3acb992 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -213,4 +213,16 @@ test_expect_success 'local clone from linked checkout' '
 	( cd here-clone && git fsck )
 '
 
+test_expect_success '"add" worktree with --no-checkout' '
+	git worktree add --no-checkout -b swamp swamp &&
+	! test -e swamp/init.t &&
+	git -C swamp reset --hard &&
+	test_cmp init.t swamp/init.t
+'
+
+test_expect_success '"add" worktree with --checkout' '
+	git worktree add --checkout -b swmap2 swamp2 &&
+	test_cmp init.t swamp2/init.t
+'
+
 test_done

--
https://github.com/git/git/pull/217
