From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] sequencer: introduce git-sequencer builtin
Date: Sun, 13 Nov 2011 16:16:19 +0530
Message-ID: <1321181181-23923-6-git-send-email-artagnon@gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXc0-0000WR-4b
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab1KMKsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:48:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46228 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab1KMKsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:48:21 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so6026973iag.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/jdY2/e338F5I6oMYng3XgLBpgdJdCQKKCFBYr+h8a4=;
        b=HeB5rNjnUWA58I+1cjra9rHKly3FATQ0fV5iyBK2YpYXeFkPjywTKWgWu11+FRbK9o
         9v9jrUAMkh5POM9DsmYk5hluu6rOHdHXrWWKNgmSYNA7PVo2c6rYVNxm5lbvVq3zORoQ
         j/ErdGNsJcmLg2TWUE1N7DoQi1DPg232t6JVY=
Received: by 10.68.0.129 with SMTP id 1mr39796530pbe.94.1321181300825;
        Sun, 13 Nov 2011 02:48:20 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm28723464pbe.11.2011.11.13.02.48.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:48:19 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185336>

Introduce a new builtin 'git sequencer' that implements only
'--continue' and '--reset' features of the sequencer.  As a result, it
can only be used to continue an existing sequencer operation, not to
start a new one.  Now you can do:

  $ git cherry-pick foo..bar
  ... conflict ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git sequencer --continue

So, irrespective of the concrete implementation of the sequencer
invoked earlier, any sequencer operation can be continued with 'git
sequencer --continue' and reset with 'git sequencer --reset'.  Also,
we plan to make the 'git sequencer' builtin implement a concrete
operation similar to 'git rebase -i' in the future.

While at it, change the advice printed by the sequencer library and
re-organize 't3510-cherry-pick-sequence.sh'.  There are now two
separate sets of tests:

  t3510-sequencer.sh is meant to test the continuation features of the
  sequencer, using 'git cherry-pick' to initiate an operation.

  t3511-cherry-pick-sequencer.sh is meant to test 'git cherry-pick' as
  a concrete implementation of the sequencer, stressing on many of the
  backward compatibility features specific to it.

In the future, when the sequencer grows more functionality that
doesn't directly impact the concrete implementation 'git cherry-pick',
the corresponding tests should go into 't3510-sequencer.sh'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 .gitignore                                         |    1 +
 Documentation/git-sequencer.txt                    |   33 +++++
 Makefile                                           |    1 +
 builtin.h                                          |    1 +
 builtin/sequencer.c                                |   52 +++++++
 git.c                                              |    1 +
 sequencer.c                                        |    6 +-
 t/t3510-sequencer.sh                               |  153 ++++++++++++++++++++
 ...-sequence.sh => t3511-cherry-pick-sequencer.sh} |  120 +---------------
 9 files changed, 251 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/git-sequencer.txt
 create mode 100644 builtin/sequencer.c
 create mode 100755 t/t3510-sequencer.sh
 rename t/{t3510-cherry-pick-sequence.sh => t3511-cherry-pick-sequencer.sh} (61%)

diff --git a/.gitignore b/.gitignore
index 8572c8c..74ea408 100644
--- a/.gitignore
+++ b/.gitignore
@@ -128,6 +128,7 @@
 /git-rm
 /git-send-email
 /git-send-pack
