From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] git checkout -b: unparent the new branch with -o
Date: Tue, 23 Feb 2010 18:20:07 -0300
Message-ID: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:21:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2C4-0001uP-2t
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab0BWVVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:21:19 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:42656 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab0BWVVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:21:18 -0500
Received: by ywh35 with SMTP id 35so2230347ywh.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 13:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M/tUdXkJkWRUEOmSazo33fFp6Yiv1dWtr5pL+mOTwTk=;
        b=k/uldwYtSoKi4lZwrQvyOAPgh6aVA2Rj/i4AAns0QyR3dU9b6OIFwvtlRwJaYqbzWg
         HrC6TcSxLSdLIwxRP1Fh3STwwiLqQvbBMpLiAIFuRcjID+zzFBOKPi3glMMqt4WPDobv
         j+lSbFdqG21Efyoh3mwaAjnYMN+vYY9SwqbqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BjdnMJM97n+ei/rhWaDrV2SulYqJans/eI0bRzaiQglbbNM0Yaj/6ng8KsoLcUk7Kv
         zjbnL4orbswYsgQ23Ur8AopBIkqid1evmEkyOu4mHAVpxIlZf02CrvxRTvjL/TZaDZ9R
         BYUMggejBHDqTR6rYLF/mCbG5PslqoG1V4ti8=
Received: by 10.101.193.30 with SMTP id v30mr1229129anp.199.1266960073124;
        Tue, 23 Feb 2010 13:21:13 -0800 (PST)
Received: from localhost.localdomain ([187.15.98.95])
        by mx.google.com with ESMTPS id 22sm413717yxe.18.2010.02.23.13.21.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 13:21:12 -0800 (PST)
X-Mailer: git-send-email 1.7.0.84.g03684
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140841>

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

This new option just make it easy to add orphan branches to git repositories.

There are a lot of hacks to do the same thing ( I had been using some!  :-) )
but this should be seen as a part of a normal work flow so just an option.

A good example to show the need of this option is a Debian folder of control
files.  Whenever a maintainer needs to debianize a source code to build
packages he needs to add a folder called Debian with a lot of files inside it.
Those files are connected to the source code of the program but they are not
really part of the program development.  On this situation using the new
option, that maintainer would do:

	git checkout -ob debian
	git clean -df
	mkdir Debian
	add all control files
	...hack it enough...
	git add Debian
	git commit

And then when ready to build the packages from the master branch he would just
need to merge or cherry-pick the Debian branch on it.  On this work flow both
developments occur paralleled and fuse only at the moment of building the
Debian's packages.

I have some other examples to tell but I think you people already have figured
the needs and possible uses out.  :-)

Kind regards

 builtin-checkout.c             |   14 +++++++++-
 t/t2017-checkout-orphan.sh     |   50 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)
 create mode 100755 t/t2017-checkout-orphan.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..6534934 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m] [-b <new_branch> [-o]] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
 
@@ -25,6 +25,10 @@ linkgit:git-branch[1] were called; in this case you can
 use the --track or --no-track options, which will be passed to `git
 branch`.  As a convenience, --track without `-b` implies branch
 creation; see the description of --track below.
+When using -b, it is possible to use the option -o to set the new branch
+as unparented thus unrelated to the previous branch.  The new code will
+be committed by using 'git add' and 'git commit' as if it was an initial
+commit.
 
 When <paths> or --patch are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
@@ -86,6 +90,11 @@ explicitly give a name with '-b' in such a case.
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
1.7.0.84.g03684
