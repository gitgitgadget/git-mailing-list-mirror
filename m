From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Tue,  9 Mar 2010 19:28:33 -0300
Message-ID: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 23:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np7vU-0004XO-Br
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 23:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab0CIW3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 17:29:09 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:56422 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0CIW3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 17:29:07 -0500
Received: by qw-out-2122.google.com with SMTP id 8so125073qwh.37
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 14:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DOIz+AAE/uFhesqcTxBGOqC1SOU6jB1eVUUay4cOVJo=;
        b=DGiHCbO6Ofp/diwhVCFaHB/0ZW/MLL+HlrGaRgWfgAuMooEc91yiTMIGOL8IUx4YiJ
         GlKfvybZY/k6WDKtr974ocJn2lP8Yp0Suwnt4Q6A1rbHLDJi61La6KcfNMxVy3gHxXC3
         pu1SkWsYEdLYrgRSyjO6+GUJN+lV/zu2CqeQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aowhStJqhYgDffVCk+SSyTnbimZJfuawl/RMBQD5TULq4LniJEqdMIRj9HFNr3+P4o
         SRQaC6lJmdBICS5kLIDFicdA894FAGZmsEc69WnucX+tAtFSFMvVmSom2ISGtY+Zy96+
         zmUAriGHDtMsMEVVtxqjlOVGGaqzFoqfqwky4=
Received: by 10.224.35.7 with SMTP id n7mr407048qad.279.1268173739972;
        Tue, 09 Mar 2010 14:28:59 -0800 (PST)
Received: from localhost.localdomain ([187.15.94.32])
        by mx.google.com with ESMTPS id 2sm16374336qwi.51.2010.03.09.14.28.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 14:28:59 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2.164.geccf6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141849>

Sometimes it is necessary to start up a new development branch of code
intended to be merged in the near future to existing branches but which
actually does not relate to them.

The new -o/--orphan is intended to solve this situation allowing the
creation of a new branch unparented to any other.

After the 'checkout -o -b' the new branch is not saved until some files are
added to the index and committed, exactly as if it was an initial commit.
A 'git clean -df' would delete everything from the work tree making it
empty for new files.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---

Changed the text in SYNOPSIS to correct it as noticed by Jakub Narebski.

Regards

 Documentation/git-checkout.txt |   10 ++++++++
 builtin-checkout.c             |   14 +++++++++-
 t/t2017-checkout-orphan.sh     |   50 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100755 t/t2017-checkout-orphan.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..c13ab62 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
+'git checkout' [-q] [-f] [-m] [-b <new_branch> [-o]]
 'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
@@ -25,6 +26,10 @@ linkgit:git-branch[1] were called; in this case you can
 use the --track or --no-track options, which will be passed to `git
 branch`.  As a convenience, --track without `-b` implies branch
 creation; see the description of --track below.
+When using -b, it is possible to use the option -o to set the new branch
+as unparented thus unrelated to the previous branch.  The new code will
+be committed by using 'git add' and 'git commit' as if it was an initial
+commit.
 
 When <paths> or --patch are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
@@ -86,6 +91,11 @@ explicitly give a name with '-b' in such a case.
 	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
 
+-o::
+--orphan::
+	When creating a new branch, set it up as unparented thus
+	unrelated to the previous branch.
+
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
diff --git a/builtin-checkout.c b/builtin-checkout.c
index c5ab783..4882613 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -34,6 +34,7 @@ struct checkout_opts {
 
 	const char *new_branch;
 	int new_branch_log;
+	int new_branch_orphan;
 	enum branch_track track;
 };
 
@@ -509,8 +510,13 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc;
 	if (opts->new_branch) {
-		create_branch(old->name, opts->new_branch, new->name, 0,
-			      opts->new_branch_log, opts->track);
+		if (opts->new_branch_orphan) {
+			discard_cache();
+			remove_path(get_index_file());
+		}
+		else
+			create_branch(old->name, opts->new_branch, new->name, 0,
+				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
 	}
@@ -647,6 +653,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_BOOLEAN('o', "orphan", &opts.new_branch_orphan, "make the new branch unparented"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -695,6 +702,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = argv0 + 1;
 	}
 
+	if (opts.new_branch_orphan && !opts.new_branch)
+		die("-o is used only with -b");
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
new file mode 100755
index 0000000..7170641
--- /dev/null
+++ b/t/t2017-checkout-orphan.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Erick Mattos
+#
+
+test_description='git checkout -b
+
+Tests for -o functionality.'
+
+. ./test-lib.sh
+
+TEST_FILE=foo
+
+test_expect_success 'Setup' '
+	echo "initial" > "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "First Commit"
+'
+
+test_expect_success '-b without -o checkout into a new clone branch' '
+	test_tick &&
+	echo "Test 1" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Second Commit" &&
+	git log --pretty=oneline > base &&
+	git checkout -b alpha &&
+	test "alpha" = "$(git branch | sed -n "/*/s/\* //p")" &&
+	git log --pretty=oneline > actual &&
+	test_cmp base actual
+'
+
+test_expect_success '-b with -o checkout into an orphan branch' '
+	git checkout -ob beta &&
+	test -z "$(git branch | grep \*)" &&
+	test "beta" = "$(git symbolic-ref HEAD | sed "s,.*/,,")" &&
+	test -z "$(git ls-files)" &&
+	test_tick &&
+	echo "Test 2" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Third Commit" &&
+	git log --pretty=oneline > actual &&
+	test 1 -eq $(wc -l actual | sed "s/ .*//") &&
+	! test_cmp base actual
+'
+
+test_expect_success '-o must be rejected without -b' '
+	test_must_fail git checkout -o alpha
+'
+
+test_done
-- 
1.7.0.99.ge963b.dirty
