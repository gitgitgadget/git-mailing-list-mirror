From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] optionally deny all pushes
Date: Sat, 21 Jan 2012 18:49:27 +0100
Message-ID: <20120121174927.GA7128@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 18:58:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RofCY-0002Fk-RQ
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 18:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993Ab2AUR5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 12:57:50 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:52336 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750780Ab2AUR5t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 12:57:49 -0500
Received: from localhost (p5B22F10E.dip.t-dialin.net [91.34.241.14])
	by bsmtp.bon.at (Postfix) with ESMTP id C3E20CDF85;
	Sat, 21 Jan 2012 18:58:49 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188925>

For a mirror repository which is updated only by pulling from upstream,
it is convenient to disallow all pushes. An accidental push from a
downstream repository would mess up the mirror's state as well as future
updates.

Add a boolean configuration variable receive.denyAll. If enabled,
receive-pack will deny all ref updates.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 Documentation/config.txt               |    4 ++++
 Documentation/git-push.txt             |    1 +
 builtin/receive-pack.c                 |   11 +++++++++++
 contrib/completion/git-completion.bash |    1 +
 t/t5400-send-pack.sh                   |   17 +++++++++++++++++
 t/t5516-fetch-push.sh                  |   12 ++++++++++++
 6 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04f5e19..edbddea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1683,6 +1683,10 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.denyAll::
+	If set to true, git-receive-pack will deny all ref updates.
+	The repository can not be updated remotely.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index aede488..7c6cc63 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -219,6 +219,7 @@ remote rejected::
 	The remote end refused the update.  Usually caused by a hook
 	on the remote side, or because the remote repository has one
 	of the following safety options in effect:
+	`receive.denyAll` (for all pushes),
 	`receive.denyCurrentBranch` (for pushes to the checked out
 	branch), `receive.denyNonFastForwards` (for forced
 	non-fast-forward updates), `receive.denyDeletes` or
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2dcb7e..9cd04f9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -22,6 +22,7 @@ enum deny_action {
 	DENY_REFUSE
 };
 
+static int deny_all;
 static int deny_deletes;
 static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
@@ -57,6 +58,11 @@ static enum deny_action parse_deny_action(const char *var, const char *value)
 
 static int receive_pack_config(const char *var, const char *value, void *cb)
 {
+	if (strcmp(var, "receive.denyall") == 0) {
+		deny_all = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.denydeletes") == 0) {
 		deny_deletes = git_config_bool(var, value);
 		return 0;
@@ -401,6 +407,11 @@ static const char *update(struct command *cmd)
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
 
+	if (deny_all) {
+		rp_error("denying all updates");
+		return "update prohibited";
+	}
+
 	/* only refs/... are allowed */
 	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b0062ba..9d63622 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2250,6 +2250,7 @@ _git_config ()
 		rebase.autosquash
 		rebase.stat
 		receive.autogc
+		receive.denyAll
 		receive.denyCurrentBranch
 		receive.denyDeleteCurrent
 		receive.denyDeletes
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0eace37..e8c9be2 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -222,4 +222,21 @@ test_expect_success 'deny pushing to delete current branch' '
 	)
 '
 
+test_expect_success 'deny pushing to any branch with denyAll' '
+	rewound_push_setup &&
+	(
+	    cd parent &&
+	    git config receive.denyCurrentBranch false &&
+	    git config receive.denyAll true
+	) &&
+	(
+	    cd child &&
+	    test_must_fail git send-pack ../parent master 2>errs
+	) &&
+	(
+	    cd child &&
+	    test_must_fail git send-pack ../parent :refs/heads/master 2>errs
+	)
+'
+
 test_done
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b69cf57..d1117c0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -815,6 +815,18 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 	! grep "warning: updating the current branch" stderr
 '
 
+test_expect_success 'deny push to HEAD of bare repository (denyAll)' '
+	mk_test heads/master &&
+	(
+		cd testrepo &&
+		git checkout master &&
+		git config receive.denyCurrentBranch false &&
+		git config receive.denyAll true &&
+		git config core.bare true
+	) &&
+	test_must_fail git push testrepo master
+'
+
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	mk_test heads/master &&
 	(
-- 
1.7.8
