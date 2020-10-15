Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79BAC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AED21527
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391116AbgJOSy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgJOSy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 14:54:29 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Oct 2020 11:54:29 PDT
Received: from coral.adamspiers.org (coral.adamspiers.org [IPv6:2001:ba8:1f1:f27f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 503E1C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 11:54:29 -0700 (PDT)
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
        by coral.adamspiers.org (Postfix) with ESMTPSA id 280E32E62A
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 19:47:49 +0100 (BST)
From:   Adam Spiers <git@adamspiers.org>
To:     git list <git@vger.kernel.org>
Subject: [PATCH v1] hook: add sample template for push-to-checkout
Date:   Thu, 15 Oct 2020 19:47:03 +0100
Message-Id: <20201015184703.5015-1-git@adamspiers.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The template is a more-or-less exact translation to shell of the C
code for the default behaviour for git's push-to-checkout hook defined
in the push_to_deploy() function in builtin/receive-pack.c, to serve
as a convenient starting point for modification.

It also contains relevant text extracted from the git-config(1) and
githooks(5) man pages.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 templates/hooks--push-to-checkout.sample | 74 ++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 templates/hooks--push-to-checkout.sample

diff --git a/templates/hooks--push-to-checkout.sample b/templates/hooks--push-to-checkout.sample
new file mode 100755
index 0000000000..2c6e06f8f1
--- /dev/null
+++ b/templates/hooks--push-to-checkout.sample
@@ -0,0 +1,74 @@
+#!/bin/bash
+
+# An example hook script to update a checked-out tree on a git push.
+#
+# This hook is invoked by git-receive-pack(1) when it reacts to git
+# push and updates reference(s) in its repository, and when the push
+# tries to update the branch that is currently checked out and the
+# receive.denyCurrentBranch configuration variable is set to
+# updateInstead.
+#
+# By default, such a push is refused if the working tree and the index
+# of the remote repository has any difference from the currently
+# checked out commit; when both the working tree and the index match
+# the current commit, they are updated to match the newly pushed tip
+# of the branch. This hook is to be used to override the default
+# behaviour; however the code below reimplements the default behaviour
+# as a starting point for convenient modification.
+#
+# The hook receives the commit with which the tip of the current
+# branch is going to be updated:
+commit="$1"
+#echo "push-to-checkout $commit"
+
+# It can exit with a non-zero status to refuse the push (when it does
+# so, it must not modify the index or the working tree).
+die () {
+    echo >&2 "$*"
+    exit 1
+}
+
+# Or it can make any necessary changes to the working tree and to the
+# index to bring them to the desired state when the tip of the current
+# branch is updated to the new commit, and exit with a zero status.
+#
+# For example, the hook can simply run git read-tree -u -m HEAD "$1"
+# in order to emulate git fetch that is run in the reverse direction
+# with git push, as the two-tree form of git read-tree -u -m is
+# essentially the same as git switch or git checkout that switches
+# branches while keeping the local changes in the working tree that do
+# not interfere with the difference between the branches.
+
+# The below is a more-or-less exact translation to shell of the C code
+# for the default behaviour for git's push-to-checkout hook defined in
+# the push_to_deploy() function in builtin/receive-pack.c.
+#
+# Note that the hook will be executed from the repository directory,
+# not from the working tree, so if you want to perform operations on
+# the working tree, you will have to adapt your code accordingly, e.g.
+# by adding "cd .." or using relative paths.
+
+if ! git update-index -q --ignore-submodules --refresh; then
+    die "Up-to-date check failed"
+fi
+
+if ! git diff-files --quiet --ignore-submodules --; then
+    die "Working directory has unstaged changes"
+fi
+
+# This is a rough translation of:
+#
+#    head_has_history() ? "HEAD" : EMPTY_TREE_SHA1_HEX
+if git cat-file -t HEAD >&/dev/null; then
+    head=HEAD
+else
+    head=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+fi
+
+if ! git diff-index --quiet --cached --ignore-submodules $head --; then
+    die "Working directory has staged changes"
+fi
+
+if ! git read-tree -u -m $commit; then
+    die "Could not update working tree to new HEAD"
+fi
-- 
2.26.1

