From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Sun, 21 Mar 2010 12:34:38 -0300
Message-ID: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 16:34:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtNB0-00028k-5F
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 16:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab0CUPet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 11:34:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61686 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0CUPes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 11:34:48 -0400
Received: by gwaa18 with SMTP id a18so580671gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Sy2X57vZbOlWaM/xwA6P6ynRWL2k4cXPRnmY/uNX2x4=;
        b=uoqu5V7CvdAiwLI6AB2qGN35E6CZdsb+oczvfVVpiLzRXPJ2jsyepr48F8BaLtsnf0
         1+TVDMxYBRMH/OWoQ+2JEX09XqLsMGe5ox+WmCdxeQa4GBH/7nIRfDQkybO+Cqjrq6E9
         7oB9igozu9ni0R2z6399BR2fBtx4E4987buKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=r3fbfAbBb3Y0Tvcsll8l3+gPNpR9H7OBn6bU4oyF2S3ZjpL9ci0H37LiytDyKFF7dc
         q/zyjMRo2m/lRsNnnGHXr6GRdYl1lNWYxoSfZpU/yudH83et6DDnUZJTBNaFHofXoBOr
         TyUF/UqpVvJ+lOtN8dyf1TPRqGnnfFVn7HuoI=
Received: by 10.90.24.13 with SMTP id 13mr678794agx.84.1269185687058;
        Sun, 21 Mar 2010 08:34:47 -0700 (PDT)
Received: from localhost.localdomain ([187.15.37.88])
        by mx.google.com with ESMTPS id 7sm181080yxd.44.2010.03.21.08.34.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 08:34:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.324.g7eb48.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142831>

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

Final patch version (I think so... :-) ).

Added some further script tests by Junio.

 Documentation/git-checkout.txt |   21 +++++++++-
 builtin/checkout.c             |   15 ++++++-
 t/t2017-checkout-orphan.sh     |   90 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 3 deletions(-)
 create mode 100755 t/t2017-checkout-orphan.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..5a50997 100644
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
 
@@ -90,6 +90,25 @@ explicitly give a name with '-b' in such a case.
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
 
+--orphan::
+	Create a new branch named <new_branch>, unparented to any other
+	branch.  The new branch you switch to does not have any commit
+	and after the first one it will become the root of a new history
+	completely unconnected from all the other branches.
++
+When you use "--orphan", a new unparented branch is created having the
+index and the working tree intact.  This allows you to start a new
+history that records set of paths similar to that of the start-point
+commit, which is useful when you want to keep different branches for
+different audiences you are working to like when you have an open source
+and commercial versions of a software, for example.
++
+If you want to start a disconnected history that records set of paths
+totally different from the original branch, you may want to first clear
+the index and the working tree, by running "git rm -rf ." from the
+top-level of the working tree, before preparing your files (by copying
+from elsewhere, extracting a tarball, etc.) in the working tree.
+
 -m::
 --merge::
 	When switching branches,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acefaaf..37d8278 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,7 @@ struct checkout_opts {
 	int writeout_error;
 
 	const char *new_branch;
+	const char *new_orphan_branch;
 	int new_branch_log;
 	enum branch_track track;
 };
@@ -491,8 +492,9 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc;
 	if (opts->new_branch) {
-		create_branch(old->name, opts->new_branch, new->name, 0,
-			      opts->new_branch_log, opts->track);
+		if (!opts->new_orphan_branch)
+			create_branch(old->name, opts->new_branch, new->name, 0,
+				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
 	}
@@ -632,6 +634,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
+		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new unparented branch"),
 		OPT_SET_INT('2', "ours", &opts.writeout_stage, "stage",
 			    2),
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
@@ -677,6 +680,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = argv0 + 1;
 	}
 
+	if (opts.new_orphan_branch) {
+		if (opts.new_branch)
+			die("--orphan and -b are mutually exclusive");
+		if (opts.track > 0 || opts.new_branch_log)
+			die("--orphan should not be used with -t or -l");
+		opts.new_branch = opts.new_orphan_branch;
+	}
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
new file mode 100755
index 0000000..a8297c6
--- /dev/null
+++ b/t/t2017-checkout-orphan.sh
@@ -0,0 +1,90 @@
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
+	test_tick &&
+	git commit -m "Second Commit"
+'
+
+test_expect_success '--orphan creates a new orphan branch from HEAD' '
+	git checkout --orphan alpha &&
+	test_must_fail git rev-parse --verify HEAD &&
+	test "refs/heads/alpha" = "$(git symbolic-ref HEAD)" &&
+	test_tick &&
+	git commit -m "Third Commit" &&
+	test_must_fail git rev-parse --verify HEAD^ &&
+	git diff-tree --quiet master alpha
+'
+
+test_expect_success '--orphan creates a new orphan branch from <start_point>' '
+	git checkout master &&
+	git checkout --orphan beta master^ &&
+	test_must_fail git rev-parse --verify HEAD &&
+	test "refs/heads/beta" = "$(git symbolic-ref HEAD)" &&
+	test_tick &&
+	git commit -m "Fourth Commit" &&
+	test_must_fail git rev-parse --verify HEAD^ &&
+	git diff-tree --quiet master^ beta
+'
+
+test_expect_success '--orphan must be rejected with -b' '
+	git checkout master &&
+	test_must_fail git checkout --orphan new -b newer &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success '--orphan is rejected with an existing name' '
+	git checkout master &&
+	test_must_fail git checkout --orphan master &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success '--orphan refuses to switch if a merge is needed' '
+	git checkout master &&
+	git reset --hard &&
+	echo local >>"$TEST_FILE" &&
+	cat "$TEST_FILE" >"$TEST_FILE.saved" &&
+	test_must_fail git checkout --orphan gamma master^ &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)" &&
+	test_cmp "$TEST_FILE" "$TEST_FILE.saved" &&
+	git diff-index --quiet --cached HEAD &&
+	git reset --hard
+'
+
+test_expect_success '--orphan does not mix well with -t' '
+	git checkout master &&
+	test_must_fail git checkout -t master --orphan gamma &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success '--orphan ignores branch.autosetupmerge' '
+	git checkout -f master &&
+	git config branch.autosetupmerge always &&
+	git checkout --orphan delta &&
+	test -z "$(git config branch.delta.merge)" &&
+	test refs/heads/delta = "$(git symbolic-ref HEAD)" &&
+	test_must_fail git rev-parse --verify HEAD^
+'
+
+test_expect_success '--orphan does not mix well with -l' '
+	git checkout -f master &&
+	test_must_fail git checkout -l --orphan gamma
+'
+
+test_done
-- 
1.7.0.2.324.g7eb48.dirty
