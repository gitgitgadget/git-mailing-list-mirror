From: Ray Zhang <zhanglei002@gmail.com>
Subject: [PATCH v2] worktree: add: introduce --checkout option
Date: Thu, 24 Mar 2016 06:07:03 +0000
Message-ID: <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 07:22:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiyf2-0001IA-L5
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 07:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbcCXGWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 02:22:21 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:38945
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151AbcCXGWU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 02:22:20 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Mar 2016 02:22:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458799623;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=pSuEiku+x0wA6ta6A9nYPQGhooMj+QylloLnN8+QIsA=;
	b=UDpE1IOuk07F7f0QLm+WQNv0dkZBWYbzzZcOxC+YQ1c26QE9c3AflXtZK420FasM
	Jr32e8QqO4iCC1P3hiZ/jxhlcNV7cU/zlrhsgmvD1KXp86v/orZwaljBErtHtcN0+4e
	kzmBZ8BGrUnpplYw6AxIiNlKjbN703Rci4D46XXk=
In-Reply-To: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.24-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289713>

By adding this option which defaults to true, we can use the
corresponding --no-checkout to make some customizations before
the checkout, like sparse checkout, etc.

Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
---
 Documentation/git-worktree.txt |  6 +++++-
 builtin/worktree.c             | 15 ++++++++++-----
 t/t2025-worktree-add.sh        |  5 +++++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 62c76c1..e96fe0f 100644
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
 
@@ -87,6 +87,10 @@ OPTIONS
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
+--checkout::
+	Default option with `add`, populate the new working tree. Use
+	`--no-checkout` to skip the checkout.
+
 -n::
 --dry-run::
 	With `prune`, do not remove anything; just report what it would
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 38b5609..e677cd7 100644
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
@@ -284,11 +285,13 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	cp.argv = NULL;
-	argv_array_clear(&cp.args);
-	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
-	cp.env = child_env.argv;
-	ret = run_command(&cp);
+	if (opts->checkout) {
+		cp.argv = NULL;
+		argv_array_clear(&cp.args);
+		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		cp.env = child_env.argv;
+		ret = run_command(&cp);
+	}
 	if (!ret) {
 		is_junk = 0;
 		free(junk_work_tree);
@@ -320,10 +323,12 @@ static int add(int ac, const char **av, const char *prefix)
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
index cbfa41e..601f963 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -213,4 +213,9 @@ test_expect_success 'local clone from linked checkout' '
 	( cd here-clone && git fsck )
 '
 
+test_expect_success '"add" worktree without a checkout' '
+	git worktree add --no-checkout -b swamp swamp &&
+	( cd swamp && git reset --hard && git fsck)
+'
+
 test_done

--
https://github.com/git/git/pull/217
