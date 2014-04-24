From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 12/12] cherry-pick: copy notes and run hooks
Date: Wed, 23 Apr 2014 21:44:51 -0500
Message-ID: <1398307491-21314-13-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:56:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pd-00081y-KW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbaDXC4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:56:07 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:42343 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbaDXC4B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:56:01 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so1984821oag.6
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WSaGeNchj48Rl1U7IaLmwd1rue3zRvj5Xm+tD4jdUMw=;
        b=njJgKLS9aD55O1j1EOnIxQHjB9V/CpZv56wxzzw+vsNwg4QPMcJevKRPKH0OO+Fgy7
         urqr5KevDlZSvCHF9jN3UJWsehelR1kd4B7j1LljWh3FFCRqsPbeSAvPTDXGr5/qFLnv
         hruxkR+t4K8bgVA0tzCjyBy/ngTmYnU+nEBnx7U/UzgnL00M8aI5yPGIVgjnQOIeUx8W
         76Ah220LkHBe9kFkvQWQy4UaE57RKKcDWMYj1FSe1ogEb7H4YLMDltnngZ759UAASoGz
         9Xh5ZFBbekdw+oKrarH1wuJwolkh/nTLjv/+SIMUATvG/MWuauVEa/pffphjVQ/IZHH2
         a53Q==
X-Received: by 10.60.59.196 with SMTP id b4mr16089194oer.48.1398308161017;
        Wed, 23 Apr 2014 19:56:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm5746508obb.8.2014.04.23.19.55.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:56:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246926>

If no action-name is specified, nothing is done.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt       |  9 ++++-----
 Documentation/githooks.txt     |  8 ++++----
 git-rebase--interactive.sh     |  4 ++--
 sequencer.c                    | 28 +++++++++++++++++++++++++++-
 t/t3512-revert-cherry-notes.sh | 18 ++++++++++++++++++
 t/t5407-post-rewrite-hook.sh   | 16 ++++++++++++++++
 6 files changed, 71 insertions(+), 12 deletions(-)
 create mode 100755 t/t3512-revert-cherry-notes.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c26a7c8..c328d33 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1752,11 +1752,10 @@ GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
 
 notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, Git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
+	When rewriting commits with <command> (currently `amend`, `rebase`, or
+	`cherry-pick`) and this variable is set to `true`, Git automatically
+	copies your notes from the original to the rewritten commit.  Defaults
+	to `true`, but see "notes.rewriteRef" below.
 
 notes.rewriteMode::
 	When copying notes during a rewrite (see the
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..2402e7d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -352,10 +352,10 @@ post-rewrite
 ~~~~~~~~~~~~
 
 This hook is invoked by commands that rewrite commits (`git commit
---amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
-it!).  Its first argument denotes the command it was invoked by:
-currently one of `amend` or `rebase`.  Further command-dependent
-arguments may be passed in the future.
+--amend`, `git rebase`, `git cherry-pick`; currently `git filter-branch` does
+'not' call it!).  Its first argument denotes the command it was invoked by
+(e.g. `rebase`).  Further command-dependent arguments may be passed in the
+future.
 
 The hook receives a list of the rewritten commits on stdin, in the
 format
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 43631b4..fd085e1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -248,7 +248,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
+	output eval git cherry-pick "--action-name ''" "$strategy_args" $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -359,7 +359,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output eval git cherry-pick "$strategy_args" "$@" ||
+			output eval git cherry-pick "--action-name ''" "$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
diff --git a/sequencer.c b/sequencer.c
index ed59d75..2eb6ce8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -22,6 +22,25 @@ const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 static struct rewritten rewritten;
 
+static void finish(struct replay_opts *opts)
+{
+	const char *name;
+	struct strbuf msg = STRBUF_INIT;
+
+	if (opts->action != REPLAY_PICK)
+		return;
+
+	name = opts->action_name ? opts->action_name : "cherry-pick";
+
+	if (!*name)
+		return;
+
+	strbuf_addf(&msg, "Notes added by 'git %s'", name);
+	copy_rewrite_notes(&rewritten, name, msg.buf);
+	run_rewrite_hook(&rewritten, name);
+	strbuf_release(&msg);
+}
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -1042,6 +1061,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		}
 	}
 
+	finish(opts);
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -1113,8 +1134,13 @@ static int sequencer_skip(struct replay_opts *opts)
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
+	int ret;
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(cmit, opts);
+	ret = do_pick_commit(cmit, opts);
+	if (ret)
+		return ret;
+	finish(opts);
+	return 0;
 }
 
 int sequencer_pick_revisions(struct replay_opts *opts)
diff --git a/t/t3512-revert-cherry-notes.sh b/t/t3512-revert-cherry-notes.sh
new file mode 100755
index 0000000..9e9e611
--- /dev/null
+++ b/t/t3512-revert-cherry-notes.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+test_description='test cherry-pick and revert notes'
+
+. ./test-lib.sh
+
+test_expect_success 'notes are rewritten' '
+	test_config notes.rewrite.cherry-pick true &&
+	test_config notes.rewriteRef "refs/notes/*" &&
+	test_commit n1 &&
+	test_commit n2 &&
+	git notes add -m "a note" n2 &&
+	git checkout n1 &&
+	git cherry-pick n2 &&
+	git notes show HEAD
+'
+
+test_done
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ea2e0d4..53d7ade 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -53,6 +53,22 @@ test_expect_success 'git commit --amend --no-post-rewrite' '
 	test ! -f post-rewrite.data
 '
 
+test_expect_success 'git cherry-pick' '
+	git reset --hard D &&
+	clear_hook_input &&
+	git checkout A &&
+	test_must_fail git cherry-pick B..D &&
+	echo C > foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+	echo cherry-pick >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
 test_expect_success 'git rebase' '
 	git reset --hard D &&
 	clear_hook_input &&
-- 
1.9.2+fc1.2.gfbaae8c