+/git-sequencer
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
diff --git a/Documentation/git-sequencer.txt b/Documentation/git-sequencer.txt
new file mode 100644
index 0000000..aa8a80b
--- /dev/null
+++ b/Documentation/git-sequencer.txt
@@ -0,0 +1,33 @@
+git-sequencer(1)
+================
+
+NAME
+----
+git-sequencer - Finish an existing sequencer operation
+
+
+SYNOPSIS
+--------
+[verse]
+'git sequencer' --reset
+'git sequencer' --continue
+
+DESCRIPTION
+-----------
+Given any arbitrary sequencer operation started using 'git
+cherry-pick' or 'git revert', facilitate continuing or resetting it
+via a uniform interface.
+
+
+OPTIONS
+-------
+include::sequencer.txt[]
+
+
+SEE ALSO
+--------
+linkgit:git-cherry-pick[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 17404c4..e367310 100644
--- a/Makefile
+++ b/Makefile
@@ -777,6 +777,7 @@ BUILTIN_OBJS += builtin/rev-parse.o
 BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
 BUILTIN_OBJS += builtin/send-pack.o
+BUILTIN_OBJS += builtin/sequencer.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
diff --git a/builtin.h b/builtin.h
index 0e9da90..0335163 100644
--- a/builtin.h
+++ b/builtin.h
@@ -119,6 +119,7 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_sequencer(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
new file mode 100644
index 0000000..7364a52
--- /dev/null
+++ b/builtin/sequencer.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "sequencer.h"
+
+static const char *const sequencer_usage[] = {
+	"git sequencer --continue",
+	"git sequencer --reset",
+	NULL
+};
+
+static void parse_args(int argc, const char **argv, struct replay_opts *opts)
+{
+	int reset = 0;
+	int contin = 0;
+	struct option options[] = {
+		OPT_BOOLEAN(0, "reset", &reset, "forget the current operation"),
+		OPT_BOOLEAN(0, "continue", &contin, "continue the current operation"),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL, options, sequencer_usage,
+			PARSE_OPT_KEEP_ARGV0 |
+			PARSE_OPT_KEEP_UNKNOWN);
+
+	/* Set the subcommand */
+	if (reset)
+		opts->subcommand = REPLAY_RESET;
+	else if (contin)
+		opts->subcommand = REPLAY_CONTINUE;
+	else
+		opts->subcommand = REPLAY_NONE;
+
+	/* Forbid REPLAY_NONE and stray command-line arguments */
+	if (opts->subcommand == REPLAY_NONE || argc > 1)
+		usage_with_options(sequencer_usage, options);
+}
+
+int cmd_sequencer(int argc, const char **argv, const char *prefix)
+{
+	struct replay_opts opts;
+	int res;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.action = REPLAY_REVERT;
+	git_config(git_default_config, NULL);
+	parse_args(argc, argv, &opts);
+	res = sequencer_pick_revisions(&opts);
+	if (res < 0)
+		die(_("sequencer failed"));
+	return res;
+}
diff --git a/git.c b/git.c
index 8e34903..5262c9b 100644
--- a/git.c
+++ b/git.c
@@ -418,6 +418,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
+		{ "sequencer", cmd_sequencer, RUN_SETUP | NEED_WORK_TREE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "show", cmd_show, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
diff --git a/sequencer.c b/sequencer.c
index 23fd3fe..012d531 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -808,9 +808,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 
 		walk_revs_populate_todo(&todo_list, opts);
 		if (create_seq_dir() < 0) {
-			error(_("A cherry-pick or revert is in progress."));
-			advise(_("Use --continue to continue the operation"));
-			advise(_("or --reset to forget about it"));
+			error(_("A sequencer operation is in progress."));
+			advise(_("Use git sequencer --continue to it"));
+			advise(_("or git sequencer --reset to forget about it"));
 			return -1;
 		}
 		if (get_sha1("HEAD", sha1)) {
diff --git a/t/t3510-sequencer.sh b/t/t3510-sequencer.sh
new file mode 100755
index 0000000..6b2e712
--- /dev/null
+++ b/t/t3510-sequencer.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description='Test sequencer continuation features
+
+  + anotherpick: rewrites foo to d
+  + picked: rewrites foo to c
+  + unrelatedpick: rewrites unrelated to reallyunrelated
+  + base: rewrites foo to b
+  + initial: writes foo as a, unrelated as unrelated
+
+'
+
+. ./test-lib.sh
+
+# Repeat first match 10 times
+_r10='\1\1\1\1\1\1\1\1\1\1'
+
+pristine_detach () {
+	git cherry-pick --reset &&
+	git checkout -f "$1^0" &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x
+}
+
+test_expect_success setup '
+	echo unrelated >unrelated &&
+	git add unrelated &&
+	test_commit initial foo a &&
+	test_commit base foo b &&
+	test_commit unrelatedpick unrelated reallyunrelated &&
+	test_commit picked foo c &&
+	test_commit anotherpick foo d &&
+	git config advice.detachedhead false
+
+'
+
+test_expect_success '--continue complains when no sequencer operation is in progress' '
+	pristine_detach initial &&
+	test_must_fail git sequencer --continue
+'
+
+test_expect_success '--continue complains when there are unresolved conflicts' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test_must_fail git sequencer --continue
+'
+
+test_expect_success 'malformed instruction sheet 1' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick /pick/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	test_must_fail git sequencer --continue
+'
+
+test_expect_success 'malformed instruction sheet 2' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	test_must_fail git sequencer --continue
+'
+
+test_expect_success 'malformed instruction sheet 3' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	test_must_fail git sequencer --continue
+'
+
+test_expect_success 'commit descriptions in insn sheet are optional' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	cut -d" " -f1,2 .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	git sequencer --continue &&
+	test_path_is_missing .git/sequencer &&
+	git rev-list HEAD >commits
+	test_line_count = 4 commits
+'
+
+test_expect_success 'revert --continue continues after cherry-pick' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	git revert --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'mixed pick and revert instructions' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	oldsha=`git rev-parse --short HEAD~1` &&
+	echo "revert $oldsha unrelatedpick" >>.git/sequencer/todo &&
+	git sequencer --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3511-cherry-pick-sequencer.sh
similarity index 61%
rename from t/t3510-cherry-pick-sequence.sh
rename to t/t3511-cherry-pick-sequencer.sh
index 09b9e65..a9c6ac1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3511-cherry-pick-sequencer.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test cherry-pick continuation features
+test_description='Test cherry-pick as a sequencer implementation
 
   + anotherpick: rewrites foo to d
   + picked: rewrites foo to c
@@ -12,9 +12,6 @@ test_description='Test cherry-pick continuation features
 
 . ./test-lib.sh
 
-# Repeat first match 10 times
-_r10='\1\1\1\1\1\1\1\1\1\1'
-
 pristine_detach () {
 	git cherry-pick --reset &&
 	git checkout -f "$1^0" &&
@@ -34,7 +31,7 @@ test_expect_success setup '
 
 '
 
-test_expect_success 'cherry-pick persists data on failure' '
+test_expect_success 'sequencer persists data on failure' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
@@ -43,7 +40,7 @@ test_expect_success 'cherry-pick persists data on failure' '
 	test_path_is_file .git/sequencer/opts
 '
 
-test_expect_success 'cherry-pick persists opts correctly' '
+test_expect_success 'sequencer persists opts correctly' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
@@ -67,7 +64,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick cleans up sequencer state upon success' '
+test_expect_success 'sequencer cleans up state upon success' '
 	pristine_detach initial &&
 	git cherry-pick initial..picked &&
 	test_path_is_missing .git/sequencer
@@ -109,7 +106,7 @@ test_expect_success 'cherry-pick cleans up sequencer todo when one commit is lef
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
+test_expect_success 'sequencer does not implicitly stomp an existing operation' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
 	test-chmtime -v +0 .git/sequencer >expect &&
@@ -118,7 +115,7 @@ test_expect_success 'cherry-pick does not implicitly stomp an existing operation
 	test_cmp expect actual
 '
 
-test_expect_success '--continue complains when no cherry-pick is in progress' '
+test_expect_success '--continue complains when no sequencer operation is in progress' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick --continue
 '
@@ -192,109 +189,4 @@ test_expect_success '--signoff is not automatically propagated to resolved confl
 	grep "Signed-off-by:" anotherpick_msg
 '
 
-test_expect_success 'malformed instruction sheet 1' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	sed "s/pick /pick/" .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	test_must_fail git cherry-pick --continue
-'
-
-test_expect_success 'malformed instruction sheet 2' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	test_must_fail git cherry-pick --continue
-'
-
-test_expect_success 'malformed instruction sheet 3' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	test_must_fail git cherry-pick --continue
-'
-
-test_expect_success 'commit descriptions in insn sheet are optional' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	echo "c" >foo &&
-	git add foo &&
-	git commit &&
-	cut -d" " -f1,2 .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	git cherry-pick --continue &&
-	test_path_is_missing .git/sequencer &&
-	git rev-list HEAD >commits
-	test_line_count = 4 commits
-'
-
-test_expect_success 'revert --continue continues after cherry-pick' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	echo "c" >foo &&
-	git add foo &&
-	git commit &&
-	git revert --continue &&
-	test_path_is_missing .git/sequencer &&
-	{
-		git rev-list HEAD |
-		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
-	} >actual &&
-	cat >expect <<-\EOF &&
-	OBJID
-	:100644 100644 OBJID OBJID M	foo
-	OBJID
-	:100644 100644 OBJID OBJID M	foo
-	OBJID
-	:100644 100644 OBJID OBJID M	unrelated
-	OBJID
-	:000000 100644 OBJID OBJID A	foo
-	:000000 100644 OBJID OBJID A	unrelated
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'mixed pick and revert instructions' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	echo "c" >foo &&
-	git add foo &&
-	git commit &&
-	oldsha=`git rev-parse --short HEAD~1` &&
-	echo "revert $oldsha unrelatedpick" >>.git/sequencer/todo &&
-	git cherry-pick --continue &&
-	test_path_is_missing .git/sequencer &&
-	{
-		git rev-list HEAD |
-		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
-	} >actual &&
-	cat >expect <<-\EOF &&
-	OBJID
-	:100644 100644 OBJID OBJID M	unrelated
-	OBJID
-	:100644 100644 OBJID OBJID M	foo
-	OBJID
-	:100644 100644 OBJID OBJID M	foo
-	OBJID
-	:100644 100644 OBJID OBJID M	unrelated
-	OBJID
-	:000000 100644 OBJID OBJID A	foo
-	:000000 100644 OBJID OBJID A	unrelated
-	EOF
-	test_cmp expect actual
-'
-
 test_done
-- 
1.7.6.351.gb35ac.dirty
