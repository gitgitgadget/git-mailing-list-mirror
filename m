From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/3] revert: introduce --abort to cancel a failed cherry-pick
Date: Tue, 22 Nov 2011 05:20:02 -0600
Message-ID: <20111122112001.GF7399@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:20:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoOc-0003be-I2
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab1KVLUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:20:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60079 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab1KVLUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 06:20:06 -0500
Received: by iage36 with SMTP id e36so40094iag.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FRY8I1m8DWvMAh7L9ltwPQNdvdddn1U9+vY5sZgftS0=;
        b=ejcYUEb0y6rfHm47EQCr8WFDU182cDZWkzuZ1E7q0p0GhL5j/QmEHyRV7b8IMqQ59K
         n08rci0/bW/IFyS3LQsieBye4b6w4+ypsSV/O0H7it747OL2F0iDPFoVu0hl5SEISq7h
         4jwDWqw5npylnmd/jZN/NtopsOdeFvkrhC0jw=
Received: by 10.231.82.213 with SMTP id c21mr4373118ibl.70.1321960805591;
        Tue, 22 Nov 2011 03:20:05 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dd36sm58762927ibb.7.2011.11.22.03.20.04
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 03:20:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185786>

After running some ill-advised command like "git cherry-pick
HEAD..linux-next", the bewildered novice may want to return to more
familiar territory.  Introduce a "git cherry-pick --abort" command
that rolls back the entire cherry-pick sequence and places the
repository back on solid ground.

Just like "git merge --abort", this internally uses "git reset
--merge", so local changes not involved in the conflict resolution are
preserved.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cherry-pick.txt |    1 +
 Documentation/git-revert.txt      |    1 +
 Documentation/sequencer.txt       |    3 +
 builtin/revert.c                  |   87 ++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh   |  102 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 189 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 21998b82..fed5097e 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 'git cherry-pick' --continue
 'git cherry-pick' --quit
+'git cherry-pick' --abort
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index b0fcabc8..b699a345 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
 'git revert' --continue
 'git revert' --quit
+'git revert' --abort
 
 DESCRIPTION
 -----------
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 75f8e869..5747f442 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -7,3 +7,6 @@
 	Forget about the current operation in progress.  Can be used
 	to clear the sequencer state after a failed cherry-pick or
 	revert.
+
+--abort::
+	Cancel the operation and return to the pre-sequence state.
diff --git a/builtin/revert.c b/builtin/revert.c
index f5ba67a5..70a5fbb6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -40,7 +40,12 @@ static const char * const cherry_pick_usage[] = {
 };
 
 enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand { REPLAY_NONE, REPLAY_REMOVE_STATE, REPLAY_CONTINUE };
+enum replay_subcommand {
+	REPLAY_NONE,
+	REPLAY_REMOVE_STATE,
+	REPLAY_CONTINUE,
+	REPLAY_ROLLBACK
+};
 
 struct replay_opts {
 	enum replay_action action;
@@ -135,9 +140,11 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char *me = action_name(opts);
 	int remove_state = 0;
 	int contin = 0;
+	int rollback = 0;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "quit", &remove_state, "end revert or cherry-pick sequence"),
 		OPT_BOOLEAN(0, "continue", &contin, "resume revert or cherry-pick sequence"),
+		OPT_BOOLEAN(0, "abort", &rollback, "cancel revert or cherry-pick sequence"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		OPT_NOOP_NOARG('r', NULL),
@@ -173,6 +180,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	verify_opt_mutually_compatible(me,
 				"--quit", remove_state,
 				"--continue", contin,
+				"--abort", rollback,
 				NULL);
 
 	/* Set the subcommand */
@@ -180,6 +188,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->subcommand = REPLAY_REMOVE_STATE;
 	else if (contin)
 		opts->subcommand = REPLAY_CONTINUE;
+	else if (rollback)
+		opts->subcommand = REPLAY_ROLLBACK;
 	else
 		opts->subcommand = REPLAY_NONE;
 
@@ -188,8 +198,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		char *this_operation;
 		if (opts->subcommand == REPLAY_REMOVE_STATE)
 			this_operation = "--quit";
-		else
+		else if (opts->subcommand == REPLAY_CONTINUE)
 			this_operation = "--continue";
+		else {
+			assert(opts->subcommand == REPLAY_ROLLBACK);
+			this_operation = "--abort";
+		}
 
 		verify_opt_compatible(me, this_operation,
 				"--no-commit", opts->no_commit,
@@ -850,7 +864,7 @@ static int create_seq_dir(void)
 
 	if (file_exists(seq_dir)) {
 		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit)\""));
