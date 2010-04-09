From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP PATCH 3/4] Teach checkout to recursively checkout submodules
Date: Fri, 09 Apr 2010 23:39:21 +0200
Message-ID: <4BBF9E89.3010806@web.de>
References: <4BBF9D6F.2000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 23:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0LvE-0008TS-5P
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887Ab0DIVjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 17:39:23 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49445 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230Ab0DIVjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 17:39:22 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0528D14D13B42;
	Fri,  9 Apr 2010 23:39:22 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0Lv7-0006SO-00; Fri, 09 Apr 2010 23:39:21 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BBF9D6F.2000006@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19EOJxRxbs3BWKzRJwQPq+Uo6Bnr9MjDHEkp/jG
	x8xfF56MvAmyTSImnLNZbaOe6FsKir1mpRrmBkWDqfgFlMRXxm
	m1Db97vFnZs+UHhIb4Sg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144477>

Change the default behavior of "git checkout" to check out submodules
too. This can be prevented by using the new "--ignore-submodules" option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-checkout.txt |    7 +++++++
 builtin/checkout.c             |    7 ++++++-
 t/t2013-checkout-submodule.sh  |   14 ++++++++++++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4505eb6..63ac3bc 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -144,6 +144,13 @@ the conflicted merge in the specified paths.
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree.

+--ignore-submodules::
+	Since version 1.8.0 the default behavior is to checkout populated
+	submodules recursively. When this option is used, the work trees of
+	submodules will not be updated, only the hash recorded in the
+	superproject will be changed (this was the default behavior until
+	1.8.0).
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ee198ae..0008ec5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -31,6 +31,7 @@ struct checkout_opts {
 	int force;
 	int writeout_stage;
 	int writeout_error;
+	int ignore_submodules;

 	const char *new_branch;
 	const char *new_orphan_branch;
@@ -248,7 +249,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	memset(&state, 0, sizeof(state));
 	state.force = 1;
 	state.refresh_cache = 1;
-	state.ignore_submodules = 1;
+	state.ignore_submodules = opts->ignore_submodules;
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
@@ -314,6 +315,7 @@ static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 	opts.verbose_update = !o->quiet;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.ignore_submodules = o->ignore_submodules;
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
@@ -393,6 +395,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir = ".gitignore";
+		topts.ignore_submodules = opts->ignore_submodules;
 		tree = parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
@@ -649,6 +652,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  "second guess 'git checkout no-such-branch'",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		OPT_BOOLEAN(0, "ignore-submodules", &opts.ignore_submodules,
+			    "don't update submodule work trees"),
 		OPT_END(),
 	};
 	int has_dash_dash;
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index fda3f0a..e5f2e6e 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -29,14 +29,24 @@ test_expect_success '"reset <submodule>" updates the index' '
 	git diff-files --quiet
 '

-test_expect_success '"checkout <submodule>" updates the index only' '
+test_expect_success '"checkout --ignore-submodules <submodule>" updates the index only' '
 	git update-index --refresh &&
 	git diff-files --quiet &&
 	git diff-index --quiet --cached HEAD &&
-	git checkout HEAD^ submodule &&
+	git checkout --ignore-submodules HEAD^ submodule &&
 	test_must_fail git diff-files --quiet &&
 	git checkout HEAD submodule &&
 	git diff-files --quiet
 '

+test_expect_success '"checkout <submodule>" updates recursively' '
+	git update-index --refresh &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout HEAD^ submodule &&
+	git diff-files --quiet &&
+	git checkout HEAD submodule &&
+	git diff-files --quiet
+'
+
 test_done
-- 
1.7.1.rc0.248.g09203
