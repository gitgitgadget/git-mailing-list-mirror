From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 12/13] git notes merge: Add automatic conflict resolvers
 (ours, theirs, union)
Date: Fri, 23 Jul 2010 12:15:03 +0200
Message-ID: <1279880104-29796-13-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFIZ-0001FC-AT
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203Ab0GWKPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756167Ab0GWKP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:27 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000GAP9TFM390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:15 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 14E191EA552E_C496BB3B	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:15 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C1FD41EA3F09_C496BB2F	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:13 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:13 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151521>

The new -X/--resolve command-line option to 'git notes merge' allow the user
to choose how notes merge conflicts should be resolved. There are four valid
resolvers to choose from:

1. "manual" (the default): This will let the user manually resolve conflicts.
   This option currently fails with an error message. It will be implemented
   properly in future patches.

2. "ours": This automatically chooses the local version of a conflict, and
   discards the remote version.

3. "theirs": This automatically chooses the remote version of a conflict, and
   discards the local version.

4. "union": This automatically resolves the conflict by appending the remote
   version to the local version.

The auto-resolvers are implement using the combine_notes_* functions from the
notes.h API.

The patch also includes testcases verifying the correct implementation of
these auto-resolvers.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c                     |   21 ++-
 notes-merge.c                       |   29 ++-
 notes-merge.h                       |    6 +
 t/t3309-notes-merge-auto-resolve.sh |  512 +++++++++++++++++++++++++++++++++++
 4 files changed, 566 insertions(+), 2 deletions(-)
 create mode 100755 t/t3309-notes-merge-auto-resolve.sh

diff --git a/builtin/notes.c b/builtin/notes.c
index 1d22635..e14c6f2 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -26,7 +26,7 @@ static const char * const git_notes_usage[] = {
 	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
 	"git notes [--ref <notes_ref>] edit [<object>]",
 	"git notes [--ref <notes_ref>] show [<object>]",
-	"git notes [--ref <notes_ref>] merge [-v | -q] <notes_ref>",
+	"git notes [--ref <notes_ref>] merge [-v | -q] [-X <strategy> ] <notes_ref>",
 	"git notes [--ref <notes_ref>] remove [<object>]",
 	"git notes [--ref <notes_ref>] prune [-n | -v]",
 	NULL
@@ -770,8 +770,12 @@ static int merge(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct notes_merge_options o;
 	int verbosity = 0, result;
+	const char *resolver = NULL;
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
+		OPT_STRING('X', "resolve", &resolver, "strategy",
+			   "resolve notes conflicts using the given "
+			   "strategy (manual/ours/theirs/union)"),
 		OPT_END()
 	};
 
@@ -793,6 +797,21 @@ static int merge(int argc, const char **argv, const char *prefix)
 	expand_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
+	if (resolver) {
+		if (!strcmp(resolver, "manual"))
+			o.resolve = NOTES_MERGE_RESOLVE_MANUAL;
+		else if (!strcmp(resolver, "ours"))
+			o.resolve = NOTES_MERGE_RESOLVE_OURS;
+		else if (!strcmp(resolver, "theirs"))
+			o.resolve = NOTES_MERGE_RESOLVE_THEIRS;
+		else if (!strcmp(resolver, "union"))
+			o.resolve = NOTES_MERGE_RESOLVE_UNION;
+		else {
+			error("Unknown -X/--resolve strategy: %s", resolver);
+			usage_with_options(git_notes_merge_usage, options);
+		}
+	}
+
 	t = init_notes_check("merge");
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
diff --git a/notes-merge.c b/notes-merge.c
index ba9703a..c7db60a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -262,6 +262,33 @@ static void diff_tree_local(struct notes_merge_options *o,
 	diff_tree_release_paths(&opt);
 }
 
+static int merge_one_change(struct notes_merge_options *o,
+			    struct notes_merge_pair *p, struct notes_tree *t)
+{
+	/*
+	 * Return 0 if change was resolved (and added to notes_tree),
+	 * 1 if conflict
+	 */
+	switch (o->resolve) {
+	case NOTES_MERGE_RESOLVE_MANUAL:
+		return 1;
+	case NOTES_MERGE_RESOLVE_OURS:
+		OUTPUT(o, 2, "Using local notes for %s", sha1_to_hex(p->obj));
+		/* nothing to do */
+		return 0;
+	case NOTES_MERGE_RESOLVE_THEIRS:
+		OUTPUT(o, 2, "Using remote notes for %s", sha1_to_hex(p->obj));
+		add_note(t, p->obj, p->remote, combine_notes_overwrite);
+		return 0;
+	case NOTES_MERGE_RESOLVE_UNION:
+		OUTPUT(o, 2, "Concatenating local and remote notes for %s",
+		       sha1_to_hex(p->obj));
+		add_note(t, p->obj, p->remote, combine_notes_concatenate);
+		return 0;
+	}
+	die("Unknown resolve method (%i).", o->resolve);
+}
+
 static int merge_changes(struct notes_merge_options *o,
 			 struct notes_merge_pair *changes, int *num_changes,
 			 struct notes_tree *t)
@@ -289,7 +316,7 @@ static int merge_changes(struct notes_merge_options *o,
 		} else {
 			/* need file-level merge between local and remote */
 			OUTPUT(o, 5, "\t\t\tneed content-level merge");
-			conflicts += 1; /* TODO */
+			conflicts += merge_one_change(o, p, t);
 		}
 	}
 