+		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
 		return -1;
 	}
 	else if (mkdir(seq_dir, 0777) < 0)
@@ -873,6 +887,71 @@ static void save_head(const char *head)
 		die(_("Error wrapping up %s."), head_file);
 }
 
+static int reset_for_rollback(const unsigned char *sha1)
+{
+	const char *argv[4];	/* reset --merge <arg> + NULL */
+	argv[0] = "reset";
+	argv[1] = "--merge";
+	argv[2] = sha1_to_hex(sha1);
+	argv[3] = NULL;
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
+static int rollback_single_pick(void)
+{
+	unsigned char head_sha1[20];
+
+	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
+	    !file_exists(git_path("REVERT_HEAD")))
+		return error(_("no cherry-pick or revert in progress"));
+	if (!resolve_ref("HEAD", head_sha1, 0, NULL))
+		return error(_("cannot resolve HEAD"));
+	if (is_null_sha1(head_sha1))
+		return error(_("cannot abort from a branch yet to be born"));
+	return reset_for_rollback(head_sha1);
+}
+
+static int sequencer_rollback(struct replay_opts *opts)
+{
+	const char *filename;
+	FILE *f;
+	unsigned char sha1[20];
+	struct strbuf buf = STRBUF_INIT;
+
+	filename = git_path(SEQ_HEAD_FILE);
+	f = fopen(filename, "r");
+	if (!f && errno == ENOENT) {
+		/*
+		 * There is no multiple-cherry-pick in progress.
+		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
+		 * a single-cherry-pick in progress, abort that.
+		 */
+		return rollback_single_pick();
+	}
+	if (!f)
+		return error(_("cannot open %s: %s"), filename,
+						strerror(errno));
+	if (strbuf_getline(&buf, f, '\n')) {
+		error(_("cannot read %s: %s"), filename, ferror(f) ?
+			strerror(errno) : _("unexpected end of file"));
+		goto fail;
+	}
+	if (get_sha1_hex(buf.buf, sha1) || buf.buf[40] != '\0') {
+		error(_("stored pre-cherry-pick HEAD file '%s' is corrupt"),
+			filename);
+		goto fail;
+	}
+	if (reset_for_rollback(sha1))
+		goto fail;
+	strbuf_release(&buf);
+	fclose(f);
+	return 0;
+fail:
+	strbuf_release(&buf);
+	fclose(f);
+	return -1;
+}
+
 static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
@@ -977,6 +1056,8 @@ static int pick_revisions(struct replay_opts *opts)
 		remove_sequencer_state(1);
 		return 0;
 	}
