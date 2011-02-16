From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] Introduce CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 12:20:35 -0500
Message-ID: <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
References: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 18:20:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppl3d-0004cw-S1
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 18:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab1BPRUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 12:20:46 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40507 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1BPRUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 12:20:44 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so669918vws.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 09:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Ga+o62x+loKkqI1/8eaTUiZiDKkXrbDpC0qL8DFS/GU=;
        b=G4oFRtIs96LONaRPesx+L3NySMUCSMFCuElDJ2JdQdqq0wwqjSujnxSVqUgk4EZBmA
         jrGseqDkGlvfUN9/RWNRPsmMkn9rQtWhSlh5df8uYQGZTzn0YxRJg6vNyu2kWyyJl+6W
         jhvjLtZudo0vGHlq7txVL4aIbMKzUNUruRr3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XGuLbsJ/KUQyLtZh16FtKpC/qIOc9OFa+07k9kLkBapmuAvNu8BY1zdMeaRDdK9hj8
         gcwRruo0EOcg3qUFDL35IiZc0dhux9m0KvqRB0/9zdyfGmINsrmgajUhVJ5qQ48wUEQX
         p7q0azUZPmTBPqzqweWby1+LjjNraEfistLfs=
Received: by 10.220.94.201 with SMTP id a9mr11567vcn.56.1297876843948;
        Wed, 16 Feb 2011 09:20:43 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id o13sm147669vch.40.2011.02.16.09.20.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 09:20:42 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.28.gb39462
In-Reply-To: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166978>

When a cherry-pick conflicts git advises to use:

 $ git commit -c <original commit id>

to preserve the original commit message and authorship. Instead, let's
record the original commit id in CHERRY_PICK_HEAD and advise to use:

  $ git commit -c CHERRY_PICK_HEAD

In the next commit, we teach git to handle the '-c CHERRY_PICK_HEAD'
part. Note that we record CHERRY_PICK_HEAD even in the case where there
are no conflicts so that we may use it to communicate authorship to
commit; this will then allow us to remove set_author_ident_env from
revert.c.

Contributions-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Compared to the original patch, this removes CHERRY_PICK_HEAD when
a conflict occurs during an interactive rebase. Also corrected a minor
typo in the commit message. There were no changes to the next patch
in the series, so I didn't resend it.

 Documentation/git-cherry-pick.txt |   19 +++++++++++++++++++
 Documentation/revisions.txt       |    5 ++++-
 branch.c                          |    1 +
 builtin/commit.c                  |    1 +
 builtin/merge.c                   |    7 +++++++
 builtin/revert.c                  |   25 +++++++++++++++++++++++--
 t/t3507-cherry-pick-conflict.sh   |   22 +++++++++++++++++++++-
 7 files changed, 76 insertions(+), 4 deletions(-)

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
index 03cff5a..0def540 100644
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
index 9403747..454dad2 100644
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
index dc1b702..88e3b2a 100644
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
@@ -263,6 +279,11 @@ static void print_advice(void)
 
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
+		/*
+		 * rebase interactive takes care of the authorship
+		 * when the user invokes rebase --continue
+		 */
+		unlink(git_path("CHERRY_PICK_HEAD"));
 		return;
 	}
 
@@ -270,8 +291,7 @@ static void print_advice(void)
 	advise("with 'git add <paths>' or 'git rm <paths>'");
 
 	if (action == CHERRY_PICK)
-		advise("and commit the result with 'git commit -c %s'",
-		       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+		advise("and commit the result with 'git commit -c CHERRY_PICK_HEAD'");
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
@@ -504,6 +524,7 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
+		write_cherry_pick_head();
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 607bf25..fd569c8 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -11,6 +11,12 @@ test_description='test cherry-pick and revert with conflicts
 
 . ./test-lib.sh
 
+test_cmp_rev () {
+	git rev-parse --verify "$1" >expect.rev &&
+	git rev-parse --verify "$2" >actual.rev &&
+	test_cmp expect.rev actual.rev
+}
+
 test_expect_success setup '
 
 	echo unrelated >unrelated &&
@@ -51,13 +57,27 @@ test_expect_success 'advice from failed cherry-pick' "
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
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+
+	test_cmp_rev picked CHERRY_PICK_HEAD
+'
+
 test_expect_success 'failed cherry-pick produces dirty index' '
 
 	git checkout -f initial^0 &&
-- 
1.7.4.1.28.gb39462