diff --git a/notes-merge.h b/notes-merge.h
index e42ce4b..bd808d0 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -6,6 +6,12 @@ struct notes_merge_options {
 	const char *remote_ref;
 	const char *commit_msg;
 	int verbosity;
+	enum {
+		NOTES_MERGE_RESOLVE_MANUAL = 0,
+		NOTES_MERGE_RESOLVE_OURS,
+		NOTES_MERGE_RESOLVE_THEIRS,
+		NOTES_MERGE_RESOLVE_UNION
+	} resolve;
 };
 
 void init_notes_merge_options(struct notes_merge_options *o);
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
new file mode 100755
index 0000000..171e795
--- /dev/null
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -0,0 +1,512 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Johan Herland
+#
+
+test_description='Test notes merging with automatic resolvers'
+
+. ./test-lib.sh
+
+# Set up a notes merge scenario with all kinds of potential conflicts
+test_expect_success 'setup commits' '
+	# Create 15 commits with tags ("1st" through "15th")
+	: > a1 && git add a1 && test_tick && git commit -m 1st && git tag 1st &&
+	: > a2 && git add a2 && test_tick && git commit -m 2nd && git tag 2nd &&
+	: > a3 && git add a3 && test_tick && git commit -m 3rd && git tag 3rd &&
+	: > a4 && git add a4 && test_tick && git commit -m 4th && git tag 4th &&
+	: > a5 && git add a5 && test_tick && git commit -m 5th && git tag 5th &&
+	: > a6 && git add a6 && test_tick && git commit -m 6th && git tag 6th &&
+	: > a7 && git add a7 && test_tick && git commit -m 7th && git tag 7th &&
+	: > a8 && git add a8 && test_tick && git commit -m 8th && git tag 8th &&
+	: > a9 && git add a9 && test_tick && git commit -m 9th && git tag 9th &&
+	: > a10 && git add a10 && test_tick && git commit -m 10th && git tag 10th &&
+	: > a11 && git add a11 && test_tick && git commit -m 11th && git tag 11th &&
+	: > a12 && git add a12 && test_tick && git commit -m 12th && git tag 12th &&
+	: > a13 && git add a13 && test_tick && git commit -m 13th && git tag 13th &&
+	: > a14 && git add a14 && test_tick && git commit -m 14th && git tag 14th &&
+	: > a15 && git add a15 && test_tick && git commit -m 15th && git tag 15th
+'
+
+test_expect_success 'setup merge base (x)' '
+	git config core.notesRef refs/notes/x &&
+	git notes add -m "x notes on 6th commit" 6th &&
+	git notes add -m "x notes on 7th commit" 7th &&
+	git notes add -m "x notes on 8th commit" 8th &&
+	git notes add -m "x notes on 9th commit" 9th &&
+	git notes add -m "x notes on 10th commit" 10th &&
+	git notes add -m "x notes on 11th commit" 11th &&
+	git notes add -m "x notes on 12th commit" 12th &&
+	git notes add -m "x notes on 13th commit" 13th &&
+	git notes add -m "x notes on 14th commit" 14th &&
+	git notes add -m "x notes on 15th commit" 15th
+'
+
+cat >expect_notes_x <<EOF
+20c613c835011c48a5abe29170a2402ca6354910 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
+897003322b53bc6ca098e9324ee508362347e734 2ede89468182a62d0bde2583c736089bcf7d7e92
+11d97fdebfa5ceee540a3da07bce6fa0222bc082 387a89921c73d7ed72cd94d179c1c7048ca47756
+457a85d6c814ea208550f15fcc48f804ac8dc023 516bb9cbbfaa1be722bcf97df393a12e1e7c944d
+7abbc45126d680336fb24294f013a7cdfa3ed545 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+dd161bc149470fd890dd4ab52a4cbd79bbd18c36 7038787dfe22a14c3867ce816dbba39845359719
+a3daf8a1e4e5dc3409a303ad8481d57bfea7f5d6 80d796defacd5db327b7a4e50099663902fbdc5c
+5d30216a129eeffa97d9694ffe8c74317a560315 e5d4fb5698d564ab8c73551538ecaf2b0c666185
+b0c95b954301d69da2bc3723f4cb1680d355937c f42b4e95384566bc7b31d9d3bfcec2d1a8f3e2e8
+b8d03e173f67f6505a76f6e00cf93440200dd9be ffed603236bfa3891c49644257a83598afe8ae5a
+EOF
+
+cat >expect_log_x <<EOF
+516bb9c 15th
+x notes on 15th commit
+
+f42b4e9 14th
+x notes on 14th commit
+
+e5d4fb5 13th
+x notes on 13th commit
+
+7038787 12th
+x notes on 12th commit
+
+6352c5e 11th
+x notes on 11th commit
+
+ffed603 10th
+x notes on 10th commit
+
+016e982 9th
+x notes on 9th commit
+
+80d796d 8th
+x notes on 8th commit
+
+2ede894 7th
+x notes on 7th commit
+
+387a899 6th
+x notes on 6th commit
+
+bd17532 5th
+
+1502353 4th
+
+1584215 3rd
+
+268048b 2nd
+
+34b09d6 1st
+
+EOF
+
+test_expect_success 'verify state of merge base (x)' '
+	git notes >output_notes_x &&
+	test_cmp expect_notes_x output_notes_x &&
+	git log --format="%h %s%n%N" >output_log_x &&
+	test_cmp expect_log_x output_log_x
+'
+
+test_expect_success 'setup local branch (y)' '
+	git update-ref refs/notes/y refs/notes/x &&
+	git config core.notesRef refs/notes/y &&
+	git notes add -f -m "y notes on 3rd commit" 3rd &&
+	git notes add -f -m "y notes on 4th commit" 4th &&
+	git notes add -f -m "y notes on 5th commit" 5th &&
+	git notes remove 6th &&
+	git notes remove 7th &&
+	git notes remove 8th &&
+	git notes add -f -m "y notes on 12th commit" 12th &&
+	git notes add -f -m "y notes on 13th commit" 13th &&
+	git notes add -f -m "y notes on 14th commit" 14th &&
+	git notes add -f -m "y notes on 15th commit" 15th
+'
+
+cat >expect_notes_y <<EOF
+20c613c835011c48a5abe29170a2402ca6354910 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
+e2bfd06a37dd2031684a59a6e2b033e212239c78 15023535574ded8b1a89052b32673f84cf9582b8
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 1584215f1d29c65e99c6c6848626553fdd07fd75
+68b8630d25516028bed862719855b3d6768d7833 516bb9cbbfaa1be722bcf97df393a12e1e7c944d
+7abbc45126d680336fb24294f013a7cdfa3ed545 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+a66055fa82f7a03fe0c02a6aba3287a85abf7c62 7038787dfe22a14c3867ce816dbba39845359719
+154508c7a0bcad82b6fe4b472bc4c26b3bf0825b bd1753200303d0a0344be813e504253b3d98e74d
+3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc e5d4fb5698d564ab8c73551538ecaf2b0c666185
+5de7ea7ad4f47e7ff91989fb82234634730f75df f42b4e95384566bc7b31d9d3bfcec2d1a8f3e2e8
+b8d03e173f67f6505a76f6e00cf93440200dd9be ffed603236bfa3891c49644257a83598afe8ae5a
+EOF
+
+cat >expect_log_y <<EOF
+516bb9c 15th
+y notes on 15th commit
+
+f42b4e9 14th
+y notes on 14th commit
+
+e5d4fb5 13th
+y notes on 13th commit
+
+7038787 12th
+y notes on 12th commit
+
+6352c5e 11th
+x notes on 11th commit
+
+ffed603 10th
+x notes on 10th commit
+
+016e982 9th
+x notes on 9th commit
+
+80d796d 8th
+
+2ede894 7th
+
+387a899 6th
+
+bd17532 5th
+y notes on 5th commit
+
+1502353 4th
+y notes on 4th commit
+
+1584215 3rd
+y notes on 3rd commit
+
+268048b 2nd
+
+34b09d6 1st
+
+EOF
+
+test_expect_success 'verify state of local branch (y)' '
+	git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	git log --format="%h %s%n%N" >output_log_y &&
+	test_cmp expect_log_y output_log_y
+'
+
+test_expect_success 'setup remote branch (z)' '
+	git update-ref refs/notes/z refs/notes/x &&
+	git config core.notesRef refs/notes/z &&
+	git notes add -f -m "z notes on 2nd commit" 2nd &&
+	git notes add -f -m "y notes on 4th commit" 4th &&
+	git notes add -f -m "z notes on 5th commit" 5th &&
+	git notes remove 6th &&
+	git notes add -f -m "z notes on 8th commit" 8th &&
+	git notes remove 9th &&
+	git notes add -f -m "z notes on 11th commit" 11th &&
+	git notes remove 12th &&
+	git notes add -f -m "y notes on 14th commit" 14th &&
+	git notes add -f -m "z notes on 15th commit" 15th
+'
+
+cat >expect_notes_z <<EOF
+e2bfd06a37dd2031684a59a6e2b033e212239c78 15023535574ded8b1a89052b32673f84cf9582b8
+283b48219aee9a4105f6cab337e789065c82c2b9 268048bfb8a1fb38e703baceb8ab235421bf80c5
+897003322b53bc6ca098e9324ee508362347e734 2ede89468182a62d0bde2583c736089bcf7d7e92
+9b4b2c61f0615412da3c10f98ff85b57c04ec765 516bb9cbbfaa1be722bcf97df393a12e1e7c944d
+7e3c53503a3db8dd996cb62e37c66e070b44b54d 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+851e1638784a884c7dd26c5d41f3340f6387413a 80d796defacd5db327b7a4e50099663902fbdc5c
+99fc34adfc400b95c67b013115e37e31aa9a6d23 bd1753200303d0a0344be813e504253b3d98e74d
+5d30216a129eeffa97d9694ffe8c74317a560315 e5d4fb5698d564ab8c73551538ecaf2b0c666185
+5de7ea7ad4f47e7ff91989fb82234634730f75df f42b4e95384566bc7b31d9d3bfcec2d1a8f3e2e8
+b8d03e173f67f6505a76f6e00cf93440200dd9be ffed603236bfa3891c49644257a83598afe8ae5a
+EOF
+
+cat >expect_log_z <<EOF
+516bb9c 15th
+z notes on 15th commit
+
+f42b4e9 14th
+y notes on 14th commit
+
+e5d4fb5 13th
+x notes on 13th commit
+
+7038787 12th
+
+6352c5e 11th
+z notes on 11th commit
+
+ffed603 10th
+x notes on 10th commit
+
+016e982 9th
+
+80d796d 8th
+z notes on 8th commit
+
+2ede894 7th
+x notes on 7th commit
+
+387a899 6th
+
+bd17532 5th
+z notes on 5th commit
+
+1502353 4th
+y notes on 4th commit
+
+1584215 3rd
+
+268048b 2nd
+z notes on 2nd commit
+
+34b09d6 1st
+
+EOF
+
+test_expect_success 'verify state of remote branch (z)' '
+	git notes >output_notes_z &&
+	test_cmp expect_notes_z output_notes_z &&
+	git log --format="%h %s%n%N" >output_log_z &&
+	test_cmp expect_log_z output_log_z
+'
+
+# At this point, before merging z into y, we have the following status:
+#
+# commit | object  | base/x  | local/y | remote/z |? diff from x to y/z
+# -------|---------|---------|---------|----------||---------------------------
+# 1st    | 34b09d6 | [none]  | [none]  | [none]   || unchanged / unchanged
+# 2nd    | 268048b | [none]  | [none]  | 283b482  || unchanged / added
+# 3rd    | 1584215 | [none]  | 5772f42 | [none]   || added     / unchanged
+# 4th    | 1502353 | [none]  | e2bfd06 | e2bfd06  || added     / added (same)
+# 5th    | bd17532 | [none]  | 154508c | 99fc34a  |+ added     / added (diff)
+# 6th    | 387a899 | 11d97fd | [none]  | [none]   || removed   / removed
+# 7th    | 2ede894 | 8970033 | [none]  | 8970033  || removed   / unchanged
+# 8th    | 80d796d | a3daf8a | [none]  | 851e163  |+ removed   / changed
+# 9th    | 016e982 | 20c613c | 20c613c | [none]   || unchanged / removed
+# 10th   | ffed603 | b8d03e1 | b8d03e1 | b8d03e1  || unchanged / unchanged
+# 11th   | 6352c5e | 7abbc45 | 7abbc45 | 7e3c535  || unchanged / changed
+# 12th   | 7038787 | dd161bc | a66055f | [none]   |+ changed   / removed
+# 13th   | e5d4fb5 | 5d30216 | 3a631fd | 5d30216  || changed   / unchanged
+# 14th   | f42b4e9 | b0c95b9 | 5de7ea7 | 5de7ea7  || changed   / changed (same)
+# 15th   | 516bb9c | 457a85d | 68b8630 | 9b4b2c6  |+ changed   / changed (diff)
+
+test_expect_success 'merge z into y with invalid resolver => Fail/No changes' '
+	git config core.notesRef refs/notes/y &&
+	test_must_fail git notes merge --resolve=foo z &&
+	# Verify no changes (y)
+	git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	git log --format="%h %s%n%N" >output_log_y &&
+	test_cmp expect_log_y output_log_y
+'
+
+cat >expect_notes_ours <<EOF
+e2bfd06a37dd2031684a59a6e2b033e212239c78 15023535574ded8b1a89052b32673f84cf9582b8
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 1584215f1d29c65e99c6c6848626553fdd07fd75
+283b48219aee9a4105f6cab337e789065c82c2b9 268048bfb8a1fb38e703baceb8ab235421bf80c5
+68b8630d25516028bed862719855b3d6768d7833 516bb9cbbfaa1be722bcf97df393a12e1e7c944d
+7e3c53503a3db8dd996cb62e37c66e070b44b54d 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+a66055fa82f7a03fe0c02a6aba3287a85abf7c62 7038787dfe22a14c3867ce816dbba39845359719
+154508c7a0bcad82b6fe4b472bc4c26b3bf0825b bd1753200303d0a0344be813e504253b3d98e74d
+3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc e5d4fb5698d564ab8c73551538ecaf2b0c666185
+5de7ea7ad4f47e7ff91989fb82234634730f75df f42b4e95384566bc7b31d9d3bfcec2d1a8f3e2e8
+b8d03e173f67f6505a76f6e00cf93440200dd9be ffed603236bfa3891c49644257a83598afe8ae5a
+EOF
+
+cat >expect_log_ours <<EOF
+516bb9c 15th
+y notes on 15th commit
+
+f42b4e9 14th
+y notes on 14th commit
+
+e5d4fb5 13th
+y notes on 13th commit
+
+7038787 12th
+y notes on 12th commit
+
+6352c5e 11th
+z notes on 11th commit
+
+ffed603 10th
+x notes on 10th commit
+
+016e982 9th
+
+80d796d 8th
+
+2ede894 7th
+
+387a899 6th
+
+bd17532 5th
+y notes on 5th commit
+
+1502353 4th
+y notes on 4th commit
+
+1584215 3rd
+y notes on 3rd commit
+
+268048b 2nd
+z notes on 2nd commit
+
+34b09d6 1st
+
+EOF
+
+test_expect_success 'merge z into y with "ours" resolver => Non-conflicting 3-way merge' '
+	git notes merge --resolve=ours z &&
+	# Verify merge result
+	git notes >output_notes_ours &&
+	test_cmp expect_notes_ours output_notes_ours &&
+	git log --format="%h %s%n%N" >output_log_ours &&
+	test_cmp expect_log_ours output_log_ours
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	git log --format="%h %s%n%N" >output_log_y &&
+	test_cmp expect_log_y output_log_y
+'
+
+cat >expect_notes_theirs <<EOF
+e2bfd06a37dd2031684a59a6e2b033e212239c78 15023535574ded8b1a89052b32673f84cf9582b8
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 1584215f1d29c65e99c6c6848626553fdd07fd75
+283b48219aee9a4105f6cab337e789065c82c2b9 268048bfb8a1fb38e703baceb8ab235421bf80c5
+9b4b2c61f0615412da3c10f98ff85b57c04ec765 516bb9cbbfaa1be722bcf97df393a12e1e7c944d
+7e3c53503a3db8dd996cb62e37c66e070b44b54d 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+851e1638784a884c7dd26c5d41f3340f6387413a 80d796defacd5db327b7a4e50099663902fbdc5c
+99fc34adfc400b95c67b013115e37e31aa9a6d23 bd1753200303d0a0344be813e504253b3d98e74d
+3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc e5d4fb5698d564ab8c73551538ecaf2b0c666185
+5de7ea7ad4f47e7ff91989fb82234634730f75df f42b4e95384566bc7b31d9d3bfcec2d1a8f3e2e8
+b8d03e173f67f6505a76f6e00cf93440200dd9be ffed603236bfa3891c49644257a83598afe8ae5a
+EOF
+
+cat >expect_log_theirs <<EOF
+516bb9c 15th
+z notes on 15th commit
+
+f42b4e9 14th
+y notes on 14th commit
+
+e5d4fb5 13th
+y notes on 13th commit
+
+7038787 12th
+
+6352c5e 11th
+z notes on 11th commit
+
+ffed603 10th
+x notes on 10th commit
+
+016e982 9th
+
+80d796d 8th
+z notes on 8th commit
+
+2ede894 7th
+
+387a899 6th
+
+bd17532 5th
+z notes on 5th commit
+
+1502353 4th
+y notes on 4th commit
+
+1584215 3rd
+y notes on 3rd commit
+
+268048b 2nd
+z notes on 2nd commit
+
+34b09d6 1st
+
+EOF
+
+test_expect_success 'merge z into y with "theirs" resolver => Non-conflicting 3-way merge' '
+	git notes merge --resolve=theirs z &&
+	# Verify merge result
+	git notes >output_notes_theirs &&
+	test_cmp expect_notes_theirs output_notes_theirs &&
+	git log --format="%h %s%n%N" >output_log_theirs &&
+	test_cmp expect_log_theirs output_log_theirs
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	git log --format="%h %s%n%N" >output_log_y &&
+	test_cmp expect_log_y output_log_y
+'
+
+cat >expect_notes_union <<EOF
+e2bfd06a37dd2031684a59a6e2b033e212239c78 15023535574ded8b1a89052b32673f84cf9582b8
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 1584215f1d29c65e99c6c6848626553fdd07fd75
+283b48219aee9a4105f6cab337e789065c82c2b9 268048bfb8a1fb38e703baceb8ab235421bf80c5
+7c4e546efd0fe939f876beb262ece02797880b54 516bb9cbbfaa1be722bcf97df393a12e1e7c944d
+7e3c53503a3db8dd996cb62e37c66e070b44b54d 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+a66055fa82f7a03fe0c02a6aba3287a85abf7c62 7038787dfe22a14c3867ce816dbba39845359719
+851e1638784a884c7dd26c5d41f3340f6387413a 80d796defacd5db327b7a4e50099663902fbdc5c
+6c841cc36ea496027290967ca96bd2bef54dbb47 bd1753200303d0a0344be813e504253b3d98e74d
+3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc e5d4fb5698d564ab8c73551538ecaf2b0c666185
+5de7ea7ad4f47e7ff91989fb82234634730f75df f42b4e95384566bc7b31d9d3bfcec2d1a8f3e2e8
+b8d03e173f67f6505a76f6e00cf93440200dd9be ffed603236bfa3891c49644257a83598afe8ae5a
+EOF
+
+cat >expect_log_union <<EOF
+516bb9c 15th
+y notes on 15th commit
+
+z notes on 15th commit
+
+f42b4e9 14th
+y notes on 14th commit
+
+e5d4fb5 13th
+y notes on 13th commit
+
+7038787 12th
+y notes on 12th commit
+
+6352c5e 11th
+z notes on 11th commit
+
+ffed603 10th
+x notes on 10th commit
+
+016e982 9th
+
+80d796d 8th
+z notes on 8th commit
+
+2ede894 7th
+
+387a899 6th
+
+bd17532 5th
+y notes on 5th commit
+
+z notes on 5th commit
+
+1502353 4th
+y notes on 4th commit
+
+1584215 3rd
+y notes on 3rd commit
+
+268048b 2nd
+z notes on 2nd commit
+
+34b09d6 1st
+
+EOF
+
+test_expect_success 'merge z into y with "union" resolver => Non-conflicting 3-way merge' '
+	git notes merge --resolve=union z &&
+	# Verify merge result
+	git notes >output_notes_union &&
+	test_cmp expect_notes_union output_notes_union &&
+	git log --format="%h %s%n%N" >output_log_union &&
+	test_cmp expect_log_union output_log_union
+'
+
+test_done
-- 
1.7.2.220.gea1d3
