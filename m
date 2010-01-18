From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 1/2] Add branch --set-upstream
Date: Mon, 18 Jan 2010 22:44:11 +0200
Message-ID: <1263847452-29634-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1263847452-29634-1-git-send-email-ilari.liusvaara@elisanet.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 21:44:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWySl-0005pO-GI
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 21:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab0ARUoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 15:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094Ab0ARUoX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 15:44:23 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:44399 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548Ab0ARUoW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 15:44:22 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 55FD3EBD55;
	Mon, 18 Jan 2010 22:44:21 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00AC647A53; Mon, 18 Jan 2010 22:44:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 1CDF641BF5;
	Mon, 18 Jan 2010 22:44:18 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
In-Reply-To: <1263847452-29634-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137402>

Add --set-upstream option to branch that works like --track, except that
when branch exists already, its upstream info is changed without changing
the ref value.

Based-on-patch-from: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-branch.txt |    8 +++++++-
 branch.c                     |   31 +++++++++++++++++++++----------
 builtin-branch.c             |    2 ++
 cache.h                      |    1 +
 t/t6040-tracking-info.sh     |   21 +++++++++++++++++++++
 5 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0e83680..a0d6a7a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git branch' [--color | --no-color] [-r | -a]
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
-'git branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 
@@ -129,6 +129,12 @@ start-point is either a local or remote branch.
 	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
 
+--set-upstream::
+	If specified branch does not exist yet or if '--force' has been
+	given, acts exactly like '--track'. Otherwise sets up configuration
+	like '--track' would when creating the branch, except that where
+	branch points to is not changed.
+
 --contains <commit>::
 	Only list branches which contain the specified commit.
 
diff --git a/branch.c b/branch.c
index 05ef3f5..40d3c45 100644
--- a/branch.c
+++ b/branch.c
@@ -108,6 +108,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		switch (track) {
 		case BRANCH_TRACK_ALWAYS:
 		case BRANCH_TRACK_EXPLICIT:
+		case BRANCH_TRACK_OVERRIDE:
 			break;
 		default:
 			return 1;
@@ -128,18 +129,25 @@ void create_branch(const char *head,
 		   const char *name, const char *start_name,
 		   int force, int reflog, enum branch_track track)
 {
-	struct ref_lock *lock;
+	struct ref_lock *lock = NULL;
 	struct commit *commit;
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
+	int dont_change_ref = 0;
+	int explicit_tracking = 0;
+
+	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
+		explicit_tracking = 1;
 
 	if (strbuf_check_branch_ref(&ref, name))
 		die("'%s' is not a valid branch name.", name);
 
 	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
-		if (!force)
+		if (!force && track == BRANCH_TRACK_OVERRIDE)
+			dont_change_ref = 1;
+		else if (!force)
 			die("A branch named '%s' already exists.", name);
 		else if (!is_bare_repository() && !strcmp(head, name))
 			die("Cannot force update the current branch.");
@@ -153,12 +161,12 @@ void create_branch(const char *head,
 	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
 	case 0:
 		/* Not branching from any existing branch */
-		if (track == BRANCH_TRACK_EXPLICIT)
+		if (explicit_tracking)
 			die("Cannot setup tracking information; starting point is not a branch.");
 		break;
 	case 1:
 		/* Unique completion -- good, only if it is a real ref */
-		if (track == BRANCH_TRACK_EXPLICIT && !strcmp(real_ref, "HEAD"))
+		if (explicit_tracking && !strcmp(real_ref, "HEAD"))
 			die("Cannot setup tracking information; starting point is not a branch.");
 		break;
 	default:
@@ -170,9 +178,11 @@ void create_branch(const char *head,
 		die("Not a valid branch point: '%s'.", start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	lock = lock_any_ref_for_update(ref.buf, NULL, 0);
-	if (!lock)
-		die_errno("Failed to lock ref for update");
+	if (!dont_change_ref) {
+		lock = lock_any_ref_for_update(ref.buf, NULL, 0);
+		if (!lock)
+			die_errno("Failed to lock ref for update");
+	}
 
 	if (reflog)
 		log_all_ref_updates = 1;
@@ -180,15 +190,16 @@ void create_branch(const char *head,
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset from %s",
 			 start_name);
-	else
+	else if (!dont_change_ref)
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
 	if (real_ref && track)
 		setup_tracking(name, real_ref, track);
 
-	if (write_ref_sha1(lock, sha1, msg) < 0)
-		die_errno("Failed to write ref");
+	if (!dont_change_ref)
+		if (write_ref_sha1(lock, sha1, msg) < 0)
+			die_errno("Failed to write ref");
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/builtin-branch.c b/builtin-branch.c
index ddc9f2d..970cf31 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -564,6 +564,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose),
 		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pull(1))",
 			BRANCH_TRACK_EXPLICIT),
+		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
+			BRANCH_TRACK_OVERRIDE),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
diff --git a/cache.h b/cache.h
index cf36c81..e9ec537 100644
--- a/cache.h
+++ b/cache.h
@@ -553,6 +553,7 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
+	BRANCH_TRACK_OVERRIDE,
 };
 
 enum rebase_setup_type {
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 664b0f8..1785e17 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -89,4 +89,25 @@ test_expect_success 'status when tracking annotated tags' '
 	grep "set up to track" actual &&
 	git checkout heavytrack
 '
+
+test_expect_success 'setup tracking with branch --set-upstream on existing branch' '
+	git branch from-master master &&
+	test_must_fail git config branch.from-master.merge > actual &&
+	git branch --set-upstream from-master master &&
+	git config branch.from-master.merge > actual &&
+	grep -q "^refs/heads/master$" actual
+'
+
+test_expect_success '--set-upstream does not change branch' '
+	git branch from-master2 master &&
+	test_must_fail git config branch.from-master2.merge > actual &&
+	git rev-list from-master2 &&
+	git update-ref refs/heads/from-master2 from-master2^ &&
+	git rev-parse from-master2 >expect2 &&
+	git branch --set-upstream from-master2 master &&
+	git config branch.from-master.merge > actual &&
+	git rev-parse from-master2 >actual2 &&
+	grep -q "^refs/heads/master$" actual &&
+	cmp expect2 actual2
+'
 test_done
-- 
1.6.6.199.gff4b0