+	if (opts->subcommand == REPLAY_ROLLBACK)
+		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE) {
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			return error(_("No %s in progress"), action_name(opts));
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index bb67cdcb..63297ad6 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -6,7 +6,7 @@ test_description='Test cherry-pick continuation features
   + picked: rewrites foo to c
   + unrelatedpick: rewrites unrelated to reallyunrelated
   + base: rewrites foo to b
-  + initial: writes foo as a, unrelated as unrelated
+  + initial: writes foo as a, unrelated as unrelated, bar as bar
 
 '
 
@@ -19,9 +19,16 @@ pristine_detach () {
 	git clean -d -f -f -q -x
 }
 
+test_cmp_rev () {
+	git rev-parse --verify "$1" >expect.rev &&
+	git rev-parse --verify "$2" >actual.rev &&
+	test_cmp expect.rev actual.rev
+}
+
 test_expect_success setup '
 	echo unrelated >unrelated &&
-	git add unrelated &&
+	echo bar >bar &&
+	git add unrelated bar &&
 	test_commit initial foo a &&
 	test_commit base foo b &&
 	test_commit unrelatedpick unrelated reallyunrelated &&
@@ -75,6 +82,11 @@ test_expect_success '--quit does not complain when no cherry-pick is in progress
 	git cherry-pick --quit
 '
 
+test_expect_success '--abort requires cherry-pick in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --abort
+'
+
 test_expect_success '--quit cleans up sequencer state' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
@@ -88,6 +100,7 @@ test_expect_success 'cherry-pick --reset (another name for --quit)' '
 	OBJID
 	:100644 100644 OBJID OBJID M	unrelated
 	OBJID
+	:000000 100644 OBJID OBJID A	bar
 	:000000 100644 OBJID OBJID A	foo
 	:000000 100644 OBJID OBJID A	unrelated
 	EOF
@@ -103,6 +116,79 @@ test_expect_success 'cherry-pick --reset (another name for --quit)' '
 	test_cmp expect actual
 '
 
+test_expect_success '--abort to cancel multiple cherry-pick' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	git cherry-pick --abort &&
+	test_path_is_missing .git/sequencer &&
+	test_cmp_rev initial HEAD &&
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD
+'
+
+test_expect_success '--abort to cancel single cherry-pick' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick picked &&
+	git cherry-pick --abort &&
+	test_path_is_missing .git/sequencer &&
+	test_cmp_rev initial HEAD &&
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD
+'
+
+test_expect_success 'cherry-pick --abort to cancel multiple revert' '
+	pristine_detach anotherpick &&
+	test_must_fail git revert base..picked &&
+	git cherry-pick --abort &&
+	test_path_is_missing .git/sequencer &&
+	test_cmp_rev anotherpick HEAD &&
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD
+'
+
+test_expect_success 'revert --abort works, too' '
+	pristine_detach anotherpick &&
+	test_must_fail git revert base..picked &&
+	git revert --abort &&
+	test_path_is_missing .git/sequencer &&
+	test_cmp_rev anotherpick HEAD
+'
+
+test_expect_success '--abort to cancel single revert' '
+	pristine_detach anotherpick &&
+	test_must_fail git revert picked &&
+	git revert --abort &&
+	test_path_is_missing .git/sequencer &&
+	test_cmp_rev anotherpick HEAD &&
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD
+'
+
+test_expect_success '--abort keeps unrelated change, easy case' '
+	pristine_detach initial &&
+	echo changed >expect &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo changed >bar &&
+	git cherry-pick --abort &&
+	test_cmp expect bar
+'
+
+test_expect_success '--abort refuses to clobber unrelated change, harder case' '
+	pristine_detach initial &&
+	echo changed >expect &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo changed >unrelated &&
+	test_must_fail git cherry-pick --abort &&
+	test_cmp expect unrelated &&
+	git rev-list HEAD >log &&
+	test_line_count = 2 log &&
+	test_must_fail git update-index --refresh &&
+
+	git checkout unrelated &&
+	git cherry-pick --abort &&
+	test_cmp_rev initial HEAD
+'
+
 test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
@@ -121,12 +207,23 @@ test_expect_success 'cherry-pick cleans up sequencer state when one commit is le
 	OBJID
 	:100644 100644 OBJID OBJID M	unrelated
 	OBJID
+	:000000 100644 OBJID OBJID A	bar
 	:000000 100644 OBJID OBJID A	foo
 	:000000 100644 OBJID OBJID A	unrelated
 	EOF
 	test_cmp expect actual
 '
 
+test_expect_failure '--abort after last commit in sequence' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --abort &&
+	test_path_is_missing .git/sequencer &&
+	test_cmp_rev initial HEAD &&
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD
+'
+
 test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
@@ -168,6 +265,7 @@ test_expect_success '--continue continues after conflicts are resolved' '
 	OBJID
 	:100644 100644 OBJID OBJID M	unrelated
 	OBJID
+	:000000 100644 OBJID OBJID A	bar
 	:000000 100644 OBJID OBJID A	foo
 	:000000 100644 OBJID OBJID A	unrelated
 	EOF
-- 
1.7.8.rc3
