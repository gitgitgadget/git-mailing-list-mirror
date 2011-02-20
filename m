From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v4 2/4] Introduce CHERRY_PICK_HEAD
Date: Sat, 19 Feb 2011 23:12:27 -0500
Message-ID: <1298175149-41178-3-git-send-email-jaysoffian@gmail.com>
References: <1298175149-41178-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 20 05:13:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr0fm-0002em-P5
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 05:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120Ab1BTENP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 23:13:15 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52221 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab1BTENO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 23:13:14 -0500
Received: by qyk7 with SMTP id 7so1151475qyk.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 20:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ctx7wYCLbk3LstLRi0bevxvZb5241LJXFg9Er/oZ8ew=;
        b=jwQLn63UwDqyKiChnCPRThWrlC3B3qVkP0h6DUebpDWZSKKbD3FHYcJlKgc4eqAajp
         25caS5Vw69Qyg0D8b4P9cMI0WQl6JkGkuuDiGZ+Oit7dhEoSEGse2fabZdapbGdDEhxD
         6wQOJCyKTnOeX6/crOTfppdyAM355DjyQHKuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PQLnoW5wJQVXAcJv3cc5KbsHwjTHl1fNGXbHIU7nd/B4XG5M1ZFvgoMMH7zZwOQqGc
         /YO+DHFvdQK7Hb7RPEFnObU2JxMkznz20ertXftYsmGHyUdVnOJDpgabmjTH2EGP6ozN
         CdyAHhWlyAk2Wp8G4pZNh4ojll6Y9wOBpn1yI=
Received: by 10.229.231.9 with SMTP id jo9mr1818321qcb.201.1298175193476;
        Sat, 19 Feb 2011 20:13:13 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id h20sm2765343qck.0.2011.02.19.20.13.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 20:13:13 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.51.g615e0
In-Reply-To: <1298175149-41178-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167397>

When a cherry-pick conflicts git advises:

 $ git commit -c <original commit id>

to preserve the original commit message and authorship. Instead, let's
record the original commit id in CHERRY_PICK_HEAD and advise:

  $ git commit -c CHERRY_PICK_HEAD

A later patch teaches git to handle the '-c CHERRY_PICK_HEAD' part.
Note that we record CHERRY_PICK_HEAD even in the case where there
are no conflicts so that we may use it to communicate authorship to
commit; this will then allow us to remove set_author_ident_env from
revert.c. However, we do not record CHERRY_PICK_HEAD when --no-commit
is used, as presumably the user intends to further edit the commit
and possibly even cherry-pick additional commits on top.

Tests and documentation contributed by Jonathan Nieder.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-cherry-pick.txt |   19 +++++++++
 Documentation/revisions.txt       |    5 ++-
 branch.c                          |    1 +
 builtin/commit.c                  |    1 +
 builtin/merge.c                   |    7 +++
 builtin/revert.c                  |   27 ++++++++++++-
 t/t3507-cherry-pick-conflict.sh   |   76 ++++++++++++++++++++++++++++++++++++-
 7 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 749d68a..5d85daa 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -16,6 +16,25 @@ Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
 working tree to be clean (no modifications from the HEAD commit).
 
+When it is not obvious how to apply a change, the following
+happens:
+
+1. The current branch and `HEAD` pointer stay at the last commit
+   successfully made.
+2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
+   introduced the change that is difficult to apply.
+3. Paths in which the change applied cleanly are updated both
+   in the index file and in your working tree.
+4. For conflicting paths, the index file records up to three
+   versions, as described in the "TRUE MERGE" section of
+   linkgit:git-merge[1].  The working tree files will include
+   a description of the conflict bracketed by the usual
+   conflict markers `<<<<<<<` and `>>>>>>>`.
+5. No other modifications are made.
+
+See linkgit:git-merge[1] for some hints on resolving such
+conflicts.
+
 OPTIONS
 -------
 <commit>...::
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9e92734..04fceee 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -25,7 +25,8 @@ blobs contained in a commit.
   first match in the following rules:
 
   . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
