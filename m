From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] git checkout: create unparented branch by --orphan
Date: Thu, 18 Mar 2010 13:09:39 -0300
Message-ID: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 17:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsIIj-0002DF-NM
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 17:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab0CRQKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 12:10:19 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:29476 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab0CRQKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 12:10:17 -0400
Received: by qw-out-2122.google.com with SMTP id 8so403057qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=shuJ5b1+f2Lib+kAoTwLlWrQ8TF5F8XCWtVXy+EEIdc=;
        b=kT3x1ruSNPTFjXe30D4N1VDv+rmUwkJmusEmsmjNb2EBuU734nUS5GIE0hhss6PC2m
         Jz6klfxrFqvNYNjlB5ePSxoiO/Tfy2uuh38+y5Sf3SPB5/Ya3oHY4WE1Sj2/q5lBTAPm
         IGXhRC03na1mYzd0VKb+NnzMAVH2cu4bF6iD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bC2rIxUXX7+/4fI+pj68onDILTYa0XmfBY7HE/RryF/7mF9RWLdxbvUpPbQ4VbgfUe
         kyjxEkzGttdYZPP9YfKoyAJF7d9h5tiueu5qd3PLa11rAEqr4nu8NSCYN4WR1/AYvJ24
         ha1sD9AjpkrAWL4FqN3jt2CrKuxdnJ0cupWAc=
Received: by 10.224.83.85 with SMTP id e21mr813367qal.227.1268928615105;
        Thu, 18 Mar 2010 09:10:15 -0700 (PDT)
Received: from localhost.localdomain ([187.15.42.217])
        by mx.google.com with ESMTPS id 21sm57394qyk.13.2010.03.18.09.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 09:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.280.g460a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142480>

Similar to -b, --orphan creates a new branch, but it starts without any
commit.  After running "git checkout --orphan newbranch", you are on a
new branch "newbranch", and the first commit you create from this state
will start a new history without any ancestry.

"git checkout --orphan" keeps the index and the working tree files
intact in order to make it convenient for creating a new history whose
trees resemble the ones from the original branch.

When creating a branch whose trees have no resemblance to the ones from
the original branch, it may be easier to start work on the new branch by
untracking and removing all working tree files that came from the
original branch, by running a 'git rm -rf .' immediately after running
"checkout --orphan".

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---

Complete rewrite of --orphan functionality to fit it in the new design goals
set by Junio.  Now --orphan is not anymore an option of -b.  It is an
alternative to it.

Junio:  I ask you to reconsider only the giving of the "short-and-sweet" -o
from beginning because of the new design.

As it is now an alternative to -b, doing similar stuff, I think it will be nice
if they look similar too.  So the it will be [[-b|-o] <new_branch>] not
[[-b|--orphan] <new_branch>].

Please ignore it if you can preview future options to checkout that could take
the rest of the 21 remaining letters and 6 digits.

Regards

 Documentation/git-checkout.txt |   21 +++++++++++++++-
 builtin/checkout.c             |   19 +++++++++++++-
 t/t2017-checkout-orphan.sh     |   53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100755 t/t2017-checkout-orphan.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..18df834 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m] [[-b|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
 
@@ -20,6 +20,19 @@ When <paths> are not given, this command switches branches by
 updating the index, working tree, and HEAD to reflect the specified
 branch.
 
+When you use "--orphan", a new unparented branch is created having the
+index and the working tree intact.  This allows you to start a new
+history that records set of paths similar to that of the start-point
+commit, which is useful when you want to keep different branches for
+different audiences you are working to like when you have an open source
+and commercial versions of a software, for example.
+
+If you want to start a disconnected history that records set of paths
+totally different from the original branch, you may want to first clear
+the index and the working tree, by running "git rm -rf ." from the
+top-level of the working tree, before preparing your files (by copying
+from elsewhere, extracting a tarball, etc.) in the working tree.
+
 If `-b` is given, a new branch is created and checked out, as if
 linkgit:git-branch[1] were called; in this case you can
 use the --track or --no-track options, which will be passed to `git
@@ -63,6 +76,12 @@ entries; instead, unmerged entries are ignored.
 	When checking out paths from the index, check out stage #2
 	('ours') or #3 ('theirs') for unmerged paths.
 
+--orphan::
+	Create a new branch named <new_branch>, unparented to any other
+	branch.  The new branch you switch to does not have any commit
+	and after the first one it will become the root of a new history
+	completely unconnected from all the other branches.
+
 -b::
 	Create a new branch named <new_branch> and start it at
 	<start_point>; see linkgit:git-branch[1] for details.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acefaaf..9e0af6a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,7 @@ struct checkout_opts {
 	int writeout_error;
 
 	const char *new_branch;
+	const char *new_orphan_branch;
 	int new_branch_log;
 	enum branch_track track;
 };
@@ -491,8 +492,15 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc;
 	if (opts->new_branch) {
-		create_branch(old->name, opts->new_branch, new->name, 0,
-			      opts->new_branch_log, opts->track);
+		if (opts->new_orphan_branch) {
+			unsigned char rev[20];
+			int flag;
+			if (old->path != resolve_ref("HEAD", rev, 0, &flag))
+				cmd_checkout(1, &old->name, NULL);
+		}
+		else
+			create_branch(old->name, opts->new_branch, new->name, 0,
+				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
 	}
@@ -629,6 +637,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new unparented branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -677,6 +686,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = argv0 + 1;
 	}
 
+	if (opts.new_orphan_branch) {
+		if (opts.new_branch)
+			die("--orphan and -b are mutually exclusive");
+		opts.new_branch = opts.new_orphan_branch;
+	}
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
new file mode 100755
index 0000000..e6d88b1
--- /dev/null
+++ b/t/t2017-checkout-orphan.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Erick Mattos
+#
+
+test_description='git checkout --orphan
+
+Main Tests for --orphan functionality.'
+
+. ./test-lib.sh
+
+TEST_FILE=foo
+
+test_expect_success 'Setup' '
+	echo "Initial" >"$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "First Commit"
+	test_tick &&
+	echo "State 1" >>"$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Second Commit"
+'
+
+test_expect_success '--orphan creates a new orphan branch from HEAD' '
+	git checkout --orphan alpha &&
+	test_must_fail PAGER= git log >/dev/null 2>/dev/null &&
+	test "alpha" = "$(git symbolic-ref HEAD | sed "s,.*/,,")" &&
+	test_tick &&
+	git commit -m "Third Commit" &&
+	test 0 -eq $(git cat-file -p HEAD | grep "^parent" | wc -l) &&
+	git cat-file -p master | grep "^tree" >base &&
+	git cat-file -p HEAD | grep "^tree" >actual &&
+	test_cmp base actual
+'
+
+test_expect_success '--orphan creates a new orphan branch from <start_point>' '
+	git checkout master &&
+	git checkout --orphan beta master^ &&
+	test_must_fail PAGER= git log >/dev/null 2>/dev/null &&
+	test "beta" = "$(git symbolic-ref HEAD | sed "s,.*/,,")" &&
+	test_tick &&
+	git commit -m "Fourth Commit" &&
+	test 0 -eq $(git cat-file -p HEAD | grep "^parent" | wc -l) &&
+	git cat-file -p master^ | grep "^tree" >base &&
+	git cat-file -p HEAD | grep "^tree" >actual &&
+	test_cmp base actual
+'
+
+test_expect_success '--orphan must be rejected with -b' '
+	test_must_fail git checkout --orphan new -b newer
+'
+
+test_done
-- 
1.7.0.2.280.g460a6