-    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD` and `MERGE_HEAD`);
+    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
+    and `CHERRY_PICK_HEAD`);
 
   . otherwise, `refs/<name>` if exists;
 
@@ -46,6 +47,8 @@ you can change the tip of the branch back to the state before you ran
 them easily.
 MERGE_HEAD records the commit(s) you are merging into your branch
 when you run 'git merge'.
+CHERRY_PICK_HEAD records the commit you are cherry-picking
+when you run 'git cherry-pick'.
 +
 Note that any of the `refs/*` cases above may come either from
 the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
diff --git a/branch.c b/branch.c
index 93dc866..dc23e95 100644
--- a/branch.c
+++ b/branch.c
@@ -217,6 +217,7 @@ void create_branch(const char *head,
 
 void remove_branch_state(void)
 {
+	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
diff --git a/builtin/commit.c b/builtin/commit.c
index d7f55e3..7acd559 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1424,6 +1424,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("cannot update HEAD ref");
 	}
 
+	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 8c58c3c..1b94c94 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -971,6 +971,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die("You have not concluded your merge (MERGE_HEAD exists).");
 	}
+	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+		if (advice_resolve_conflict)
+			die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
+			    "Please, commit your changes before you can merge.");
+		else
+			die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).");
+	}
 	resolve_undo_clear();
 
 	if (verbosity < 0)
diff --git a/builtin/revert.c b/builtin/revert.c
index dc1b702..deecaab 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -248,6 +248,22 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
+static void write_cherry_pick_head(void)
+{
+	int fd;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
+
+	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die_errno("Could not open '%s' for writing",
+			  git_path("CHERRY_PICK_HEAD"));
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
+		die_errno("Could not write to '%s'", git_path("CHERRY_PICK_HEAD"));
+	strbuf_release(&buf);
+}
+
 static void advise(const char *advice, ...)
 {
 	va_list params;
@@ -263,6 +279,12 @@ static void print_advice(void)
 
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
+		/*
+		 * A conflict has occured but the porcelain
+		 * (typically rebase --interactive) wants to take care
+		 * of the commit itself so remove CHERRY_PICK_HEAD
+		 */
+		unlink(git_path("CHERRY_PICK_HEAD"));
 		return;
 	}
 
@@ -270,8 +292,7 @@ static void print_advice(void)
 	advise("with 'git add <paths>' or 'git rm <paths>'");
 
 	if (action == CHERRY_PICK)
-		advise("and commit the result with 'git commit -c %s'",
-		       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+		advise("and commit the result with 'git commit -c CHERRY_PICK_HEAD'");
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
@@ -504,6 +525,8 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
+		if (!no_commit)
+			write_cherry_pick_head();
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 2313d79..e0bf356 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -52,13 +52,87 @@ test_expect_success 'advice from failed cherry-pick' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit -c \$picked'
+	hint: and commit the result with 'git commit -c CHERRY_PICK_HEAD'
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
 	test_cmp expected actual
 "
 
+test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick picked &&
+	test_cmp_rev picked CHERRY_PICK_HEAD
+'
+
+test_expect_success 'successful cherry-pick does not set CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	git cherry-pick base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	git cherry-pick --no-commit base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	(
+		GIT_CHERRY_PICK_HELP="and then do something else" &&
+		export GIT_CHERRY_PICK_HELP &&
+		test_must_fail git cherry-pick picked
+	) &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick picked &&
+	git reset &&
+
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success 'failed commit does not clear CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick picked &&
+	test_must_fail git commit &&
+
+	test_cmp_rev picked CHERRY_PICK_HEAD
+'
+
+test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick picked &&
+	echo resolved >foo &&
+	git add foo &&
+	git update-index --refresh -q &&
+	test_must_fail git diff-index --exit-code HEAD &&
+	(
+		GIT_EDITOR=false &&
+		export GIT_EDITOR &&
+		test_must_fail git commit
+	) &&
+
+	test_cmp_rev picked CHERRY_PICK_HEAD
+'
+
+test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick picked &&
+	echo resolved >foo &&
+	git add foo &&
+	git commit &&
+
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
 test_expect_success 'failed cherry-pick produces dirty index' '
 	pristine_detach initial &&
 
-- 
1.7.4.1.51.g615e0
